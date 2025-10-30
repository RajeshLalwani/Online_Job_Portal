using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Job Seeker")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    string currentPasswordHash = string.Empty;

                    // Step 1: Fetch the current password hash from the database
                    string fetchQuery = "SELECT PasswordHash FROM JobSeekers WHERE JobSeekerID = @JobSeekerID";
                    using (SqlCommand fetchCmd = new SqlCommand(fetchQuery, con))
                    {
                        fetchCmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                        object result = fetchCmd.ExecuteScalar();
                        if (result != null)
                        {
                            currentPasswordHash = result.ToString();
                        }
                    }

                    // Step 2: Verify the entered current password against the stored hash
                    if (!string.IsNullOrEmpty(currentPasswordHash) && BCrypt.Net.BCrypt.Verify(txtCurrentPassword.Text, currentPasswordHash))
                    {
                        // Step 3: If correct, hash the new password and update the database
                        string newPasswordHash = BCrypt.Net.BCrypt.HashPassword(txtNewPassword.Text);
                        string updateQuery = "UPDATE JobSeekers SET PasswordHash = @PasswordHash WHERE JobSeekerID = @JobSeekerID";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                        {
                            updateCmd.Parameters.AddWithValue("@PasswordHash", newPasswordHash);
                            updateCmd.Parameters.AddWithValue("@JobSeekerID", Session["UserID"]);
                            updateCmd.ExecuteNonQuery();
                        }
                        ShowSuccess("Your password has been updated successfully.", "View_Profile.aspx");
                    }
                    else
                    {
                        // If the current password is incorrect
                        ShowError("The current password you entered is incorrect. Please try again.");
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred. Please try again later.");
                }
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }

    private void ShowSuccess(string message, string redirectUrl)
    {
        string script = $@"Swal.fire({{
                            title: 'Success!',
                            text: '{HttpUtility.JavaScriptStringEncode(message)}',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        }}).then((result) => {{
                            if (result.isConfirmed) {{
                                window.location.href = '{redirectUrl}';
                            }}
                        }});";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertSuccess", script, true);
    }
}