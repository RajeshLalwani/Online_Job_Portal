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
            LoadSiteStats();
        }
    }

    // <summary>
    // Loads key statistics for the entire platform to display on the public home page.
    // </summary>
    private void LoadSiteStats()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // A single, efficient query to get all counts
            string query = @"SELECT 
                                (SELECT COUNT(*) FROM Jobs WHERE JobStatus = 'Active') AS LiveJobs,
                                (SELECT COUNT(*) FROM Companies) AS TotalCompanies,
                                (SELECT COUNT(*) FROM JobSeekers) AS TotalJobSeekers,
                                (SELECT COUNT(*) FROM JobApplications) AS TotalApplications";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ltLiveJobs.Text = reader["LiveJobs"].ToString();
                            ltCompanies.Text = reader["TotalCompanies"].ToString();
                            ltJobSeekers.Text = reader["TotalJobSeekers"].ToString();
                            ltApplications.Text = reader["TotalApplications"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // In case of a database error, show "N/A"
                    ltLiveJobs.Text = "0";
                    ltCompanies.Text = "0";
                    ltJobSeekers.Text = "0";
                    ltApplications.Text = "0";
                }
            }
        }
    }
}

