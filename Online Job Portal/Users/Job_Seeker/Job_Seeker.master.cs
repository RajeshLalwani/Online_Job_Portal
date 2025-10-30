using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Job_Seeker_Job_Seeker : System.Web.UI.MasterPage
{
    //private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    //private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    //private string _antiXsrfTokenValue;

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    // The code below helps to protect against XSRF attacks
    //    var requestCookie = Request.Cookies[AntiXsrfTokenKey];
    //    Guid requestCookieGuidValue;
    //    if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
    //    {
    //        // Use the Anti-XSRF token from the cookie
    //        _antiXsrfTokenValue = requestCookie.Value;
    //        Page.ViewStateUserKey = _antiXsrfTokenValue;
    //    }
    //    else
    //    {
    //        // Generate a new Anti-XSRF token and save to the cookie
    //        _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
    //        Page.ViewStateUserKey = _antiXsrfTokenValue;

    //        var responseCookie = new HttpCookie(AntiXsrfTokenKey)
    //        {
    //            HttpOnly = true,
    //            Value = _antiXsrfTokenValue
    //        };
    //        if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
    //        {
    //            responseCookie.Secure = true;
    //        }
    //        Response.Cookies.Set(responseCookie);
    //    }

    //    Page.PreLoad += master_Page_PreLoad;
    //}

    //protected void master_Page_PreLoad(object sender, EventArgs e)
    //{
    //    if (!IsPostBack)
    //    {
    //        // Set Anti-XSRF token
    //        ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
    //        ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
    //    }
    //    else
    //    {
    //        // Validate the Anti-XSRF token
    //        if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
    //            || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
    //        {
    //            throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
    //        }
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {



        // Security check on every page load for this master page
        if (Session["UserType"] == null || Session["UserType"].ToString() != "Job Seeker" || Session["Email"] == null || Session["UserID"] == null)
        {
            // If the user is not a valid, logged-in Job Seeker, redirect them to the login page.
            Response.Redirect("~/Account/Login.aspx");
        }

        // Display SweetAlert messages if they have been set in the session by another page
        if (Session["title"] != null && Session["text"] != null && Session["icon"] != null)
        {
            string title = Session["title"].ToString();
            string text = Session["text"].ToString();
            string icon = Session["icon"].ToString();

            // Build the JavaScript to show the alert
            string script = $@"Swal.fire({{
                                title: '{title}',
                                text: '{text}',
                                icon: '{icon}',
                                confirmButtonText: 'OK'
                             }});";

            // Register the script to be executed on the client side
            Page.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

            // Clear the session variables after displaying the message to prevent it from showing again
            Session.Remove("title");
            Session.Remove("text");
            Session.Remove("icon");
        }
    }



    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Securely log out the user by clearing all session data
        Session.Clear();
        Session.Abandon();
        Session.RemoveAll();

        // Redirect the user to the guest home page after logging out
        Response.Redirect("~/Users/Guest/Home.aspx");
    }
}
