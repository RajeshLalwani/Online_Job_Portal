using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_PostedJobs : System.Web.UI.Page
{

    // NEW: Property to hold the current page index in ViewState
    private int CurrentPage
    {
        get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 0; }
        set { ViewState["CurrentPage"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Employer")
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            else
            {
                BindPostedJobs();
            }
        }
    }


  

    private void BindPostedJobs()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // CORRECTED: Query now includes a subquery to count applicants for each job.
            string query = @"SELECT j.*, (SELECT COUNT(*) FROM JobApplications ja WHERE ja.JobID = j.JobID) AS ApplicantCount 
                             FROM Jobs j 
                             WHERE j.CompanyID = @CompanyID 
                             ORDER BY j.DatePosted DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                sda.SelectCommand.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                // NEW: Paging Logic
                PagedDataSource pds = new PagedDataSource();
                pds.DataSource = dt.DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = 5; // Set to 5 entries
                pds.CurrentPageIndex = CurrentPage;

                rptPostedJobs.DataSource = pds;
                rptPostedJobs.DataBind();

                BindPager(pds);

                pnlNoJobs.Visible = dt.Rows.Count == 0;
                rptPostedJobs.Visible = dt.Rows.Count > 0;
            }
        }
    }

    protected void rptPostedJobs_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int jobId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteJob")
        {
            DeleteJob(jobId);
        }
        else if (e.CommandName == "ActivateJob")
        {
            UpdateJobStatus(jobId, "Active");
        }
        else if (e.CommandName == "CloseJob")
        {
            UpdateJobStatus(jobId, "Closed");
        }
    }

    // NEW: Method to bind the pager controls
    private void BindPager(PagedDataSource pds)
    {
        pnlPagination.Visible = pds.PageCount > 1;

        lblCurrentPage.Text = (CurrentPage + 1).ToString();
        lblTotalPages.Text = pds.PageCount.ToString();

        btnPrev.Enabled = !pds.IsFirstPage;
        btnNext.Enabled = !pds.IsLastPage;
    }

    // NEW: Event handler for Previous/Next buttons
    protected void Page_Changed(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        if (btn.ID == "btnPrev")
        {
            CurrentPage -= 1;
        }
        else if (btn.ID == "btnNext")
        {
            CurrentPage += 1;
        }
        BindPostedJobs();
    }

    // Helper method to generate the SweetAlert confirmation script
    protected string GetConfirmClientClick(string title, string text)
    {
        return $"return confirmAction(this, event, '{HttpUtility.JavaScriptStringEncode(title)}', '{HttpUtility.JavaScriptStringEncode(text)}');";
    }

    private void UpdateJobStatus(int jobId, string newStatus)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "UPDATE Jobs SET JobStatus = @Status WHERE JobID = @JobID AND CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("Job status updated successfully.");
                    BindPostedJobs();
                }
                catch (Exception ex) { ShowError("Error updating job status."); }
            }
        }
    }

    private void DeleteJob(int jobId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Jobs WHERE JobID = @JobID AND CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("Job posting has been deleted successfully.");
                    BindPostedJobs();
                }
                catch (Exception ex) { ShowError("Error deleting job. It may have related records (e.g., applications) that must be removed first."); }
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

