using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_JobDetails : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserType"]?.ToString() != "Admin")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobId))
        {
            // Handle invalid ID, maybe redirect to job management page
            Response.Redirect("JobManagement.aspx");
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
                             WHERE j.JobID = @JobID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        ltJobTitle.Text = Server.HtmlEncode(reader["JobTitle"].ToString());
                        ltCompanyName.Text = Server.HtmlEncode(reader["CompanyName"].ToString());
                        imgCompanyLogo.ImageUrl = ResolveUrl(reader["CompanyLogoPath"].ToString());
                        ltLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                        ltJobType.Text = Server.HtmlEncode(reader["JobType"].ToString());
                        ltJobDescription.Text = reader["JobDescription"].ToString().Replace("\n", "<br />");
                        ltSalary.Text = Server.HtmlEncode(reader["Salary"].ToString());
                        ltExperience.Text = Server.HtmlEncode(reader["ExperienceRequired"].ToString());
                        ltQualification.Text = Server.HtmlEncode(reader["QualificationRequired"].ToString());
                        ltDatePosted.Text = Convert.ToDateTime(reader["DatePosted"]).ToString("dd MMM yyyy");
                        ltDeadline.Text = Convert.ToDateTime(reader["ApplicationDeadline"]).ToString("dd MMM yyyy");
                        string[] skills = reader["SkillsRequired"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        rptSkills.DataSource = skills.Select(s => s.Trim());
                        rptSkills.DataBind();
                    }
                }
            }
        }
    }
}
