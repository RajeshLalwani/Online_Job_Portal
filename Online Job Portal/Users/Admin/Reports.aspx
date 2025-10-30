<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Users_Admin_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .reports-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }
        .reports-hero h1 { font-size: 2.8em; font-weight: 700; }
        .report-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.07);
            margin-bottom: 30px;
        }
        .report-title {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }
        .grid-view-container { 
            max-height: none; /* Removed fixed height for pagination */
            overflow-y: auto; 
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
            position: sticky;
            top: 0;
        }
        .grid-view td {
            padding: 15px;
            border-bottom: 1px solid #f1f1f1;
            vertical-align: middle;
        }
        .grid-view tr:hover { background-color: #f9f9f9; }
        
        .grid-view tfoot tr {
            background-color: #f8f7ff;
            border-top: 2px solid #3a0ca3;
            font-weight: 700;
            color: #3a0ca3;
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

        .btn-export {
            background-image: linear-gradient(120deg, #28a745, #218838);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.4s ease;
        }
        .btn-export:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
            transform: translateY(-2px);
        }
        
         .report-container .form-control {
            display: block; width: 100% !important; max-width: none !important; box-sizing: border-box;
            border-radius: 8px; border: 1px solid #ced4da; padding: 10px 15px; height: 42px; transition: all 0.3s ease;
        }
         .btn-filter {
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            background-size: 200% auto;
            color: #fff;
            border:none;
            border-radius: 50px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.4s ease;
             width: 100% !important;
            max-width: none !important;
        }
        .btn-filter:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }

        .stat-box {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #7928ca;
        }
        .stat-box h4 {
            font-size: 1.8em;
            font-weight: 700;
            color: #3a0ca3;
            margin: 0;
        }
        .stat-box p {
            font-weight: 500;
            color: #555;
            margin: 0;
            font-size: 0.9em;
        }
    </style>


    <div class="reports-hero">
        <div class="container">
            <h1>Platform Reports</h1>
            <p class="lead">View and export platform data for analysis.</p>
        </div>
    </div>

    <div class="container">
        <!-- Hiring Statistics Report -->
        <div class="report-container">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="report-title">Hiring Statistics per Company</h3>
                </div>
                <div class="col-md-6 text-right">
                    <asp:Button ID="btnExportStats" runat="server" Text="Export Stats (CSV)" CssClass="btn btn-export" OnClick="btnExportStats_Click" />
                </div>
            </div>
            <div class="row" style="margin-bottom: 20px;">
                <div class="col-md-3">
                    <label>Filter by Date Range:</label>
                    <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
                        <asp:ListItem Value="AllTime">All Time</asp:ListItem>
                        <asp:ListItem Value="Today">Today</asp:ListItem>
                        <asp:ListItem Value="Last7Days">Last 7 Days</asp:ListItem>
                        <asp:ListItem Value="Last30Days">Last 30 Days</asp:ListItem>
                        <asp:ListItem Value="Last90Days">Last 90 Days</asp:ListItem>
                        <asp:ListItem Value="ThisYear">This Year</asp:ListItem>
                    </asp:DropDownList>
                </div>
                 <div class="col-md-3">
                     <label>&nbsp;</label>
                    <asp:Button ID="btnApplyFilter" runat="server" Text="Apply Filter" CssClass="btn btn-filter" OnClick="btnApplyFilter_Click" />
                 </div>
            </div>
            <div class="grid-view-container">
                <asp:GridView ID="gvCompanyStats" runat="server" AutoGenerateColumns="False" CssClass="table grid-view"
                    EmptyDataText="No company data found for the selected period." ShowFooter="True"
                    OnRowDataBound="gvCompanyStats_RowDataBound" FooterStyle-Font-Bold="true" FooterStyle-BackColor="#f8f7ff"
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="gvCompanyStats_PageIndexChanging">
                    <PagerStyle CssClass="grid-view-pager" />
                    <Columns>
                        <asp:BoundField DataField="CompanyName" HeaderText="Company" FooterText="TOTALS" />
                        <asp:TemplateField HeaderText="Total Jobs">
                            <ItemTemplate><%# Eval("TotalJobs") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalJobs" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active Jobs">
                            <ItemTemplate><%# Eval("ActiveJobs") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltActiveJobs" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pending Jobs">
                            <ItemTemplate><%# Eval("PendingJobs") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltPendingJobs" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rejected Jobs">
                            <ItemTemplate><%# Eval("RejectedJobs") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltRejectedJobs" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Apps">
                            <ItemTemplate><%# Eval("TotalApplications") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalApps" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Shortlisted">
                            <ItemTemplate><%# Eval("Shortlisted") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalShortlisted" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Interview">
                            <ItemTemplate><%# Eval("Interview") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalInterview" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hired (Apps)">
                            <ItemTemplate><%# Eval("Hired") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalHired" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rejected (Apps)">
                            <ItemTemplate><%# Eval("Rejected") %></ItemTemplate>
                            <FooterTemplate><asp:Literal ID="ltTotalRejectedApps" runat="server" /></FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>  

        <!-- Job Seekers Report -->
        <div class="report-container">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="report-title">All Job Seekers</h3>
                </div>
                <div class="col-md-6 text-right">
                    <asp:Button ID="btnExportJobSeekers" runat="server" Text="Export Job Seekers (CSV)" CssClass="btn btn-export" OnClick="btnExportJobSeekers_Click" />
                </div>
            </div>
            <%-- NEW: Stat boxes for Job Seekers --%>
            <div class="row" style="margin-bottom: 20px;">
                <div class="col-md-4 col-sm-4"><div class="stat-box"><h4><asp:Literal ID="ltTotalSeekers" runat="server">0</asp:Literal></h4><p>Total Job Seekers</p></div></div>
                <div class="col-md-4 col-sm-4"><div class="stat-box" style="border-color: #28a745;"><h4><asp:Literal ID="ltActiveSeekers" runat="server">0</asp:Literal></h4><p>Active</p></div></div>
                <div class="col-md-4 col-sm-4"><div class="stat-box" style="border-color: #dc3545;"><h4><asp:Literal ID="ltSuspendedSeekers" runat="server">0</asp:Literal></h4><p>Suspended</p></div></div>
            </div>
            <div class="grid-view-container">
                <asp:GridView ID="gvJobSeekers" runat="server" AutoGenerateColumns="False" CssClass="table grid-view" EmptyDataText="No job seekers found."
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="gvJobSeekers_PageIndexChanging">
                    <PagerStyle CssClass="grid-view-pager" />
                    <Columns>
                        <asp:BoundField DataField="JobSeekerID" HeaderText="User ID" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Country" HeaderText="Country" />
                        <asp:BoundField DataField="AccountStatus" HeaderText="Status" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Employers Report -->
        <div class="report-container">
            <div class="row">
                <div class="col-md-6"><h3 class="report-title">All Employers</h3></div>
                <div class="col-md-6 text-right"><asp:Button ID="btnExportEmployers" runat="server" Text="Export Employers (CSV)" CssClass="btn btn-export" OnClick="btnExportEmployers_Click" /></div>
            </div>
            <%-- NEW: Stat boxes for Employers --%>
            <div class="row" style="margin-bottom: 20px;">
                <div class="col-md-4 col-sm-4"><div class="stat-box"><h4><asp:Literal ID="ltTotalEmployers" runat="server">0</asp:Literal></h4><p>Total Employers</p></div></div>
                <div class="col-md-4 col-sm-4"><div class="stat-box" style="border-color: #28a745;"><h4><asp:Literal ID="ltActiveEmployers" runat="server">0</asp:Literal></h4><p>Active</p></div></div>
                <div class="col-md-4 col-sm-4"><div class="stat-box" style="border-color: #dc3545;"><h4><asp:Literal ID="ltSuspendedEmployers" runat="server">0</asp:Literal></h4><p>Suspended</p></div></div>
            </div>
             <div class="grid-view-container">
                <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False" CssClass="table grid-view" EmptyDataText="No employers found."
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="gvCompanies_PageIndexChanging">
                    <PagerStyle CssClass="grid-view-pager" />
                     <Columns>
                        <asp:BoundField DataField="CompanyID" HeaderText="Company ID" />
                        <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                        <asp:BoundField DataField="ContactName" HeaderText="Contact Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Country" HeaderText="Country" />
                        <asp:BoundField DataField="AccountStatus" HeaderText="Status" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

