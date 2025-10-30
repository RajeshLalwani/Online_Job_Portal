<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Job_Seeker/Job_Seeker.master" AutoEventWireup="true" CodeFile="Edit_Profile.aspx.cs" Inherits="Users_Job_Seeker_Edit_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .edit-profile-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

            .edit-profile-hero h1 {
                font-size: 3.5em;
                font-weight: 700;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            }

        .form-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
        }

        .form-section-title {
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
        }

        /* --- DEFINITIVE FIX FOR ALL FORM CONTROLS --- */
        .form-container .form-group .form-control {
            display: block;
            width: 100% !important;
            max-width: none !important;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 10px 15px;
            height: 42px;
            transition: all 0.3s ease;
        }

        .form-container .form-group textarea.form-control {
            height: auto;
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
        }

        .file-upload-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            cursor: pointer;
        }

            .file-upload-wrapper input[type=file] {
                font-size: 100px;
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
                cursor: pointer;
            }

        .file-upload-btn {
            border: 2px dashed #ced4da;
            color: #7f8c8d;
            background-color: #f9f9f9;
            padding: 20px 30px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        /*#profilePicPreview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #e9ecef;
            margin-top: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }*/

       .profile-pic-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #e9ecef;
            margin-top: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .btn-update-submit {
            background-image: linear-gradient(120deg, #7928ca, #3a0ca3);
            background-size: 200% auto;
            color: #fff !important;
            border: none;
            border-radius: 50px;
            padding: 15px 40px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.4s ease;
            margin-top: 30px;
        }

            .btn-update-submit:hover {
                background-position: right center;
                box-shadow: 0 4px 15px rgba(58, 12, 163, 0.4);
                transform: translateY(-2px);
            }
    </style>

    <div class="edit-profile-hero">
        <div class="container">
            <h1>Edit Your Profile</h1>
            <p class="lead">Keep your professional profile up-to-date to attract the best opportunities.</p>
        </div>
    </div>

    <div class="container" style="margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="form-container">

                    <h3 class="form-section-title">Basic Information</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtFirstName.ClientID %>">First Name</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="First Name must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtLastName.ClientID %>">Last Name</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Last Name must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Email Address (Cannot be changed)</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" ToolTip="Email address cannot be changed."></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtPhoneNumber.ClientID %>">Phone Number</label>
                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" ErrorMessage="Invalid phone number format." ControlToValidate="txtPhoneNumber" ValidationExpression="^[0-9\-\(\)\s\+]{10,20}$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <h3 class="form-section-title">Location Details</h3>
                    <div class="form-group">
                        <label for="<%= txtAddress.ClientID %>">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Style="height: auto;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtCity.ClientID %>">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtState.ClientID %>">State / Province</label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" ErrorMessage="State is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revState" runat="server" ControlToValidate="txtState" ErrorMessage="State must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtPostalCode.ClientID %>">Postal / Zip Code</label>
                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPostalCode" runat="server" ControlToValidate="txtPostalCode" ErrorMessage="Postal Code is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPostalCode" runat="server" ControlToValidate="txtPostalCode" ErrorMessage="Invalid postal code." ValidationExpression="^\d{5,6}(?:[-\s]\d{4})?$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= ddlCountry.ClientID %>">Country</label>
                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCountry" runat="server" ControlToValidate="ddlCountry" InitialValue="" ErrorMessage="Country is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <h3 class="form-section-title">Professional Details</h3>
                    <div class="form-group">
                        <label for="<%= txtProfessionalTitle.ClientID %>">Professional Title</label>
                        <asp:TextBox ID="txtProfessionalTitle" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProfessionalTitle" runat="server" ControlToValidate="txtProfessionalTitle" ErrorMessage="Title is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revProfessionalTitle" runat="server" ControlToValidate="txtProfessionalTitle" ErrorMessage="Title must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label for="<%= txtSummary.ClientID %>">Summary</label>
                        <asp:TextBox ID="txtSummary" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Style="height: auto;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSummary" runat="server" ControlToValidate="txtSummary" ErrorMessage="Summary is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                             <div class="form-group">
                                <label for="<%= ddlQualification.ClientID %>">Highest Qualification</label>
                                <%-- CORRECTED: Changed TextBox to IT-specific DropDownList --%>
                                <asp:DropDownList ID="ddlQualification" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Qualification --</asp:ListItem>
                                    <asp:ListItem>DCA</asp:ListItem>
                                    <asp:ListItem>BCA</asp:ListItem>
                                    <asp:ListItem>BBA ITM</asp:ListItem>
                                    <asp:ListItem>BBA Business Analytics</asp:ListItem>
                                    <asp:ListItem>BSc IT</asp:ListItem>
                                    <asp:ListItem>BSc Computer Science</asp:ListItem>
                                    <asp:ListItem>B.E. in Computer Science</asp:ListItem>
                                    <asp:ListItem>B. Tech</asp:ListItem>
                                    <asp:ListItem>PGDCA</asp:ListItem>
                                    <asp:ListItem>MCA</asp:ListItem>
                                    <asp:ListItem>MSc IT</asp:ListItem>
                                    <asp:ListItem>MSc AIML</asp:ListItem>
                                    <asp:ListItem>MSc Computer Science</asp:ListItem>
                                    <asp:ListItem>M. Tech</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvQualification" runat="server" ControlToValidate="ddlQualification" InitialValue="" ErrorMessage="Qualification is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtTotalExperience.ClientID %>">Total Experience (in years)</label>
                                <asp:TextBox ID="txtTotalExperience" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTotalExperience" runat="server" ControlToValidate="txtTotalExperience" ErrorMessage="Experience is required." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="rangeExperience" runat="server" ControlToValidate="txtTotalExperience" MinimumValue="0" MaximumValue="50" Type="Integer" ErrorMessage="Please enter a valid number of years." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RangeValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="<%= txtSkills.ClientID %>">Skills</label>
                        <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Style="height: auto;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvSkills" runat="server" ControlToValidate="txtSkills" ErrorMessage="Skills are required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>

                    <hr />

                    <h3 class="form-section-title">Upload Documents</h3>
                    <div class="row">
                        <div class="col-md-6 text-center">
                            <div class="form-group">
                                <label>Profile Picture</label>
                                <div class="file-upload-wrapper">
                                    <span class="file-upload-btn"><span class="glyphicon glyphicon-camera"></span>Choose a photo...</span>
                                    <asp:FileUpload ID="fuProfilePicture" runat="server" onchange="previewImage(this); " /> <!-- profilePictureText(this); -->
                                </div>
                                <asp:CustomValidator ID="cvProfilePicture" runat="server" OnServerValidate="cvProfilePicture_ServerValidate" ErrorMessage="Invalid file." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true" />
                                <div>
                                    <img id="profilePicPreview" src="#" alt="Profile Preview" class="profile-pic-preview" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 text-center">
                            <div class="form-group">
                                <label>Resume / CV</label>
                                <div class="file-upload-wrapper">
                                    <span id="resumeBtn" class="file-upload-btn"><span class="glyphicon glyphicon-open-file"></span>Upload new resume...</span>
                                    <asp:FileUpload ID="fuResume" runat="server" onchange="updateResumeText(this);" />
                                </div>
                                <asp:CustomValidator ID="cvResume" runat="server" OnServerValidate="cvResume_ServerValidate" ErrorMessage="Invalid file." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true" />
                                <asp:HyperLink ID="hlResume" runat="server" Target="_blank" Text="View Current Resume" Style="margin-top: 10px; display: inline-block;"></asp:HyperLink>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="text-center">
                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Changes" CssClass="btn btn-update-submit" OnClick="btnUpdateProfile_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

       <%-- JavaScript for image preview and file upload UI --%>
    <script type="text/javascript">
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%= profilePicPreview.ClientID %>').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function updateResumeText(input) {
            if(input.files && input.files[0]) {
                $('#resumeBtn').html('<span class="glyphicon glyphicon-ok-sign"></span> ' + input.files[0].name);
            }

            //function profilePictureText(input) {
            //if(input.files && input.files[0]) {
            //    $('#fuProfilePicture').html('<span class="glyphicon glyphicon-ok-sign"></span> ' + input.files[0].name);
            //}
        }
    </script>
</asp:Content>

