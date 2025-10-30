using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Guest_JobDetails : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!int.TryParse(Request.QueryString["id"], out jobId))
        {
            Response.Redirect("FindJobs.aspx"); // Redirect if ID is invalid
        }

        if (!IsPostBack)
        {
            LoadJobDetails();
            
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
                       // Response.Redirect("FindJobs.aspx");
                    }
                }
            }
        }
    }
    protected void btnApplyNow_Click(object sender, EventArgs e)
    {
        //Session["title"] = "Log in Required!";
        //Session["text"] = "You'll have to Log in First to Apply for any Job...";
        //Session["icon"] = "success";

        //Response.Redirect("../../Account/Login.aspx");

        // string script = "Swal.fire('Log in Required!', 'You'll have to Log in First to Apply for any Job.', 'warning').then(() => { window.location.href = '../../Account/Login.aspx'; });";
        //ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        // ShowMessage("You have successfully applied for this job!", "success");

        // CORRECTED: This script will now fire correctly because the SweetAlert library is loaded on the page.
        string script = "Swal.fire('Log in Required!', 'You must log in first to apply for any job.', 'warning').then(() => { window.location.href = '../../Account/Login.aspx'; });";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);


    }

    private void ShowMessage(string message, string type)
    {
        string script = $"Swal.fire('{char.ToUpper(type[0]) + type.Substring(1)}', '{HttpUtility.JavaScriptStringEncode(message)}', '{type}');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
    }
}