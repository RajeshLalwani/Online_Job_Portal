using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_ViewApplicantProfile : System.Web.UI.Page
{

    private int jobSeekerId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserType"]?.ToString() != "Admin")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobSeekerId))
        {
            ShowError("Invalid Applicant ID.");
            return;
        }

        if (!IsPostBack)
        {
            LoadUserProfile();
            LoadApplicationHistory(); // Load the new history data
        }
    }

    private void LoadUserProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Admin can view any profile, so no security check is needed here
            string query = "SELECT * FROM JobSeekers WHERE JobSeekerID = @JobSeekerID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobSeekerID", jobSeekerId);
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            pnlProfile.Visible = true;
                            ltFullName.Text = Server.HtmlEncode($"{reader["FirstName"]} {reader["LastName"]}");
                            ltProfileTitle.Text = Server.HtmlEncode(reader["ProfessionalTitle"].ToString());
                            imgProfile.ImageUrl = ResolveUrl(reader["ProfilePicturePath"].ToString());
                            ltEmail.Text = Server.HtmlEncode(reader["Email"].ToString());
                            ltPhone.Text = Server.HtmlEncode(reader["PhoneNumber"].ToString());
                            ltLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                            hlDownloadResume.NavigateUrl = ResolveUrl(reader["ResumePath"].ToString());
                            ltSummary.Text = Server.HtmlEncode(reader["Summary"].ToString());
                            ltQualification.Text = Server.HtmlEncode(reader["Qualification"].ToString());
                            int exp = Convert.ToInt32(reader["TotalExperience"]);
                            ltExperience.Text = Server.HtmlEncode($"{exp} {(exp == 1 ? "Year" : "Years")}");
                            List<string> skills = reader["Skills"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(s => s.Trim()).ToList();
                            rptSkills.DataSource = skills;
                            rptSkills.DataBind();
                        }
                        else
                        {
                            pnlProfile.Visible = false;
                            ShowError("Applicant profile not found.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    pnlProfile.Visible = false;
                    ShowError("An error occurred while loading the profile.");
                }
            }
        }
    }

    // NEW: Method to load the application history
    private void LoadApplicationHistory()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT j.JobID, j.JobTitle, c.CompanyName, ja.Status
                             FROM JobApplications ja
                             INNER JOIN Jobs j ON ja.JobID = j.JobID
                             INNER JOIN Companies c ON j.CompanyID = c.CompanyID
                             WHERE ja.JobSeekerID = @JobSeekerID
                             ORDER BY ja.ApplicationDate DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                sda.SelectCommand.Parameters.AddWithValue("@JobSeekerID", jobSeekerId);
                try
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptApplicationHistory.DataSource = dt;
                    rptApplicationHistory.DataBind();
                    pnlNoHistory.Visible = dt.Rows.Count == 0;
                }
                catch (Exception ex)
                {
                    // Optionally handle error for this section
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

