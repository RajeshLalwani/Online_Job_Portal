<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Users/Guest/Guest.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" Async="true" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <style>
        .login-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

        .login-hero h1 {
            font-size: 3.5em;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }

        .login-container {
            max-width: 450px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            transition: all 0.3s ease-in-out;
        }
        
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(58, 12, 163, 0.15);
        }

        .login-container h2 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
            display: inline-block;
        }
        
        .form-group {
             margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            text-align: left;
        }
        
         .login-container .form-group .form-control {
            display: block;
            width: 100% !important; 
            max-width: none !important;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
            height: 47px;
            transition: all 0.3s ease;
        }
        
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
            text-align: left;
        }

        .btn-login-submit {
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            
            font-weight: 600;
            transition: all 0.4s ease;
             width: 100% !important; 
            max-width: none !important;
        }
        
        .btn-login-submit:hover {
            background-position: right center;
            box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
            transform: translateY(-2px);
        }
        
        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            font-size: 0.9em;
        }
        
        .login-options .checkbox-container {
            display: flex;
            align-items: center;
        }

        .login-options .checkbox-container label {
            font-weight: 500;
            color: #555;
            margin: 0 0 0 5px;
        }
        
        .login-options a, .login-options span {
            color: #7928ca;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .login-options a:hover, .login-options span:hover {
            color: #3a0ca3;
            text-decoration: underline; 
        }
        
        .link-group {
            text-align: center;
            margin-top: 20px;
        }
        .link-group a, .link-group span {
             color: #7928ca;
             font-weight: 600;
             display: block;
             margin-bottom: 10px;
             font-size: 0.9em;
        }
        .link-group a:hover, .link-group span:hover {
            color: #3a0ca3;
            text-decoration: underline; 
        }
    </style>

    <div class="login-hero">
        <div class="container">
            <h1>Welcome Back</h1>
            <p class="lead">Log in to access your Jobify dashboard and opportunities.</p>
        </div>
    </div>
    
    <div class="container">
        <div class="login-container">
            <div class="text-center">
                 <h2>Secure Login</h2>
            </div>
            
            <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                <p class="text-danger text-center" style="font-weight: 600;">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
            </asp:PlaceHolder>

            <div class="form-group">
                <label for="<%= Email.ClientID %>">Email</label>
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" placeholder="Enter your email address" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="The Email field is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validation-error" Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Email" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validation-error" Display="Dynamic" SetFocusOnError="True" ValidationGroup="fp"></asp:RegularExpressionValidator>--%>
                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="Email is required to reset password." Display="Dynamic" SetFocusOnError="True" ValidationGroup="fp" />--%>
            </div>

            <div class="form-group">
                <label for="<%= Password.ClientID %>">Password</label>
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" placeholder="Enter your password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="validation-error" ErrorMessage="The Password field is required." Display="Dynamic" SetFocusOnError="True" />
            </div>

            <div class="form-group">
                 <label for="<%= Utype.ClientID %>">User Type</label>
                 <asp:DropDownList ID="Utype" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">-- Select User Type --</asp:ListItem>
                    <asp:ListItem>Job Seeker</asp:ListItem>
                    <asp:ListItem>Employer</asp:ListItem>
                    <asp:ListItem>Admin</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Utype" CssClass="validation-error" ErrorMessage="The User Type field is required." Display="Dynamic" InitialValue="0" SetFocusOnError="True" />
                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="Utype" CssClass="validation-error" ErrorMessage="User Type is required to reset password." Display="Dynamic" InitialValue="0" SetFocusOnError="True" ValidationGroup="fp" />--%>
            </div>
            
            <div class="login-options">
                <div class="checkbox-container">
                    <asp:CheckBox runat="server" ID="RememberMe" />
                    <asp:Label runat="server" AssociatedControlID="RememberMe" Text="Remember me?" />
                </div>
                <div>
                    <asp:LinkButton ID="ForgotPasswordLinkButton" runat="server" OnClick="ForgotPasswordLinkButton_Click" ValidationGroup="fp">Forgot Password?</asp:LinkButton>
                </div>
            </div>

            <div class="form-group" style="margin-top: 25px;">
                 <asp:Button runat="server" ID="Login" OnClick="Login_Click" Text="Log in" CssClass="btn btn-login-submit" />
            </div>
            
            <div class="link-group">
                 <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Don't have an account? Register Here</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>

