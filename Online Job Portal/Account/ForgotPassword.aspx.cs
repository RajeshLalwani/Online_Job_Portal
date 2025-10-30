using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_ForgotPassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
    string unm, psd = string.Empty;
    SqlDataReader sdr;
    string QA = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Pre-fill fields if coming from the login page with query strings
            if (Request.QueryString["UType"] != null && Request.QueryString["UserEmail"] != null)
            {
                // Ensure the value exists in the dropdown before setting it
                if (ddlUserType.Items.FindByValue(Request.QueryString["UType"]) != null)
                {
                    ddlUserType.SelectedValue = Request.QueryString["UType"];
                }
                txtEmail.Text = Request.QueryString["UserEmail"];
            }
        }

    }


 

    protected void btnFindAccount_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string userType = ddlUserType.SelectedValue;
            string email = txtEmail.Text.Trim();
            string secQuestion = GetSecurityQuestion(email, userType);

            if (!string.IsNullOrEmpty(secQuestion))
            {
                // Account found, store details in session to use in the next step
                Session["ForgotPassword_Email"] = email;
                Session["ForgotPassword_UserType"] = userType;

                lblSecQue.Text = secQuestion;
                pnlStep1.Visible = false;
                pnlStep2.Visible = true;
            }
            else
            {
                ShowError("No account found with that email and user type combination.");
            }
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && Session["ForgotPassword_Email"] != null && Session["ForgotPassword_UserType"] != null)
        {
            string userType = Session["ForgotPassword_UserType"].ToString();
            string email = Session["ForgotPassword_Email"].ToString();
            string providedAnswer = txtSecAns.Text.Trim();
            string newPassword = txtNewPassword.Text;

            if (VerifySecurityAnswer(email, userType, providedAnswer))
            {
                if (UpdatePassword(email, userType, newPassword))
                {
                    // Clear session variables after successful reset
                    Session.Remove("ForgotPassword_Email");
                    Session.Remove("ForgotPassword_UserType");

                    string script = "Swal.fire('Success!', 'Your password has been updated successfully. You can now log in.', 'success').then(() => { window.location.href = 'Login.aspx'; });";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    ShowError("There was an error updating your password. Please try again.");
                }
            }
            else
            {
                ShowError("The security answer is incorrect. Please try again.");
            }
        }
        else
        {
            ShowError("Your session has expired. Please start the process again.");
            pnlStep1.Visible = true;
            pnlStep2.Visible = false;
        }
    }


    private string GetSecurityQuestion(string email, string userType)
    {
        if (userType == "0") return null; // Invalid user type selected
        string tableName = userType == "Job Seeker" ? "JobSeekers" : "Companies";
        string query = $"SELECT SecQue FROM {tableName} WHERE Email = @Email";

        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : null;
            }
        }
    }

    private bool VerifySecurityAnswer(string email, string userType, string answer)
    {
        string tableName = userType == "Job Seeker" ? "JobSeekers" : "Companies";
        string query = $"SELECT SecAns FROM {tableName} WHERE Email = @Email";

        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                object result = cmd.ExecuteScalar();
                // Case-insensitive comparison for user-friendliness
                return result != null && result.ToString().Equals(answer, StringComparison.OrdinalIgnoreCase);
            }
        }
    }

    private bool UpdatePassword(string email, string userType, string newPassword)
    {
        string tableName = userType == "Job Seeker" ? "JobSeekers" : "Companies";
        string newPasswordHash = BCrypt.Net.BCrypt.HashPassword(newPassword);
        string query = $"UPDATE {tableName} SET PasswordHash = @PasswordHash WHERE Email = @Email";

        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@PasswordHash", newPasswordHash);
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }
}

