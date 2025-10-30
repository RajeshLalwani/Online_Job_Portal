using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_AppliedJobs : System.Web.UI.Page
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
            // Security check to ensure a valid job seeker is logged in
            if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Job Seeker")
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            else
            {
                BindAppliedJobs();
            }
        }

    }

    /// <summary>
    /// Fetches all job applications for the logged-in user and binds them to the repeater.
    /// </summary>
    private void BindAppliedJobs()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // This query joins the necessary tables to get all details for the applied jobs list.
            string query = @"SELECT j.JobID, j.JobTitle, c.CompanyName, c.CompanyLogoPath, ja.ApplicationDate, ja.Status, ja.InterviewDate, ja.RejectionReason
                             FROM JobApplications ja
                             INNER JOIN Jobs j ON ja.JobID = j.JobID
                             INNER JOIN Companies c ON j.CompanyID = c.CompanyID
                             WHERE ja.JobSeekerID = @JobSeekerID
                             ORDER BY ja.ApplicationDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Use a parameterized query to prevent SQL injection.
                cmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);

                try
                {
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        // NEW: Paging Logic
                        PagedDataSource pds = new PagedDataSource();
                        pds.DataSource = dt.DefaultView;
                        pds.AllowPaging = true;
                        pds.PageSize = 10; // Set to 10 entries per page
                        pds.CurrentPageIndex = CurrentPage;

                        rptAppliedJobs.DataSource = pds;
                        rptAppliedJobs.DataBind();

                        BindPager(pds);

                        pnlNoApplications.Visible = dt.Rows.Count == 0;
                        rptAppliedJobs.Visible = dt.Rows.Count > 0;

                        // Show a message panel if the user has no applications.
                        pnlNoApplications.Visible = dt.Rows.Count == 0;
                        rptAppliedJobs.Visible = dt.Rows.Count > 0;
                    }
                }
                catch (Exception ex)
                {
                    ShowError(ex.ToString());
                    // Log the error for debugging purposes.
                    // System.Diagnostics.Debug.WriteLine(ex.ToString());
                    // Optionally, show an error message on the page.
                }
            }
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
        BindAppliedJobs();
    }

    private void ShowError(string message)
    {
        // Using SweetAlert2 for a better user experience
        string script = $"Swal.fire('Login Failed', '{message}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }

    protected string FormatInterviewDate(object interviewDateObj)
    {
        if (interviewDateObj == DBNull.Value || interviewDateObj == null)
        {
            return "Not Yet Confirmed";
        }
        DateTime interviewDate = Convert.ToDateTime(interviewDateObj);
        return interviewDate.ToString("dd MMMM yyyy, hh:mm tt");
    }
}

