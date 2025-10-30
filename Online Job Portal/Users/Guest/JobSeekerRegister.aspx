<%@ Page Title="Job Seeker Registration - Jobify" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="JobSeekerRegister.aspx.cs" Inherits="Users_Guest_JobSeekerRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

     <style>
        /* Simple styling for better presentation */
        body { background-color: #f8f8f8; font-family: Arial, sans-serif; }
        .registration-container {
            max-width: 800px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .panel-heading {
            background-color: #337ab7 !important;
            color: #fff !important;
            border-bottom: 0;
        }
        .btn-primary {
            background-color: #337ab7;
            border-color: #2e6da4;
        }
    </style>

    <%--<form id="form1" runat="server" class="form-horizontal">--%>
        <div class="container">
            <div class="registration-container panel panel-primary">
                <div class="panel-heading">
                    <h2 class="panel-title text-center">Job Seeker Registration</h2>
                </div>
                <div class="panel-body">
                    <!-- Message Display Area -->
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>

                    <!-- First Name -->
                    <div class="form-group">
                        <label for="txtFirstName" class="col-sm-3 control-label">First Name</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter your first name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                ErrorMessage="First name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Last Name -->
                    <div class="form-group">
                        <label for="txtLastName" class="col-sm-3 control-label">Last Name</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter your last name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                                ErrorMessage="Last name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="txtEmail" class="col-sm-3 control-label">Email Address</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="e.g., user@example.com" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Please enter a valid email address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="txtPassword" class="col-sm-3 control-label">Password</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                                ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="txtConfirmPassword" class="col-sm-3 control-label">Confirm Password</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                ErrorMessage="Please confirm your password." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
                                ErrorMessage="Passwords do not match." CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
                        </div>
                    </div>
                    
                    <!-- Professional Title -->
                    <div class="form-group">
                        <label for="txtProfessionalTitle" class="col-sm-3 control-label">Professional Title</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtProfessionalTitle" runat="server" CssClass="form-control" placeholder="e.g., Senior Software Engineer"></asp:TextBox>
                        </div>
                    </div>
                    
                    <!-- Resume Upload -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Upload Resume</label>
                        <div class="col-sm-9">
                            <asp:FileUpload ID="fuResume" runat="server" />
                            <p class="help-block">Optional. PDF or DOCX files are preferred.</p>
                        </div>
                    </div>

                    <!-- Registration Button -->
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-lg" OnClick="btnRegister_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <%--</form>--%>

</asp:Content>

