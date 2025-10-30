using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_View_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Security check to ensure a valid job seeker is logged in
            if (Session["UserID"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "Job Seeker")
            {
                LoadUserProfile();
            }
            else
            {
                // If not, redirect to the login page
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }

    /// <summary>
    /// Fetches the complete profile data for the logged-in user from the JobSeekers table
    /// and binds it to the controls on the page.
    /// </summary>
    private void LoadUserProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Query to select all relevant fields for the profile view
            string query = "SELECT * FROM JobSeekers WHERE JobSeekerID = @JobSeekerID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // --- Populate Contact Card ---
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            ltFullName.Text = Server.HtmlEncode($"{firstName} {lastName}");
                            ltProfileTitle.Text = Server.HtmlEncode(reader["ProfessionalTitle"].ToString());
                            imgProfile.ImageUrl = ResolveUrl(reader["ProfilePicturePath"].ToString());
                            ltEmail.Text = Server.HtmlEncode(reader["Email"].ToString());
                            ltPhone.Text = Server.HtmlEncode(reader["PhoneNumber"].ToString());
                            ltLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                            hlDownloadResume.NavigateUrl = ResolveUrl(reader["ResumePath"].ToString());

                            // --- Populate Details Sections ---
                            ltSummary.Text = Server.HtmlEncode(reader["Summary"].ToString());
                            ltQualification.Text = Server.HtmlEncode(reader["Qualification"].ToString());

                            // --- CORRECTED: Handle singular vs. plural for Experience ---
                            int experienceYears = Convert.ToInt32(reader["TotalExperience"]);
                            ltExperience.Text = Server.HtmlEncode($"{experienceYears} {(experienceYears == 1 ? "Year" : "Years")}");

                            //ltExperience.Text = Server.HtmlEncode(reader["TotalExperience"].ToString());

                            // --- Process and Display Skills ---
                            string skillsData = reader["Skills"].ToString();
                            // Split the comma-separated string into a list, removing empty entries and trimming whitespace
                            List<string> skillsList = skillsData.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                                .Select(skill => skill.Trim())
                                                                .ToList();
                            rptSkills.DataSource = skillsList;
                            rptSkills.DataBind();
                        }
                        else
                        {
                            // Handle the unlikely case where the profile for a logged-in user is not found
                            ShowError("Could not find your profile. Please contact support.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception for debugging: System.Diagnostics.Debug.WriteLine(ex.ToString());
                    ShowError("An error occurred while loading your profile.");
                }
            }
        }
    }

    /// <summary>
    /// Displays an error message to the user.
    /// </summary>
    /// <param name="message">The error message to display.</param>
    private void ShowError(string message)
    {
        // A simple way to show an error without a dedicated control.
        // For a more integrated look, you could add an asp:Literal or Panel to the .aspx page.
        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{Server.HtmlEncode(message)}');", true);
    }
}

