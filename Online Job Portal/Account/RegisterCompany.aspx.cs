using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_RegisterCompany : System.Web.UI.Page
{
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
                // Handle database errors gracefully
                cvCompanyLogo.IsValid = false;
                cvCompanyLogo.ErrorMessage = "Database error loading countries.";
            }
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string email = txtEmail.Text.Trim();

            // Check if email already exists
            if (IsEmailAlreadyRegistered(email))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Registration Failed', 'This email address is already registered. Please use a different email or log in.', 'error');", true);
                return;
            }

            string companyName = txtCompanyName.Text.Trim();
            string safeBaseFileName = $"{companyName}_{email}".Replace(" ", "_").Replace("@", "_at_");

            // Handle Company Logo Upload
            string companyLogoPath = "../images/default-logo.png"; // Default logo
            if (fuCompanyLogo.HasFile)
            {
                string extension = Path.GetExtension(fuCompanyLogo.FileName);
                string fileName = $"Logo_{safeBaseFileName}{extension}";
                string folderPath = Server.MapPath("~/Uploads/CompanyLogos/");
                Directory.CreateDirectory(folderPath); // Ensure the directory exists
                fuCompanyLogo.SaveAs(Path.Combine(folderPath, fileName));
                companyLogoPath = $"~/Uploads/CompanyLogos/{fileName}";
            }

            // Hash the password
            string passwordHash = BCrypt.Net.BCrypt.HashPassword(txtPassword.Text);

            // Save to database
            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Companies (CompanyName, Email, PasswordHash, CompanyLogoPath, CompanyWebsite, AboutCompany, CompanySize, FoundedYear, Address, City, State, PostalCode, Country, ContactName, ContactPhone, SecQue, SecAns)
                                 VALUES (@CompanyName, @Email, @PasswordHash, @CompanyLogoPath, @CompanyWebsite, @AboutCompany, @CompanySize, @FoundedYear, @Address, @City, @State, @PostalCode, @Country, @ContactName, @ContactPhone, @SecQue, @SecAns)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyName", companyName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd.Parameters.AddWithValue("@CompanyLogoPath", companyLogoPath);
                    cmd.Parameters.AddWithValue("@CompanyWebsite", txtCompanyWebsite.Text.Trim());
                    cmd.Parameters.AddWithValue("@AboutCompany", txtAboutCompany.Text.Trim());
                    cmd.Parameters.AddWithValue("@CompanySize", ddlCompanySize.SelectedValue);
                    cmd.Parameters.AddWithValue("@FoundedYear", Convert.ToInt32(txtFoundedYear.Text));
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());
                    cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@ContactName", txtContactName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ContactPhone", txtContactPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@SecQue", ddlSecQue.SelectedValue);
                    cmd.Parameters.AddWithValue("@SecAns", txtSecAns.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Show success message and redirect
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Success!', 'Your company profile has been created successfully.', 'success').then((result) => { if (result.isConfirmed) { window.location.href='Login.aspx'; } });", true);
        }
    }

    private bool IsEmailAlreadyRegistered(string email)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Query the Companies table instead of JobSeekers
            string query = "SELECT COUNT(*) FROM Companies WHERE Email = @Email";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }

    protected void cvCompanyLogo_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (fuCompanyLogo.HasFile)
        {
            int maxSize = 5 * 1024 * 1024; // 5 MB
            if (fuCompanyLogo.PostedFile.ContentLength > maxSize)
            {
                args.IsValid = false;
                cvCompanyLogo.ErrorMessage = "Logo file must be less than 5 MB.";
                return;
            }

            string extension = Path.GetExtension(fuCompanyLogo.FileName).ToLower();
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
            {
                args.IsValid = false;
                cvCompanyLogo.ErrorMessage = "Only .jpg, .jpeg, or .png files are allowed for logos.";
                return;
            }
        }
        else
        {
            args.IsValid = false;
            cvCompanyLogo.ErrorMessage = "Company logo is required.";
            return;
        }
        args.IsValid = true;
    }
}
