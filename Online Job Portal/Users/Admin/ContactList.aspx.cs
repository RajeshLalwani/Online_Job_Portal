using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_ContactList : System.Web.UI.Page
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
            BindContactList();
        }
    }

    /// <summary>
    /// Fetches all contact queries from the database and binds them to the repeater.
    /// </summary>
    private void BindContactList()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Contact ORDER BY QueryDate DESC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
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
                        pds.PageSize = 5; // Set to 5 entries
                        pds.CurrentPageIndex = CurrentPage;

                        rptContactList.DataSource = pds;
                        rptContactList.DataBind();

                        BindPager(pds);

                        pnlNoQueries.Visible = dt.Rows.Count == 0;
                        rptContactList.Visible = dt.Rows.Count > 0;
                        btnDeleteAll.Visible = dt.Rows.Count > 0;
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while fetching contact queries.");
                }
            }
        }
    }

    /// <summary>
    /// Handles the delete command from the repeater for individual queries.
    /// </summary>
    protected void rptContactList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "DeleteQuery")
        {
            int contactId = Convert.ToInt32(e.CommandArgument);
            DeleteEntry(contactId, "Contact", "ContactID");
        }
    }

    /// <summary>
    /// Handles the click event for the "Delete All" button.
    /// </summary>
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        DeleteAllEntries("Contact");
    }

    /// <summary>
    /// CORRECTED: Added the missing helper method to generate the client-side script safely.
    /// </summary>
    protected string GetDeleteClientClick(object contactId)
    {
        string message = "Are you sure you want to delete this query?";
        return $"return confirmAction(this, event, 'Delete Query?', '{HttpUtility.JavaScriptStringEncode(message)}');";
    }

    /// <summary>
    /// Deletes a single entry from a specified table by its ID.
    /// </summary>
    private void DeleteEntry(int id, string tableName, string idColumnName)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = $"DELETE FROM {tableName} WHERE {idColumnName} = @ID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("Query deleted successfully.");
                    BindContactList(); // Refresh the list
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while deleting the entry.");
                }
            }
        }
    }

    /// <summary>
    /// Deletes all entries from a specified table.
    /// </summary>
    private void DeleteAllEntries(string tableName)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = $"DELETE FROM {tableName}";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ShowSuccess("All queries have been deleted successfully.");
                    BindContactList(); // Refresh the list
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred while deleting all entries.");
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
        BindContactList();
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

