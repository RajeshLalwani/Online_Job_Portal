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
            if (Session["UserID"] != null && Session["UserType"]?.ToString() == "Employer")
            {
                LoadCompanyProfile();
                LoadDashboardStats();
            }
            else
            {
                Response.Redirect("~/Account/Login.aspx");
            }
        }
    }

    private void LoadCompanyProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CompanyName, City, Country, CompanyLogoPath FROM Companies WHERE CompanyID = @CompanyID";
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
                            ltCompanyName.Text = Server.HtmlEncode(reader["CompanyName"].ToString());
                            ltCompanyLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["Country"]}");
                            imgCompanyLogo.ImageUrl = ResolveUrl(reader["CompanyLogoPath"].ToString());
                        }
                    }
                }
                catch (Exception ex) { /* Handle error */ }
            }
        }
    }

    private void LoadDashboardStats()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT 
                                (SELECT COUNT(*) FROM Jobs WHERE CompanyID = @CompanyID AND JobStatus = 'Active') AS ActiveJobCount,
                                (SELECT COUNT(ja.ApplicationID) FROM JobApplications ja INNER JOIN Jobs j ON ja.JobID = j.JobID WHERE j.CompanyID = @CompanyID) AS TotalApplicantCount,
                                (SELECT COUNT(ja.ApplicationID) FROM JobApplications ja INNER JOIN Jobs j ON ja.JobID = j.JobID WHERE j.CompanyID = @CompanyID AND ja.Status = 'Hired') AS HiredCount";
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
                            ltActiveJobs.Text = reader["ActiveJobCount"].ToString();
                            ltTotalApplicants.Text = reader["TotalApplicantCount"].ToString();
                            ltHired.Text = reader["HiredCount"].ToString();
                        }
                    }
                }
                catch (Exception ex) { /* Handle error */ }
            }
        }
    }
}

