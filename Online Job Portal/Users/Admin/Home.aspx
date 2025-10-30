<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Users/Admin/Admin.Master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .dashboard-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

        .dashboard-hero h1 {
            font-size: 2.8em;
            font-weight: 700;
        }

        .dashboard-container {
            padding: 15px;
        }
        
        /* REMOVED Flex rules from .row and .col- to fix spacing/height issues */

        .stat-card {
            background: #fff;
            color: #3a0ca3;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-left: 5px solid #7928ca;
            width: 100%; 
            margin-bottom: 30px; /* Added margin to each card for vertical space */
            
            /* CORRECTED: Set a minimum height to force all cards to be equal */
            min-height: 180px; 
            display: flex; /* Use flex to center content vertically */
            flex-direction: column;
            justify-content: center;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(58, 12, 163, 0.15);
        }

        .stat-card .glyphicon {
            font-size: 2.5em;
            opacity: 0.8;
            margin-bottom: 10px;
        }

        .stat-card h4 {
            font-size: 2.5em;
            font-weight: 700;
            margin: 0;
        }

        .stat-card p {
            font-weight: 500;
            color: #555;
            font-size: 0.9em; 
        }
        
        .section-title {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
            display: inline-block;
        }

        .action-card {
            background: linear-gradient(135deg, #7928ca, #5d22b3);
            color: #fff;
            padding: 30px 20px;
            text-align: center;
            border-radius: 12px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            display: block;
            text-decoration: none !important;
            width: 100%;
            /* CORRECTED: Set a minimum height for equal height */
            min-height: 150px; 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(93, 34, 179, 0.3);
            color: #fff;
        }

        .action-card .glyphicon {
            font-size: 2.5em;
        }

        .action-card h5 {
            font-weight: 600;
            margin: 15px 0 0 0;
            font-size: 1.2em;
        }
    </style>

    <div class="dashboard-hero">
        <div class="container">
            <h1>Admin Dashboard</h1>
            <p class="lead">Welcome! Here's an overview of your platform's activity.</p>
        </div>
    </div>

    <div class="container dashboard-container">
        <%-- 10 Stat cards in a 5x2 layout --%>
        <div class="row">
            <div class="col-lg-2 col-lg-offset-1 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-user"></span>
                    <h4><asp:Literal ID="ltTotalJobSeekers" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Job Seekers</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-tower"></span>
                    <h4><asp:Literal ID="ltTotalEmployers" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Employers</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-briefcase"></span>
                    <h4><asp:Literal ID="ltTotalJobs" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Jobs Posted</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-check"></span>
                    <h4><asp:Literal ID="ltActiveJobs" runat="server" Text="0"></asp:Literal></h4>
                    <p>Active Jobs</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-time"></span>
                    <h4><asp:Literal ID="ltPendingJobs" runat="server" Text="0"></asp:Literal></h4>
                    <p>Pending Jobs</p>
                </div>
            </div>
        </div>
        <div class="row">
             <div class="col-lg-2 col-lg-offset-1 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-folder-open"></span>
                    <h4><asp:Literal ID="ltTotalApplications" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Applications</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-ok-sign"></span>
                    <h4><asp:Literal ID="ltTotalHired" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Hired</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-thumbs-down"></span>
                    <h4><asp:Literal ID="ltTotalRejected" runat="server" Text="0"></asp:Literal></h4>
                    <p>Apps Rejected</p>
                </div>
            </div>
            <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-comment"></span>
                    <h4><asp:Literal ID="ltTotalFeedbacks" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Feedbacks</p>
                </div>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <div class="stat-card">
                    <span class="glyphicon glyphicon-envelope"></span>
                    <h4><asp:Literal ID="ltTotalQueries" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total Contact Queries</p>
                </div>
            </div>
        </div>
        
        <div class="row" style="margin-top: 30px;">
            <div class="col-md-12">
                <h3 class="section-title">Quick Actions</h3>
            </div>
            <%-- 5 Quick Action cards in a balanced layout --%>
             <div class="col-md-offset-1 col-lg-2 col-md-4 col-sm-6">
                <a href="UserManagement.aspx" class="action-card">
                    <span class="glyphicon glyphicon-user"></span>
                    <h5>Manage Users</h5>
                </a>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <a href="JobManagement.aspx" class="action-card">
                    <span class="glyphicon glyphicon-list-alt"></span>
                    <h5>Manage Jobs</h5>
                </a>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <a href="ContactList.aspx" class="action-card">
                    <span class="glyphicon glyphicon-envelope"></span>
                    <h5>View Queries</h5>
                </a>
            </div>
            <div class="col-lg-2 col-md-4 col-sm-6">
                <a href="FeedbackList.aspx" class="action-card">
                    <span class="glyphicon glyphicon-bullhorn"></span>
                    <h5>View Feedbacks</h5>
                </a>
            </div>
             <div class="col-lg-2 col-md-4 col-sm-6">
                <a href="Reports.aspx" class="action-card">
                    <span class="glyphicon glyphicon-stats"></span>
                    <h5>Manage Reports</h5>
                </a>
            </div>
        </div>
    </div>
</asp:Content>

