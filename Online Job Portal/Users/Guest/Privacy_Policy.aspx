<%@ Page Title="" Language="C#" MasterPageFile="~/Users/Guest/Guest.master" AutoEventWireup="true" CodeFile="Privacy_Policy.aspx.cs" Inherits="Users_Guest_Privacy_Policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Custom CSS for a professional and readable policy page --%>
    <style>
        .policy-hero {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/about-us-background.jpg') no-repeat center center;
            /*background: linear-gradient(135deg, rgba(45, 2, 84, 0.95), rgba(121, 40, 202, 0.9)), url('../images/it-hero-background.jpg') no-repeat center center;*/
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 0;
            margin: -20px -15px 30px -15px;
        }

        .policy-hero h1 {
            font-size: 3.5em;
            font-weight: 700;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }

        .policy-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(58, 12, 163, 0.1);
            margin-bottom: 50px;
        }

        .policy-container h2 {
            font-size: 1.8em;
            font-weight: 600;
            color: #3a0ca3;
            margin-top: 30px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #7928ca;
        }

        .policy-container h3 {
            font-size: 1.4em;
            font-weight: 600;
            color: #555;
            margin-top: 25px;
            margin-bottom: 15px;
        }

        .policy-container p, .policy-container ul li {
            font-size: 1.1em;
            line-height: 1.8;
            color: #444;
            text-align: justify;
        }
        
        .policy-container ul {
            padding-left: 20px;
        }

        .policy-container a {
            color: #7928ca;
            font-weight: 500;
        }
        
        .last-updated {
            font-style: italic;
            color: #777;
            margin-bottom: 20px;
            text-align: center;
            font-size: 1.1em;
        }
    </style>

    <div class="policy-hero">
        <div class="container">
            <h1>Privacy Policy</h1>
            <p class="lead">Your privacy is important to us. It is Jobify's policy to respect your privacy regarding any information we may collect from you across our website.</p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="policy-container">
                    <p class="last-updated">Last updated: September 01, 2025</p>

                    <h2>1. Information We Collect</h2>
                    <p>We collect information you provide directly to us when you create an account, build your profile, apply for jobs, or otherwise communicate with us. The types of information we may collect include:</p>
                    
                    <h3>For Job Seekers:</h3>
                    <ul>
                        <li>Personal identification information (First Name, Last Name, Email, Phone Number).</li>
                        <li>Location data (Address, City, State, Country).</li>
                        <li>Professional and educational background (Professional Title, Summary, Qualification, Experience, Skills).</li>
                        <li>Documents you provide, such as your resume/CV and profile picture.</li>
                        <li>Account credentials (Hashed Password, Security Question and Answer).</li>
                    </ul>

                    <h3>For Companies/Employers:</h3>
                    <ul>
                        <li>Company identification information (Company Name, Email, Website).</li>
                        <li>Contact person's details (Contact Name, Contact Phone).</li>
                        <li>Company profile details (About Company, Company Size, Founded Year, Company Logo).</li>
                        <li>Account credentials (Hashed Password, Security Question and Answer).</li>
                    </ul>

                    <h2>2. How We Use Your Information</h2>
                    <p>We use the information we collect to:</p>
                    <ul>
                        <li>Provide, maintain, and improve our services, including matching job seekers with potential employers.</li>
                        <li>Create and manage your account and profile.</li>
                        <li>Communicate with you about jobs, services, offers, and events.</li>
                        <li>Ensure the security of our platform, including preventing fraud and unauthorized access.</li>
                        <li>Personalize and improve the user experience.</li>
                    </ul>

                    <h2>3. Data Security</h2>
                    <p>We are committed to protecting your data. We use a variety of security technologies and procedures to help protect your personal information from unauthorized access, use, or disclosure. All passwords are encrypted using industry-standard hashing algorithms (BCrypt), and sensitive data is transmitted over secure channels.</p>

                    <h2>4. Sharing of Information</h2>
                    <p>We do not sell your personal data to third parties. Your information may be shared under the following circumstances:</p>
                    <ul>
                        <li>With your consent, for example, when you apply for a job, your profile information and resume are shared with the employer.</li>
                        <li>For legal reasons, such as to comply with a subpoena or other legal process.</li>
                    </ul>

                    <h2>5. Your Rights and Choices</h2>
                    <p>You have the right to access, update, or delete your personal information at any time through your account dashboard. You can also contact us to request the removal of your data. Please note that we may retain certain information as required by law or for legitimate business purposes.</p>

                    <h2>6. Changes to This Privacy Policy</h2>
                    <p>We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page. You are advised to review this Privacy Policy periodically for any changes.</p>

                    <h2>7. Contact Us</h2>
                    <p>If you have any questions about this Privacy Policy, please contact us at <a href="mailto:privacy@jobify.com">privacy@jobify.com</a>.</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
