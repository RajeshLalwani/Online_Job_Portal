using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_ViewApplicantProfile : System.Web.UI.Page
{

    private int jobSeekerId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Employer")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobSeekerId))
        {
            ShowError("Invalid Applicant ID provided.");
            return;
        }

        if (!IsPostBack)
        {
            LoadUserProfile();
        }

    }

    private void LoadUserProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // This query performs a crucial security check:
            // It ensures that the profile being viewed (JobSeekerID) has an application
            // for a job that belongs to the currently logged-in employer (CompanyID).
            string query = @"SELECT js.* FROM JobSeekers js
                             INNER JOIN JobApplications ja ON js.JobSeekerID = ja.JobSeekerID
                             INNER JOIN Jobs j ON ja.JobID = j.JobID
                             WHERE js.JobSeekerID = @JobSeekerID AND j.CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobSeekerID", jobSeekerId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            pnlProfile.Visible = true; // Show the profile panel

                            // Populate contact card
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            ltFullName.Text = Server.HtmlEncode($"{firstName} {lastName}");
                            ltProfileTitle.Text = Server.HtmlEncode(reader["ProfessionalTitle"].ToString());
                            imgProfile.ImageUrl = ResolveUrl(reader["ProfilePicturePath"].ToString());
                            ltEmail.Text = Server.HtmlEncode(reader["Email"].ToString());
                            ltPhone.Text = Server.HtmlEncode(reader["PhoneNumber"].ToString());
                            ltLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                            hlDownloadResume.NavigateUrl = ResolveUrl(reader["ResumePath"].ToString());

                            // Populate details sections
                            ltSummary.Text = Server.HtmlEncode(reader["Summary"].ToString());
                            ltQualification.Text = Server.HtmlEncode(reader["Qualification"].ToString());

                            int experienceYears = Convert.ToInt32(reader["TotalExperience"]);
                            ltExperience.Text = Server.HtmlEncode($"{experienceYears} {(experienceYears == 1 ? "Year" : "Years")}");

                            // Process and display skills
                            string skillsData = reader["Skills"].ToString();
                            List<string> skillsList = skillsData.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                                .Select(skill => skill.Trim())
                                                                .ToList();
                            rptSkills.DataSource = skillsList;
                            rptSkills.DataBind();
                        }
                        else
                        {
                            // This means the employer does not have permission to view this profile.
                            pnlProfile.Visible = false;
                            ShowError("You do not have permission to view this applicant's profile, or the profile does not exist.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    pnlProfile.Visible = false;
                    ShowError("An error occurred while loading the applicant's profile.");
                }
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }
}
