<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="ViewCompanyProfile.aspx.cs" Inherits="Users_Admin_ViewCompanyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Reusing styles from Employer's View Profile page for consistency --%>
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

        .summary-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            text-align: center;
            position: sticky !important;
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

        /* Stat Card Styles */
        .stat-card {
            background: #f9f9f9;
            color: #3a0ca3;
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 15px;
            border-left: 4px solid #7928ca;
        }

            .stat-card h4 {
                font-size: 1.8em;
                font-weight: 700;
                margin: 0;
            }

            .stat-card p {
                font-weight: 500;
                color: #555;
                margin-top: 5px;
                font-size: 0.9em;
            }


  
    </style>

    <div class="profile-hero">
        <div class="container">
            <h1>Company Profile</h1>
        </div>
    </div>
    <div class="container profile-container">
        <asp:Panel ID="pnlProfile" runat="server" Visible="false">
            <div class="row">
                <div class="col-md-4">
                    <div class="summary-card">
                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="profile-logo-large" />
                        <h2>
                            <asp:Literal ID="ltCompanyName" runat="server"></asp:Literal></h2>
                        <asp:HyperLink ID="hlCompanyWebsite" runat="server" Target="_blank" CssClass="company-website"></asp:HyperLink>
                        <ul class="contact-info-list">
                            <li><span class="glyphicon glyphicon-user"></span><strong>Contact:</strong>
                                <asp:Literal ID="ltContactName" runat="server"></asp:Literal></li>
                            <li><span class="glyphicon glyphicon-phone"></span><strong>Phone:</strong>
                                <asp:Literal ID="ltContactPhone" runat="server"></asp:Literal></li>
                            <li><span class="glyphicon glyphicon-envelope"></span><strong>Email:</strong>
                                <asp:Literal ID="ltEmail" runat="server"></asp:Literal></li>
                        </ul>
                        <asp:HyperLink ID="hlViewJobs" runat="server" CssClass="btn btn-profile-action" Style="background: #eee; color: #333 !important;">
                             <span class="glyphicon glyphicon-list-alt"></span> View Posted Jobs
                        </asp:HyperLink>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-info-sign"></span>About Company</h3>
                        <p class="about-text">
                            <asp:Literal ID="ltAboutCompany" runat="server"></asp:Literal></p>
                    </div>

                    <%-- CORRECTED: Re-added the missing sections --%>
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-stats"></span>Company Details</h3>
                        <div class="info-grid">
                            <div class="row">
                                <div class="col-sm-4 info-label">Company Size</div>
                                <div class="col-sm-8 info-value">
                                    <asp:Literal ID="ltCompanySize" runat="server"></asp:Literal></div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 info-label">Founded In</div>
                                <div class="col-sm-8 info-value">
                                    <asp:Literal ID="ltFoundedYear" runat="server"></asp:Literal></div>
                            </div>
                        </div>
                    </div>
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-map-marker"></span>Location</h3>
                        <div class="info-grid">
                            <div class="row">
                                <div class="col-sm-4 info-label">Address</div>
                                <div class="col-sm-8 info-value">
                                    <asp:Literal ID="ltAddress" runat="server"></asp:Literal></div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 info-label">Location</div>
                                <div class="col-sm-8 info-value">
                                    <asp:Literal ID="ltFullLocation" runat="server"></asp:Literal></div>
                            </div>
                        </div>
                    </div>

                    <!-- NEW: Statistics Section -->
                    <div class="profile-details-section">
                        <h3><span class="glyphicon glyphicon-dashboard"></span>Hiring Statistics</h3>
                        <h4>Job Postings</h4>
                        <div class="row">
                            <div class="col-md-3 col-sm-6">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltTotalJobs" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Total Jobs</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltActiveJobs" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Active</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltPendingJobs" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Pending</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltClosedJobs" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Closed</p>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <h4>Applicants Overview</h4>
                        <div class="row">
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltTotalApplicants" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Total</p>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltPendingApplicants" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Pending</p>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltShortlisted" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Shortlisted</p>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltInterview" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Interview</p>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltHired" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Hired</p>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="stat-card">
                                    <h4>
                                        <asp:Literal ID="ltRejected" runat="server" Text="0"></asp:Literal></h4>
                                    <p>Rejected</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

