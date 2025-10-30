using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contact : Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        ErrorMessage.Visible = false;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Insert into Contact (Name,Email,Subject,Message,UserType) values (@Name,@Email,@Subject,@Message,@UserType)", con);

            cmd.Parameters.AddWithValue("Name", Name.Text.Trim());
            cmd.Parameters.AddWithValue("Email", Email.Text.Trim());
            cmd.Parameters.AddWithValue("Subject", Subject.Text.Trim());
            cmd.Parameters.AddWithValue("Message", Message.Text.Trim());
            cmd.Parameters.AddWithValue("UserType", "Job Seeker");


            int r = cmd.ExecuteNonQuery();

            if (r > 0)
            {
                //Session["title"] = "Success";
                //Session["text"] = "Thanks for Reaching Out, We\'ll Look into Your Query...";
                //Session["icon"] = "success";



                string script = @"
                    Swal.fire({
                    title: 'Success', 
                    text: 'Thanks for Reaching Out, We\'ll Look into Your Query...', 
                    icon: 'success', 
                    confirmButtonText: 'OK' 
                    });
                    ";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-success";
                FailureText.Text = "Thanks for Reaching Out, We'll Look into Your Query...";
                FailureText.Focus();
                clear();
                //Response.Redirect("Contact.aspx");

            }
            else
            {
                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-danger";
                FailureText.Text = "Error : Unable to Save Record. Please Try Again After Some Time."; //+ ex.ToString();
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
            FailureText.Text = "Error : Unable to Save Record. Please Try Again After Some Time."; //+ ex.ToString();
            FailureText.Focus();

        }
        finally
        {
            con.Close();
        }

    }

    private void clear()
    {
        Name.Text = String.Empty;
        Email.Text = String.Empty;
        Subject.Text = String.Empty;
        Message.Text = String.Empty;

    }
}