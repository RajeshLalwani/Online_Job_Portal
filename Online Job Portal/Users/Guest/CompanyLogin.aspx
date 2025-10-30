<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="CompanyLogin.aspx.cs" Inherits="Users_Guest_CompanyLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <style>
        /* Internal CSS for the unified login page */
        body {
            background-color: #f8f8f8;
            font-family: Arial, sans-serif;
        }
        .login-container {
            max-width: 450px;
            margin: 100px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .panel-heading {
            background-color: #5bc0de !important; /* A neutral info blue */
            color: #fff !important;
            border-bottom: 0;
            border-radius: 8px 8px 0 0;
        }
        .panel-body {
            padding-top: 30px;
        }
        .btn-info {
            background-color: #5bc0de;
            border-color: #46b8da;
            width: 100%; /* Full-width button */
        }
    </style>

        <div class="container">
            <div class="login-container panel panel-info">
                <div class="panel-heading">
                    <h2 class="panel-title text-center">User Login</h2>
                </div>
                <div class="panel-body">
                    <!-- Message Display Area -->
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>

                    <!-- User Role Selector (Dropdown) -->
                    <div class="form-group">
                        <label for="ddlUserType">I am a:</label>
                        <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Job Seeker" Value="JobSeeker"></asp:ListItem>
                            <asp:ListItem Text="Company" Value="Company"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter your password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Login Button -->
                    <div class="form-group">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-info btn-lg" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>

