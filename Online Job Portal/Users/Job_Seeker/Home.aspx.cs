using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] != null && Session["UserType"] != null && Session["UserType"].ToString() == "Job Seeker")
            {
                LoadUserProfile();
                LoadDashboardStats();
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }

    private void LoadUserProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT FirstName, LastName, ProfessionalTitle, ProfilePicturePath FROM JobSeekers WHERE JobSeekerID = @JobSeekerID";
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
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            ltName.Text = Server.HtmlEncode(firstName);
                            ltFullName.Text = Server.HtmlEncode($"{firstName} {lastName}");
                            ltProfileTitle.Text = Server.HtmlEncode(reader["ProfessionalTitle"].ToString());
                            imgProfile.ImageUrl = ResolveUrl(reader["ProfilePicturePath"].ToString());
                        }
                    }
                }
                catch (Exception ex) { /* Handle Error */ }
            }
        }
    }

    private void LoadDashboardStats()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT 
                                COUNT(ApplicationID) AS TotalApplications,
                                COUNT(CASE WHEN Status = 'Interview Scheduled' THEN 1 END) AS InterviewCount,
                                COUNT(CASE WHEN Status = 'Rejected' THEN 1 END) AS RejectedCount
                             FROM JobApplications WHERE JobSeekerID = @JobSeekerID";
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
                            ltJobsApplied.Text = reader["TotalApplications"].ToString();
                            ltInterviews.Text = reader["InterviewCount"].ToString();
                            ltRejected.Text = reader["RejectedCount"].ToString();
                        }
                    }
                }
                catch (Exception ex) { /* Handle Error */ }
            }
        }
    }
}