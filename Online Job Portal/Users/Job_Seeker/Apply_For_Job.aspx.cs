using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_Apply_For_Job : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {

    }

    protected string FormatTimeAgo(object createdDateObject)
    {
        if (createdDateObject == null || createdDateObject == DBNull.Value)
        {
            return string.Empty;
        }

        DateTime createdDate = Convert.ToDateTime(createdDateObject);
        TimeSpan timeSince = DateTime.Now.Subtract(createdDate);

        if (timeSince.TotalMinutes < 1)
        {
            return "just now";
        }
        if (timeSince.TotalMinutes < 60)
        {
            return $"{Math.Floor(timeSince.TotalMinutes)} minutes ago";
        }
        if (timeSince.TotalHours < 24)
        {
            return $"{Math.Floor(timeSince.TotalHours)} hours ago";
        }
        if (timeSince.TotalDays < 30)
        {
            return $"{Math.Floor(timeSince.TotalDays)} days ago";
        }
        if (timeSince.TotalDays < 365)
        {
            int months = Convert.ToInt32(Math.Floor(timeSince.TotalDays / 30));
            return $"{months} {(months > 1 ? "months" : "month")} ago";
        }
        else
        {
            int years = Convert.ToInt32(Math.Floor(timeSince.TotalDays / 365));
            return $"{years} {(years > 1 ? "years" : "year")} ago";
        }
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        // e.AffectedRows contains the number of records returned by the query.
        // We format this into the string we want to display.
        lblJobCount.Text = $"{e.AffectedRows:N0} Jobs found";
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
}