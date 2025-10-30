<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Employer/Employer.master" AutoEventWireup="true" CodeFile="Edit_Profile.aspx.cs" Inherits="Users_Employer_Edit_Profile" %>

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

        #MainContent .form-container .form-group textarea.form-control {
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

        .company-logo-preview {
            width: 150px;
            height: 150px;
            border-radius: 8px;
            object-fit: contain;
            border: 4px solid #e9ecef;
            margin-top: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /*#companyLogoPreview {
            width: 150px;
            height: 150px;
            border-radius: 8px;
            object-fit: contain;
            border: 4px solid #e9ecef;
            margin-top: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }*/

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
            <h1>Update Company Profile</h1>
            <p class="lead">Keep your company's information current to attract the best candidates.</p>
        </div>
    </div>

    <div class="container" style="margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="form-container">
                    <h3 class="form-section-title">Company Information</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtCompanyName.ClientID %>">Company Name</label>
                                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="txtCompanyName" ErrorMessage="Company Name is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCompanyName" runat="server" ControlToValidate="txtCompanyName" ErrorMessage="Company Name can contain characters and numbers." ValidationExpression="^[a-zA-Z0-9\s.,'\-&]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtCompanyWebsite.ClientID %>">Company Website</label>
                                <asp:TextBox ID="txtCompanyWebsite" runat="server" CssClass="form-control" TextMode="Url"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCompanyWebsite" runat="server" ControlToValidate="txtCompanyWebsite" ErrorMessage="Company Website is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCompanyWebsite" runat="server" ControlToValidate="txtCompanyWebsite" ErrorMessage="Please enter a valid website URL (e.g., https://example.com)." ValidationExpression="https?://.+" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Official Email (Cannot be changed)</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <h3 class="form-section-title">Company Details</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= ddlCompanySize.ClientID %>">Company Size</label>
                                <asp:DropDownList ID="ddlCompanySize" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-- Select Size --</asp:ListItem>
                                    <asp:ListItem>1-10 employees</asp:ListItem>
                                    <asp:ListItem>11-50 employees</asp:ListItem>
                                    <asp:ListItem>51-200 employees</asp:ListItem>
                                    <asp:ListItem>201-500 employees</asp:ListItem>
                                    <asp:ListItem>501-1000 employees</asp:ListItem>
                                    <asp:ListItem>1000+ employees</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCompanySize" runat="server" ControlToValidate="ddlCompanySize" InitialValue="" ErrorMessage="Company Size is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtFoundedYear.ClientID %>">Founded Year</label>
                                <asp:TextBox ID="txtFoundedYear" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFoundedYear" runat="server" ControlToValidate="txtFoundedYear" ErrorMessage="Founded Year is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="rangeFoundedYear" runat="server" ControlToValidate="txtFoundedYear" MinimumValue="1900" MaximumValue="2025" Type="Integer" ErrorMessage="Please enter a valid year." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RangeValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="<%= txtAboutCompany.ClientID %>">About Company</label>
                        <asp:TextBox ID="txtAboutCompany" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Style="height: auto;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAboutCompany" runat="server" ControlToValidate="txtAboutCompany" ErrorMessage="About Company is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
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

                    <h3 class="form-section-title">Contact Person</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtContactName.ClientID %>">Contact Full Name</label>
                                <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvContactName" runat="server" ControlToValidate="txtContactName" ErrorMessage="Contact Name is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revContactName" runat="server" ControlToValidate="txtContactName" ErrorMessage="Contact Name must contain only characters." ValidationExpression="^[a-zA-Z\s]+$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="<%= txtContactPhone.ClientID %>">Contact Phone</label>
                                <asp:TextBox ID="txtContactPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvContactPhone" runat="server" ControlToValidate="txtContactPhone" ErrorMessage="Contact Phone is required." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revContactPhone" runat="server" ErrorMessage="Invalid phone number format." ControlToValidate="txtContactPhone" ValidationExpression="^[0-9\-\(\)\s\+]{10,20}$" CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <h3 class="form-section-title">Update Company Logo</h3>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <div class="form-group">
                                <label>Upload a New Logo (Optional)</label>
                                <div class="file-upload-wrapper">
                                    <span class="file-upload-btn"><span class="glyphicon glyphicon-picture"></span>Choose a new logo...</span>
                                    <asp:FileUpload ID="fuCompanyLogo" runat="server" onchange="previewLogo(this);" />
                                </div>
                                <asp:CustomValidator ID="cvCompanyLogo" runat="server" OnServerValidate="cvCompanyLogo_ServerValidate" ErrorMessage="Invalid file." CssClass="validation-error" Display="Dynamic" SetFocusOnError="true" />
                                <div>
                                    <img id="companyLogoPreview" runat="server" class="company-logo-preview" src="#" alt="Logo Preview" />
                                </div>
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
</asp:Content>

