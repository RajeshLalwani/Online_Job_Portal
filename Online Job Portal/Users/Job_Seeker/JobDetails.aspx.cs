using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_JobDetails : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Job Seeker")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobId))
        {
            Response.Redirect("FindJobs.aspx"); // Redirect if ID is invalid
        }

        if (!IsPostBack)
        {
            LoadJobDetails();
            CheckApplicationStatus();
        }
    }

    private void LoadJobDetails()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT j.*, c.CompanyName, c.CompanyLogoPath 
                             FROM Jobs j 
                             INNER JOIN Companies c ON j.CompanyID = c.CompanyID 
                             WHERE j.JobID = @JobID AND j.JobStatus = 'Active'";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate Header
                        ltJobTitle.Text = Server.HtmlEncode(reader["JobTitle"].ToString());
                        ltCompanyName.Text = Server.HtmlEncode(reader["CompanyName"].ToString());
                        imgCompanyLogo.ImageUrl = ResolveUrl(reader["CompanyLogoPath"].ToString());
                        ltLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                        ltJobType.Text = Server.HtmlEncode(reader["JobType"].ToString());

                        // Populate Body
                        ltJobDescription.Text = reader["JobDescription"].ToString().Replace("\n", "<br />"); // Keep formatting
                        ltSalary.Text = Server.HtmlEncode(reader["Salary"].ToString());
                        ltExperience.Text = Server.HtmlEncode(reader["ExperienceRequired"].ToString());
                        ltQualification.Text = Server.HtmlEncode(reader["QualificationRequired"].ToString());
                        ltDatePosted.Text = Convert.ToDateTime(reader["DatePosted"]).ToString("dd MMM yyyy");
                        ltDeadline.Text = Convert.ToDateTime(reader["ApplicationDeadline"]).ToString("dd MMM yyyy");

                        // Populate Skills
                        string[] skills = reader["SkillsRequired"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        rptSkills.DataSource = skills.Select(s => s.Trim());
                        rptSkills.DataBind();
                    }
                    else
                    {
                        // If job not found or not active, redirect back
                        Response.Redirect("FindJobs.aspx");
                    }
                }
            }
        }
    }

    private void CheckApplicationStatus()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM JobApplications WHERE JobID = @JobID AND JobSeekerID = @JobSeekerID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                if (count > 0)
                {
                    btnApplyNow.Enabled = false;
                    btnApplyNow.Text = "Already Applied";
                    btnApplyNow.CssClass = "btn btn-already-applied";
                }
            }
        }
    }


    protected void btnApplyNow_Click(object sender, EventArgs e)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // Final check before inserting to prevent duplicates from rapid clicks
            string checkQuery = "SELECT COUNT(*) FROM JobApplications WHERE JobID = @JobID AND JobSeekerID = @JobSeekerID";
            using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@JobID", jobId);
                checkCmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                con.Open();
                int count = (int)checkCmd.ExecuteScalar();
                if (count > 0)
                {
                    ShowMessage("You have already applied for this job.", "info");
                    return;
                }
                con.Close();
            }

            // Insert new application
            string insertQuery = "INSERT INTO JobApplications (JobID, JobSeekerID) VALUES (@JobID, @JobSeekerID)";
            using (SqlCommand cmd = new SqlCommand(insertQuery, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        ShowMessage("You have successfully applied for this job!", "success");
        CheckApplicationStatus(); // Update button state
    }

    private void ShowMessage(string message, string type)
    {
        string script = $"Swal.fire('{char.ToUpper(type[0]) + type.Substring(1)}', '{HttpUtility.JavaScriptStringEncode(message)}', '{type}');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
    }
}