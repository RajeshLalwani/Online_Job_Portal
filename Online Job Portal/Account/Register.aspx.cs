using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using Online_Job_Portal;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

public partial class Account_Register : Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
        //protected void CreateUser_Click(object sender, EventArgs e)
        //{
        //    //var manager = new UserManager();
        //    //var user = new ApplicationUser() { UserName = UserName.Text };
        //    //IdentityResult result = manager.Create(user, Password.Text);
        //    //if (result.Succeeded)
        //    //{
        //    //    IdentityHelper.SignIn(manager, user, isPersistent: false);
        //    //    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        //    //}
        //    //else
        //    //{
        //    //    ErrorMessage.Text = result.Errors.FirstOrDefault();
        //    //}
        //}

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["title"] != null && Session["text"] != null && Session["icon"] != null)
        {
            string title = Session["title"] as string;

            string text = Session["text"] as string;
            string icon = Session["icon"] as string;

            string script = $@"
                            Swal.fire({{ 
                            title: '{title}', 
                            text: '{text}', 
                            icon: '{icon}', 
                            confirmButtonText: 'OK' 
                              }});
                             ";
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

            Session.Remove("title");
            Session.Remove("text");
            Session.Remove("icon");
        }

        if(SecQueD.SelectedValue== "Custom")
        {
            SecQueTP.Visible = true;
            SecQueT.Focus();
        }
        else
        {
            SecQueTP.Visible = false;
        }
        
    }

    protected void Register_Click(object sender, EventArgs e)
    {


        try
        {
            if (ProfPhoto.HasFile)
            {
                String strpath = System.IO.Path.GetExtension(ProfPhoto.FileName);


                if (strpath != ".jpg"  && strpath != ".jpeg" && strpath != ".png")  //FileUpload1.FileName  // && strpath != ".pdf" && strpath != ".jpeg" && strpath != ".png"
                {
                    ErrorMessage.Visible = true;
                    FailureText.CssClass = "alert alert-danger";
                    FailureText.Text = "Error : Only (.jpg, .jpeg and .png) File Formats are Accepted..!"; //+ ex.ToString();
                    FailureText.Focus();
                   
                }
                else if (strpath == ".jpg" || strpath != ".jpeg" || strpath != ".png")
                {
                    int filesize = ProfPhoto.PostedFile.ContentLength;

                    if (filesize > 1000000)
                    {
                        ErrorMessage.Visible = true;
                        FailureText.CssClass = "alert alert-danger";
                        FailureText.Text = "Error : Please Upload files within 1MB only...!"; //+ ex.ToString();
                        FailureText.Focus();
                       
                    }
                    else
                    {
                        String filename = "Profile_Photo" + "_" + UserName.Text + strpath;

                        ProfPhoto.SaveAs(Server.MapPath("../Assets/Images/Profile_Photos//" + filename));



                        con.Open();
                        SqlCommand cmd = new SqlCommand("Insert into Users (UType,UStatus,UserName,Password,FullName,Address,MobileNo,Email,Country,SecQue,SQAnswer,ProfPhoto) " +
                            "values (@UType,@UStatus,@UserName,@Password,@FullName,@Address,@MobileNo,@Email,@Country,@SecQue,@SQAnswer,@ProfPhoto)", con);

                        cmd.Parameters.AddWithValue("@UType", Utype.SelectedValue);

                        cmd.Parameters.AddWithValue("@UStatus", "UnLocked");
                        cmd.Parameters.AddWithValue("@UserName", UserName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", Password.Text.Trim());
                        cmd.Parameters.AddWithValue("@FullName", FullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", Address.Text.Trim());
                        cmd.Parameters.AddWithValue("@MobileNo", MobileNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());

                        cmd.Parameters.AddWithValue("@Country", Country.SelectedValue);

                        if (SecQueD.SelectedValue == "Custom")
                        {

                            cmd.Parameters.AddWithValue("@SecQue", SecQueT.Text);

                        }
                        else if (SecQueD.SelectedValue != "Custom")
                        {
                            cmd.Parameters.AddWithValue("@SecQue", SecQueD.SelectedValue.ToString());
                        }

                        else
                        {
                            string errorMessage = "Error: Please Select Security Qestion First...'";
                            string script = $@"
                            Swal.fire({{ 
                            title: 'Error!', 
                            text: '{errorMessage}', 
                            icon: 'error', 
                            confirmButtonText: 'OK' 
                              }});
                             ";
                            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                            // Response.Write("<script LANGUAGE='JavaScript' >alert('\tError: Please Select Security Qestion First...')</script>");

                        }
                        

                        cmd.Parameters.AddWithValue("@SQAnswer", SQAnswer.Text.Trim());

                        cmd.Parameters.AddWithValue("@ProfPhoto", filename);



                        int r = cmd.ExecuteNonQuery();

                        if (r > 0)
                        {
                            Session["title"] = "Success";
                            Session["text"] = "User Registration Successful...";
                            Session["icon"] = "success";
                            Response.Redirect("Login.aspx");
                            //Session["UserName"] = UserName.Text.Trim();
                            //Session["UType"] = Utype.SelectedValue;
                            //Session["UStatus"] = "UnLocked";

                            //if(Session["UserType"].ToString() == "Job Seeker" && Session["UStatus"].ToString() == "UnLocked" && Session["UserName"].ToString() != null)
                            //{
                            //    Response.Redirect("../Users/Job_Seeker/Home");
                            //}

                            //if (Session["UserType"].ToString() == "Employer" && Session["UStatus"].ToString() == "UnLocked" && Session["UserName"].ToString() != null)
                            //{
                            //    Response.Redirect("../Users/Employer/Home");
                            //}

                            //if (Session["UserType"].ToString() == "Job Seeker" && Session["UStatus"].ToString() == "UnLocked" && Session["UserName"].ToString() != null)
                            //{
                            //    Response.Redirect("../Users/Job_Seeker/Home");
                            //}


                            //string script = @"
                            // swal.fire({
                            // title: 'success', 
                            // text: 'registration successful...', 
                            // icon: 'success', 
                            // confirmbuttontext: 'ok' 
                            //});
                            //";
                            //ClientScript.RegisterStartupScript(this.GetType(), "sweetalert", script, true);

                            //ErrorMessage.Visible = true;
                            //FailureText.CssClass = "alert alert-success";
                            //FailureText.Text = "Registration Successful...";
                            //FailureText.Focus();
                            //clear();



                        }
                        else
                        {
                            ErrorMessage.Visible = true;
                            FailureText.CssClass = "alert alert-danger";
                            FailureText.Text = "Error : Unable to Save Record. Please Try Again After Some Time."; //+ ex.ToString();
                            FailureText.Focus();
                        }




                    


                    }
                }
            }
            else
            {
                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-danger";
                FailureText.Text = "Error : Please Select Any File...!"; //+ ex.ToString();
                FailureText.Focus();
      
            }

           



        }
        catch (Exception ex)
        {
            if(ex.Message.Contains("Violation of UNIQUE KEY constraint"))
            {
                string errorMessage = "Error : @" + UserName.Text.Trim() + " User Already Exists, Try Different One...!";
                string script = $@"
                    Swal.fire({{ 
                    title: 'Error!', 
                    text: '{errorMessage}', 
                    icon: 'warning', 
                    confirmButtonText: 'OK' 
                    }});
                    ";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-warning";
                FailureText.Text = "<b>@" + UserName.Text.Trim() + "</b>" + " User Already Exists, Try Different One...!"; 
                FailureText.Focus();

            }
            else
            {
                string errorMessage = HttpUtility.JavaScriptStringEncode(ex.ToString());//"Error: Unable to Save Record, Try Again After Some Time...!";
                string script = $@"
                    Swal.fire({{ 
                    title: 'Error!', 
                    text: '{errorMessage}', 
                    icon: 'error', 
                    confirmButtonText: 'OK' 
                    }});
                    ";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

                ErrorMessage.Visible = true;
                FailureText.CssClass = "alert alert-danger";
                FailureText.Text = "Error: Unable to Save Record, Try Again After Some Time...!";
                FailureText.Focus();
            }
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

        }
        finally
        {
            con.Close();
        }

    }

    private void clear()
    {
        Utype.ClearSelection(); //
        UserName.Text = String.Empty;
        Password.Text = String.Empty;
        ConfirmPassword.Text = String.Empty;
        FullName.Text = String.Empty;
        Address.Text = String.Empty;
        MobileNo.Text = String.Empty;
        Email.Text = String.Empty;
        Country.ClearSelection(); //
        SecQueD.ClearSelection(); //
        SecQueT.Text = String.Empty;
        SQAnswer.Text = String.Empty;
        ProfPhoto.Attributes.Clear();

    }
}