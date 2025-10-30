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

public partial class Users_Job_Seeker_FindJobs : System.Web.UI.Page
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
            BindJobProfileFilter();
            BindCountryFilter();
            BindJobList();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        CurrentPage = 0; // Reset to first page on new search
        BindJobList();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        CurrentPage = 0; // Reset to first page
        txtSearchMain.Text = string.Empty;
        txtLocationMain.Text = string.Empty;
        ddlSortBy.ClearSelection();
        ddlJobProfile.ClearSelection();
        ddlCountryFilter.ClearSelection();
        cblJobType.ClearSelection();
        ddlDatePosted.ClearSelection();
        BindJobList();
    }

    private void BindJobList()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            // CORRECTED: Added [AND j.ApplicationDeadline > GETDATE()] to automatically hide expired jobs
            StringBuilder queryBuilder = new StringBuilder(@"SELECT j.JobID, j.JobTitle, j.City, j.Country, j.JobType, j.Salary, j.DatePosted, j.ExperienceRequired, j.QualificationRequired,
                                                                  c.CompanyName, c.CompanyLogoPath 
                                                             FROM Jobs j
                                                             INNER JOIN Companies c ON j.CompanyID = c.CompanyID
                                                             WHERE j.JobStatus = 'Active' AND j.ApplicationDeadline > GETDATE()");

            using (SqlCommand cmd = new SqlCommand())
            {
                // Main Search Box Logic
                string searchTerm = txtSearchMain.Text.Trim();
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    queryBuilder.Append(" AND (j.JobTitle LIKE @SearchTerm OR j.SkillsRequired LIKE @SearchTerm OR c.CompanyName LIKE @SearchTerm)");
                    cmd.Parameters.AddWithValue("@SearchTerm", $"%{searchTerm}%");
                }

                string locationTerm = txtLocationMain.Text.Trim();
                if (!string.IsNullOrEmpty(locationTerm))
                {
                    queryBuilder.Append(" AND (j.City LIKE @LocationTerm OR j.State LIKE @LocationTerm OR j.Country LIKE @LocationTerm)");
                    cmd.Parameters.AddWithValue("@LocationTerm", $"%{locationTerm}%");
                }

                if (!string.IsNullOrEmpty(ddlJobProfile.SelectedValue))
                {
                    queryBuilder.Append(" AND j.JobTitle = @JobTitle");
                    cmd.Parameters.AddWithValue("@JobTitle", ddlJobProfile.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlCountryFilter.SelectedValue))
                {
                    queryBuilder.Append(" AND j.Country = @Country");
                    cmd.Parameters.AddWithValue("@Country", ddlCountryFilter.SelectedValue);
                }

                // --- Sidebar Filter Logic for Job Type Checkboxes ---
                var selectedJobTypes = cblJobType.Items.Cast<ListItem>()
                                       .Where(li => li.Selected)
                                       .Select(li => li.Value)
                                       .ToList();

                if (selectedJobTypes.Any())
                {
                    queryBuilder.Append(" AND j.JobType IN (");
                    for (int i = 0; i < selectedJobTypes.Count; i++)
                    {
                        string paramName = $"@JobType{i}";
                        queryBuilder.Append(paramName);
                        if (i < selectedJobTypes.Count - 1)
                        {
                            queryBuilder.Append(", ");
                        }
                        cmd.Parameters.AddWithValue(paramName, selectedJobTypes[i]);
                    }
                    queryBuilder.Append(")");
                }


                if (!string.IsNullOrEmpty(ddlDatePosted.SelectedValue))
                {
                    int days = Convert.ToInt32(ddlDatePosted.SelectedValue);
                    queryBuilder.Append(" AND j.DatePosted >= DATEADD(day, -@Days, GETDATE())");
                    cmd.Parameters.AddWithValue("@Days", days);
                }

                // --- Sort By Logic ---
                queryBuilder.AppendFormat(" ORDER BY j.DatePosted {0}", ddlSortBy.SelectedValue);

                cmd.CommandText = queryBuilder.ToString();
                cmd.Connection = con;

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
                        pds.PageSize = 5; // Show 10 jobs per page
                        pds.CurrentPageIndex = CurrentPage;

                        // Bind the paged data to the repeater
                        rptJobList.DataSource = pds;
                        rptJobList.DataBind();

                        // Bind the pager controls
                        BindPager(pds);

                        pnlNoJobs.Visible = dt.Rows.Count == 0;
                        rptJobList.Visible = dt.Rows.Count > 0;
                    }
                }
                catch (Exception ex)
                {
                    pnlNoJobs.Visible = true;
                    rptJobList.Visible = false;
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
        BindJobList();
    }

    private void BindJobProfileFilter()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT JobTitle FROM Jobs WHERE JobStatus = 'Active' ORDER BY JobTitle ASC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                ddlJobProfile.DataSource = cmd.ExecuteReader();
                ddlJobProfile.DataTextField = "JobTitle";
                ddlJobProfile.DataValueField = "JobTitle";
                ddlJobProfile.DataBind();
                ddlJobProfile.Items.Insert(0, new ListItem("All Profiles", ""));
            }
        }
    }

    private void BindCountryFilter()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT Country FROM Jobs WHERE JobStatus = 'Active' ORDER BY Country ASC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                ddlCountryFilter.DataSource = cmd.ExecuteReader();
                ddlCountryFilter.DataTextField = "Country";
                ddlCountryFilter.DataValueField = "Country";
                ddlCountryFilter.DataBind();
                ddlCountryFilter.Items.Insert(0, new ListItem("All Countries", ""));
            }
        }
    }

    protected string GetTimeAgo(object datePostedObj)
    {
        if (datePostedObj == DBNull.Value || datePostedObj == null) return string.Empty;
        DateTime datePosted = Convert.ToDateTime(datePostedObj);
        TimeSpan timeSince = DateTime.Now.Subtract(datePosted);
        if (timeSince.TotalMinutes < 1) return "Just now";
        if (timeSince.TotalMinutes < 2) return "1 minute ago";
        if (timeSince.TotalMinutes < 60) return $"{timeSince.Minutes} minutes ago";
        if (timeSince.TotalHours < 2) return "1 hour ago";
        if (timeSince.TotalHours < 24) return $"{timeSince.Hours} hours ago";
        if (timeSince.TotalDays < 2) return "1 day ago";
        if (timeSince.TotalDays < 7) return $"{timeSince.Days} days ago";
        if (timeSince.TotalDays < 14) return "1 week ago";
        if (timeSince.TotalDays < 30) return $"{(int)Math.Floor(timeSince.TotalDays / 7)} weeks ago";
        if (timeSince.TotalDays < 60) return "1 month ago";
        if (timeSince.TotalDays < 365) return $"{(int)Math.Floor(timeSince.TotalDays / 30)} months ago";
        if (timeSince.TotalDays < 730) return "1 year ago";
        return $"{(int)Math.Floor(timeSince.TotalDays / 365)} years ago";
    }


    /// <summary>
    /// Returns a CSS class based on the job type for styling the tag.
    /// </summary>
    //protected string GetJobTypeCssClass(object jobTypeObj)
    //{
    //    if (jobTypeObj == null) return string.Empty;
    //    string jobType = jobTypeObj.ToString().ToLower().Replace("-", "");
    //    return "job-type-" + jobType;
    //}
}

