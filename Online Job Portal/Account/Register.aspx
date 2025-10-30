<%@ Page Title="Register Here" Language="C#" MasterPageFile="~/Users/Guest/Guest.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

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
            width: 700px;
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
       
    </style>

    <div class="page-container">
        <div class="content-box">
            <h2><%: Title %></h2>
            <h4>Log in Information</h4>
            <hr />

             <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-center">
                            <br />

                            <asp:Label runat="server" ID="FailureText" />
                            <br /><br />    

                        </p>
                    </asp:PlaceHolder>

              <!--  User Type Question Drop Down -->
             <div class="form-group">
                <asp:DropDownList ID="Utype" runat="server"   CssClass="form-control " placeholder=" ">

                    <asp:ListItem Value="0">Select User Registration Type</asp:ListItem>
                     <asp:ListItem>Job Seeker</asp:ListItem>
                        <asp:ListItem>Employer</asp:ListItem>                       
                </asp:DropDownList>                     
              <%--  <label for="SecQue">SecQue</label>--%>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Utype"
                    CssClass="text-danger" ErrorMessage="The User Type field is required." Display="Dynamic" InitialValue="0" />                
                <br />
            </div>

            <!-- User Name -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" placeholder=" " />
                <label for="UserName">User Name</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="The User Name field is required." Display="Dynamic" SetFocusOnError="True" />
                
                <br />
            </div>

             <!-- Password -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="Password" CssClass="form-control" placeholder=" " TextMode="Password" />
                <ajaxToolkit:PasswordStrength ID="Password_PasswordStrength" runat="server" BehaviorID="Password_PasswordStrength" RequiresUpperAndLowerCaseCharacters="True" TargetControlID="Password" TextCssClass="gradient-text" MinimumLowerCaseCharacters="1" MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1" PreferredPasswordLength="7" MinimumNumericCharacters="1" HelpHandlePosition="LeftSide" PrefixText="Password Strength: " DisplayPosition="BelowLeft">
                </ajaxToolkit:PasswordStrength>
                <label for="Password">Password</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The Password field is required." Display="Dynamic" SetFocusOnError="True" />
                <br />
            </div>

            <!-- ConfirmPassword -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="ConfirmPassword" CssClass="form-control" placeholder=" " TextMode="Password" />
                <label for="ConfirmPassword">Confirm Password</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" ErrorMessage="The Confirm Password field is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="The Confirm Password must be same as Password field." 
                    ControlToValidate="ConfirmPassword" ControlToCompare="Password"
                    CssClass="text-danger" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                <br />
            </div>


              <h4>Personal Information</h4>
            <hr />

             <!-- Full Name -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="FullName" CssClass="form-control" placeholder=" " />
                <label for="FullName">Full Name</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="FullName"
                    CssClass="text-danger" ErrorMessage="The Full Name field is required." Display="Dynamic" SetFocusOnError="True" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Full Name must only Contain Characters."
                    ControlToValidate="FullName" Display="Dynamic" SetFocusOnError="True" ValidationExpression="^[a-zA-Z\s]+$"
                    CssClass="text-danger"></asp:RegularExpressionValidator>
                <br />
            </div>

              <!-- Address -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="Address" CssClass="form-control" placeholder=" " TextMode="MultiLine" Rows="3" />
                <label for="Address">Address</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Address"
                    CssClass="text-danger" ErrorMessage="The Address field is required." Display="Dynamic" />
                <br />
            </div>


            <!-- Mobile No -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="MobileNo" CssClass="form-control" placeholder=" " TextMode="Phone" />
                <label for="MobileNo">Mobile No.</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="MobileNo"
                    CssClass="text-danger" ErrorMessage="The Mobile No. field is required." Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="MobileNo" CssClass="text-danger"
                    ErrorMessage="Please Enter Valid Mobile No." ValidationExpression="^\d{10}$" Display="Dynamic" />
                <br />
            </div>

            <!-- Email -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" placeholder=" " TextMode="Email" />
                <label for="Email">Email</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The Email field is required." Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="Email" CssClass="text-danger" 
                    ErrorMessage="Please Enter Valid Email." 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" />
                <br />
            </div>

             <!-- Country -->
            <div class="form-group">
                <asp:DropDownList ID="Country" runat="server"  AppendDataBoundItems="true" CssClass="form-control " 
                    placeholder=" " DataSourceID="SqlDataSource1" DataTextField="CName" DataValueField="CName">
                    <asp:ListItem Value="0">Select Country</asp:ListItem>
                </asp:DropDownList>      
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Conn %>" SelectCommand="SELECT [CName] FROM [Country]"></asp:SqlDataSource>
              <%--  <label for="Country">Country</label>--%>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Country"
                    CssClass="text-danger" ErrorMessage="The Country field is required." Display="Dynamic" InitialValue="0" />                
                <br />
            </div>


             <h4>Password Recovery Information</h4>
            <hr />

             <!--  Security Question Drop Down -->
             <div class="form-group">
                <asp:DropDownList ID="SecQueD" runat="server"   CssClass="form-control " placeholder=" " AutoPostBack="True">

                    <asp:ListItem Value="0">Select Security Question</asp:ListItem>
                     <asp:ListItem>What is your date of birth?</asp:ListItem>
                        <asp:ListItem>What was your favorite school teacher’s name?</asp:ListItem>
                        <asp:ListItem>What’s your favorite movie?</asp:ListItem>
                        <asp:ListItem>What was your first car?</asp:ListItem>
                        <asp:ListItem>What is your astrological sign?</asp:ListItem>
                        <asp:ListItem>What city were you born in?</asp:ListItem>
                        <asp:ListItem>What is your oldest sibling’s middle name?</asp:ListItem>
                        <asp:ListItem>What was the first concert you attended?</asp:ListItem>
                        <asp:ListItem>What was the make and model of your first car?</asp:ListItem>
                        <asp:ListItem>In what city or town did your parents meet?</asp:ListItem>
                        <asp:ListItem>Custom</asp:ListItem>
                </asp:DropDownList>                     
              <%--  <label for="SecQue">SecQue</label>--%>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="SecQueD"
                    CssClass="text-danger" ErrorMessage="The Security Question field is required." Display="Dynamic" InitialValue="0" />                
                <br />
            </div>

            <asp:Panel ID="SecQueTP" runat="server">
              <!-- Security Question TextBox -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="SecQueT" CssClass="form-control" placeholder=" " />
                <label for="SecQueT">Security Question</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="SQAnswer"
                    CssClass="text-danger" ErrorMessage="The Security Question field is required." Display="Dynamic" />
                <br />
            </div>
            </asp:Panel>

              <!-- SQAnswer -->
            <div class="form-group">
                <asp:TextBox runat="server" ID="SQAnswer" CssClass="form-control" placeholder=" " />
                <label for="SQAnswer">Answer</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="SQAnswer"
                    CssClass="text-danger" ErrorMessage="The Answer field is required." Display="Dynamic" />
                <br />
            </div>



          <h4>Personal Profile Information</h4>
            <hr />

             <!-- Profile Photo -->
            <div class="form-group">
                <asp:FileUpload ID="ProfPhoto" runat="server" CssClass="form-control" />
               
                <label for="ProfPhoto">Upload Profile Picture</label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ProfPhoto"
                    CssClass="text-danger" ErrorMessage="The  Profile Picture field is required." Display="Dynamic" SetFocusOnError="True" />
                <br />
            </div>


            <!-- Submit -->
            <asp:Button runat="server" ID="Register" OnClick="Register_Click" Text="Register" CssClass="btn btn-primary mt-3" />

            <br />
             <p>
                    <asp:HyperLink runat="server" ID="LoginHyperLink" NavigateUrl="~/Account/Login.aspx" ViewStateMode="Disabled">Already Registered? Click Here</asp:HyperLink>
                 
                </p>
        </div>
    </div>
</asp:Content>


<%--    <style>
        .box {
    /* box  cont*/
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    /*box-shadow:2px 6px 10px 7px black;
    /* box-shadow:-5px -5px 30px 5px gray,2px 6px 10px 7px black; */
    background-color: White;
    border-radius: 12px;
    box-shadow: 1px 0px 30px 4px black;
    padding-top: 50px;
    padding-left: 80px;
    margin-bottom: 50px;
    width: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
    </style>
    <center>
     <asp:Panel ID="Panel1" runat="server">
    <div class="box">
        
        
    <h2><%: Title %></h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Create a new account.</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">User Name</asp:Label>
            <div class="col-md-12">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="The user name field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-12">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm Password</asp:Label>
            <div class="col-md-12">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
            </div>
           
         
        </div>
    </div>
            
        </div>
       </asp:Panel>
        </center>
</asp:Content>--%>
