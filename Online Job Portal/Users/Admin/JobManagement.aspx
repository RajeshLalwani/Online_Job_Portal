<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="JobManagement.aspx.cs" Inherits="Users_Admin_JobManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .job-mgmt-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

            .job-mgmt-hero h1 {
                font-size: 2.8em;
                font-weight: 700;
            }

        .management-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.07);
        }

        .nav-tabs > li > a {
            font-weight: 600;
            color: #5d22b3;
        }

        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:hover,
        .nav-tabs > li.active > a:focus {
            color: #fff;
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            border-radius: 8px 8px 0 0;
            border-color: transparent;
        }

        .grid-view-container {
            margin-top: 20px;
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
        }

            .grid-view th {
                background-color: #f8f7ff;
                color: #3a0ca3;
                font-weight: 600;
                padding: 15px;
                text-align: left;
            }

            .grid-view td {
                padding: 15px;
                border-bottom: 1px solid #f1f1f1;
                vertical-align: middle;
            }

            .grid-view tr:hover {
                background-color: #f9f9f9;
            }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            color: #fff;
            font-weight: 500;
            font-size: 0.9em;
        }

        .status-active {
            background-color: #28a745;
        }

        .status-closed {
            background-color: #6c757d;
        }

        .status-pendingapproval {
            background-color: #ffc107;
            color: #333;
        }

        .status-rejected {
            background-color: #dc3545;
        }

        /* NEW: Style for the filter info panel */
        .filter-info-panel {
            background-color: #eaf2f8;
            border-left: 5px solid #3498db;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-size: 1.1em;
        }

        /* NEW: Styles for the GridView Pager */
            .grid-view-pager {
                background-color: #f8f7ff;
                padding: 10px;
                text-align: right;
            }
            .grid-view-pager table {
                margin: 0;
            }
            .grid-view-pager span, .grid-view-pager a {
                display: inline-block;
                padding: 8px 14px;
                margin: 0 2px;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .grid-view-pager a {
                color: #5d22b3;
                border: 1px solid #ddd;
            }
            .grid-view-pager a:hover {
                background-color: #5d22b3;
                color: #fff;
                border-color: #5d22b3;
            }
            .grid-view-pager span {
                background-color: #5d22b3;
                color: #fff;
                border: 1px solid #5d22b3;
            }
    </style>

    <div class="job-mgmt-hero">
        <div class="container">
            <h1>Job Postings Management</h1>
            <p class="lead">Approve, moderate, and manage all job listings on the platform.</p>
        </div>
    </div>

    <div class="container">
        <div class="management-container">
            <%-- NEW: Panel to show filter information --%>
            <asp:Panel ID="pnlFilterInfo" runat="server" Visible="false" CssClass="filter-info-panel">
                <strong>Showing jobs for:</strong>
                <asp:Literal ID="ltCompanyName" runat="server"></asp:Literal>.
                <asp:HyperLink runat="server" NavigateUrl="~/Users/Admin/JobManagement.aspx" CssClass="pull-right">View All Jobs</asp:HyperLink>
            </asp:Panel>

            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#pending" aria-controls="pending" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-time"></span>Pending Approval</a></li>
                <li role="presentation"><a href="#active" aria-controls="active" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-ok-sign"></span>Active Jobs</a></li>
                <li role="presentation"><a href="#other" aria-controls="other" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-folder-close"></span>Closed & Rejected</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="pending">
                    <div class="grid-view-container">
                        <asp:GridView ID="gvPendingJobs" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                                DataKeyNames="JobID" OnRowCommand="gvJobs_RowCommand" EmptyDataText="No jobs are currently pending approval."
                                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvPendingJobs_PageIndexChanging">
                                <PagerStyle CssClass="grid-view-pager" />
                            <Columns>
                                <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnApprove" runat="server" CssClass="btn btn-xs btn-success" CommandName="ApproveJob" CommandArgument='<%# Eval("JobID") %>'>Approve</asp:LinkButton>
                                        <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-xs btn-danger" Style="margin-left: 5px;" CommandName="RejectJob" CommandArgument='<%# Eval("JobID") %>'>Reject</asp:LinkButton>
                                        <asp:HyperLink runat="server" CssClass="btn btn-xs btn-info" Style="margin-left: 5px;" NavigateUrl='<%# "~/Users/Admin/JobDetails.aspx?id=" + Eval("JobID") %>' Target="_blank">View Details</asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="active">
                    <div class="grid-view-container">
                        <asp:GridView ID="gvActiveJobs" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                                DataKeyNames="JobID" OnRowCommand="gvJobs_RowCommand" EmptyDataText="There are no active job postings."
                                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvActiveJobs_PageIndexChanging">
                                <PagerStyle CssClass="grid-view-pager" />
                            <Columns>
                                <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnCloseJob" runat="server" CssClass="btn btn-xs btn-warning" CommandName="ToggleStatus" CommandArgument='<%# Eval("JobID") + ",Active" %>'>Close</asp:LinkButton>
                                        <asp:HyperLink runat="server" CssClass="btn btn-xs btn-default" Style="margin-left: 5px;" NavigateUrl='<%# "~/Users/Admin/Applicants.aspx?id=" + Eval("JobID") %>' Target="_blank">View Applicants</asp:HyperLink>
                                        <asp:HyperLink runat="server" CssClass="btn btn-xs btn-info" Style="margin-left: 5px;" NavigateUrl='<%# "~/Users/Admin/JobDetails.aspx?id=" + Eval("JobID") %>' Target="_blank">View Details</asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="other">
                    <div class="grid-view-container">
                        <asp:GridView ID="gvOtherJobs" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                                DataKeyNames="JobID" OnRowCommand="gvJobs_RowCommand" EmptyDataText="There are no closed or rejected jobs."
                                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvOtherJobs_PageIndexChanging">
                                <PagerStyle CssClass="grid-view-pager" />
                            <Columns>
                                <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='status-badge status-<%# Eval("JobStatus").ToString().Replace(" ", "").ToLower() %>'>
                                            <%# Eval("JobStatus") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnReopen" runat="server" CssClass="btn btn-xs btn-success" CommandName="ToggleStatus" CommandArgument='<%# Eval("JobID") + "," + Eval("JobStatus") %>' Visible='<%# Eval("JobStatus").ToString() == "Closed" %>'>Re-Open</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" Style="margin-left: 5px;" CommandName="DeleteJob" CommandArgument='<%# Eval("JobID") %>' OnClientClick="return confirm('Are you sure you want to permanently delete this job posting?');">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

