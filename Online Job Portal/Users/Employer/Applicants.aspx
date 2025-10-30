<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="Applicants.aspx.cs" Inherits="Users_Employer_Applicants" %>

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

        .filter-bar {
            background-color: #fff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

            .filter-bar .form-group {
                margin-bottom: 0;
            }

            .filter-bar label {
                font-weight: 600;
                color: #5d22b3;
            }

            .filter-bar .form-group .form-control {
                display: block;
                width: 100% !important;
                max-width: none !important;
                box-sizing: border-box;
                border-radius: 8px;
                border: 1px solid #ced4da;
                padding: 10px 15px;
                height: 42px;
            }

        .applicant-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            transition: all 0.3s ease;
            border-left: 5px solid #ced4da;
        }

            .applicant-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(58, 12, 163, 0.1);
            }

        .status-interviewscheduled {
            border-left-color: #007bff;
        }

        .status-rejected {
            border-left-color: #dc3545;
        }

        .status-pending {
            border-left-color: #ffc107;
        }

        .status-shortlisted {
            border-left-color: #28a745;
        }

        .status-hired {
            border-left-color: #5d22b3;
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

        .skill-tag {
            display: inline-block;
            background-color: #f8f7ff;
            color: #5d22b3;
            padding: 5px 12px;
            border-radius: 20px;
            margin: 2px;
            font-size: 0.9em;
            font-weight: 500;
            border: 1px solid #e0d1f5;
        }

        .application-details {
            padding: 0 20px 20px 20px;
            color: #555;
        }

            .application-details .detail-label {
                font-weight: bold;
                color: #3a0ca3;
            }

        .applicant-footer {
            background-color: #f9f9f9;
            padding: 15px 20px;
            border-top: 1px solid #f1f1f1;
            border-radius: 0 0 12px 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .application-status {
            font-weight: 600;
            font-size: 1.1em;
        }

        .applicant-actions .btn {
            border-radius: 50px;
            font-weight: 600;
            padding: 8px 20px;
            transition: all 0.3s ease;
            margin-left: 10px;
        }

        .btn-view-profile, .btn-hired {
            background-image: linear-gradient(120deg, #7928ca, #5d22b3);
            color: #fff !important;
            border: none;
        }

            .btn-view-profile:hover, .btn-hired:hover {
                box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
                transform: translateY(-2px);
            }

        .btn-shortlist {
            background-color: #28a745;
            color: #fff !important;
            border: none;
        }

            .btn-shortlist:hover {
                background-color: #218838;
                color: #fff;
                transform: translateY(-2px);
            }

        .btn-interview {
            background-color: #007bff;
            color: #fff !important;
            border: none;
        }

            .btn-interview:hover {
                background-color: #0069d9;
                color: #fff;
                transform: translateY(-2px);
            }

        .btn-reject {
            background-color: #dc3545;
            color: #fff !important;
            border: none;
        }

            .btn-reject:hover {
                background-color: #c82333;
                color: #fff;
                transform: translateY(-2px);
            }

        .no-applicants-panel {
            text-align: center;
            padding: 60px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
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
        <asp:HiddenField ID="hdnApplicationID" runat="server" />
        <asp:HiddenField ID="hdnInputValue" runat="server" />
        <asp:Button ID="btnPerformRejection" runat="server" OnClick="btnPerformRejection_Click" Style="display: none;" />
        <asp:Button ID="btnPerformInterviewSchedule" runat="server" OnClick="btnPerformInterviewSchedule_Click" Style="display: none;" />

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

        <div class="filter-bar">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="<%= ddlStatusFilter.ClientID %>">Filter by Status</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="">All Applicants</asp:ListItem>
                            <asp:ListItem>Pending</asp:ListItem>
                            <asp:ListItem>Shortlisted</asp:ListItem>
                            <asp:ListItem Value="Interview Scheduled">Interview Scheduled</asp:ListItem>
                            <asp:ListItem>Hired</asp:ListItem>
                            <asp:ListItem>Rejected</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <asp:Repeater ID="rptApplicants" runat="server" OnItemCommand="rptApplicants_ItemCommand">
            <ItemTemplate>
                <div class='applicant-card status-<%# Eval("Status").ToString().Replace(" ", "").ToLower() %>'>
                    <div class="applicant-main-content">
                        <asp:Image runat="server" CssClass="applicant-photo" ImageUrl='<%# ResolveUrl(Eval("ProfilePicturePath").ToString()) %>' />
                        <div class="applicant-info">
                            <h4><%# Eval("FirstName") %> <%# Eval("LastName") %></h4>
                            <p><%# Eval("ProfessionalTitle") %></p>
                            <div>
                                <asp:Repeater ID="rptSkills" runat="server" DataSource='<%# SplitSkills(Eval("Skills")) %>'>
                                    <ItemTemplate>
                                        <span class="skill-tag"><%# Container.DataItem.ToString().Trim() %></span>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <div class="application-details">
                        <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Rejected" && Eval("RejectionReason") != DBNull.Value %>'>
                            <span class="detail-label">Rejection Reason:</span> <%# Eval("RejectionReason") %>
                        </asp:Panel>
                        <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Interview Scheduled" && Eval("InterviewDate") != DBNull.Value %>'>
                            <span class="detail-label">Interview Date:</span> <%# FormatInterviewDate(Eval("InterviewDate")) %>
                        </asp:Panel>
                    </div>
                    <div class="applicant-footer">
                        <div class="application-status">
                            Status: <strong><%# Eval("Status") %></strong>
                        </div>
                        <div class="applicant-actions">
                            <asp:HyperLink runat="server" CssClass="btn btn-default" Target="_blank" NavigateUrl='<%# ResolveUrl(Eval("ResumePath").ToString()) %>'>
                                 <span class="glyphicon glyphicon-download-alt"></span> Resume
                            </asp:HyperLink>

                            <asp:HyperLink runat="server" CssClass="btn btn-info" NavigateUrl='<%# "~/Users/Employer/ViewApplicantProfile.aspx?id=" + Eval("JobSeekerID") %>'>
                                 <span class="glyphicon glyphicon-eye-open"></span> View Profile
                            </asp:HyperLink>

                            <asp:LinkButton ID="btnShortlist" runat="server" CssClass="btn btn-shortlist"
                                CommandName="Shortlist" CommandArgument='<%# Eval("ApplicationID") %>'
                                Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                OnClientClick='<%# GetConfirmClientClick("Shortlist Applicant?", "This will mark the application as shortlisted.") %>'>
                                <span class="glyphicon glyphicon-thumbs-up"></span> Shortlist
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnHired" runat="server" CssClass="btn btn-hired"
                                CommandName="Hired" CommandArgument='<%# Eval("ApplicationID") %>'
                                Visible='<%# Eval("Status").ToString() == "Interview Scheduled" %>'
                                OnClientClick='<%# GetConfirmClientClick("Mark as Hired?", "This will finalize the hiring process for this applicant.") %>'>
                                <span class="glyphicon glyphicon-ok"></span> Mark as Hired
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnScheduleInterview" runat="server" CssClass="btn btn-interview"
                                OnClientClick='<%# GetScheduleInterviewClientClick(Eval("ApplicationID"), Eval("Status")) %>'
                                Visible='<%# Eval("Status").ToString() == "Shortlisted" || Eval("Status").ToString() == "Interview Scheduled" %>'>
                                <span class="glyphicon glyphicon-calendar"></span> <%# Eval("Status").ToString() == "Interview Scheduled" ? "Reschedule" : "Schedule" %>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-reject"
                                OnClientClick='<%# GetRejectClientClick(Eval("ApplicationID")) %>'
                                Visible='<%# Eval("Status").ToString() != "Rejected" && Eval("Status").ToString() != "Hired" %>'>
                                <span class="glyphicon glyphicon-thumbs-down"></span> Reject
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoApplicants" runat="server" Visible="false" CssClass="no-applicants-panel">
            <h3>No Applicants Found</h3>
            <p>There are currently no applicants matching your filter. Try selecting "All Applicants".</p>
            <asp:HyperLink runat="server" NavigateUrl="~/Users/Employer/PostedJobs.aspx" CssClass="btn btn-default" Style="margin-top: 20px;">
                <span class="glyphicon glyphicon-arrow-left"></span> Back to All Jobs
            </asp:HyperLink>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function confirmAction(sender, event, title, text) {
            event.preventDefault();
            Swal.fire({
                title: title,
                text: text,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, proceed!'
            }).then((result) => {
                if (result.isConfirmed) {
                    eval(sender.getAttribute('href'));
                }
            });
            return false;
        }

        function rejectApplication(applicationID) {
            Swal.fire({
                title: 'Reject Application',
                input: 'textarea',
                inputPlaceholder: 'Please provide a reason for rejection...',
                showCancelButton: true,
                confirmButtonText: 'Submit Rejection',
                confirmButtonColor: '#dc3545',
                preConfirm: (reason) => {
                    if (!reason) {
                        Swal.showValidationMessage('A reason is required to reject an application.');
                    }
                    return reason;
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hdnApplicationID.ClientID %>').value = applicationID;
                    document.getElementById('<%= hdnInputValue.ClientID %>').value = result.value;
                    document.getElementById('<%= btnPerformRejection.ClientID %>').click();
                    }
                });
        }

        function scheduleInterview(applicationID, currentStatus) {
            const isReschedule = currentStatus === "Interview Scheduled";
            const title = isReschedule ? 'Reschedule Interview' : 'Schedule Interview';

            const now = new Date();
            const minDateTime = now.toISOString().slice(0, 16);

            Swal.fire({
                title: title,
                html: '<p>Please select a date and time for the interview.</p>' +
                    `<input type="datetime-local" id="interviewDate" class="swal2-input" min="${minDateTime}">`,
                showCancelButton: true,
                confirmButtonText: 'Confirm Schedule',
                confirmButtonColor: '#28a745',
                preConfirm: () => {
                    const interviewDate = document.getElementById('interviewDate').value;
                    if (!interviewDate) {
                        Swal.showValidationMessage('Please select a date and time for the interview.');
                    }
                    return interviewDate;
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hdnApplicationID.ClientID %>').value = applicationID;
                    document.getElementById('<%= hdnInputValue.ClientID %>').value = result.value;
                    document.getElementById('<%= btnPerformInterviewSchedule.ClientID %>').click();
                    }
                });
        }
    </script>
</asp:Content>

