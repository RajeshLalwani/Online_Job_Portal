<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.Master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="_Default" %>

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

        .profile-summary-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-picture {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #7928ca;
            margin-bottom: 15px;
        }

        .profile-summary-card h3 {
            font-weight: 600;
            color: #3a0ca3;
            margin-top: 0;
        }

        .profile-summary-card p {
            color: #555;
            font-size: 1.1em;
            margin-bottom: 20px;
        }
        
        .btn-profile-view {
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.4s ease;
        }
        
        .btn-profile-view:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
            text-decoration: none;
        }

        .stat-card {
            background: linear-gradient(135deg, #7928ca, #5d22b3);
            color: #fff;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(93, 34, 179, 0.3);
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
            background: #fff;
            padding: 20px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            display: block;
            color: inherit;
            text-decoration: none !important;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(58, 12, 163, 0.1);
        }

        .action-card .glyphicon {
            font-size: 2em;
            color: #7928ca;
        }

        .action-card h5 {
            font-weight: 600;
            margin: 15px 0 0 0;
            color: #3a0ca3;
        }
    </style>

    <div class="dashboard-hero">
        <div class="container">
            <h1>Welcome, <asp:Literal ID="ltName" runat="server" />!</h1>
            <p class="lead">Your personalized career dashboard is ready.</p>
        </div>
    </div>

    <div class="container dashboard-container">
        <div class="row">
            <%-- Profile Summary --%>
            <div class="col-md-4">
                <div class="profile-summary-card">
                    <asp:Image ID="imgProfile" runat="server" CssClass="profile-picture" alt="Profile Picture" />
                    <h3><asp:Literal ID="ltFullName" runat="server" /></h3>
                    <p><asp:Literal ID="ltProfileTitle" runat="server" /></p>
                    <asp:HyperLink runat="server" NavigateUrl="~/Users/Job_Seeker/View_Profile.aspx" CssClass="btn btn-profile-view">View & Edit Profile</asp:HyperLink>
                </div>
            </div>

            <%-- Dashboard Stats --%>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-4 col-sm-4">
                        <div class="stat-card">
                            <span class="glyphicon glyphicon-briefcase"></span>
                            <h4><asp:Literal ID="ltJobsApplied" runat="server" Text="0"></asp:Literal></h4>
                            <p>Jobs Applied</p>
                        </div>
                    </div>
                     <div class="col-md-4 col-sm-4">
                        <div class="stat-card">
                            <span class="glyphicon glyphicon-calendar"></span>
                            <h4><asp:Literal ID="ltInterviews" runat="server" Text="0"></asp:Literal></h4>
                            <p>Interviews Scheduled</p>
                        </div>
                    </div>
                     <div class="col-md-4 col-sm-4">
                        <div class="stat-card">
                            <span class="glyphicon glyphicon-thumbs-down"></span>
                            <h4><asp:Literal ID="ltRejected" runat="server" Text="0"></asp:Literal></h4>
                            <p>Applications Rejected</p>
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-12">
                        <h3 class="section-title">Quick Actions</h3>
                    </div>
                     <div class="col-md-4 col-sm-4">
                         <a href="FindJobs.aspx" class="action-card">
                             <span class="glyphicon glyphicon-search"></span>
                             <h5>Find New Jobs</h5>
                         </a>
                    </div>
                     <div class="col-md-4 col-sm-4">
                         <a href="AppliedJobs.aspx" class="action-card">
                             <span class="glyphicon glyphicon-list-alt"></span>
                             <h5>My Applications</h5>
                         </a>
                    </div>
                     <div class="col-md-4 col-sm-4">
                         <a href="Edit_Profile.aspx" class="action-card">
                             <span class="glyphicon glyphicon-cog"></span>
                             <h5>Update Profile</h5>
                         </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

