<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Users_Job_Seeker_ChangePassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .change-password-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

            .change-password-hero h1 {
                font-size: 3.5em;
                font-weight: 700;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            }

        .cp-container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
        }

            .cp-container h2 {
                font-size: 1.8em;
                font-weight: 600;
                color: #3a0ca3;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 2px solid #7928ca;
                display: inline-block;
            }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            text-align: left;
        }

        /* --- DEFINITIVE FIX FOR ALL FORM CONTROLS --- */
        .cp-container .form-group .form-control {
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
        /* --- END OF FIX --- */

        .form-control:focus {
            border-color: #7928ca;
            box-shadow: 0 0 0 0.2rem rgba(121, 40, 202, 0.25);
        }

        .validation-error {
            color: #dc3545;
            font-weight: 500;
            font-size: 0.9em;
            margin-top: 5px;
            display: block;
            text-align: left;
        }

        .btn-cp-submit {
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
            margin-top: 20px;
        }

            .btn-cp-submit:hover {
                background-position: right center;
                box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
                transform: translateY(-2px);
            }

        .gradient-text {
            /*background: linear-gradient(45deg, #007bff, #00c6ff); */ /* blue color*/
            background: linear-gradient(45deg, #9d50bb, #ff6ec4); /* purple color*/
            /*  background: linear-gradient(45deg, #ff6a00, #ff1493); */ /*  red color*/
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: bold; /* optional */
            font-size: 14px; /* adjust as needed */
            background-color: transparent; /* remove background */
        }
    </style>

    <div class="change-password-hero">
        <div class="container">
            <h1>Update Your Password</h1>
            <p class="lead">Keep your account secure by regularly updating your password.</p>
        </div>
    </div>

    <div class="container">
        <div class="cp-container">
            <div class="text-center">
                <h2>Change Password</h2>
            </div>

            <div class="form-group">
                <label for="<%= txtCurrentPassword.ClientID %>">Current Password</label>
                <asp:TextBox runat="server" ID="txtCurrentPassword" CssClass="form-control" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCurrentPassword" CssClass="validation-error" ErrorMessage="Current Password is required." Display="Dynamic" SetFocusOnError="True" />
            </div>
            <hr style="margin: 25px 0;" />
            <div class="form-group">
                <label for="<%= txtNewPassword.ClientID %>">New Password</label>
                <asp:TextBox runat="server" ID="txtNewPassword" CssClass="form-control" TextMode="Password" />
                <ajaxToolkit:PasswordStrength ID="txtNewPassword_PasswordStrength" runat="server" BehaviorID="txtNewPassword_PasswordStrength" TargetControlID="txtNewPassword" RequiresUpperAndLowerCaseCharacters="True" TextCssClass="gradient-text" MinimumLowerCaseCharacters="1" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="7" MinimumNumericCharacters="1" HelpHandlePosition="LeftSide" PrefixText="Password Strength: " DisplayPosition="AboveLeft"></ajaxToolkit:PasswordStrength>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword" CssClass="validation-error" ErrorMessage="New Password is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Password must be 8-28 characters long and include uppercase, lowercase, number, and special character." ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,28}$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <%--<ajaxToolkit:PasswordStrength ID="txtNewPassword_PasswordStrength" runat="server" BehaviorID="txtNewPassword_PasswordStrength" TargetControlID="txtNewPassword" RequiresUpperAndLowerCaseCharacters="True"  TextCssClass="gradient-text" MinimumLowerCaseCharacters="1" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="7" MinimumNumericCharacters="1" HelpHandlePosition="LeftSide" PrefixText="Password Strength: " DisplayPosition="AboveLeft"  />--%>
            </div>
            <div class="form-group">
                <label for="<%= txtConfirmPassword.ClientID %>">Confirm New Password</label>
                <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword" CssClass="validation-error" ErrorMessage="Confirm Password is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:CompareValidator runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" CssClass="validation-error" Operator="Equal" ErrorMessage="Passwords do not match." Display="Dynamic" SetFocusOnError="True" />
            </div>
            <div class="form-group" style="margin-top: 25px;">
                <asp:Button runat="server" ID="btnChangePassword" OnClick="btnChangePassword_Click" Text="Update Password" CssClass="btn btn-cp-submit" />
            </div>
        </div>
    </div>
</asp:Content>
