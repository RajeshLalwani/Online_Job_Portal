using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Guest_FeedBack : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        ErrorMessage.Visible = false;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("Insert into FeedBack (Name,ContactNo,Email,FeedBack,UserType) values (@Name,@ContactNo,@Email,@FeedBack,@UserType)", con);

                cmd.Parameters.AddWithValue("@Name", Name.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactNo", ContactNo.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());
                cmd.Parameters.AddWithValue("@FeedBack", FeedBack.Text.Trim());
                cmd.Parameters.AddWithValue("@UserType", "Guest");


                int r = cmd.ExecuteNonQuery();

                if (r > 0)
                {
                    // ✅ Success popup with animation
                    string successScript = @"Swal.fire({
                                        title: '✅ Success!',
                                        text: 'Thank you for your valuable feedback 🎉',
                                        icon: 'success',
                                        showClass: { popup: 'animate__animated animate__fadeInDown' },
                                        hideClass: { popup: 'animate__animated animate__fadeOutUp' },
                                        confirmButtonColor: '#007bff'
                                    });";
                    ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertSuccess", successScript, true);
                    //string script = @"
                    //    Swal.fire({
                    //    title: 'Success', 
                    //    text: 'Thanks for Reaching Out, We\'ll Look into Your Query...', 
                    //    icon: 'success', 
                    //    confirmButtonText: 'OK' 
                    //    });
                    //    ";
                    //ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                    ErrorMessage.Visible = true;
                    FailureText.CssClass = "alert alert-success";
                    FailureText.Text = "Thanks for Reaching Out, We'll Look into Your Query...";
                    FailureText.Focus();
                    clear();

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
                string errorScript = @"Swal.fire({
                                        title: '⚠️ Error!',
                                        text: 'Something went wrong. Please try again.',
                                        icon: 'error',
                                        showClass: { popup: 'animate__animated animate__shakeX' },
                                        hideClass: { popup: 'animate__animated animate__fadeOut' },
                                        confirmButtonColor: '#dc3545'
                                    });";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", errorScript, true);
                //string errorMessage = HttpUtility.JavaScriptStringEncode(ex.ToString());
                //string script = $@"
                //        Swal.fire({{ 
                //        title: 'Error!', 
                //        text: '{errorMessage}', 
                //        icon: 'error', 
                //        confirmButtonText: 'OK' 
                //        }});
                //        ";
                //ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
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

        else
        {
            // ⚠️ Validation warning
            string validationScript = @"Swal.fire({
                                        title: 'Oops!',
                                        text: 'Please fill all required fields correctly.',
                                        icon: 'warning',
                                        showClass: { popup: 'animate__animated animate__shakeY' },
                                        confirmButtonColor: '#ffc107'
                                    });";
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertValidation", validationScript, true);
        }

    }

    private void clear()
    {
        Name.Text = String.Empty;
        ContactNo.Text = String.Empty;
        Email.Text = String.Empty;
        FeedBack.Text = String.Empty;

    }
}