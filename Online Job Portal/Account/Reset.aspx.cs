using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_Reset : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        ErrorMessage.Visible = false;

        Utype.Text = Request.QueryString["utype"].ToString();
        UserName.Text = Request.QueryString["unm"].ToString();
    }

    protected void Reset_Click(object sender, EventArgs e)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Update Users set Password=@Password where UserName=@UserName and UType=@UType", con);

            cmd.Parameters.AddWithValue("@Password", NewPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@UserName", UserName.Text.Trim());
            cmd.Parameters.AddWithValue("@UType", Utype.Text.Trim());
            
       


            int r = cmd.ExecuteNonQuery();

            if (r > 0)
            {
                Session["title"] = "Success";
                Session["text"] = "Your Password Has Been Changed Successfully...";
                Session["icon"] = "success";

                Response.Redirect("Login.aspx");

                string script = @"
                    Swal.fire({
                    title: 'Success', 
                    text: 'Your Password has been Changed Successfully...', 
                    icon: 'success', 
                    confirmButtonText: 'OK' 
                    });
                    ";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-success";
                FailureText.Text = "Thanks for Reaching Out, We'll Look into Your Query...";
                FailureText.Focus();
               

            }
            else
            {
                string script = @"
                    Swal.fire({
                    title: 'Error', 
                    text: 'Error: Unable to Changee Your Password, Try Again After Some Time...', 
                    icon: 'error', 
                    confirmButtonText: 'OK' 
                    });
                    ";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-danger";
                FailureText.Text = "Error : Unable to Changee Your Password, Try Again After Some Time..."; //+ ex.ToString();
                FailureText.Focus();
            }






        }
        catch (Exception ex)
        {
            string errorMessage = HttpUtility.JavaScriptStringEncode(ex.ToString());
            string script = $@"
                    Swal.fire({{ 
                    title: 'Error!', 
                    text: '{errorMessage}', 
                    icon: 'error', 
                    confirmButtonText: 'OK' 
                    }});
                    ";
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "k", "swal('Error!','ex.ToString()','error')",true);

            //ErrorMessage.Visible = true;
            //FailureText.CssClass = "alert alert-danger";
            //FailureText.Text = "Error : "+ ex.ToString();
            //FailureText.Focus();

            ErrorMessage.Visible = true;
            FailureText.CssClass = "alert alert-danger";
            FailureText.Text = "Error : Unable to Changee Your Password, Try Again After Some Time..."; //+ ex.ToString();
            FailureText.Focus();

        }
        finally
        {
            con.Close();
        }

    }
}