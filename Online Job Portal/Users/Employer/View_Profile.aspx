<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="View_Profile.aspx.cs" Inherits="Users_Employer_View_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .profile-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
            text-align: center;
        }

        .profile-hero h1 {
            font-size: 2.8em;
            font-weight: 700;
        }
        
        .profile-container {
            margin-top: 30px;
        }

        /* Left Column - Summary Card */
        .summary-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            text-align: center;
            position: sticky;
            top: 90px;
        }

        .profile-logo-large {
            width: 150px;
            height: 150px;
            border-radius: 12px;
            object-fit: contain;
            border: 6px solid #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: -90px;
            margin-bottom: 15px;
            background-color: #fff;
        }

        .summary-card h2 {
            font-weight: 600;
            color: #3a0ca3;
            margin-top: 0;
            margin-bottom: 5px;
        }

        .summary-card .company-website {
            color: #555;
            font-size: 1.2em;
            margin-bottom: 20px;
            display: block;
            word-wrap: break-word;
        }
        
        .contact-info-list {
            list-style: none;
            padding: 0;
            text-align: left;
            margin: 20px 0;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }
        .contact-info-list li {
            margin-bottom: 15px;
            font-size: 1.1em;
            color: #333;
        }
        .contact-info-list .glyphicon {
            color: #7928ca;
            margin-right: 15px;
            width: 20px;
            text-align: center;
        }
        
        .btn-profile-action {
            width: 100%;
            margin-bottom: 10px;
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 12px 25px;
            font-size: 1.1em;
            font-weight: 600;
            transition: all 0.4s ease;
        }
        .btn-profile-action:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }

        /* Right Column - Details */
        .profile-details-section {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            margin-bottom: 30px;
        }
        
        .profile-details-section h3 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }
        
        .about-text {
            font-size: 1.1em;
            line-height: 1.8;
            color: #555;
        }
        
        .info-grid {
             font-size: 1.1em;
        }
        .info-grid .row {
            padding: 15px 0;
            border-bottom: 1px solid #f1f1f1;
        }
        .info-grid .row:last-child {
            border-bottom: none;
        }
        .info-grid .info-label {
            font-weight: 600;
            color: #333;
        }
        .info-grid .info-value {
            color: #555;
        }

    </style>

    <div class="profile-hero">
        <div class="container">
            <h1>Company Profile</h1>
            <p class="lead">Manage your company's information and hiring presence.</p>
        </div>
    </div>

    <div class="container profile-container">
        <div class="row">
            <%-- Left Column --%>
            <div class="col-md-4">
                <div class="summary-card">
                    <asp:Image ID="imgCompanyLogo" runat="server" CssClass="profile-logo-large" />
                    <h2><asp:Literal ID="ltCompanyName" runat="server"></asp:Literal></h2>
                    <asp:HyperLink ID="hlCompanyWebsite" runat="server" Target="_blank" CssClass="company-website"></asp:HyperLink>
                    
                    <ul class="contact-info-list">
                        <li><span class="glyphicon glyphicon-user"></span><strong>Contact:</strong> <asp:Literal ID="ltContactName" runat="server"></asp:Literal></li>
                        <li><span class="glyphicon glyphicon-phone"></span><strong>Phone:</strong> <asp:Literal ID="ltContactPhone" runat="server"></asp:Literal></li>
                        <li><span class="glyphicon glyphicon-envelope"></span><strong>Email:</strong> <asp:Literal ID="ltEmail" runat="server"></asp:Literal></li>
                    </ul>
                    
                    <asp:HyperLink ID="hlPostJob" runat="server" NavigateUrl="~/Users/Employer/Add_New_Job.aspx" CssClass="btn btn-profile-action">
                         <span class="glyphicon glyphicon-plus"></span> Post a New Job
                    </asp:HyperLink>
                    <asp:HyperLink ID="hlEditProfile" runat="server" NavigateUrl="~/Users/Employer/Edit_Profile.aspx" CssClass="btn btn-profile-action" style="background: #eee; color: #333 !important;">
                        <span class="glyphicon glyphicon-pencil"></span> Edit Profile
                    </asp:HyperLink>
                </div>
            </div>

            <%-- Right Column --%>
            <div class="col-md-8">
                <div class="profile-details-section">
                    <h3><span class="glyphicon glyphicon-info-sign" style="margin-right:10px;"></span>About Company</h3>
                    <p class="about-text">
                        <asp:Literal ID="ltAboutCompany" runat="server"></asp:Literal>
                    </p>
                </div>
                
                <div class="profile-details-section">
                    <h3><span class="glyphicon glyphicon-stats" style="margin-right:10px;"></span>Company Details</h3>
                    <div class="info-grid">
                        <div class="row">
                            <div class="col-sm-4 info-label">Company Size</div>
                            <div class="col-sm-8 info-value"><asp:Literal ID="ltCompanySize" runat="server"></asp:Literal></div>
                        </div>
                         <div class="row">
                            <div class="col-sm-4 info-label">Founded In</div>
                            <div class="col-sm-8 info-value"><asp:Literal ID="ltFoundedYear" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                </div>

                 <div class="profile-details-section">
                    <h3><span class="glyphicon glyphicon-map-marker" style="margin-right:10px;"></span>Location</h3>
                    <div class="info-grid">
                        <div class="row">
                            <div class="col-sm-4 info-label">Address</div>
                            <div class="col-sm-8 info-value"><asp:Literal ID="ltAddress" runat="server"></asp:Literal></div>
                        </div>
                         <div class="row">
                            <div class="col-sm-4 info-label">Location</div>
                            <div class="col-sm-8 info-value"><asp:Literal ID="ltFullLocation" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
