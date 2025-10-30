<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="CompanyRegister.aspx.cs" Inherits="Users_Guest_CompanyRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <style>
        /* Reusing styles for consistency */
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
            background-color: #5cb85c !important;
            color: #fff !important;
            border-bottom: 0;
        }
        .btn-success {
            background-color: #5cb85c;
            border-color: #4cae4c;
        }
    </style>

        <div class="container">
            <div class="registration-container panel panel-success">
                <div class="panel-heading">
                    <h2 class="panel-title text-center">Company Registration</h2>
                </div>
                <div class="panel-body">
                    <!-- Message Display Area -->
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>

                    <!-- Company Name -->
                    <div class="form-group">
                        <label for="txtCompanyName" class="col-sm-3 control-label">Company Name</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Enter the company's legal name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName"
                                ErrorMessage="Company name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Company Email -->
                    <div class="form-group">
                        <label for="txtEmail" class="col-sm-3 control-label">Company Email</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="e.g., contact@company.com" TextMode="Email"></asp:TextBox>
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

                    <!-- Company Website -->
                    <div class="form-group">
                        <label for="txtCompanyWebsite" class="col-sm-3 control-label">Website</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtCompanyWebsite" runat="server" CssClass="form-control" placeholder="https://www.company.com" TextMode="Url"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Industry -->
                    <div class="form-group">
                        <label for="txtIndustry" class="col-sm-3 control-label">Industry</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtIndustry" runat="server" CssClass="form-control" placeholder="e.g., Information Technology"></asp:TextBox>
                        </div>
                    </div>
                    
                    <!-- Company Logo Upload -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Upload Logo</label>
                        <div class="col-sm-9">
                            <asp:FileUpload ID="fuCompanyLogo" runat="server" />
                            <p class="help-block">Optional. PNG or JPG files are preferred.</p>
                        </div>
                    </div>

                    <!-- Registration Button -->
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <asp:Button ID="btnRegister" runat="server" Text="Register Company" CssClass="btn btn-success btn-lg" OnClick="btnRegister_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

