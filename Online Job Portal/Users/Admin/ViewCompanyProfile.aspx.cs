using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_ViewCompanyProfile : System.Web.UI.Page
{

    private int companyId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserType"]?.ToString() != "Admin")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out companyId))
        {
            ShowError("Invalid Company ID.");
            return;
        }

        if (!IsPostBack)
        {
            LoadCompanyProfile();
            LoadCompanyStats();
        }
    }

    private void LoadCompanyProfile()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Companies WHERE CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", companyId);
                try
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            pnlProfile.Visible = true;
                            ltCompanyName.Text = Server.HtmlEncode(reader["CompanyName"].ToString());
                            hlCompanyWebsite.Text = Server.HtmlEncode(reader["CompanyWebsite"].ToString());
                            hlCompanyWebsite.NavigateUrl = reader["CompanyWebsite"].ToString();
                            imgCompanyLogo.ImageUrl = ResolveUrl(reader["CompanyLogoPath"].ToString());
                            ltContactName.Text = Server.HtmlEncode(reader["ContactName"].ToString());
                            ltContactPhone.Text = Server.HtmlEncode(reader["ContactPhone"].ToString());
                            ltEmail.Text = Server.HtmlEncode(reader["Email"].ToString());
                            ltAboutCompany.Text = Server.HtmlEncode(reader["AboutCompany"].ToString());
                            ltCompanySize.Text = Server.HtmlEncode(reader["CompanySize"].ToString());
                            ltFoundedYear.Text = Server.HtmlEncode(reader["FoundedYear"].ToString());
                            ltAddress.Text = Server.HtmlEncode(reader["Address"].ToString());
                            ltFullLocation.Text = Server.HtmlEncode($"{reader["City"]}, {reader["State"]}, {reader["Country"]} - {reader["PostalCode"]}");

                            hlViewJobs.NavigateUrl = $"~/Users/Admin/JobManagement.aspx?companyId={companyId}";
                        }
                        else
                        {
                            pnlProfile.Visible = false;
                            ShowError("Company profile not found.");
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

    private void LoadCompanyStats()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            try
            {
                con.Open();
                // --- Get Job Statistics ---
                string jobQuery = @"SELECT 
                                    COUNT(JobID) AS TotalJobs,
                                    COUNT(CASE WHEN JobStatus = 'Active' THEN 1 END) AS ActiveJobs,
                                    COUNT(CASE WHEN JobStatus = 'Pending Approval' THEN 1 END) AS PendingJobs,
                                    COUNT(CASE WHEN JobStatus = 'Closed' THEN 1 END) AS ClosedJobs
                                FROM Jobs WHERE CompanyID = @CompanyID";
                using (SqlCommand cmd = new SqlCommand(jobQuery, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyID", companyId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            ltTotalJobs.Text = reader["TotalJobs"].ToString();
                            ltActiveJobs.Text = reader["ActiveJobs"].ToString();
                            ltPendingJobs.Text = reader["PendingJobs"].ToString();
                            ltClosedJobs.Text = reader["ClosedJobs"].ToString();
                        }
                    }
                }

                // --- Get Applicant Statistics ---
                string appQuery = @"SELECT ja.Status, COUNT(*) AS StatusCount 
                                  FROM JobApplications ja 
                                  INNER JOIN Jobs j ON ja.JobID = j.JobID
                                  WHERE j.CompanyID = @CompanyID 
                                  GROUP BY ja.Status";
                using (SqlCommand cmd = new SqlCommand(appQuery, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyID", companyId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        int total = 0;
                        // Reset all to 0
                        ltPendingApplicants.Text = "0"; ltShortlisted.Text = "0"; ltInterview.Text = "0";
                        ltHired.Text = "0"; ltRejected.Text = "0";

                        while (reader.Read())
                        {
                            int count = Convert.ToInt32(reader["StatusCount"]);
                            total += count;
                            switch (reader["Status"].ToString())
                            {
                                case "Pending": ltPendingApplicants.Text = count.ToString(); break;
                                case "Shortlisted": ltShortlisted.Text = count.ToString(); break;
                                case "Interview Scheduled": ltInterview.Text = count.ToString(); break;
                                case "Hired": ltHired.Text = count.ToString(); break;
                                case "Rejected": ltRejected.Text = count.ToString(); break;
                            }
                        }
                        ltTotalApplicants.Text = total.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions if stats fail to load
                ShowError("Could not load company statistics.");
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }
}

