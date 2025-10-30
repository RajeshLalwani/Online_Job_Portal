<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="AppliedJobs.aspx.cs" Inherits="Users_Job_Seeker_AppliedJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .applied-jobs-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

        .applied-jobs-hero h1 {
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
        .status-interviewscheduled { border-left-color: #007bff; }
        .status-rejected { border-left-color: #dc3545; }
        .status-pending { border-left-color: #ffc107; }
        .status-shortlisted { border-left-color: #28a745; }

        .job-card-header {
            padding: 20px;
            display: flex;
            align-items: center;
        }
        
        .company-logo-container {
            width: 70px;
            height: 70px;
            margin-right: 20px;
            border: 1px solid #f1f1f1;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .company-logo {
            max-width: 55px;
            max-height: 55px;
            object-fit: contain;
        }

        .job-info h4 {
            margin-top: 0;
            margin-bottom: 5px;
            font-weight: 600;
            color: #3a0ca3;
        }
        .job-info .company-name {
            font-weight: 500;
            color: #555;
        }

        .job-card-body {
            padding: 20px;
            border-top: 1px solid #f1f1f1;
            border-bottom: 1px solid #f1f1f1;
        }

        .status-section {
            font-size: 1.1em;
        }

        .status-label {
            font-weight: 700;
            color: #3a0ca3;
        }
        
        /* Status Text Colors */
        .status-text-interviewscheduled { color: #007bff; }
        .status-text-rejected { color: #dc3545; }
        .status-text-pending { color: #ffc107; }
        .status-text-shortlisted { color: #28a745; }
        
        .reason-text {
            font-style: italic;
            color: #555;
            margin-top: 5px;
            padding-left: 15px;
            border-left: 3px solid #eee;
        }

        .job-card-footer {
            background-color: #f9f9f9;
            padding: 15px 20px;
            border-radius: 0 0 12px 12px;
            font-size: 0.9em;
            color: #777;
            text-align: right;
        }

        .no-jobs-panel {
            text-align: center;
            padding: 60px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .no-jobs-panel h3 {
            font-weight: 600;
            color: #3a0ca3;
        }

           /* CORRECTED: Clickable overlay link */
        .card-click-overlay {
            display: block;
            color: inherit;
            text-decoration: none !important;
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

    <div class="applied-jobs-hero">
        <div class="container">
            <h1>My Job Applications</h1>
            <p class="lead">Track the status of your job applications below.</p>
        </div>
    </div>

    <div class="container">
        <asp:Repeater ID="rptAppliedJobs" runat="server">
            <ItemTemplate>
               
                <asp:HyperLink runat="server" NavigateUrl='<%# "~/Users/Job_Seeker/JobDetails.aspx?id=" + Eval("JobID") %>' CssClass="card-click-overlay">
                <div class='job-card status-<%# Eval("Status").ToString().Replace(" ", "").ToLower() %>'>
                    
                    <div class="job-card-header">
                        <div class="company-logo-container">
                            <asp:Image runat="server" CssClass="company-logo" ImageUrl='<%# ResolveUrl(Eval("CompanyLogoPath").ToString()) %>' />
                        </div>
                        <div class="job-info">
                            <h4><%# Eval("JobTitle") %></h4>
                            <p class="company-name"><%# Eval("CompanyName") %></p>
                        </div>
                    </div>
                    <div class="job-card-body">
                        <div class="status-section">
                            <span class="status-label">Application Status: </span>
                            <strong class='status-text-<%# Eval("Status").ToString().Replace(" ", "").ToLower() %>'>
                                <%# Eval("Status") %>
                            </strong>
                            
                            <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Rejected" && Eval("RejectionReason") != DBNull.Value %>'>
                                <p class="reason-text"><strong>Reason:</strong> <%# Eval("RejectionReason") %></p>
                            </asp:Panel>
                            <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Interview Scheduled" && Eval("InterviewDate") != DBNull.Value %>'>
                                <p class="reason-text"><strong>Interview Date:</strong> <%# FormatInterviewDate(Eval("InterviewDate")) %></p>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="job-card-footer">
                        Applied on: <%# Convert.ToDateTime(Eval("ApplicationDate")).ToString("dd MMMM yyyy") %>
                    </div>
                </div>
                    </asp:HyperLink>
            </ItemTemplate>
        </asp:Repeater>

        <%-- NEW: Pagination Controls --%>
        <asp:Panel ID="pnlPagination" runat="server" Visible="false">
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


        <asp:Panel ID="pnlNoApplications" runat="server" Visible="false" CssClass="no-jobs-panel">
            <h3>You haven't applied for any jobs yet.</h3>
            <p>Start your job search to find your next opportunity.</p>
            <asp:HyperLink runat="server" NavigateUrl="~/Users/Job_Seeker/FindJobs.aspx" CssClass="btn btn-primary btn-lg" style="margin-top:20px;">
                <span class="glyphicon glyphicon-search"></span> Find Jobs Now
            </asp:HyperLink>
        </asp:Panel>
    </div>
</asp:Content>
