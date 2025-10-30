<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="ViewApplicantProfile.aspx.cs" Inherits="Users_Employer_ViewApplicantProfile" %>

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

        /* Left Column - Contact Card */
        .contact-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            text-align: center;
            position: sticky;
            top: 90px;
        }

        .profile-picture-large {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 6px solid #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: -90px;
            margin-bottom: 15px;
            background-color: #fff;
        }

        .contact-card h2 {
            font-weight: 600;
            color: #3a0ca3;
            margin-top: 0;
            margin-bottom: 5px;
        }

        .contact-card .professional-title {
            color: #555;
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        
        .contact-info-list {
            list-style: none;
            padding: 0;
            text-align: left;
            margin: 20px 0;
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
        
        .summary-text {
            font-size: 1.1em;
            line-height: 1.8;
            color: #555;
        }
        
        .skills-container .skill-tag {
            display: inline-block;
            background-color: #f8f7ff;
            color: #5d22b3;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 5px;
            font-weight: 500;
            border: 1px solid #e0d1f5;
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
            <h1>Applicant Profile</h1>
            <p class="lead">Review the candidate's professional details below.</p>
        </div>
    </div>

    <div class="container profile-container">
         <asp:Panel ID="pnlProfile" runat="server" Visible="false">
            <div class="row">
                <%-- Left Column --%>
                <div class="col-md-4">
                    <div class="contact-card">
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-picture-large" />
                        <h2><asp:Literal ID="ltFullName" runat="server"></asp:Literal></h2>
                        <p class="professional-title"><asp:Literal ID="ltProfileTitle" runat="server"></asp:Literal></p>
                        
                        <ul class="contact-info-list">
                            <li><span class="glyphicon glyphicon-envelope"></span><asp:Literal ID="ltEmail" runat="server"></asp:Literal></li>
                            <li><span class="glyphicon glyphicon-phone"></span><asp:Literal ID="ltPhone" runat="server"></asp:Literal></li>
                            <li><span class="glyphicon glyphicon-map-marker"></span><asp:Literal ID="ltLocation" runat="server"></asp:Literal></li>
                        </ul>
                        
                        <asp:HyperLink ID="hlDownloadResume" Target="_blank" runat="server" CssClass="btn btn-profile-action">
                             <span class="glyphicon glyphicon-download-alt"></span> Download Resume
                        </asp:HyperLink>
                    </div>
                </div>

                <%-- Right Column --%>
                <div class="col-md-8">
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-user" style="margin-right:10px;"></span>Summary</h3>
                        <p class="summary-text">
                            <asp:Literal ID="ltSummary" runat="server"></asp:Literal>
                        </p>
                    </div>
                    
                    <div class="profile-details-section skills-container">
                        <h3><span class="glyphicon glyphicon-tags" style="margin-right:10px;"></span>Skills</h3>
                        <asp:Repeater ID="rptSkills" runat="server">
                            <ItemTemplate>
                                <span class="skill-tag"><%# Container.DataItem %></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-education" style="margin-right:10px;"></span>Experience & Qualification</h3>
                        <div class="info-grid">
                            <div class="row">
                                <div class="col-sm-4 info-label">Highest Qualification</div>
                                <div class="col-sm-8 info-value"><asp:Literal ID="ltQualification" runat="server"></asp:Literal></div>
                            </div>
                             <div class="row">
                                <div class="col-sm-4 info-label">Total Experience</div>
                                <div class="col-sm-8 info-value"><asp:Literal ID="ltExperience" runat="server"></asp:Literal></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
