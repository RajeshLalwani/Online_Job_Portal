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
            LoadDashboardStats();
        }
    }

    /// <summary>
    /// Loads key statistics for the entire platform from the database.
    /// </summary>
    private void LoadDashboardStats()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // UPDATED: A single, comprehensive query for all dashboard stats
            string query = @"
                SELECT 
                    (SELECT COUNT(*) FROM JobSeekers) AS TotalJobSeekers,
                    (SELECT COUNT(*) FROM Companies) AS TotalEmployers,
                    (SELECT COUNT(*) FROM Jobs WHERE JobStatus = 'Active') AS ActiveJobs,
                    (SELECT COUNT(*) FROM Jobs WHERE JobStatus = 'Pending Approval') AS PendingJobs,
                    (SELECT COUNT(*) FROM JobApplications) AS TotalApplications,
                    (SELECT COUNT(*) FROM JobApplications WHERE Status = 'Hired') AS TotalHired,
                    (SELECT COUNT(*) FROM FeedBack) AS TotalFeedbacks,
                    (SELECT COUNT(*) FROM Contact) AS TotalQueries
            ";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ltTotalJobSeekers.Text = reader["TotalJobSeekers"].ToString();
                            ltTotalEmployers.Text = reader["TotalEmployers"].ToString();
                            ltActiveJobs.Text = reader["ActiveJobs"].ToString();
                            ltTotalApplications.Text = reader["TotalApplications"].ToString();
                            ltTotalHired.Text = reader["TotalHired"].ToString();
                            ltPendingJobs.Text = reader["PendingJobs"].ToString();
                            ltTotalFeedbacks.Text = reader["TotalFeedbacks"].ToString();
                            ltTotalQueries.Text = reader["TotalQueries"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception for debugging: System.Diagnostics.Debug.WriteLine(ex.ToString());
                    // Show an error state on the dashboard
                    ltTotalJobSeekers.Text = "N/A";
                    ltTotalEmployers.Text = "N/A";
                    ltActiveJobs.Text = "N/A";
                    ltTotalApplications.Text = "N/A";
                    ltTotalHired.Text = "N/A";
                    ltPendingJobs.Text = "N/A";
                    ltTotalFeedbacks.Text = "N/A";
                    ltTotalQueries.Text = "N/A";
                }
            }
        }
    }
}

       