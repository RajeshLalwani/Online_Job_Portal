<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Admin/Admin.master" AutoEventWireup="true" CodeFile="FeedbackList.aspx.cs" Inherits="Users_Admin_FeedbackList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .feedback-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 60px 20px;
            margin: -20px -15px 30px -15px;
            border-radius: 0 0 15px 15px;
        }

        .feedback-hero h1 {
            font-size: 2.8em;
            font-weight: 700;
        }

        .page-header-actions {
            margin-bottom: 20px;
            text-align: right;
        }

        .feedback-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-left: 5px solid #28a745; /* Green for feedback */
        }

        .feedback-header {
            padding: 20px;
            border-bottom: 1px solid #f1f1f1;
        }

        .feedback-header h4 {
             margin-top: 0;
            margin-bottom: 5px;
            font-weight: 600;
            color: #3a0ca3;
        }

        .feedback-header .meta-info {
            color: #777;
            font-size: 0.9em;
        }
        .feedback-header .glyphicon {
            margin-right: 5px;
        }
        
        .feedback-body {
            padding: 20px;
        }
        .feedback-body .message-label {
            font-weight: bold;
            color: #333;
        }
        .feedback-body .message-content {
            margin-top: 5px;
            line-height: 1.7;
            color: #555;
        }
        
        .feedback-footer {
            background-color: #f9f9f9;
            padding: 10px 20px;
            border-top: 1px solid #f1f1f1;
            border-radius: 0 0 12px 12px;
            text-align: right;
        }
        
        .no-feedback-panel {
             text-align: center;
            padding: 60px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
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
    </style>

    <div class="feedback-hero">
        <div class="container">
            <h1>User Feedback</h1>
            <p class="lead">Review feedback submitted by users.</p>
        </div>
    </div>

    <div class="container">
         <div class="page-header-actions">
            <asp:LinkButton ID="btnDeleteAll" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteAll_Click" 
                OnClientClick="return confirmAction(this, event, 'Delete All Feedback?', 'This action cannot be undone and will permanently delete all feedback entries.');">
                <span class="glyphicon glyphicon-trash"></span> Delete All Feedback
            </asp:LinkButton>
        </div>

        <asp:Repeater ID="rptFeedbackList" runat="server" OnItemCommand="rptFeedbackList_ItemCommand">
            <ItemTemplate>
                <div class="feedback-card">
                    <div class="feedback-header">
                        <h4>Feedback from <%# Eval("Name") %></h4>
                        <div class="meta-info">
                            <span><span class="glyphicon glyphicon-user"></span> <strong>User Type:</strong> <%# Eval("UserType") %></span> | 
                            <span><span class="glyphicon glyphicon-time"></span> <strong>Received:</strong> <%# Convert.ToDateTime(Eval("FeedBackDate")).ToString("dd MMM yyyy, hh:mm tt") %></span>
                        </div>
                         <div class="meta-info" style="margin-top: 5px;">
                            <span><span class="glyphicon glyphicon-envelope"></span> <strong>Email:</strong> <a href='mailto:<%# Eval("Email") %>'><%# Eval("Email") %></a></span>
                        </div>
                    </div>
                    <div class="feedback-body">
                        <p class="message-label">Message:</p>
                        <p class="message-content"><%# Eval("FeedBack") %></p>
                    </div>
                     <div class="feedback-footer">
                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-danger" CommandName="DeleteFeedback" 
                            CommandArgument='<%# Eval("FeedBackID") %>' 
                            OnClientClick='<%# GetDeleteClientClick(Eval("FeedBackID")) %>'>
                            <span class="glyphicon glyphicon-trash"></span> Delete
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

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
        
        <asp:Panel ID="pnlNoFeedback" runat="server" Visible="false" CssClass="no-feedback-panel">
             <h3>There is no user feedback at this time.</h3>
        </asp:Panel>
    </div>
    
    <script type="text/javascript">
        function confirmAction(sender, event, title, text) {
            event.preventDefault();
            Swal.fire({
                title: title,
                text: text,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    eval(sender.getAttribute('href'));
                }
            });
            return false;
        }
    </script>
</asp:Content>


