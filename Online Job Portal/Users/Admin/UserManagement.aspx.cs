using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_UserManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindJobSeekers();
            BindCompanies();
        }
    }

    private void BindJobSeekers()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT JobSeekerID, FirstName, LastName, Email, AccountStatus FROM JobSeekers";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvJobSeekers.DataSource = dt;
                gvJobSeekers.DataBind();
            }
        }
    }

    private void BindCompanies()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CompanyID, CompanyName, Email, ContactName, AccountStatus FROM Companies";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCompanies.DataSource = dt;
                gvCompanies.DataBind();
            }
        }
    }

    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView grid = (GridView)sender;
        string userType = grid.ID == "gvJobSeekers" ? "JobSeeker" : "Company";

        if (e.CommandName == "ToggleStatus")
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            int userId = Convert.ToInt32(args[0]);
            string currentStatus = args[1];
            string newStatus = currentStatus == "Active" ? "Suspended" : "Active";
            UpdateUserStatus(userId, newStatus, userType);
        }
        else if (e.CommandName == "DeleteUser")
        {
            int userId = Convert.ToInt32(e.CommandArgument);
            DeleteUser(userId, userType);
        }
    }

    // Helper method to generate the SweetAlert confirmation script
    protected string GetDeleteClientClick(string userType)
    {
        string message = userType == "user"
            ? "Are you sure you want to permanently delete this user? This will also delete their applications."
            : "Are you sure you want to permanently delete this company? This will also delete all their job postings.";
        return $"return confirmAction(this, event, 'Confirm Deletion', '{HttpUtility.JavaScriptStringEncode(message)}');";
    }

    private void UpdateUserStatus(int userId, string newStatus, string userType)
    {
        string tableName = userType == "JobSeeker" ? "JobSeekers" : "Companies";
        string idColumn = userType == "JobSeeker" ? "JobSeekerID" : "CompanyID";

        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = $"UPDATE {tableName} SET AccountStatus = @Status WHERE {idColumn} = @ID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@ID", userId);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("User status updated successfully.");
                    if (userType == "JobSeeker") BindJobSeekers(); else BindCompanies();
                }
                catch (Exception ex) { ShowError("Error updating status."); }
            }
        }
    }

    private void DeleteUser(int userId, string userType)
    {
        string tableName = userType == "JobSeeker" ? "JobSeekers" : "Companies";
        string idColumn = userType == "JobSeeker" ? "JobSeekerID" : "CompanyID";

        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = $"DELETE FROM {tableName} WHERE {idColumn} = @ID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", userId);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("User deleted successfully.");
                    if (userType == "JobSeeker") BindJobSeekers(); else BindCompanies();
                }
                catch (Exception ex) { ShowError("Error deleting user. They may have related records (e.g., job postings or applications) that must be removed first."); }
            }
        }
    }

    // NEW: Page index changing event handler for both GridViews
    protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView gv = (GridView)sender;
        gv.PageIndex = e.NewPageIndex;

        if (gv.ID == "gvJobSeekers")
        {
            BindJobSeekers();
        }
        else if (gv.ID == "gvCompanies")
        {
            BindCompanies();
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

