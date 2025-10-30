using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_Admin : System.Web.UI.MasterPage
{
   
    

    protected void Page_Load(object sender, EventArgs e)
    {
        // Robust security check for the Admin master page
        if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        // Display SweetAlert messages if they have been set in the session
        if (Session["title"] != null && Session["text"] != null && Session["icon"] != null)
        {
            string title = Session["title"].ToString();
            string text = Session["text"].ToString();
            string icon = Session["icon"].ToString();

            string script = $@"Swal.fire({{
                                title: '{title}',
                                text: '{text}',
                                icon: '{icon}',
                                confirmButtonText: 'OK'
                             }});";

            Page.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

            // Clear session variables after displaying the message
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

        // Redirect to the login page after logging out
        Response.Redirect("~/Account/Login.aspx");
    }
}

