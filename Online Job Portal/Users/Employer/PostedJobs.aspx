<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="PostedJobs.aspx.cs" Inherits="Users_Employer_PostedJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .posted-jobs-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

        .posted-jobs-hero h1 {
            font-size: 2.8em;
            font-weight: 700;
        }

        .job-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
            border-left: 5px solid #ced4da; /* Default border */
        }
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(58, 12, 163, 0.1);
        }

        /* Status-specific styles */
        .status-active { border-left-color: #28a745; }
        .status-pendingapproval { border-left-color: #ffc107; }
        .status-closed { border-left-color: #6c757d; }
        .status-rejected { border-left-color: #dc3545; }

        .job-card-header {
            padding: 20px;
            border-bottom: 1px solid #f1f1f1;
        }
        .job-card-header h3 {
            margin: 0;
            font-size: 1.5em;
            font-weight: 600;
            color: #3a0ca3;
        }
        .job-card-header .job-location {
            color: #555;
            font-weight: 500;
        }
        .job-card-header .glyphicon {
            margin-right: 5px;
        }

        .job-card-body {
            padding: 20px;
            flex-grow: 1;
        }
        
        .job-stats {
            display: flex;
            justify-content: space-around;
            text-align: center;
        }
        .stat {
            color: #555;
        }
        .stat .stat-number {
            font-size: 1.8em;
            font-weight: 700;
            color: #5d22b3;
            display: block;
        }
        
        /* Status Text Colors */
        .status-text-pendingapproval { color: #f0ad4e; }
        .status-text-active { color: #28a745; }
        .status-text-closed { color: #6c757d; }
        .status-text-rejected { color: #dc3545; }

        .job-card-footer {
            background-color: #f9f9f9;
            padding: 15px 20px;
            border-top: 1px solid #f1f1f1;
            border-radius: 0 0 12px 12px;
        }
        
        .job-card-footer .btn {
            border-radius: 50px;
            font-weight: 600;
            padding: 8px 20px;
            transition: all 0.3s ease;
        }
        .btn-view-applicants {
             background-image: linear-gradient(120deg, #7928ca, #5d22b3);
             color: #fff !important;
             border:none;
        }
        .btn-view-applicants:hover {
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }
        .btn-delete-job {
            color: #e74c3c;
        }
        .btn-delete-job:hover {
            background-color: #e74c3c;
            color: #fff;
        }

        .no-jobs-panel {
            text-align: center;
            padding: 60px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        /* NEW: Styles for the custom pager */
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .pagination-container .btn-pager {
            background-color: #fff;
            border: 1px solid #ddd;
            color: #5d22b3;
            font-weight: 600;
            padding: 10px 20px;
            margin: 0 5px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        .pagination-container .btn-pager:hover {
            background-color: #5d22b3;
            color: #fff;
            border-color: #5d22b3;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.3);
            transform: translateY(-2px);
        }
        .pagination-container .btn-pager:disabled {
            background-color: #f1f1f1;
            color: #aaa;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        .pagination-container .page-number {
            font-weight: 600;
            color: #3a0ca3;
            font-size: 1.2em;
            margin: 0 15px;
        }
    </style>

    <div class="posted-jobs-hero">
        <div class="container">
            <h1>Manage Job Postings</h1>
            <p class="lead">Here are the jobs you've posted. You can view applicants, edit, or delete listings.</p>
        </div>
    </div>

    <div class="container">
        <asp:Repeater ID="rptPostedJobs" runat="server" OnItemCommand="rptPostedJobs_ItemCommand">
            <ItemTemplate>
                <div class='job-card status-<%# Eval("JobStatus").ToString().Replace(" ", "").ToLower() %>'>
                    <div class="job-card-header">
                        <h3><%# Eval("JobTitle") %></h3>
                        <span class="job-location"><span class="glyphicon glyphicon-map-marker"></span><%# Eval("City") %>, <%# Eval("Country") %></span>
                    </div>
                    <div class="job-card-body">
                        <div class="job-stats">
                            <div class="stat">
                                <span class="stat-number"><%# Eval("ApplicantCount") %></span>
                                Applicants
                            </div>
                             <div class="stat">
                                <span class='stat-number status-text-<%# Eval("JobStatus").ToString().Replace(" ", "").ToLower() %>'><%# Eval("JobStatus") %></span>
                                Status
                            </div>
                             <div class="stat">
                                <span class="stat-number"><%# Convert.ToDateTime(Eval("DatePosted")).ToString("dd MMM yyyy") %></span>
                                Date Posted
                            </div>
                        </div>
                    </div>
                    <div class="job-card-footer text-right">
                        <asp:HyperLink runat="server" CssClass="btn btn-default" NavigateUrl='<%# "EditJob.aspx?id=" + Eval("JobID") %>'><span class="glyphicon glyphicon-pencil"></span> Edit Details</asp:HyperLink>
                        
                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-default btn-delete-job" 
                            CommandName="DeleteJob" CommandArgument='<%# Eval("JobID") %>'
                            OnClientClick='<%# GetConfirmClientClick("Delete Job?", "Are you sure you want to permanently delete this job posting?") %>'>
                            <span class="glyphicon glyphicon-trash"></span> Delete
                        </asp:LinkButton>
                        
                        <asp:LinkButton ID="btnCloseJob" runat="server" CssClass="btn btn-warning" 
                            CommandName="CloseJob" CommandArgument='<%# Eval("JobID") %>'
                            Visible='<%# Eval("JobStatus").ToString() == "Active" %>'
                            OnClientClick='<%# GetConfirmClientClick("Close Applications?", "This will stop new applications. You can re-activate it later.") %>'>
                            <span class="glyphicon glyphicon-folder-close"></span> Close Applications
                        </asp:LinkButton>

                         <asp:LinkButton ID="btnActivateJob" runat="server" CssClass="btn btn-success" 
                            CommandName="ActivateJob" CommandArgument='<%# Eval("JobID") %>'
                            Visible='<%# Eval("JobStatus").ToString() == "Closed" %>'
                             OnClientClick='<%# GetConfirmClientClick("Activate Job?", "This will make the job visible to seekers and open it for new applications.") %>'>
                            <span class="glyphicon glyphicon-folder-open"></span> Activate Job
                        </asp:LinkButton>

                        <asp:HyperLink runat="server" CssClass="btn btn-primary btn-view-applicants" 
                            NavigateUrl='<%# "Applicants.aspx?id=" + Eval("JobID") %>'
                            Visible='<%# Eval("JobStatus").ToString() != "Pending Approval" %>'>
                            View Applicants
                        </asp:HyperLink>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

         <%-- NEW: Pagination Controls --%>
        <asp:Panel ID="pnlPagination" runat="server" Visible="true">
            <div class="pagination-container">
                <asp:LinkButton ID="btnPrev" runat="server" CssClass="btn btn-pager" OnClick="Page_Changed">
                    <span class="glyphicon glyphicon-arrow-left"></span> Previous
                </asp:LinkButton>
                <span class="page-number">
                    Page <asp:Label ID="lblCurrentPage" runat="server" Text="1"></asp:Label> of <asp:Label ID="lblTotalPages" runat="server" Text="1"></asp:Label>
                </span>
                <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-pager" OnClick="Page_Changed">
                    Next <span class="glyphicon glyphicon-arrow-right"></span>
                </asp:LinkButton>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoJobs" runat="server" Visible="false" CssClass="no-jobs-panel">
            <h3>You haven't posted any jobs yet.</h3>
            <p>Get started by posting your first job opening to reach qualified candidates.</p>
            <asp:HyperLink runat="server" NavigateUrl="~/Users/Employer/Add_New_Job.aspx" CssClass="btn btn-primary btn-lg" style="margin-top:20px;">
                <span class="glyphicon glyphicon-plus"></span> Post a New Job
            </asp:HyperLink>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function confirmAction(sender, event, title, text) {
            event.preventDefault();
            Swal.fire({
                title: title,
                text: text,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, proceed!'
            }).then((result) => {
                if (result.isConfirmed) {
                    eval(sender.getAttribute('href'));
                }
            });
            return false;
        }
    </script>
</asp:Content>

