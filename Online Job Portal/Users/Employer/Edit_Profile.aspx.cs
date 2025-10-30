using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_Edit_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "Employer")
            {
                BindCountryDropDown();
                LoadCompanyProfile();
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx");
            }
        }

        else
        {
            // CORRECTED: Re-apply the logo path from ViewState on postback.
            // This ensures the image doesn't disappear if a validation error occurs.
            if (ViewState["OriginalLogoPath"] != null)
            {
                companyLogoPreview.Src = ResolveUrl(ViewState["OriginalLogoPath"].ToString());
            }
        }
    }


    private void LoadCompanyProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Companies WHERE CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtCompanyName.Text = reader["CompanyName"].ToString();
                        txtCompanyWebsite.Text = reader["CompanyWebsite"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        ddlCompanySize.SelectedValue = reader["CompanySize"].ToString();
                        txtFoundedYear.Text = reader["FoundedYear"].ToString();
                        txtAboutCompany.Text = reader["AboutCompany"].ToString();
                        txtAddress.Text = reader["Address"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["State"].ToString();
                        txtPostalCode.Text = reader["PostalCode"].ToString();
                        ddlCountry.SelectedValue = reader["Country"].ToString();
                        txtContactName.Text = reader["ContactName"].ToString();
                        txtContactPhone.Text = reader["ContactPhone"].ToString();

                        companyLogoPreview.Src = ResolveUrl(reader["CompanyLogoPath"].ToString());
                        ViewState["OriginalLogoPath"] = reader["CompanyLogoPath"].ToString();
                    }
                }
            }
        }
    }



    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string logoPath = ViewState["OriginalLogoPath"].ToString();

            if (fuCompanyLogo.HasFile)
            {
                string safeBaseFileName = $"{txtCompanyName.Text.Trim()}_{txtEmail.Text.Trim()}".Replace(" ", "_");
                string extension = Path.GetExtension(fuCompanyLogo.FileName);
                string fileName = $"Logo_{safeBaseFileName}{extension}";
                string folderPath = Server.MapPath("~/Uploads/CompanyLogos/");
                fuCompanyLogo.SaveAs(Path.Combine(folderPath, fileName));
                logoPath = $"~/Uploads/CompanyLogos/{fileName}";
            }

            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Companies SET 
                                 CompanyName = @CompanyName, CompanyWebsite = @CompanyWebsite, CompanyLogoPath = @CompanyLogoPath, 
                                 AboutCompany = @AboutCompany, CompanySize = @CompanySize, FoundedYear = @FoundedYear, 
                                 Address = @Address, City = @City, State = @State, PostalCode = @PostalCode, Country = @Country, 
                                 ContactName = @ContactName, ContactPhone = @ContactPhone
                                 WHERE CompanyID = @CompanyID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                    cmd.Parameters.AddWithValue("@CompanyWebsite", txtCompanyWebsite.Text.Trim());
                    cmd.Parameters.AddWithValue("@CompanyLogoPath", logoPath);
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
                    cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["title"] = "Success!";
            Session["text"] = "Your company profile has been updated successfully.";
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

    protected void cvCompanyLogo_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (fuCompanyLogo.HasFile)
        {
            if (fuCompanyLogo.PostedFile.ContentLength > 2097152) // 2MB
            {
                args.IsValid = false;
                cvCompanyLogo.ErrorMessage = "Image file must be less than 2 MB.";
                return;
            }

            string fileExtension = Path.GetExtension(fuCompanyLogo.FileName).ToLower();
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
            {
                args.IsValid = false;
                cvCompanyLogo.ErrorMessage = "Only .jpg, .jpeg, .png, or .gif files are allowed.";
            }
        }
    }
}
