using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Employer_EditJob : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null || Session["UserType"]?.ToString() != "Employer")
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        if (!int.TryParse(Request.QueryString["id"], out jobId))
        {
            ShowError("Invalid job ID provided.");
            btnUpdateJob.Enabled = false;
            return;
        }

        if (!IsPostBack)
        {
            cvApplicationDeadline.ValueToCompare = DateTime.Now.ToString("yyyy-MM-dd");
            BindCountryDropDown();
            LoadJobDetails();
        }
    }

    private void LoadJobDetails()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Jobs WHERE JobID = @JobID AND CompanyID = @CompanyID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtJobTitle.Text = reader["JobTitle"].ToString();
                        ddlJobType.SelectedValue = reader["JobType"].ToString();
                        txtExperienceRequired.Text = reader["ExperienceRequired"].ToString();

                        SetSelectedQualifications(reader["QualificationRequired"].ToString());

                        txtSalary.Text = reader["Salary"].ToString();
                        txtCity.Text = reader["City"].ToString();
                        txtState.Text = reader["State"].ToString();
                        ddlCountry.SelectedValue = reader["Country"].ToString();
                        txtSkills.Text = reader["SkillsRequired"].ToString();
                        txtJobDescription.Text = reader["JobDescription"].ToString();
                        txtApplicationDeadline.Text = Convert.ToDateTime(reader["ApplicationDeadline"]).ToString("yyyy-MM-dd");

                        ltCurrentStatus.Text = Server.HtmlEncode(reader["JobStatus"].ToString());
                        pnlStatusInfo.Visible = true;
                    }
                    else
                    {
                        ShowError("Job not found or you do not have permission to edit it.");
                        btnUpdateJob.Enabled = false;
                    }
                }
            }
        }
    }

    protected void btnUpdateJob_Click(object sender, EventArgs e)
    {
        cvQualification.Validate();
        if (Page.IsValid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Jobs SET 
                                 JobTitle = @JobTitle, JobDescription = @JobDescription, SkillsRequired = @SkillsRequired, 
                                 City = @City, State = @State, Country = @Country, JobType = @JobType, 
                                 ExperienceRequired = @ExperienceRequired, QualificationRequired = @QualificationRequired, Salary = @Salary, 
                                 ApplicationDeadline = @ApplicationDeadline, JobStatus = 'Pending Approval'
                                 WHERE JobID = @JobID AND CompanyID = @CompanyID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
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
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    cmd.Parameters.AddWithValue("@CompanyID", Session["UserID"]);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        ShowSuccess("Your job posting has been updated and sent for admin approval.", "PostedJobs.aspx");
                    }
                    catch (Exception ex)
                    {
                        ShowError("An error occurred while updating the job. Please try again later.");
                    }
                }
            }
        }
    }

    protected void cvQualification_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = lbQualificationRequired.SelectedItem != null;
    }

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

    private void SetSelectedQualifications(string qualifications)
    {
        if (string.IsNullOrEmpty(qualifications)) return;

        List<string> selectedList = qualifications.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                  .Select(s => s.Trim())
                                                  .ToList();

        foreach (ListItem item in lbQualificationRequired.Items)
        {
            if (selectedList.Contains(item.Value))
            {
                item.Selected = true;
            }
        }
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

