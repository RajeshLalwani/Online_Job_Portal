<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="Apply_For_Job.aspx.cs" Inherits="Users_Job_Seeker_Apply_For_Job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">


    <%-- Custom styles to match the target design --%>
    <style>
        .page-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .mb-15 {
            margin-bottom: 15px;
        }
        .mb-20 {
            margin-bottom: 20px;
        }
        a.job-panel-link, a.job-panel-link:hover {
            text-decoration: none;
            color: inherit;
        }
        .job-panel-link .panel-default {
             transition: all 0.2s ease-in-out;
        }
        .job-panel-link .panel-default:hover {
            border-color: #ccc;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }
        
        .company-logo-wrapper {
            width: 80px;
            height: 80px;
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #1bae9a; 
            margin-right: 20px;
        }
        .company-logo {
            width: 100%;
            height: 100%;
            object-fit: cover; 
        }

        h4.media-heading {
            font-weight: 600;
            color: #333;
            font-size: 22px; 
        }
        .job-meta-info {
             margin-top: 5px;
        }
        .job-meta-info span {
            margin-right: 35px; 
            color: #777;
            font-size: 19px;
        }
        
        .job-posted-date {
            font-size: 17px; 
            display:inline-block; 
            margin-top:5px;
        }

        .location-icon {
            margin-right: 2px;
        }

        /* --- UPDATED: Using position:fixed for reliable positioning --- */
        .sidebar-fixed {
            position: fixed;
            /* Adjust this 'top' value to match the height of your master page's header */
            top: 90px; 
        }
        /* REMOVED .content-offset, as we are now using Bootstrap's native offset class */

        .job-type-badge {
            display: inline-block;
            padding: 5px 32px 5px 32px;

            font-size: 12px;
            font-weight: 500;
            line-height: 1.5;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            border-radius: 15px;
            transition: all 0.3s ease;
            color: #1bae9a;
            background-color: rgba(27, 174, 154, 0.1);
            border: 2px solid #1bae9a;
        }
        
        .job-type-badge:hover {
            color: #fff;
            background-color: #1bae9a;
            border-color: #1bae9a;
            cursor: pointer; 
        }

        /* Your other custom styles */
        .lbl-with-icon-filter::before {
            font-family: 'Glyphicons Halflings';
            content: "\e138";
            margin-right: 5px;
            background: linear-gradient(145deg, rgba(127,234,217,1) 100%, rgba(240,255,253,1) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: bold;
        }
        .btn-with-icon-filter::before, .btn-with-icon-reset::before {
            font-family: 'Glyphicons Halflings';
            margin-right: 5px;
        }
        .btn-with-icon-filter::before { content: "\e138"; }
        .btn-with-icon-reset::before { content: "\e031"; }
        .sbutton-style {
            background: linear-gradient(0deg, rgba(127,234,217,1) 0%, rgba(240,255,233,1) 100%);
            box-shadow: 0px 0px 0px 3px white;
            transition: box-shadow 0.6s linear;
            color: #1bae9a;
            border-radius: 5px;
            text-decoration: none;
        }
        .sbutton-style:hover {
            box-shadow: 5px 5px 5px #333333;
            transition: box-shadow 0.6s linear;
            text-decoration: none;
        }
    </style>

    <div class="container-fluid page-container">
        <div class="row">
            <div class="col-lg-2 sidebar-fixed">
                <div class="panel panel-default">
                    <div class="panel-body">
                         <div class="text-center">
                              <h4><label class="filter-title lbl-with-icon-filter">Filter Jobs</label></h4>
                            <%--<h4 class="filter-title lbl-with-icon-filter">Filter Jobs</h4>--%>
                         </div>
                         <hr />
                         
                         <%-- RESTORED: Filter controls are back in the panel --%>
                          <div class="form-group">
                              <label>Sort Jobs By</label>
                                <hr />
                              <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Width="190px">
                                  <asp:ListItem Value="0">None</asp:ListItem>
                                  <asp:ListItem>Newest First</asp:ListItem>
                                  <asp:ListItem>Oldest First</asp:ListItem>
                              </asp:DropDownList>
                                <hr />
                          </div>

                          <div class="form-group">
                            <label>Job Profile</label>
                                <hr />
                            <asp:DropDownList ID="JCPosition" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="JCPosition" DataValueField="JCPosition" AppendDataBoundItems="true" Width="190px">
                                <asp:ListItem Value="0">Select Job Profile</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Conn %>" SelectCommand="SELECT DISTINCT [JCPosition] FROM [Jobs]"></asp:SqlDataSource>
                                <hr />
                          </div>

                          <div class="form-group">
                            <label>Job Country</label>
                               <%--<h5>Job Country</h5>--%>
                                <hr />
                            <asp:DropDownList ID="Country" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataSourceID="SqlDataSource3" DataTextField="CName" DataValueField="CName" Width="190px">
                                <asp:ListItem Value="0">Select Job Country</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Conn %>" SelectCommand="SELECT distinct [CName] FROM [Country]"></asp:SqlDataSource>
                              <hr />
                          </div>

                      
                        <div class="form-group">
                            <label>Job Type</label>
                         <%--<h5>Job Type</h5>--%>
                         <hr />
                         <div class="checkbox">
                             <label><input type="checkbox" value="" id="ftm" checked> Full Time</label>
                         </div>
                         <div class="checkbox">
                             <label><input type="checkbox" value="" id="ptm" checked> Part Time</label>
                         </div>
                         <div class="checkbox">
                             <label><input type="checkbox" value="" id="rtm" checked> Remote</label>
                         </div>
                         <div class="checkbox">
                             <label><input type="checkbox" value="" id="frtm" checked> Freelance</label>
                         </div>
                         <hr />
                         </div>

                          <div class="text-center">
                              <asp:LinkButton ID="LinkButton1" runat="server" CssClass="sbutton-style btn-with-icon-filter" OnClick="LinkButton1_Click" Height="25px" Width="80px">Filter</asp:LinkButton>
                              <asp:LinkButton ID="LinkButton2" runat="server" CssClass="sbutton-style btn-with-icon-reset" Height="25px" Width="80px">Reset</asp:LinkButton>
                          </div>
                    </div>
                </div>
            </div>

            <%-- UPDATED: Using Bootstrap's col-lg-offset-3 to prevent overlap --%>
            <div class="col-lg-9 col-lg-offset-3">
                <div class="clearfix mb-20">
                    <div class="pull-left">
                        <asp:Label ID="lblJobCount" runat="server" style="font-size: 18px; color: #333; line-height:30px;"></asp:Label>
                    </div>
                    <div class="pull-right form-inline">
                        <div class="form-group">
                            <label class="control-label" style="margin-right:5px; font-weight:normal; color:#777;">Sort by</label>
                            <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control input-sm">
                                <asp:ListItem Value="0">None</asp:ListItem>
                                <asp:ListItem>Newest</asp:ListItem>
                                <asp:ListItem>Oldest</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <asp:DataList ID="DataList1" runat="server" DataKeyField="JId" DataSourceID="SqlDataSource1" RepeatDirection="Vertical" RepeatLayout="Flow" CssClass="w-100">
                    <ItemTemplate>
                        <a href='<%# "Apply_For_Job_Individual_List.aspx?JId=" + Eval("JId") %>' class="job-panel-link">
                            <div class="panel panel-default mb-15">
                                <div class="panel-body">
                                    <div class="media">
                                        <div class="media-left media-middle">
                                            <div class="company-logo-wrapper">
                                                <asp:Image ID="Image1" runat="server" CssClass="company-logo" 
                                                    ImageUrl='<%# "../../Assets/Images/Company_Logos/" + Eval("JCompLogo") %>' 
                                                    alt='<%# Eval("JCName") + " Logo" %>' />
                                            </div>
                                        </div>
                                        <div class="media-body">
                                            <div class="pull-right text-right">
                                                <span class="job-type-badge"><%# Eval("JType") %></span>
                                                <br />
                                                <br /> 
                                                <small class="text-muted job-posted-date">
                                                    <span class="glyphicon glyphicon-time" style="color: #1bae9a;"></span>
                                                    <%# FormatTimeAgo(Eval("JCreated_At")) %>
                                                </small>
                                            </div>
                                            <h4 class="media-heading"><%# Eval("JCPosition") %></h4>
                                            <div class="job-meta-info">
                                                <span><%# Eval("JCName") %></span>
                                                <span><span class="glyphicon glyphicon-map-marker location-icon" style="color: #1bae9a;"></span><%# Eval("JLocation") %></span>
                                                <span><%# Eval("JSalary") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:Conn %>"
        SelectCommand="SELECT * FROM [Jobs]"
        OnSelected="SqlDataSource1_Selected">
    </asp:SqlDataSource>
</asp:Content>
