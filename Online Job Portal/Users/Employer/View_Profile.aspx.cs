using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_View_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Security check to ensure a valid employer is logged in
            if (Session["UserID"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "Employer")
            {
                LoadCompanyProfile();
            }
            else
            {
                // If not, redirect to the login page
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }
    /// <summary>
    /// Fetches the complete profile data for the logged-in company from the database
    /// and binds it to the controls on the page.
    /// </summary>
    private void LoadCompanyProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Query to select all relevant fields for the company profile view
            string query = "SELECT * FROM Companies WHERE CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // --- Populate Summary Card ---
                            ltCompanyName.Text = Server.HtmlEncode(reader["CompanyName"].ToString());
                            hlCompanyWebsite.Text = Server.HtmlEncode(reader["CompanyWebsite"].ToString());
                            hlCompanyWebsite.NavigateUrl = reader["CompanyWebsite"].ToString();
                            imgCompanyLogo.ImageUrl = ResolveUrl(reader["CompanyLogoPath"].ToString());
                            ltContactName.Text = Server.HtmlEncode(reader["ContactName"].ToString());
                            ltContactPhone.Text = Server.HtmlEncode(reader["ContactPhone"].ToString());
                            ltEmail.Text = Server.HtmlEncode(reader["Email"].ToString());

                            // --- Populate Details Sections ---
                            ltAboutCompany.Text = Server.HtmlEncode(reader["AboutCompany"].ToString());
                            ltCompanySize.Text = Server.HtmlEncode(reader["CompanySize"].ToString());
                            ltFoundedYear.Text = Server.HtmlEncode(reader["FoundedYear"].ToString());
                            ltAddress.Text = Server.HtmlEncode(reader["Address"].ToString());
                            ltFullLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["State"]}, {reader["Country"]} - {reader["PostalCode"]}");
                        }
                        else
                        {
                            ShowError("Could not find your company profile. Please contact support.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception for debugging: System.Diagnostics.Debug.WriteLine(ex.ToString());
                    ShowError("An error occurred while loading your company profile.");
                }
            }
        }
    }

    /// <summary>
    /// Displays an error message to the user using SweetAlert2.
    /// </summary>
    private void ShowError(string message)
    {
        // Use SweetAlert2 for a professional and consistent look.
        // HttpUtility.JavaScriptStringEncode ensures the message is safe to use in a script.
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }
}

