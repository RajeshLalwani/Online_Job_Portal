using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Admin_Applicants : System.Web.UI.Page
{

    private int jobId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserType"]?.ToString() != "Admin") { Response.Redirect("~/Account/Login.aspx"); }
        if (!int.TryParse(Request.QueryString["id"], out jobId)) { ShowError("Invalid Job ID."); return; }
        if (!IsPostBack)
        {
            BindApplicants();
            LoadApplicantStats();
        }
    }

    private void BindApplicants()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT js.JobSeekerID, js.FirstName, js.LastName, js.ProfessionalTitle, js.ProfilePicturePath, ja.Status
                             FROM JobApplications ja
                             INNER JOIN JobSeekers js ON ja.JobSeekerID = js.JobSeekerID
                             WHERE ja.JobID = @JobID";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                sda.SelectCommand.Parameters.AddWithValue("@JobID", jobId);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                rptApplicants.DataSource = dt;
                rptApplicants.DataBind();
                pnlNoApplicants.Visible = dt.Rows.Count == 0;
            }
        }
    }

    private void LoadApplicantStats()
    {
        string cs = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT Status, COUNT(*) AS StatusCount FROM JobApplications WHERE JobID = @JobID GROUP BY Status";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobID", jobId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    int total = 0;
                    while (reader.Read())
                    {
                        int count = Convert.ToInt32(reader["StatusCount"]);
                        total += count;
                        switch (reader["Status"].ToString())
                        {
                            case "Pending": ltPending.Text = count.ToString(); break;
                            case "Shortlisted": ltShortlisted.Text = count.ToString(); break;
                            case "Interview Scheduled": ltInterview.Text = count.ToString(); break;
                            case "Hired": ltHired.Text = count.ToString(); break;
                            case "Rejected": ltRejected.Text = count.ToString(); break;
                        }
                    }
                    ltTotal.Text = total.ToString();
                }

                // Get Job Title for the hero section
                cmd.CommandText = "SELECT JobTitle FROM Jobs WHERE JobID = @JobID";
                object result = cmd.ExecuteScalar();
                if (result != null) ltJobTitle.Text = result.ToString();
            }
        }
    }

    private void ShowError(string message)
    {
        string script = $"Swal.fire('Error', '{HttpUtility.JavaScriptStringEncode(message)}', 'error');";
        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlertError", script, true);
    }
}

