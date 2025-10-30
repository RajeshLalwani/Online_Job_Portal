<%@ Page Title="Contact US" Language="C#" MasterPageFile="~/Users/Employer/Employer.Master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Custom CSS for a beautiful and professional contact page --%>
    <style>
        .contact-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/about-us-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

        .contact-hero h1 {
            font-size: 3.5em;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }

        .contact-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            margin-bottom: 50px;
            transition: all 0.3s ease-in-out;
        }

        .contact-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(58, 12, 163, 0.15);
        }

        .contact-form h3, .contact-info h3 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
            transition: text-shadow 0.3s ease;
        }

        /* Hover effect removed from .contact-form h3 */
        .contact-info h3:hover {
            text-shadow: 0 0 8px rgba(121, 40, 202, 0.5);
        }

        /* --- FINAL, SIMPLIFIED FORM STYLING --- */
        .contact-form .form-group {
            margin-bottom: 20px; /* Adds space between form fields */
        }
        
        .contact-form .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            transition: color 0.3s ease;
        }
        
        /* New hover effect for labels */
        .contact-form .form-group:hover label {
            color: #7928ca;
        }

        .contact-form .form-control {
            display: block;
            width: 100%;
            max-width: none;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
            height: 47px; /* Increased height by 5px */
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

        .btn-submit-message {
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.4s ease;
        }

        .btn-submit-message:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }

        .contact-info-panel {
            background-color: #f8f7ff;
            padding: 30px;
            border-radius: 12px;
            border-left: 5px solid #7928ca;
            height: 100%;
            transition: all 0.3s ease;
        }

        .contact-info-panel:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(58, 12, 163, 0.1);
        }

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
            font-size: 1.1em;
            transition: transform 0.3s ease;
        }

        .contact-info-item:hover {
            transform: translateX(5px);
        }

        .contact-info-item .glyphicon {
            font-size: 1.5em;
            color: #7928ca;
            margin-right: 20px;
            margin-top: 5px;
        }

        .contact-info-item h4 {
            font-weight: 600;
            margin-top: 0;
            margin-bottom: 5px;
            color: #3a0ca3;
        }

        .contact-info-item a {
            color: #555;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .contact-info-item a:hover {
            color: #7928ca;
            text-decoration: none;
        }
    </style>

    <div class="contact-hero">
        <div class="container">
            <h1>Get In Touch</h1>
            <p class="lead">We'd love to hear from you. Whether you have a question, feedback, or need assistance, our team is ready to help.</p>
        </div>
    </div>

    <div class="container">
        <div class="contact-container">
            <div class="row">
                <%-- Contact Form Column --%>
                <div class="col-md-8">
                    <div class="contact-form">
                        <h3>Send Us a Message</h3>

                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-center text-danger">
                                <br />
                                <asp:Label runat="server" ID="FailureText" />
                                <br />
                                <br />
                            </p>
                        </asp:PlaceHolder>

                        <%-- SIMPLIFIED AND RESTRUCTURED FORM --%>
                        <div class="form-group">
                            <label for="<%= Name.ClientID %>">Your Name</label>
                            <asp:TextBox runat="server" ID="Name" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" CssClass="validation-error" ErrorMessage="The Name field is required." Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="Name" CssClass="validation-error" ErrorMessage="Name can only contain letters and spaces." ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </div>
                        <div class="form-group">
                            <label for="<%= Email.ClientID %>">Your Email</label>
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" placeholder="Enter your email address" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="The Email field is required." Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Email" CssClass="validation-error" Display="Dynamic" ErrorMessage="Please enter a valid email." SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                        <div class="form-group">
                            <label for="<%= Subject.ClientID %>">Subject</label>
                            <asp:TextBox runat="server" ID="Subject" CssClass="form-control" placeholder="Enter the subject of your message"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Subject" CssClass="validation-error" ErrorMessage="The Subject field is required." Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label for="<%= Message.ClientID %>">Message</label>
                            <asp:TextBox runat="server" ID="Message" CssClass="form-control" placeholder="Enter your message here..." TextMode="MultiLine" Rows="6" Style="height: auto;"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Message" CssClass="validation-error" ErrorMessage="The Message field is required." Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group text-center">
                            <asp:Button runat="server" ID="Submit" OnClick="Submit_Click" Text="Send Message" CssClass="btn btn-submit-message" />
                        </div>
                         <%-- END OF SIMPLIFIED FORM --%>
                    </div>
                </div>

                <%-- Contact Information Column --%>
                <div class="col-md-4">
                    <div class="contact-info-panel">
                        <h3>Contact Information</h3>
                        <div class="contact-info-item">
                            <span class="glyphicon glyphicon-map-marker"></span>
                            <div>
                                <h4>Our Office</h4>
                                <p>
                                    Anand, Gujarat,<br />
                                    India - 388001</p>
                            </div>
                        </div>
                        <div class="contact-info-item">
                            <span class="glyphicon glyphicon-earphone"></span>
                            <div>
                                <h4>Phone</h4>
                                <p><a href="tel:+918488984951">+91 84889 84951</a></p>
                            </div>
                        </div>
                        <div class="contact-info-item">
                            <span class="glyphicon glyphicon-envelope"></span>
                            <div>
                                <h4>Email</h4>
                                <p><a href="mailto:support@jobify.com">support@jobify.com</a></p>
                                <p><a href="mailto:marketing@jobify.com">marketing@jobify.com</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

