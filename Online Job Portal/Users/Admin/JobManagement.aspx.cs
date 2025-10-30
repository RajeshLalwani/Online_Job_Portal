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

public partial class Users_Admin_JobManagement : System.Web.UI.Page
{

    // A class-level variable to hold the company ID from the query string
    private int companyId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        // Check for companyId in query string on every page load
        if (!string.IsNullOrEmpty(Request.QueryString["companyId"]))
        {
            int.TryParse(Request.QueryString["companyId"], out companyId);
        }

        if (!IsPostBack)
        {
            // If filtering by a company, show the info panel
            if (companyId > 0)
            {
                ShowFilterInfo();
            }
            BindAllGrids();
        }
    }

    private void BindAllGrids()
    {
        BindGrid("Pending Approval", gvPendingJobs);
        BindGrid("Active", gvActiveJobs);
        BindGrid("Other", gvOtherJobs);
    }

    private void BindGrid(string status, GridView gv)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            StringBuilder queryBuilder = new StringBuilder(@"SELECT j.JobID, j.JobTitle, j.DatePosted, j.JobStatus, c.CompanyName 
                                                             FROM Jobs j 
                                                             INNER JOIN Companies c ON j.CompanyID = c.CompanyID");

            if (status == "Other")
            {
                queryBuilder.Append(" WHERE j.JobStatus IN ('Closed', 'Rejected')");
            }
            else
            {
                queryBuilder.Append(" WHERE j.JobStatus = @Status");
            }

            // CORRECTED: Add the company filter to the query if a companyId exists
            if (companyId > 0)
            {
                queryBuilder.Append(" AND j.CompanyID = @CompanyID");
            }

            queryBuilder.Append(" ORDER BY j.DatePosted DESC");

            using (SqlDataAdapter sda = new SqlDataAdapter(queryBuilder.ToString(), con))
            {
                if (status != "Other")
                {
                    sda.SelectCommand.Parameters.AddWithValue("@Status", status);
                }
                if (companyId > 0)
                {
                    sda.SelectCommand.Parameters.AddWithValue("@CompanyID", companyId);
                }

                DataTable dt = new DataTable();
                sda.Fill(dt);
                gv.DataSource = dt;
                gv.DataBind();
            }
        }
    }

    // This method shows the "Filtering by Company X" panel
    private void ShowFilterInfo()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CompanyName FROM Companies WHERE CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@CompanyID", companyId);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    pnlFilterInfo.Visible = true;
                    ltCompanyName.Text = Server.HtmlEncode(result.ToString());
                }
            }
        }
    }

    protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int jobId = 0;

        if (e.CommandName == "ApproveJob")
        {
            jobId = Convert.ToInt32(e.CommandArgument);
            UpdateJobStatus(jobId, "Active");
        }
        else if (e.CommandName == "RejectJob")
        {
            jobId = Convert.ToInt32(e.CommandArgument);
            UpdateJobStatus(jobId, "Rejected");
        }
        else if (e.CommandName == "ToggleStatus")
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            jobId = Convert.ToInt32(args[0]);
            string currentStatus = args[1];
            string newStatus = (currentStatus == "Active") ? "Closed" : "Active";
            UpdateJobStatus(jobId, newStatus);
        }
        else if (e.CommandName == "DeleteJob")
        {
            jobId = Convert.ToInt32(e.CommandArgument);
            DeleteJob(jobId);
        }
    }

    private void UpdateJobStatus(int jobId, string newStatus)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "UPDATE Jobs SET JobStatus = @Status WHERE JobID = @JobID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@JobID", jobId);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("Job status updated successfully.");
                    BindAllGrids();
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
            string query = "DELETE FROM Jobs WHERE JobID = @JobID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("Job deleted successfully.");
                    BindAllGrids();
                }
                catch (Exception ex) { ShowError("Error deleting job. It may have related records (e.g., applications) that prevent deletion."); }
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

    // NEW: Page index changing event handlers for each GridView
    protected void gvPendingJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPendingJobs.PageIndex = e.NewPageIndex;
        BindAllGrids();
    }

    protected void gvActiveJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvActiveJobs.PageIndex = e.NewPageIndex;
        BindAllGrids();
    }

    protected void gvOtherJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvOtherJobs.PageIndex = e.NewPageIndex;
        BindAllGrids();
    }
}

