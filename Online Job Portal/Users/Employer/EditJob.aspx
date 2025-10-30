<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="EditJob.aspx.cs" Inherits="Users_Employer_EditJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .edit-job-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

        .edit-job-hero h1 {
            font-size: 3.5em;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }

        .edit-job-form-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
        }
        
        .form-section-title {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
            display: inline-block;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }
        
        /* --- DEFINITIVE FIX FOR ALL FORM CONTROLS --- */
         .edit-job-form-container .form-group .form-control {
            display: block;
            width: 100% !important; 
            max-width: none !important;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
            height: 42px;
            transition: all 0.3s ease;
        }
         .edit-job-form-container .form-group textarea.form-control {
            height: auto;
        }
        /* --- END OF FIX --- */
        
        .form-control:focus {
            border-color: #7928ca;
            box-shadow: 0 0 0 0.2rem rgba(121, 40, 202, 0.25);
        }

        .validation-error {
            color: #dc3545;
            font-weight: 500;
            font-size: 0.9em;
            margin-top: 5px;
            display: block;
        }
        
        .btn-update-job {
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.4s ease;
            margin-top: 30px;
        }
        .btn-update-job:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }
        
         /* NEW: Styles for the CheckBoxList */
        .qualification-list td {
            padding-bottom: 5px;
            padding-left: 5px;
        }
        .qualification-list label {
            font-weight: normal !important;
            margin-left: 8px;
        }
        .status-info-panel {
            background-color: #f8f7ff;
            border-left: 5px solid #7928ca;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 500;
        }

         /* NEW: Ensure the ListBox height is appropriate */
         .edit-job-form-container .form-group .form-control[multiple] {
            height: 220px; /* Show multiple items */
        }
    </style>

    <div class="edit-job-hero">
        <div class="container">
            <h1>Edit Job Posting</h1>
            <p class="lead">Update the details for your job listing below.</p>
        </div>
    </div>

    <div class="container" style="margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="edit-job-form-container">
                    
                    <asp:Panel ID="pnlStatusInfo" runat="server" CssClass="status-info-panel" Visible="false">
                        <strong>Current Job Status:</strong> <asp:Literal ID="ltCurrentStatus" runat="server"></asp:Literal>
                        <br />
                        <small>Note: Any changes made will submit the job for admin re-approval.</small>
                    </asp:Panel>
                    
                    <h3 class="form-section-title">Job Details</h3>
                    <div class="form-group">
                        <label for="<%= txtJobTitle.ClientID %>">Job Title</label>
                        <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="e.g., Senior Backend Developer"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvJobTitle" runat="server" ControlToValidate="txtJobTitle" ErrorMessage="Job Title is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revJobTitle" runat="server" ControlToValidate="txtJobTitle" ErrorMessage="Job Title must contain only valid characters." ValidationExpression="^[a-zA-Z0-9\s.,'\-&]+$" CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                     <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= ddlJobType.ClientID %>">Job Type</label>
                                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Job Type --</asp:ListItem>
                                    <asp:ListItem>Full-time</asp:ListItem>
                                    <asp:ListItem>Part-time</asp:ListItem>
                                    <asp:ListItem>Contract</asp:ListItem>
                                    <asp:ListItem>Internship</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvJobType" runat="server" ControlToValidate="ddlJobType" InitialValue="" ErrorMessage="Job Type is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtExperienceRequired.ClientID %>">Experience Required</label>
                                <asp:TextBox ID="txtExperienceRequired" runat="server" CssClass="form-control" placeholder="e.g., 2-4 Years or Fresher"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvExperienceRequired" runat="server" ControlToValidate="txtExperienceRequired" ErrorMessage="Experience is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                         <div class="col-md-12">
                            <%-- CORRECTED: Replaced CheckBoxList with a Multi-Select ListBox --%>
                            <div class="form-group">
                                <label for="<%= lbQualificationRequired.ClientID %>">Qualification Required</label>
                                <asp:ListBox ID="lbQualificationRequired" runat="server" CssClass="form-control" SelectionMode="Multiple" Rows="8">
                                    <asp:ListItem>DCA</asp:ListItem>
                                    <asp:ListItem>BCA</asp:ListItem>
                                    <asp:ListItem>BBA ITM</asp:ListItem>
                                    <asp:ListItem>BBA Business Analytics</asp:ListItem>
                                    <asp:ListItem>BSc IT</asp:ListItem>
                                    <asp:ListItem>BSc Computer Science</asp:ListItem>
                                    <asp:ListItem>B.E. in Computer Science</asp:ListItem>
                                    <asp:ListItem>B. Tech</asp:ListItem>
                                    <asp:ListItem>PGDCA</asp:ListItem>
                                    <asp:ListItem>MCA</asp:ListItem>
                                    <asp:ListItem>MSc IT</asp:ListItem>
                                    <asp:ListItem>MSc AIML</asp:ListItem>
                                    <asp:ListItem>MSc Computer Science</asp:ListItem>
                                    <asp:ListItem>M. Tech</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:ListBox>
                                <small class="help-block">Hold Ctrl (or Cmd) to select multiple qualifications.</small>
                                <asp:CustomValidator ID="cvQualification" runat="server" ErrorMessage="At least one qualification is required." CssClass="validation-error" Display="Dynamic" OnServerValidate="cvQualification_ServerValidate"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="<%= txtSalary.ClientID %>">Salary Range (Optional)</label>
                                <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" placeholder="e.g., 90,000 - 1,20,000 or Competitive"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <hr />
                    <h3 class="form-section-title">Location</h3>
                     <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtCity.ClientID %>">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="e.g., San Francisco"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtState.ClientID %>">State / Province</label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control" placeholder="e.g., California"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" ErrorMessage="State is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revState" runat="server" ControlToValidate="txtState" ErrorMessage="State must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-12">
                             <div class="form-group">
                                <label for="<%= ddlCountry.ClientID %>">Country</label>
                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountry" InitialValue="" ErrorMessage="Country is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <hr />
                    <h3 class="form-section-title">Requirements & Description</h3>
                     <div class="form-group">
                        <label for="<%= txtSkills.ClientID %>">Required Skills</label>
                        <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" style="height: auto;" placeholder="e.g., C#, .NET Core, SQL Server, Azure, React"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSkills" runat="server" ControlToValidate="txtSkills" ErrorMessage="Skills are required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                         <small class="help-block">Please enter comma-separated skills.</small>
                    </div>
                    <div class="form-group">
                        <label for="<%= txtJobDescription.ClientID %>">Job Description</label>
                        <asp:TextBox ID="txtJobDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" style="height: auto;" placeholder="Describe the role, responsibilities, and qualifications..."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvJobDescription" runat="server" ControlToValidate="txtJobDescription" ErrorMessage="Job Description is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <hr />
                     <h3 class="form-section-title">Application Details</h3>
                     <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="<%= txtApplicationDeadline.ClientID %>">Application Deadline</label>
                                <asp:TextBox ID="txtApplicationDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApplicationDeadline" runat="server" ControlToValidate="txtApplicationDeadline" ErrorMessage="Application Deadline is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvApplicationDeadline" runat="server" ControlToValidate="txtApplicationDeadline" Operator="GreaterThanEqual" Type="Date" ErrorMessage="Deadline must be today or a future date." CssClass="validation-error" Display="Dynamic"></asp:CompareValidator>
                           </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <asp:Button ID="btnUpdateJob" runat="server" Text="Save Changes" CssClass="btn btn-update-job" OnClick="btnUpdateJob_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

