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

public partial class Users_Admin_Reports : System.Web.UI.Page
{

    private DateTime startDate;
    private DateTime endDate;

    private static DataTable dtCompanyStats = new DataTable();
    private static DataTable dtJobSeekers = new DataTable();
    private static DataTable dtCompanies = new DataTable();

    // Variables for calculating totals (for GridView Footer display only)
    private int totalJobs = 0, totalActive = 0, totalPending = 0, totalRejectedJobs = 0;
    private int totalApps = 0, totalShortlisted = 0, totalInterview = 0, totalHired = 0, totalRejectedApps = 0;

    private int totalSeekers = 0, activeSeekers = 0, suspendedSeekers = 0;
    private int totalEmployers = 0, activeEmployers = 0, suspendedEmployers = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetDateRange(true); // Set initial default ("All Time")
            BindAllGrids();
        }
        else
        {
            SetDateRange(false); // Set based on dropdown selection
        }
    }
    protected void btnApplyFilter_Click(object sender, EventArgs e)
    {
        // Reset totals before re-binding
        totalJobs = 0; totalActive = 0; totalPending = 0; totalRejectedJobs = 0;
        totalApps = 0; totalShortlisted = 0; totalInterview = 0; totalHired = 0; totalRejectedApps = 0;

        // Reset page index for the stats grid
        gvCompanyStats.PageIndex = 0;
        BindCompanyStats();
    }

    private void SetDateRange(bool isInitialLoad)
    {
        endDate = DateTime.UtcNow.AddDays(1).Date; // Today + 1 to include all of today
        string range = isInitialLoad ? "AllTime" : ddlDateRange.SelectedValue;

        switch (range)
        {
            case "Today":
                startDate = DateTime.UtcNow.Date;
                break;
            case "Last7Days":
                startDate = DateTime.UtcNow.AddDays(-7).Date;
                break;
            case "Last30Days":
                startDate = DateTime.UtcNow.AddDays(-30).Date;
                break;
            case "Last90Days":
                startDate = DateTime.UtcNow.AddDays(-90).Date;
                break;
            case "ThisYear":
                startDate = new DateTime(DateTime.UtcNow.Year, 1, 1);
                break;
            default: // AllTime
                startDate = new DateTime(1900, 1, 1);
                break;
        }
    }
    private void BindAllGrids()
    {
        BindCompanyStats();
        BindJobSeekers();
        BindCompanies();
    }

    private void BindCompanyStats()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
                SELECT 
                    C.CompanyName,
                    COUNT(DISTINCT CASE WHEN J.DatePosted BETWEEN @StartDate AND @EndDate THEN J.JobID END) AS TotalJobs,
                    COUNT(DISTINCT CASE WHEN J.JobStatus = 'Active' AND J.DatePosted BETWEEN @StartDate AND @EndDate THEN J.JobID END) AS ActiveJobs,
                    COUNT(DISTINCT CASE WHEN J.JobStatus = 'Pending Approval' AND J.DatePosted BETWEEN @StartDate AND @EndDate THEN J.JobID END) AS PendingJobs,
                    COUNT(DISTINCT CASE WHEN J.JobStatus = 'Rejected' AND J.DatePosted BETWEEN @StartDate AND @EndDate THEN J.JobID END) AS RejectedJobs,
                    COUNT(DISTINCT CASE WHEN JA.ApplicationDate BETWEEN @StartDate AND @EndDate THEN JA.ApplicationID END) AS TotalApplications,
                    COUNT(DISTINCT CASE WHEN JA.Status = 'Shortlisted' AND JA.ApplicationDate BETWEEN @StartDate AND @EndDate THEN JA.ApplicationID END) AS Shortlisted,
                    COUNT(DISTINCT CASE WHEN JA.Status = 'Interview Scheduled' AND JA.ApplicationDate BETWEEN @StartDate AND @EndDate THEN JA.ApplicationID END) AS Interview,
                    COUNT(DISTINCT CASE WHEN JA.Status = 'Hired' AND JA.ApplicationDate BETWEEN @StartDate AND @EndDate THEN JA.ApplicationID END) AS Hired,
                    COUNT(DISTINCT CASE WHEN JA.Status = 'Rejected' AND JA.ApplicationDate BETWEEN @StartDate AND @EndDate THEN JA.ApplicationID END) AS Rejected
                FROM
                    Companies C
                LEFT JOIN
                    Jobs J ON C.CompanyID = J.CompanyID
                LEFT JOIN
                    JobApplications JA ON J.JobID = JA.JobID
                GROUP BY
                    C.CompanyID, C.CompanyName
                ORDER BY
                    TotalJobs DESC, TotalApplications DESC";

            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                sda.SelectCommand.Parameters.AddWithValue("@StartDate", startDate);
                sda.SelectCommand.Parameters.AddWithValue("@EndDate", endDate);

                dtCompanyStats.Clear(); // Clear static table before refilling
                sda.Fill(dtCompanyStats);
                gvCompanyStats.DataSource = dtCompanyStats;
                gvCompanyStats.DataBind();
            }
        }
    }

    protected void gvCompanyStats_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalJobs += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalJobs"));
            totalActive += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ActiveJobs"));
            totalPending += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PendingJobs"));
            totalRejectedJobs += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "RejectedJobs"));
            totalApps += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalApplications"));
            totalShortlisted += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Shortlisted"));
            totalInterview += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Interview"));
            totalHired += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Hired"));
            totalRejectedApps += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Rejected"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            ((Literal)e.Row.FindControl("ltTotalJobs")).Text = totalJobs.ToString();
            ((Literal)e.Row.FindControl("ltActiveJobs")).Text = totalActive.ToString();
            ((Literal)e.Row.FindControl("ltPendingJobs")).Text = totalPending.ToString();
            ((Literal)e.Row.FindControl("ltRejectedJobs")).Text = totalRejectedJobs.ToString();
            ((Literal)e.Row.FindControl("ltTotalApps")).Text = totalApps.ToString();
            ((Literal)e.Row.FindControl("ltTotalShortlisted")).Text = totalShortlisted.ToString();
            ((Literal)e.Row.FindControl("ltTotalInterview")).Text = totalInterview.ToString();
            ((Literal)e.Row.FindControl("ltTotalHired")).Text = totalHired.ToString();
            ((Literal)e.Row.FindControl("ltTotalRejectedApps")).Text = totalRejectedApps.ToString();
        }
    }

    private void BindJobSeekers()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT JobSeekerID, FirstName, LastName, Email, Country, AccountStatus FROM JobSeekers ORDER BY FirstName";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                dtJobSeekers.Clear(); // Clear static table
                sda.Fill(dtJobSeekers);
                gvJobSeekers.DataSource = dtJobSeekers;
                gvJobSeekers.DataBind();

                totalSeekers = dtJobSeekers.Rows.Count;
                activeSeekers = dtJobSeekers.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Active");
                suspendedSeekers = dtJobSeekers.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Suspended");

                ltTotalSeekers.Text = totalSeekers.ToString();
                ltActiveSeekers.Text = activeSeekers.ToString();
                ltSuspendedSeekers.Text = suspendedSeekers.ToString();
            }
        }
    }

    private void BindCompanies()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT CompanyID, CompanyName, ContactName, Email, Country, AccountStatus FROM Companies ORDER BY CompanyName";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                dtCompanies.Clear(); // Clear static table
                sda.Fill(dtCompanies);
                gvCompanies.DataSource = dtCompanies;
                gvCompanies.DataBind();

                totalEmployers = dtCompanies.Rows.Count;
                activeEmployers = dtCompanies.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Active");
                suspendedEmployers = dtCompanies.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Suspended");

                ltTotalEmployers.Text = totalEmployers.ToString();
                ltActiveEmployers.Text = activeEmployers.ToString();
                ltSuspendedEmployers.Text = suspendedEmployers.ToString();
            }
        }
    }

    // --- Paging Event Handlers ---
    protected void gvCompanyStats_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCompanyStats.PageIndex = e.NewPageIndex;
        BindCompanyStats();
    }

    protected void gvJobSeekers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvJobSeekers.PageIndex = e.NewPageIndex;
        BindJobSeekers();
    }

    protected void gvCompanies_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCompanies.PageIndex = e.NewPageIndex;
        BindCompanies();
    }

    // --- Export Methods ---
    protected void btnExportStats_Click(object sender, EventArgs e)
    {
        // For export, we need ALL data, not just one page.
        // So, we re-bind without paging to get the full dtCompanyStats.
        gvCompanyStats.AllowPaging = false;
        BindCompanyStats();

        if (dtCompanyStats.Rows.Count > 0)
        {
            ExportDataTableToCsv(dtCompanyStats, $"Company_Hiring_Stats_{ddlDateRange.SelectedValue}.csv");
        }

        gvCompanyStats.AllowPaging = true; // Turn paging back on
        BindCompanyStats();
    }

    protected void btnExportJobSeekers_Click(object sender, EventArgs e)
    {
        gvJobSeekers.AllowPaging = false;
        BindJobSeekers();

        if (dtJobSeekers.Rows.Count > 0)
        {
            ExportDataTableToCsv(dtJobSeekers, "All_JobSeekers_Report.csv");
        }

        gvJobSeekers.AllowPaging = true;
        BindJobSeekers();
    }

    protected void btnExportEmployers_Click(object sender, EventArgs e)
    {
        gvCompanies.AllowPaging = false;
        BindCompanies();

        if (dtCompanies.Rows.Count > 0)
        {
            ExportDataTableToCsv(dtCompanies, "All_Employers_Report.csv");
        }

        gvCompanies.AllowPaging = true;
        BindCompanies();
    }

    private void ExportDataTableToCsv(DataTable dt, string fileName)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ContentType = "text/csv";
        HttpContext.Current.Response.AddHeader("Content-Disposition", $"attachment; filename={fileName}");

        StringBuilder sb = new StringBuilder();
        foreach (DataColumn column in dt.Columns)
        {
            sb.Append(CsvSafe(column.ColumnName) + ',');
        }
        sb.Remove(sb.Length - 1, 1);
        sb.Append(Environment.NewLine);

        foreach (DataRow row in dt.Rows)
        {
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                sb.Append(CsvSafe(row[i].ToString()) + ',');
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append(Environment.NewLine);
        }

        // CORRECTED: Calculate totals directly from the static DataTables for export
        if (dt == dtCompanyStats)
        {
            sb.Append(Environment.NewLine);
            sb.Append("TOTALS,");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("TotalJobs")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("ActiveJobs")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("PendingJobs")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("RejectedJobs")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("TotalApplications")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("Shortlisted")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("Interview")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("Hired")) + ",");
            sb.Append(dt.AsEnumerable().Sum(row => row.Field<int>("Rejected")) + Environment.NewLine);
        }

        if (dt == dtJobSeekers)
        {
            int total = dt.Rows.Count;
            int active = dt.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Active");
            int suspended = dt.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Suspended");

            sb.Append(Environment.NewLine);
            sb.Append($"Total Job Seekers,{total},Active,{active},Suspended,{suspended}");
            sb.Append(Environment.NewLine);
        }

        if (dt == dtCompanies)
        {
            int total = dt.Rows.Count;
            int active = dt.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Active");
            int suspended = dt.AsEnumerable().Count(row => row.Field<string>("AccountStatus") == "Suspended");

            sb.Append(Environment.NewLine);
            sb.Append($"Total Employers,{total},Active,{active},Suspended,{suspended}");
            sb.Append(Environment.NewLine);
        }

        HttpContext.Current.Response.Write(sb.ToString());
        HttpContext.Current.Response.End();
    }

    private string CsvSafe(string text)
    {
        if (text.Contains(",") || text.Contains("\"") || text.Contains("\n"))
        {
            return $"\"{text.Replace("\"", "\"\"")}\"";
        }
        return text;
    }
}
