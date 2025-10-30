using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_Applicants : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Employer")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobId))
        {
            ShowError("Invalid Job ID provided.");
            return;
        }

        if (!IsPostBack)
        {
            BindApplicants();
        }
    }

    protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindApplicants();
    }

    protected void rptApplicants_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int applicationID = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "Shortlist")
        {
            UpdateApplicationStatus(applicationID, "Shortlisted", DBNull.Value, DBNull.Value);
        }
        else if (e.CommandName == "Hired")
        {
            UpdateApplicationStatus(applicationID, "Hired", DBNull.Value, DBNull.Value);
        }
    }

    private void BindApplicants()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            StringBuilder queryBuilder = new StringBuilder(@"SELECT js.JobSeekerID, js.FirstName, js.LastName, js.ProfessionalTitle, js.ProfilePicturePath, js.ResumePath, js.Skills, 
                                                                  j.JobTitle, ja.ApplicationID, ja.Status, ja.InterviewDate, ja.RejectionReason
                                                           FROM JobApplications ja
                                                           INNER JOIN JobSeekers js ON ja.JobSeekerID = js.JobSeekerID
                                                           INNER JOIN Jobs j ON ja.JobID = j.JobID
                                                           WHERE ja.JobID = @JobID AND j.CompanyID = @CompanyID");

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);

                if (!string.IsNullOrEmpty(ddlStatusFilter.SelectedValue))
                {
                    queryBuilder.Append(" AND ja.Status = @Status");
                    cmd.Parameters.AddWithValue("@Status", ddlStatusFilter.SelectedValue);
                }

                queryBuilder.Append(" ORDER BY ja.ApplicationDate DESC");
                cmd.CommandText = queryBuilder.ToString();
                cmd.Connection = con;

                try
                {
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (string.IsNullOrEmpty(ltJobTitle.Text))
                        {
                            CheckJobExistsAndSetTitle();
                        }

                        rptApplicants.DataSource = dt;
                        rptApplicants.DataBind();

                        pnlNoApplicants.Visible = dt.Rows.Count == 0;
                        rptApplicants.Visible = dt.Rows.Count > 0;
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while fetching applicants.");
                }
            }
        }
    }

    protected void btnPerformRejection_Click(object sender, EventArgs e)
    {
        int applicationID = Convert.ToInt32(hdnApplicationID.Value);
        string reason = hdnInputValue.Value;
        UpdateApplicationStatus(applicationID, "Rejected", DBNull.Value, reason);
    }

    protected void btnPerformInterviewSchedule_Click(object sender, EventArgs e)
    {
        int applicationID = Convert.ToInt32(hdnApplicationID.Value);
        DateTime interviewDate = Convert.ToDateTime(hdnInputValue.Value);
        UpdateApplicationStatus(applicationID, "Interview Scheduled", interviewDate, DBNull.Value);
    }

    // NEW METHOD to load statistics
    private void LoadApplicantStats()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT ja.Status, COUNT(*) AS StatusCount
                             FROM JobApplications ja
                             INNER JOIN Jobs j ON ja.JobID = j.JobID
                             WHERE ja.JobID = @JobID AND j.CompanyID = @CompanyID
                             GROUP BY ja.Status";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    int total = 0;
                    // Reset labels to 0
                    ltPending.Text = "0"; ltShortlisted.Text = "0"; ltInterview.Text = "0"; ltHired.Text = "0"; ltRejected.Text = "0";

                    while (reader.Read())
                    {
                        int count = Convert.ToInt32(reader["StatusCount"]);
                        total += count;
                        switch (reader["Status"].ToString())
                        {
                            case "Pending": ltPending.Text = count.ToString(); break;
                            case "Shortlisted": ltShortlisted.Text = count.ToString(); break;
                            case "Interview Scheduled": ltInterview.Text = count.ToString(); break;
                            case "Hired": ltHired.Text = count.ToString(); break;
                            case "Rejected": ltRejected.Text = count.ToString(); break;
                        }
                    }
                    ltTotal.Text = total.ToString();
                }
            }
        }
    }


    private void UpdateApplicationStatus(int applicationID, string status, object interviewDate, object rejectionReason)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"UPDATE ja SET ja.Status = @Status, ja.InterviewDate = @InterviewDate, ja.RejectionReason = @RejectionReason
                             FROM JobApplications ja
                             INNER JOIN Jobs j ON ja.JobID = j.JobID
                             WHERE ja.ApplicationID = @ApplicationID AND j.CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@InterviewDate", interviewDate);
                cmd.Parameters.AddWithValue("@RejectionReason", rejectionReason);
                cmd.Parameters.AddWithValue("@ApplicationID", applicationID);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);

                try
                {
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        ShowSuccess($"Application has been successfully {status.ToLower()}.");
                        BindApplicants();
                        LoadApplicantStats(); // Refresh stats
                    }
                    else
                    {
                        ShowError("Could not update status. You may not have permission.");
                    }

                                   
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while updating the application status.");
                }
            }
        }
    }

    protected string[] SplitSkills(object skillsObject)
    {
        if (skillsObject == null || string.IsNullOrEmpty(skillsObject.ToString()))
        {
            return new string[0];
        }
        return skillsObject.ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
    }

    protected string FormatInterviewDate(object interviewDateObj)
    {
        if (interviewDateObj == DBNull.Value || interviewDateObj == null)
        {
            return "Not Scheduled";
        }
        DateTime interviewDate = Convert.ToDateTime(interviewDateObj);
        return interviewDate.ToString("dd MMMM yyyy, hh:mm tt");
    }

    // NEW: Helper method for simple confirmations
    protected string GetConfirmClientClick(string title, string text)
    {
        return $"return confirmAction(this, event, '{HttpUtility.JavaScriptStringEncode(title)}', '{HttpUtility.JavaScriptStringEncode(text)}');";
    }

    protected string GetScheduleInterviewClientClick(object applicationID, object status)
    {
        return $"scheduleInterview({applicationID}, '{status}'); return false;";
    }

    protected string GetRejectClientClick(object applicationID)
    {
        return $"rejectApplication({applicationID}); return false;";
    }

    private void CheckJobExistsAndSetTitle()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT JobTitle FROM Jobs WHERE JobID = @JobID AND CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    ltJobTitle.Text = Server.HtmlEncode(result.ToString());
                }
                else
                {
                    ltJobTitle.Text = "Invalid Job";
                    ShowError("Could not retrieve job details. You may not have permission to view this page.");
                }
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }

    private void ShowSuccess(string message)
    {
        string script = $"Swal.fire('Success!', '{HttpUtility.JavaScriptStringEncode(message)}', 'success');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertSuccess", script, true);
    }
}

