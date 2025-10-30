<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="JobDetails.aspx.cs" Inherits="Users_Job_Seeker_JobDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .job-detail-header {
            background-color: #fff;
            padding: 30px;
            margin: -20px -15px 30px -15px;
            border-bottom: 1px solid #eee;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
        }

        .header-logo-container {
            width: 100px;
            height: 100px;
            margin-right: 25px;
            border: 1px solid #f1f1f1;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .header-logo {
            max-width: 80px;
            max-height: 80px;
            object-fit: contain;
        }

        .header-info h1 {
            margin-top: 0;
            margin-bottom: 5px;
            font-size: 2.5em;
            font-weight: 700;
            color: #3a0ca3;
        }
        .header-info .company-name {
            font-size: 1.3em;
            font-weight: 500;
            color: #555;
        }
        .header-info .meta-info {
            margin-top: 10px;
            color: #777;
        }
        .header-info .meta-info span {
            margin-right: 20px;
        }
        .header-info .glyphicon {
            margin-right: 5px;
        }

        .job-detail-container {
            margin-top: 30px;
        }

        /* Left Column */
        .job-description-section {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .job-description-section h3 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }

        .job-description-content {
            font-size: 1.1em;
            line-height: 1.8;
            color: #555;
        }
         .job-description-content ul {
            padding-left: 20px;
        }
        .job-description-content li {
            margin-bottom: 10px;
        }
        
        .skills-container {
            margin-top: 30px;
        }
        .skill-tag {
            display: inline-block;
            background-color: #f8f7ff;
            color: #5d22b3;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 5px;
            font-weight: 500;
            border: 1px solid #e0d1f5;
        }

        /* Right Column */
        .summary-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: sticky;
            top: 90px;
        }
        
        .summary-card h4 {
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 1.1em;
        }
        .summary-item .item-label {
            font-weight: 600;
            color: #333;
        }
        .summary-item .item-value {
            color: #555;
        }
        
        .btn-apply-now {
            width: 100%;
            background-image: linear-gradient(120deg, #28a745, #218838); /* Green gradient for apply */
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.4s ease;
            margin-top: 20px;
        }
        .btn-apply-now:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
            transform: translateY(-2px);
        }

        .btn-already-applied {
            width: 100%;
            background-color: #6c757d;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            margin-top: 20px;
            cursor: not-allowed;
        }

    </style>

    <div class="job-detail-header">
        <div class="header-logo-container">
            <asp:Image ID="imgCompanyLogo" runat="server" CssClass="header-logo" />
        </div>
        <div class="header-info">
            <h1><asp:Literal ID="ltJobTitle" runat="server"></asp:Literal></h1>
            <div class="company-name"><asp:Literal ID="ltCompanyName" runat="server"></asp:Literal></div>
            <div class="meta-info">
                <span><span class="glyphicon glyphicon-map-marker"></span><asp:Literal ID="ltLocation" runat="server"></asp:Literal></span>
                <span><span class="glyphicon glyphicon-time"></span><asp:Literal ID="ltJobType" runat="server"></asp:Literal></span>
            </div>
        </div>
    </div>

    <div class="container job-detail-container">
        <div class="row">
            <%-- Left Column --%>
            <div class="col-md-8">
                <div class="job-description-section">
                    <h3>Job Description</h3>
                    <div class="job-description-content">
                        <asp:Literal ID="ltJobDescription" runat="server" Mode="PassThrough"></asp:Literal>
                    </div>

                    <div class="skills-container">
                        <h3>Required Skills</h3>
                        <asp:Repeater ID="rptSkills" runat="server">
                            <ItemTemplate>
                                <span class="skill-tag"><%# Container.DataItem %></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <%-- Right Column --%>
            <div class="col-md-4">
                <div class="summary-card">
                    <h4>Job Summary</h4>
                    <div class="summary-item">
                        <span class="item-label">Salary</span>
                        <span class="item-value"><asp:Literal ID="ltSalary" runat="server"></asp:Literal></span>
                    </div>                   
                    <div class="summary-item">
                        <span class="item-label">Experience Required</span>
                        <span class="item-value"><asp:Literal ID="ltExperience" runat="server"></asp:Literal></span>
                    </div>
                      <div class="summary-item">
                        <span class="item-label">Qualification Required</span>
                        <span class="item-value"><asp:Literal ID="ltQualification" runat="server"></asp:Literal></span>
                    </div>
                     <div class="summary-item">
                        <span class="item-label">Posted On</span>
                        <span class="item-value"><asp:Literal ID="ltDatePosted" runat="server"></asp:Literal></span>
                    </div>
                     <div class="summary-item">
                        <span class="item-label">Deadline</span>
                        <span class="item-value"><asp:Literal ID="ltDeadline" runat="server"></asp:Literal></span>
                    </div>

                    <asp:Button ID="btnApplyNow" runat="server" Text="Apply Now" CssClass="btn btn-apply-now" OnClick="btnApplyNow_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>


