using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using Online_Job_Portal;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;

public partial class Account_Login : Page
{
   
    protected void Page_Load(object sender, EventArgs e)
        {

        if (!IsPostBack)
        {
            // Set a default registration link
            RegisterHyperLink.NavigateUrl = "RegisterSeeker.aspx";
        }

        // Check for "Remember Me" cookie and pre-fill form
        if (Request.Cookies["RememberMe"] != null)
        {
            Email.Text = Request.Cookies["RememberMe"]["Email"];
            Utype.SelectedValue = Request.Cookies["RememberMe"]["UserType"];
            RememberMe.Checked = true;
        }
    }

    private void HandleRememberMe(string email, string userType)
    {
        if (RememberMe.Checked)
        {
            // Create a new cookie to remember the user
            HttpCookie cookie = new HttpCookie("RememberMe");
            cookie["Email"] = email;
            cookie["UserType"] = userType;
            cookie.Expires = DateTime.Now.AddDays(30); // Cookie persists for 30 days
            Response.Cookies.Add(cookie);
        }
        else
        {
            // If the user unchecks the box, expire any existing cookie
            if (Request.Cookies["RememberMe"] != null)
            {
                Response.Cookies["RememberMe"].Expires = DateTime.Now.AddDays(-1);
            }
        }
    }





    protected void Login_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string userType = Utype.SelectedValue;
            string email = Email.Text.Trim();
            string password = Password.Text.Trim();

            try
            {
                switch (userType)
                {
                    case "Admin":
                        ValidateAdmin(email, password);
                        break;
                    case "Job Seeker":
                        ValidateJobSeeker(email, password);
                        break;
                    case "Employer":
                        ValidateCompany(email, password);
                        break;
                    default:
                        ShowError("Please select a valid user type.");
                        break;
                }
            }
            catch (Exception ex)
            {
                // For debugging, you should log the full exception: System.Diagnostics.Debug.WriteLine(ex.ToString());
                ShowError("An error occurred. Please try again later.");
            }
        }
    }
    private void ValidateAdmin(string email, string password)
    {
        string adminEmail = WebConfigurationManager.AppSettings["AdminEmail"];
        string adminPassword = WebConfigurationManager.AppSettings["AdminPassword"];

        if (email.Equals(adminEmail, StringComparison.OrdinalIgnoreCase) && password == adminPassword)
        {
            // Admin credentials are correct
            Session["Email"] = email;
            Session["UserType"] = "Admin";

            Session["title"] = "Success";
            Session["text"] = "Admin User Logged in Successfully...";
            Session["icon"] = "success";
            Response.Redirect("../Users/Admin/Home.aspx");
        }
        else
        {
            ShowError("Invalid Admin credentials.");
        }
    }

    private void ValidateJobSeeker(string email, string password)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT JobSeekerID, PasswordHash, AccountStatus FROM JobSeekers WHERE Email = @Email";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string storedHash = reader["PasswordHash"].ToString();
                        string accountStatus = reader["AccountStatus"].ToString();

                        if (accountStatus != "Active")
                        {
                            ShowError("Your account is not active. Please contact support.");
                            return;
                        }

                        if (BCrypt.Net.BCrypt.Verify(password, storedHash))
                        {
                            // Password is correct
                            Session["AccountStatus"] = accountStatus;
                            Session["UserID"] = reader["JobSeekerID"];
                            Session["Email"] = email;
                            Session["UserType"] = "Job Seeker";

                            Session["title"] = "Success";
                            Session["text"] = "Job Seeker User Logged in Successfully...";
                            Session["icon"] = "success";

                            Response.Redirect("../Users/Job_Seeker/Home.aspx");
                        }
                        else
                        {
                            ShowError("Invalid email or password.");
                        }
                    }
                    else
                    {
                        ShowError("Invalid email or password.");
                    }
                }
            }
        }
    }

    private void ValidateCompany(string email, string password)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CompanyID, PasswordHash, AccountStatus FROM Companies WHERE Email = @Email";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string storedHash = reader["PasswordHash"].ToString();
                        string accountStatus = reader["AccountStatus"].ToString();

                        if (accountStatus != "Active")
                        {
                            ShowError("Your company account is not active. Please contact support.");
                            return;
                        }

                        if (BCrypt.Net.BCrypt.Verify(password, storedHash))
                        {
                            // Password is correct
                            Session["AccountStatus"] = accountStatus;
                            Session["UserID"] = reader["CompanyID"];
                            Session["Email"] = email;
                            Session["UserType"] = "Employer";

                            Session["title"] = "Success";
                            Session["text"] = "Employer User Logged in Successfully...";
                            Session["icon"] = "success";

                            Response.Redirect("../Users/Employer/Home.aspx");
                        }
                        else
                        {
                            ShowError("Invalid email or password.");
                        }
                    }
                    else
                    {
                        ShowError("Invalid email or password.");
                    }
                }
            }
        }
    }

    private void ShowError(string message)
    {
        // Using SweetAlert2 for a better user experience
        string script = $"Swal.fire('Login Failed', '{message}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }

    protected void ForgotPasswordLinkButton_Click(object sender, EventArgs e)
    {
        // This validates ONLY the controls in the "fp" group
        Page.Validate("fp");
        if (Page.IsValid)
        {
            string userType = Utype.SelectedValue;
            string userEmail = Email.Text.Trim();
            Response.Redirect($"ForgotPassword.aspx?UType={userType}&UserEmail={userEmail}");
        }
    }
}
