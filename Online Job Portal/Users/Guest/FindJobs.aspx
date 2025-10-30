<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="FindJobs.aspx.cs" Inherits="Users_Guest_FindJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .find-jobs-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

        .search-bar-container .form-control {
            height: 50px;
            border-radius: 8px;
            border: 1px solid transparent;
        }

        .search-bar-container .btn-search {
            height: 50px;
            width: 100%;
            border-radius: 8px;
            background-color: #fff;
            color: #5d22b3;
            font-weight: 700;
            border:none;
        }
        
        .page-content {
            margin-top: 40px;
        }

        /* UPDATED: Filter Sidebar Styles */
        .filter-sidebar {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.07);
            position: sticky !important;
            top: 90px !important;
        }
        .filter-sidebar h4 {
            font-weight: 600;
            color: #3a0ca3;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }
        .filter-sidebar .form-group {
            margin-bottom: 15px;
        }
        .filter-sidebar .form-group label {
            font-weight: 500;
            margin-bottom: 10px;
        }
         .filter-sidebar .form-control {
            width: 100% !important; 
            border-radius: 8px;
            height: 42px;
        }
        .filter-sidebar .btn {
            width: 48%;
            border-radius: 8px;
            font-weight: 600;
            height: 42px;
            transition: all 0.3s ease;
        }
        .btn-filter {
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            background-size: 200% auto;
            color: #fff;
            border:none;
        }
        .btn-filter:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }
        /* CORRECTED Checkbox alignment */
        .job-type-checkbox-list td {
            padding-bottom: 1px;
        }
        .job-type-checkbox-list label {
            font-weight: normal !important;
            margin-left: 8px;
        }
        .filter-buttons {
            margin-top: 20px;
            overflow: hidden;
        }


        /* UPDATED: Job Card Styles */
        .job-card-link {
            display: block;
            color: inherit;
            text-decoration: none !important;
        }
        .job-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            display: flex;
            padding: 20px;
            align-items: center;
            border: 1px solid #eee;
        }
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(58, 12, 163, 0.1);
            border-color: #7928ca;
        }
        
        .company-logo-container {
            width: 80px;
            height: 80px;
            margin-right: 20px;
            border: 1px solid #f1f1f1;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .company-logo {
            max-width: 60px;
            max-height: 60px;
        }
        
        .job-details {
            width: 100%;
        }

        .job-details h4 {
            margin-top: 0;
            margin-bottom: 5px;
            font-weight: 600;
            color: #3a0ca3;
        }
        .job-details .company-name {
            font-weight: 500;
            color: #555;
            margin-bottom: 10px;
        }
        .job-meta-info span {
            margin-right: 20px;
            color: #777;
            font-size: 0.95em;
        }
        .job-meta-info .glyphicon {
            margin-right: 5px;
        }
        
        .job-actions {
            margin-left: auto;
            text-align: right;
            flex-shrink: 0;
        }
        .job-actions .posted-time {
            font-size: 0.9em;
            color: #999;
            margin-top: 10px;
            display: block;
        }
        
        .job-type-tag {
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9em;
            transition: all 0.3s ease;
            margin-bottom: 5px;
            display: inline-block;
            background-color: rgba(93, 34, 179, 0.1); 
            color: #5d22b3; 
            border: 1px solid rgba(93, 34, 179, 0.3);
        }
        .job-card-link:hover .job-type-tag {
            background-color: #5d22b3;
            color: #fff;
        }

        .no-jobs-panel {
            text-align: center;
            padding: 60px;
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

         html, body, form {
            overflow: visible !important;
        }
    </style>

    <div class="find-jobs-hero">
        <div class="container text-center">
            <h1>Find Your Next Tech Job</h1>
            <p class="lead">Search from thousands of active IT job listings from top companies.</p>
             <div class="search-bar-container">
                <div class="row">
                    <div class="col-md-5">
                        <asp:TextBox ID="txtSearchMain" runat="server" CssClass="form-control" placeholder="Job title, keywords, or company..."></asp:TextBox>
                    </div>
                    <div class="col-md-5">
                        <asp:TextBox ID="txtLocationMain" runat="server" CssClass="form-control" placeholder="City, state, or country..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearchMain" runat="server" Text="Search" CssClass="btn btn-search" OnClick="btnSearchMain_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container page-content">
        <div class="row">
            <!-- Filter Sidebar -->
            <div class="col-md-3">
                <div class="filter-sidebar">
                    <h4><span class="glyphicon glyphicon-filter"></span> Filter Jobs</h4>
                    <div class="form-group">
                        <label for="<%=ddlSortBy.ClientID %>">Sort By</label>
                        <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control" Width="215px">
                            <asp:ListItem Value="DESC">Newest First</asp:ListItem>
                            <asp:ListItem Value="ASC">Oldest First</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                     <hr />
                     <div class="form-group">
                        <label for="<%=ddlJobProfile.ClientID %>">Job Profile</label>
                        <asp:DropDownList ID="ddlJobProfile" runat="server" CssClass="form-control" Width="215px"></asp:DropDownList>
                    </div>
                     <hr />
                     <div class="form-group">
                        <label for="<%=ddlCountryFilter.ClientID %>">Job Country</label>
                        <asp:DropDownList ID="ddlCountryFilter" runat="server" CssClass="form-control" Width="215px"></asp:DropDownList>
                    </div>
                     <hr />
                    <div class="form-group">
                        <label>Job Type</label>
                        <asp:CheckBoxList ID="cblJobType" runat="server" CssClass="job-type-checkbox-list" RepeatLayout="Table" RepeatColumns="1">
                            <asp:ListItem>Full-time</asp:ListItem>
                            <asp:ListItem>Part-time</asp:ListItem>
                            <asp:ListItem>Contract</asp:ListItem>
                            <asp:ListItem>Internship</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                     <hr />
                    <div class="form-group">
                         <label for="<%=ddlDatePosted.ClientID %>">Date Posted</label>
                        <asp:DropDownList ID="ddlDatePosted" runat="server" CssClass="form-control"  Width="215px">
                            <asp:ListItem Value="">Any Time</asp:ListItem>
                            <asp:ListItem Value="1">Past 24 Hours</asp:ListItem>
                            <asp:ListItem Value="7">Past Week</asp:ListItem>
                            <asp:ListItem Value="30">Past Month</asp:ListItem>
                        </asp:DropDownList>
                         <hr />
                    </div>
                    <div class="filter-buttons">
                        <asp:Button ID="btnApplyFilters" runat="server" Text="Filter" CssClass="btn btn-filter pull-left" OnClick="btnApplyFilters_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-default btn-reset pull-right" OnClick="btnClear_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <!-- Job Listings -->
           <!-- Job Listings -->
            <div class="col-md-9">
                <asp:Repeater ID="rptJobList" runat="server">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" NavigateUrl='<%# "~/Users/Guest/JobDetails.aspx?id=" + Eval("JobID") %>' CssClass="job-card-link">
                            <div class="job-card">
                                <div class="company-logo-container">
                                    <asp:Image runat="server" CssClass="company-logo" ImageUrl='<%# ResolveUrl(Eval("CompanyLogoPath").ToString()) %>' />
                                </div>
                                <div class="job-details">
                                    <h4><%# Eval("JobTitle") %></h4>
                                    <div class="company-name"><%# Eval("CompanyName") %></div>
                                    <div class="job-meta-info">
                                        <span><span class="glyphicon glyphicon-map-marker"></span><%# Eval("City") %>, <%# Eval("Country") %></span>
                                        <span><span class="glyphicon glyphicon-briefcase"></span><%# Eval("ExperienceRequired") %></span>
                                        <span><span class="glyphicon glyphicon-credit-card"></span><%# Eval("Salary") %></span>
                                       
                                        <span style="margin-top: 5px;"><span class="glyphicon glyphicon-education"></span><%# Eval("QualificationRequired") %></span>
                                    </div>
                                </div>
                                <div class="job-actions">
                                    <span class='job-type-tag'><%# Eval("JobType") %></span>
                                    <span class="posted-time"><span class="glyphicon glyphicon-time"></span> <%# GetTimeAgo(Eval("DatePosted")) %></span>
                                </div>
                            </div>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:Repeater>
                 <asp:Panel ID="pnlNoJobs" runat="server" Visible="false" CssClass="no-jobs-panel">
                    <h3>No Jobs Found</h3>
                    <p>Your search did not match any job listings. Please try a different search term or clear the filters.</p>
                </asp:Panel>

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
            </div>
        </div>
    </div>
</asp:Content>

