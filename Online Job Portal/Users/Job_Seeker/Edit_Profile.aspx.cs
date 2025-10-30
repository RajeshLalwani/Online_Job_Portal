using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_Edit_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Security check: Ensure a valid job seeker is logged in
            if (Session["UserID"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "Job Seeker")
            {
                BindCountryDropDown();
                LoadUserProfile();
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }


    /// <summary>
    /// Fetches the current user's data from the database and populates the form fields.
    /// </summary>
    private void LoadUserProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM JobSeekers WHERE JobSeekerID = @JobSeekerID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtPhoneNumber.Text = reader["PhoneNumber"].ToString();
                        txtAddress.Text = reader["Address"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["State"].ToString();
                        txtPostalCode.Text = reader["PostalCode"].ToString();
                        ddlCountry.SelectedValue = reader["Country"].ToString();
                        txtProfessionalTitle.Text = reader["ProfessionalTitle"].ToString();
                        txtSummary.Text = reader["Summary"].ToString();
                        //txtQualification.Text = reader["Qualification"].ToString();
                        // CORRECTED: Load value into DropDownList
                        string qualification = reader["Qualification"].ToString();
                        if (ddlQualification.Items.FindByValue(qualification) != null)
                        {
                            ddlQualification.SelectedValue = qualification;
                        }
                        txtTotalExperience.Text = reader["TotalExperience"].ToString();
                        txtSkills.Text = reader["Skills"].ToString();

                        profilePicPreview.Src = ResolveUrl(reader["ProfilePicturePath"].ToString());
                        hlResume.NavigateUrl = ResolveUrl(reader["ResumePath"].ToString());
                        ViewState["OriginalProfilePicPath"] = reader["ProfilePicturePath"].ToString();
                        ViewState["OriginalResumePath"] = reader["ResumePath"].ToString();
                    }
                }
            }
        }
    }

    /// <summary>
    /// Handles the click event of the "Save Changes" button.
    /// </summary>
    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string profilePicturePath = ViewState["OriginalProfilePicPath"].ToString();
            string resumePath = ViewState["OriginalResumePath"].ToString();

            if (fuProfilePicture.HasFile)
            {
                string safeFileName = $"ProfilePic_{Session["UserID"]}_{Guid.NewGuid()}{Path.GetExtension(fuProfilePicture.FileName)}";
                string folderPath = Server.MapPath("~/Uploads/ProfilePictures/");
                fuProfilePicture.SaveAs(Path.Combine(folderPath, safeFileName));
                profilePicturePath = $"~/Uploads/ProfilePictures/{safeFileName}";
            }

            if (fuResume.HasFile)
            {
                string safeFileName = $"Resume_{Session["UserID"]}_{Guid.NewGuid()}{Path.GetExtension(fuResume.FileName)}";
                string folderPath = Server.MapPath("~/Uploads/Resumes/");
                fuResume.SaveAs(Path.Combine(folderPath, safeFileName));
                resumePath = $"~/Uploads/Resumes/{safeFileName}";
            }

            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // CORRECTED: Removed the password update logic from this query.
                string query = @"UPDATE JobSeekers SET 
                    FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, Address = @Address, 
                    City = @City, State = @State, PostalCode = @PostalCode, Country = @Country, 
                    ProfilePicturePath = @ProfilePicturePath, ProfessionalTitle = @ProfessionalTitle, Summary = @Summary, 
                    Qualification = @Qualification, TotalExperience = @TotalExperience, Skills = @Skills, ResumePath = @ResumePath
                    WHERE JobSeekerID = @JobSeekerID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());
                    cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@ProfilePicturePath", profilePicturePath);
                    cmd.Parameters.AddWithValue("@ProfessionalTitle", txtProfessionalTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@Summary", txtSummary.Text.Trim());
                    //cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
                    // CORRECTED: Get value from DropDownList
                    cmd.Parameters.AddWithValue("@Qualification", ddlQualification.SelectedValue);
                    cmd.Parameters.AddWithValue("@TotalExperience", Convert.ToInt32(txtTotalExperience.Text));
                    cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                    cmd.Parameters.AddWithValue("@ResumePath", resumePath);
                    cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["title"] = "Success!";
            Session["text"] = "Your profile has been updated successfully.";
            Session["icon"] = "success";
            Response.Redirect("View_Profile.aspx");
        }
    }

    private void BindCountryDropDown()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CName FROM Country ORDER BY CName ASC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                ddlCountry.DataSource = cmd.ExecuteReader();
                ddlCountry.DataTextField = "CName";
                ddlCountry.DataValueField = "CName";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("-- Select Country --", ""));
            }
        }
    }

    // --- Custom Validators for File Uploads ---

    protected void cvProfilePicture_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (fuProfilePicture.HasFile)
        {
            // Size Validation (2MB limit)
            if (fuProfilePicture.PostedFile.ContentLength > 2097152)
            {
                args.IsValid = false;
                cvProfilePicture.ErrorMessage = "Image file must be less than 2 MB.";
                return;
            }

            // Type Validation
            string fileExtension = Path.GetExtension(fuProfilePicture.FileName).ToLower();
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
            {
                args.IsValid = false;
                cvProfilePicture.ErrorMessage = "Only .jpg, .jpeg, .png, or .gif files are allowed.";
            }
        }
    }

    protected void cvResume_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (fuResume.HasFile)
        {
            // Size Validation (5MB limit)
            if (fuResume.PostedFile.ContentLength > 5242880)
            {
                args.IsValid = false;
                cvResume.ErrorMessage = "Resume file must be less than 5 MB.";
                return;
            }

            // Type Validation
            string fileExtension = Path.GetExtension(fuResume.FileName).ToLower();
            string[] allowedExtensions = { ".pdf", ".doc", ".docx" };
            if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
            {
                args.IsValid = false;
                cvResume.ErrorMessage = "Only .pdf, .doc, or .docx files are allowed.";
            }
        }
    }
}

