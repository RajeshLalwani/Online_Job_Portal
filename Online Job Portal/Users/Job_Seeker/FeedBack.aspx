<%@ Page Title="Feed Back" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="FeedBack.aspx.cs" Inherits="Users_Job_Seeker_FeedBack" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Custom CSS for a beautiful and professional feedback page --%>
    <style>
        .feedback-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/about-us-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

        .feedback-hero h1 {
            font-size: 3.5em;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }

        .feedback-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            margin-bottom: 50px;
            transition: all 0.3s ease-in-out;
        }

        .feedback-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(58, 12, 163, 0.15);
        }

        .feedback-form h3 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }

        /* Form Styling */
        .feedback-form .form-group {
            margin-bottom: 20px;
        }
        
        .feedback-form .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            transition: color 0.3s ease;
        }
        
        .feedback-form .form-group:hover label {
            color: #7928ca;
        }

        /* --- DEFINITIVE FIX FOR TEXTBOX WIDTH --- */
        /* This high-specificity rule overrides external styles to ensure full width. */
        .feedback-container .feedback-form .form-group .form-control {
            display: block;
            width: 100% !important; /* Force full width */
            max-width: none !important; /* Remove any max-width constraints */
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
            height: 47px;
            transition: all 0.3s ease;
        }
        /* --- END OF FIX --- */

        .form-control:focus {
            border-color: #7928ca;
            box-shadow: 0 0 0 0.2rem rgba(121, 40, 202, 0.25);
        }

        .form-control:hover {
            border-color: #9a65d0;
        }

        .validation-error {
            color: #dc3545;
            font-weight: 500;
            font-size: 0.9em;
            margin-top: 5px;
            display: block;
        }

        .btn-submit-feedback {
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.4s ease;
            margin-top: 15px;
        }

        .btn-submit-feedback:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }
    </style>

    <div class="feedback-hero">
        <div class="container">
            <h1>Share Your Feedback</h1>
            <p class="lead">We are constantly working to improve your experience. We'd love to hear your thoughts!</p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <%-- MODIFIED: Container width changed from col-md-8 to col-md-6 for a more focused look --%>
            <div class="col-md-6 col-md-offset-3">
                <div class="feedback-container">
                    <div class="feedback-form">
                        <h3>We Value Your Opinion</h3>

                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-center text-danger">
                                <br />
                                <asp:Label runat="server" ID="FailureText" />
                                <br /><br />
                            </p>
                        </asp:PlaceHolder>

                        <div class="form-group">
                            <label for="<%= Name.ClientID %>">Full Name</label>
                            <asp:TextBox runat="server" ID="Name" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" CssClass="validation-error" ErrorMessage="The Name field is required." Display="Dynamic" SetFocusOnError="True" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="Name" CssClass="validation-error" ErrorMessage="Name can only contain letters and spaces." ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-group">
                            <label for="<%= ContactNo.ClientID %>">Contact No.</label>
                            <asp:TextBox runat="server" ID="ContactNo" CssClass="form-control" placeholder="Enter your 10-digit mobile number" TextMode="Phone"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ContactNo" CssClass="validation-error" ErrorMessage="The Contact No. field is required." Display="Dynamic" SetFocusOnError="True" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="ContactNo" CssClass="validation-error" ErrorMessage="Please enter a valid 10-digit contact number." ValidationExpression="^\d{10}$" Display="Dynamic" SetFocusOnError="True" />
                        </div>

                        <div class="form-group">
                            <label for="<%= Email.ClientID %>">Email</label>
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" placeholder="Enter your email address" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="The Email field is required." Display="Dynamic" SetFocusOnError="True" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="Please enter a valid email." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" SetFocusOnError="True" />
                        </div>

                        <div class="form-group">
                            <label for="<%= FeedBack.ClientID %>">Feedback</label>
                            <asp:TextBox runat="server" ID="FeedBack" CssClass="form-control" placeholder="Share your thoughts, suggestions, or issues..." TextMode="MultiLine" Rows="6" Style="height: auto;"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="FeedBack" CssClass="validation-error" ErrorMessage="The Feedback field is required." Display="Dynamic" SetFocusOnError="True" />
                        </div>

                        <div class="form-group text-center">
                            <asp:Button runat="server" ID="Submit" OnClick="Submit_Click" Text="Submit Feedback" CssClass="btn btn-submit-feedback" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

