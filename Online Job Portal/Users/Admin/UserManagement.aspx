<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="Users_Admin_UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .usermgmt-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

            .usermgmt-hero h1 {
                font-size: 2.8em;
                font-weight: 700;
            }

        .management-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.07);
        }

        /* Tab Styles */
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

        /* GridView Styling */
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

        /* Status Badge Styling */
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

        .status-suspended {
            background-color: #dc3545;
        }

        /* NEW: Styles for the GridView Pager (if not already in master) */
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

    <div class="usermgmt-hero">
        <div class="container">
            <h1>User Management</h1>
            <p class="lead">View, manage, and moderate user accounts on the platform.</p>
        </div>
    </div>

    <div class="container">
        <div class="management-container">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#jobseekers" aria-controls="jobseekers" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-user"></span>Job Seekers</a></li>
                <li role="presentation"><a href="#employers" aria-controls="employers" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-tower"></span>Employers</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="jobseekers">
                    <div class="grid-view-container">
                        <asp:GridView ID="gvJobSeekers" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                            DataKeyNames="JobSeekerID" OnRowCommand="gvUsers_RowCommand" EmptyDataText="No job seekers found."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvUsers_PageIndexChanging">
                            <PagerStyle CssClass="grid-view-pager" />
                            <Columns>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='status-badge status-<%# Eval("AccountStatus").ToString().ToLower() %>'>
                                            <%# Eval("AccountStatus") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:HyperLink runat="server" CssClass="btn btn-xs btn-info" NavigateUrl='<%# "~/Users/Admin/ViewApplicantProfile.aspx?id=" + Eval("JobSeekerID") %>' Target="_blank">View Profile</asp:HyperLink>
                                        <asp:LinkButton ID="btnToggleStatus" runat="server" CssClass='<%# Eval("AccountStatus").ToString() == "Active" ? "btn btn-xs btn-warning" : "btn btn-xs btn-success" %>' Style="margin-left: 5px;"
                                            CommandName="ToggleStatus" CommandArgument='<%# Eval("JobSeekerID") + "," + Eval("AccountStatus") %>'>
                                            <%# Eval("AccountStatus").ToString() == "Active" ? "Suspend" : "Activate" %>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" Style="margin-left: 5px;"
                                            CommandName="DeleteUser" CommandArgument='<%# Eval("JobSeekerID") %>'
                                            OnClientClick='<%# GetDeleteClientClick("user") %>'>
                                            Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="employers">
                    <div class="grid-view-container">
                        <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                            DataKeyNames="CompanyID" OnRowCommand="gvUsers_RowCommand" EmptyDataText="No employers found."
                            AllowPaging="True" PageSize="5" OnPageIndexChanging="gvUsers_PageIndexChanging">
                            <PagerStyle CssClass="grid-view-pager" />
                            <Columns>
                                <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:BoundField DataField="ContactName" HeaderText="Contact Name" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='status-badge status-<%# Eval("AccountStatus").ToString().ToLower() %>'>
                                            <%# Eval("AccountStatus") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:HyperLink runat="server" CssClass="btn btn-xs btn-info" NavigateUrl='<%# "~/Users/Admin/ViewCompanyProfile.aspx?id=" + Eval("CompanyID") %>' Target="_blank">View Profile</asp:HyperLink>
                                        <asp:LinkButton ID="btnToggleStatus" runat="server" CssClass='<%# Eval("AccountStatus").ToString() == "Active" ? "btn btn-xs btn-warning" : "btn btn-xs btn-success" %>' Style="margin-left: 5px;"
                                            CommandName="ToggleStatus" CommandArgument='<%# Eval("CompanyID") + "," + Eval("AccountStatus") %>'>
                                            <%# Eval("AccountStatus").ToString() == "Active" ? "Suspend" : "Activate" %>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-xs btn-danger" Style="margin-left: 5px;"
                                            CommandName="DeleteUser" CommandArgument='<%# Eval("CompanyID") %>'
                                            OnClientClick='<%# GetDeleteClientClick("company") %>'>
                                            Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function confirmAction(sender, event, title, text) {
            event.preventDefault();
            Swal.fire({
                title: title,
                text: text,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    eval(sender.getAttribute('href'));
                }
            });
            return false;
        }
    </script>
</asp:Content>

