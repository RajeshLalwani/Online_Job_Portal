using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using BCrypt.Net; // Added for BCrypt Hashing
using System.IO;
using System.Data;

public partial class Account_RegisterSeeker : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCountryDropDown();
        }
    }

    private void BindCountryDropDown()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT CName FROM Country ORDER BY CName", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlCountry.DataSource = dt;
                ddlCountry.DataTextField = "CName";
                ddlCountry.DataValueField = "CName";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("-- Select Country --", ""));
            }
            catch (Exception ex)
            {
                // Log the exception (e.g., to a file or database)
                // For now, we'll just show an error on the page, but logging is better.
                cvProfilePicture.IsValid = false; // Use a validator to show a generic error
                cvProfilePicture.ErrorMessage = "Database error loading countries.";
            }
        }
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string email = txtEmail.Text.Trim();

            if (IsEmailAlreadyRegistered(email))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Registration Failed', 'This email address is already registered. Please use a different email or log in.', 'error');", true);
                return;
            }

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string safeBaseFileName = $"{firstName}_{lastName}_{email}".Replace(" ", "_");

            string profilePicturePath = "../images/default-profile.png";
            if (fuProfilePicture.HasFile)
            {
                string extension = Path.GetExtension(fuProfilePicture.FileName);
                string fileName = $"Profile_Picture_{safeBaseFileName}{extension}";
                string folderPath = Server.MapPath("~/Uploads/ProfilePictures/");
                Directory.CreateDirectory(folderPath);
                fuProfilePicture.SaveAs(Path.Combine(folderPath, fileName));
                profilePicturePath = $"~/Uploads/ProfilePictures/{fileName}";
            }

            string resumePath = string.Empty;
            if (fuResume.HasFile)
            {
                string extension = Path.GetExtension(fuResume.FileName);
                string fileName = $"Resume_{safeBaseFileName}{extension}";
                string folderPath = Server.MapPath("~/Uploads/Resumes/");
                Directory.CreateDirectory(folderPath);
                fuResume.SaveAs(Path.Combine(folderPath, fileName));
                resumePath = $"~/Uploads/Resumes/{fileName}";
            }

            string passwordHash = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO JobSeekers (FirstName, LastName, Email, PasswordHash, PhoneNumber, Address, City, State, PostalCode, Country, ProfilePicturePath, ProfessionalTitle, Summary, Qualification, TotalExperience, Skills, ResumePath, SecQue, SecAns)
                                 VALUES (@FirstName, @LastName, @Email, @PasswordHash, @PhoneNumber, @Address, @City, @State, @PostalCode, @Country, @ProfilePicturePath, @ProfessionalTitle, @Summary, @Qualification, @TotalExperience, @Skills, @ResumePath, @SecQue, @SecAns)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());
                    cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@ProfilePicturePath", profilePicturePath);
                    cmd.Parameters.AddWithValue("@ProfessionalTitle", txtProfessionalTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Summary", txtSummary.Text.Trim());
                    // cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim()); // Changed from ddlQualification
                    // CORRECTED: Taking value from ddlQualification instead of txtQualification                    
                    cmd.Parameters.AddWithValue("@Qualification", ddlQualification.SelectedValue);
                    cmd.Parameters.AddWithValue("@TotalExperience", Convert.ToInt32(txtTotalExperience.Text));
                    cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                    cmd.Parameters.AddWithValue("@ResumePath", resumePath);
                    cmd.Parameters.AddWithValue("@SecQue", ddlSecQue.SelectedValue);
                    cmd.Parameters.AddWithValue("@SecAns", txtSecAns.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Success!', 'Your profile has been created successfully.', 'success').then((result) => { if (result.isConfirmed) { window.location.href='Login.aspx'; } });", true);
        }
    }

    private bool IsEmailAlreadyRegistered(string email)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM JobSeekers WHERE Email = @Email";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }

    protected void cvProfilePicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (fuProfilePicture.HasFile)
        {
            if (fuProfilePicture.PostedFile.ContentLength > 2097152) // 2MB
            {
                args.IsValid = false;
                cvProfilePicture.ErrorMessage = "Image file must be less than 2 MB.";
                return;
            }
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            string extension = Path.GetExtension(fuProfilePicture.FileName).ToLower();
            if (Array.IndexOf(allowedExtensions, extension) == -1)
            {
                args.IsValid = false;
                cvProfilePicture.ErrorMessage = "Only .jpg, .jpeg, .png, or .gif files are allowed.";
            }
        }
    }

    protected void cvResume_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (!fuResume.HasFile)
        {
            args.IsValid = false;
            cvResume.ErrorMessage = "Resume is required.";
        }
        else
        {
            if (fuResume.PostedFile.ContentLength > 5242880) // 5MB
            {
                args.IsValid = false;
                cvResume.ErrorMessage = "Resume file must be less than 5 MB.";
                return;
            }
            string[] allowedExtensions = { ".pdf", ".doc", ".docx" };
            string extension = Path.GetExtension(fuResume.FileName).ToLower();
            if (Array.IndexOf(allowedExtensions, extension) == -1)
            {
                args.IsValid = false;
                cvResume.ErrorMessage = "Only .pdf, .doc, or .docx files are allowed.";
            }
        }
    }
}

