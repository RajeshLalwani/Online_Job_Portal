<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="Applicants.aspx.cs" Inherits="Users_Admin_Applicants" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .applicants-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

            .applicants-hero h1 {
                font-size: 2.8em;
                font-weight: 700;
            }

            .applicants-hero .job-title-sub {
                font-size: 1.5em;
                opacity: 0.9;
            }

        .stat-card {
            background: #fff;
            color: #3a0ca3;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 20px;
            border-left: 5px solid #7928ca;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

            .stat-card h4 {
                font-size: 2em;
                font-weight: 700;
                margin: 0;
            }

            .stat-card p {
                font-weight: 500;
                color: #555;
                margin-top: 5px;
            }

        .applicant-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

            .applicant-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(58, 12, 163, 0.1);
            }

        .applicant-main-content {
            display: flex;
            align-items: center;
            padding: 20px;
        }

        .applicant-photo {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #f1f1f1;
            margin-right: 20px;
        }

        .applicant-info h4 {
            margin-top: 0;
            margin-bottom: 5px;
            font-weight: 600;
            color: #3a0ca3;
        }

        .applicant-info p {
            margin-bottom: 10px;
            color: #555;
        }

        .applicant-actions {
            margin-left: auto;
            text-align: right;
        }

            .applicant-actions .btn {
                border-radius: 50px;
                font-weight: 600;
                padding: 8px 20px;
            }

        .btn-view-profile {
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            color: #fff !important;
            border: none;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            color: #fff;
            font-weight: 500;
            font-size: 0.9em;
        }

        .status-active, .status-shortlisted {
            background-color: #28a745;
        }

        .status-hired {
            background-color: #5d22b3;
        }

        .status-rejected {
            background-color: #dc3545;
        }

        .status-pending {
            background-color: #ffc107;
            color: #333;
        }

        .status-interviewscheduled {
            background-color: #007bff;
        }
    </style>

    <div class="applicants-hero">
        <div class="container">
            <h1>Job Applicants</h1>
            <p class="lead job-title-sub">For:
                <asp:Literal ID="ltJobTitle" runat="server"></asp:Literal></p>
        </div>
    </div>

    <div class="container">
        <!-- Stats Row -->
        <div class="row">
            <div class="col-md-2 col-sm-4">
                <div class="stat-card">
                    <h4>
                        <asp:Literal ID="ltTotal" runat="server" Text="0"></asp:Literal></h4>
                    <p>Total</p>
                </div>
            </div>
            <div class="col-md-2 col-sm-4">
                <div class="stat-card">
                    <h4>
                        <asp:Literal ID="ltPending" runat="server" Text="0"></asp:Literal></h4>
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

        <asp:Repeater ID="rptApplicants" runat="server">
            <ItemTemplate>
                <div class="applicant-card">
                    <div class="applicant-main-content">
                        <asp:Image runat="server" CssClass="applicant-photo" ImageUrl='<%# ResolveUrl(Eval("ProfilePicturePath").ToString()) %>' />
                        <div class="applicant-info">
                            <h4><%# Eval("FirstName") %> <%# Eval("LastName") %></h4>
                            <p><%# Eval("ProfessionalTitle") %></p>
                            <div>
                                <span class='status-badge status-<%# Eval("Status").ToString().Replace(" ", "").ToLower() %>'>Status: <%# Eval("Status") %>
                                </span>
                            </div>
                        </div>
                        <div class="applicant-actions">
                            <asp:HyperLink runat="server" CssClass="btn btn-primary btn-view-profile" NavigateUrl='<%# "~/Users/Admin/ViewApplicantProfile.aspx?id=" + Eval("JobSeekerID") %>'>View Profile</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Panel ID="pnlNoApplicants" runat="server" Visible="false" CssClass="no-applicants-panel">
            <h3>No Applicants Found For This Job</h3>
        </asp:Panel>
    </div>
</asp:Content>

