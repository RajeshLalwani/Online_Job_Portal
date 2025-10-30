<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="Reset.aspx.cs" Inherits="Account_Reset" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
  
    
    <style>







/* Style dropdowns and file upload same as textboxes */
.form-group select,
.form-group input[type="file"] {
    width: 100%;
    max-width: 420px;
    padding: 14px 16px;
    border: 2px solid #ddd;
    border-radius: 10px;
    font-size: 17px;
    background: #f9f9f9;
    outline: none;
    transition: all 0.3s ease;
    display: block;
    margin: 0 auto;
    cursor: pointer;
}

/* Focus effect like textboxes */
.form-group select:focus,
.form-group input[type="file"]:focus {
    border-color: #007bff;
    box-shadow: 0 0 6px rgba(0,123,255,0.35);
    background: #fff;
}







     /* Keep input, textarea, and button widths aligned */
.form-group input,
.form-group textarea,
.btn-primary {
    width: 100%;
    max-width: 420px;  /* same max width */
    display: block;
    margin: 0 auto;
}

        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .page-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #89f7fe, #66a6ff);
            padding: 20px;
        }

        .content-box {
            background: #fff;
            margin-top:80px;
            padding: 25px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.18);
            width: 500px;
            max-width: 95%;
            text-align: center;
            animation: zoomIn 0.7s ease;
        }

        h2 {
            font-weight: 700;
            color: #222;
            margin-bottom: 6px;
        }

        h4 {
            font-weight: 500;
            color: #444;
            margin-bottom: 14px;
            font-size: 18px;
        }

        hr {
            border-top: 2px solid #eee;
            margin: 10px 0 20px 0;
        }

        /* Floating label group - centered */
        .form-group {
            position: relative;
            margin: 12px auto;
            width: 100%;
            max-width: 420px;
        }

        

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 16px 16px 16px 18px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 17px;
            background: #f9f9f9;
            outline: none;
            transition: all 0.3s ease;
        }

        
        .form-group textarea {
            min-height: 100px;
            resize: none;
        }

        /* floating label */
        .form-group label {
            position: absolute;
            top: 16px;
            left: 18px;
            color: #777;
            font-size: 16px;
            font-weight: 500;
            pointer-events: none;
            background: transparent;
            transition: 0.25s ease;
        }

        /* on focus or value */
        .form-group input:focus ~ label,
        .form-group input:not(:placeholder-shown) ~ label,
        .form-group textarea:focus ~ label,
        .form-group textarea:not(:placeholder-shown) ~ label {
            top: -9px;
            left: 14px;
            font-size: 14px;
            font-weight: 600;
            color: #007bff;
            background: #fff;
            padding: 0 6px;
            border-radius: 4px;
        }

    
        /* focus border */
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #007bff;
            box-shadow: 0 0 6px rgba(0,123,255,0.35);
            background: #fff;
        }

        /* validators */
        .text-danger {
            display: block;
            margin-top: 4px;
            font-size: 15px;
            font-weight: 600;
            color: #e74c3c;
            text-align: left;
        }

        /* submit button */
        .btn-primary {
            width: 100%;
            max-width: 420px;
            padding: 14px;
            border-radius: 28px;
            font-size: 18px;
            font-weight: 600;
            background: linear-gradient(45deg, #007bff, #00c6ff);
            border: none;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 12px auto 0 auto;
            display: block;
        }

        .btn-primary:hover {
            transform: scale(1.04);
            box-shadow: 0 6px 15px rgba(0,123,255,0.4);
        }

        .btn-primary:active {
            transform: scale(0.96);
        }

        /* animations */
        @keyframes zoomIn {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        /* password strength checker css*/
        .gradient-text {
   /* background: linear-gradient(45deg, #007bff, #00c6ff); 
   background: linear-gradient(45deg, #ffffff, #e0e0e0); 
   background: linear-gradient(45deg, #9d50bb, #ff6ec4);*/
   background: linear-gradient(45deg, #ff6a00, #ff1493);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-weight: bold;  /* optional */
    font-size: 14px;    /* adjust as needed */
    background-color: transparent; /* remove background */
}
    
        

            /* password strength checker css*/
        .gradient-text {
   /* background: linear-gradient(45deg, #007bff, #00c6ff); 
   background: linear-gradient(45deg, #ffffff, #e0e0e0); 
   background: linear-gradient(45deg, #9d50bb, #ff6ec4);*/
   background: linear-gradient(45deg, #ff6a00, #ff1493);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-weight: bold;  /* optional */
    font-size: 14px;    /* adjust as needed */
    background-color: transparent; /* remove background */

    </style>

    <div class="page-container">
        <div class="content-box">
            <h2><%: Title %></h2>
            <h4>Reset Your Password Here</h4>
            <hr />

             <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-center">
                            <br />

                            <asp:Label runat="server" ID="FailureText" />
                            <br /><br />    

                        </p>
                    </asp:PlaceHolder>

             

             <!-- User Type -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="Utype" CssClass="form-control" placeholder=" " ReadOnly="True" />
                <label for="Utype">User Type</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Utype"
                    CssClass="text-danger" ErrorMessage="The User Type field is required." Display="Dynamic" SetFocusOnError="True" />
                
                <br />
            </div>

            <!-- User Name -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" placeholder=" " ReadOnly="True" />
                <label for="UserName">User Name</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="The User Name field is required." Display="Dynamic" SetFocusOnError="True" />
                
                <br />
            </div>

             <!-- New Password -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="NewPassword" CssClass="form-control" placeholder=" " TextMode="Password" />
                <ajaxToolkit:PasswordStrength ID="NewPassword_PasswordStrength" runat="server" BehaviorID="NewPassword_PasswordStrength"  RequiresUpperAndLowerCaseCharacters="True" TargetControlID="NewPassword" TextCssClass="gradient-text" MinimumLowerCaseCharacters="1" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="7" MinimumNumericCharacters="1" HelpHandlePosition="LeftSide" PrefixText="Password Strength: " DisplayPosition="BelowLeft" />
               <%-- <ajaxToolkit:PasswordStrength ID="NewPassword_PasswordStrength" runat="server" BehaviorID="NewPassword_PasswordStrength" RequiresUpperAndLowerCaseCharacters="True" TargetControlID="Password" TextCssClass="gradient-text" MinimumLowerCaseCharacters="1" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="7" MinimumNumericCharacters="1" HelpHandlePosition="LeftSide" PrefixText="Password Strength: " DisplayPosition="BelowLeft">
                </ajaxToolkit:PasswordStrength>--%>
                <label for="NewPassword">New Password</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                    CssClass="text-danger" ErrorMessage="The New Password field is required." Display="Dynamic" SetFocusOnError="True" />
                <br />
            </div>

            <!-- ConfirmPassword -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="ConfirmPassword" CssClass="form-control" placeholder=" " TextMode="Password" />
                <label for="ConfirmPassword">Confirm Password</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" ErrorMessage="The Confirm Password field is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="The Confirm Password must be same as Password field." 
                    ControlToValidate="ConfirmPassword" ControlToCompare="NewPassword"
                    CssClass="text-danger" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                <br />
            </div>


                    



            <!-- Reset -->
            <asp:Button runat="server" ID="Reset" OnClick="Reset_Click" Text="Reset" CssClass="btn btn-primary mt-3" />

            <br />
             <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" NavigateUrl="~/Account/Login.aspx" ViewStateMode="Disabled">< Go Back to Log in Page</asp:HyperLink>
                 
                </p>

             <br />
            
        </div>
    </div>
</asp:Content>
















