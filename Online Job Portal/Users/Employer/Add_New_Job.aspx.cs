using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_Add_New_Job : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Employer")
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            cvApplicationDeadline.ValueToCompare = DateTime.Now.ToString("yyyy-MM-dd");
            BindCountryDropDown();
        }
    }

    protected void btnPostJob_Click(object sender, EventArgs e)
    {
        // Re-validate the custom validator on postback
        cvQualification.Validate();

        if (Page.IsValid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Jobs 
                                 (CompanyID, JobTitle, JobDescription, SkillsRequired, City, State, Country, JobType, ExperienceRequired, QualificationRequired, Salary, ApplicationDeadline) 
                                 VALUES 
                                 (@CompanyID, @JobTitle, @JobDescription, @SkillsRequired, @City, @State, @Country, @JobType, @ExperienceRequired, @QualificationRequired, @Salary, @ApplicationDeadline)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                    cmd.Parameters.AddWithValue("@JobTitle", txtJobTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@JobDescription", txtJobDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@SkillsRequired", txtSkills.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                    cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());
                    cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@JobType", ddlJobType.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExperienceRequired", txtExperienceRequired.Text.Trim());
                    cmd.Parameters.AddWithValue("@QualificationRequired", GetSelectedQualifications());
                    cmd.Parameters.AddWithValue("@Salary", string.IsNullOrEmpty(txtSalary.Text) ? "N/A" : txtSalary.Text.Trim());
                    cmd.Parameters.AddWithValue("@ApplicationDeadline", Convert.ToDateTime(txtApplicationDeadline.Text));

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Session["title"] = "Success!";
                        Session["text"] = "Your job has been posted and is pending admin approval.";
                        Session["icon"] = "success";
                        Response.Redirect("PostedJobs.aspx");
                    }
                    catch (Exception ex)
                    {
                        ShowError("An error occurred while posting the job. Please try again later.");
                    }
                }
            }
        }
    }

    // NEW: Custom validator for the CheckBoxList
    protected void cvQualification_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = lbQualificationRequired.SelectedItem != null;
    }

    // NEW: Helper function to get selections from CheckBoxList
    private string GetSelectedQualifications()
    {
        var selectedQualifications = new List<string>();
        foreach (ListItem item in lbQualificationRequired.Items)
        {
            if (item.Selected)
            {
                selectedQualifications.Add(item.Value);
            }
        }
        return string.Join(", ", selectedQualifications);
    }

    private void BindCountryDropDown()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT CName FROM Country ORDER BY CName ASC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                ddlCountry.DataSource = cmd.ExecuteReader();
                ddlCountry.DataTextField = "CName";
                ddlCountry.DataValueField = "CName";
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("-- Select Country --", ""));
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{System.Web.HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }
}

