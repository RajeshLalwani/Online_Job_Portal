# Online Job Portal

Jobify is a comprehensive, N-Tier web application built with ASP.NET Web Forms (C#) and SQL Server. It is a full-featured job portal designed specifically for the IT industry, connecting qualified tech professionals with top employers.

This application features a robust three-tier user system (Admin, Employer, and Job Seeker), each with a dedicated dashboard and functionalities. The entire platform is built with a focus on security, scalability, and a professional user experience.

Key Features

The platform is divided into three main modules:

1. Admin Module (The Control Panel)

A powerful backend dashboard for complete site management:

Dynamic Dashboard: Displays 10 live statistic cards, including Total Users, Total Jobs, Pending Approvals, Total Applications, and Hired candidates.

User Management: Admin can view, activate, and suspend both Job Seeker and Employer accounts.

Job Management: Admin has full control to approve or reject new job postings submitted by employers.

Profile Viewing: Ability to view detailed profiles of any Job Seeker or Employer on the platform.

Query Management: View and delete all user-submitted feedback and contact form queries, with 10-item pagination.

Advanced Reporting:

Generate comprehensive, date-filterable reports on all hiring activity (Total Jobs, Apps, Hired, Rejected) on a per-company basis.

Generate reports for all Job Seekers and Employers, including status-wise totals (Active/Suspended).

Export all reports to a professional CSV file, including a "Grand Total" summary row.

2. Employer Module (The Recruiter)

A complete portal for companies to find and manage talent:

Secure Registration & Login: Professional registration form with strong validation and BCrypt password hashing.

Profile Management: Employers can create and edit their detailed company profile, including logos, company size, and location.

Job Posting: Create new job postings with fields for Experience, Salary, Skills, and multi-select IT-specific Qualifications (e.g., MCA, B. Tech, BSc IT).

Job Management:

Dashboard to view all posted jobs and their current status (Active, Pending Approval, Closed).

Live applicant count for each job.

Ability to Activate or Close job applications instantly.

Editing a job automatically sends it for Admin re-approval to maintain quality.

Applicant Tracking System (ATS):

View a paged list of all applicants for a specific job.

Update an applicant's status (Shortlisted, Interview Scheduled, Hired, Rejected).

View applicant profiles and download their resumes.

Security: Dedicated "Change Password" page (separate from "Edit Profile").

3. Job Seeker & Guest Module (The Candidate)

A professional and intuitive interface for job hunting:

Secure Registration & Login: Detailed registration with profile picture/resume uploads and BCrypt password hashing.

Profile Management: Job Seekers can edit their entire professional profile, including summary, skills, experience, and IT-specific qualifications.

Dynamic Dashboard: View live stats for "Jobs Applied," "Interviews Scheduled," and "Applications Rejected."

Advanced Job Search:

Search for jobs by title, location, or skills.

Filter results by Job Type, Country, and Profile.

Professional 10-item pagination to handle large numbers of jobs.

A sticky filter sidebar that stays visible while scrolling through job listings.

Application Tracking:

View a paged list of all applied-to jobs.

Track the live status of each application (Pending, Shortlisted, Interview Scheduled, Hired, Rejected).

View rejection reasons or interview dates provided by the employer.

Security: Dedicated "Change Password" page.

Guest Access: Public-facing pages (Home, Find Jobs, Job Details) allow non-registered users to browse jobs. The "Apply Now" button professionally prompts them to log in or register using a SweetAlert2 modal.

🚀 Technology Stack

Framework: ASP.NET 4.x (Web Forms)

Language: C#

Database: Microsoft SQL Server

Frontend: HTML5, CSS3, Bootstrap 3.3.7, jQuery

Security: BCrypt.Net (for industry-standard password hashing)

UX: SweetAlert2 (for professional pop-ups and alerts)

💻 Core Technical Concepts Implemented

N-Tier Architecture: The project follows a logical separation of concerns (Presentation/UI, Business Logic, and Data Access).

Database Design: A relational database schema with Foreign Key constraints (ON DELETE CASCADE) to ensure data integrity.

Security:

Password Hashing: All user passwords are hashed using BCrypt.Net and never stored in plain text.

SQL Injection Prevention: All database queries are fully parameterized to prevent SQL injection attacks.

Role-Based Access Control (RBAC): Session variables are used on every page and in the master pages to ensure users can only access pages appropriate for their role (Admin, Employer, Job Seeker).

Professional UI/UX:

Custom Pagination: Implemented PagedDataSource in C# to create professional, high-performance pagination for all Repeater controls (FindJobs, AppliedJobs, PostedJobs).

GridView Pagination: Utilized the built-in AllowPaging="true" feature for all Admin-side GridView controls.

Sticky Elements: Implemented position: sticky with CSS overrides to fix filter sidebars and profile cards on scroll.

Dynamic Content: All dashboards and reports are loaded dynamically from the SQL database.

Data Export:

Advanced C# functions to generate and download dynamic CSV reports from GridView data.

Successfully implemented logic to calculate and append "Grand Total" summary rows to the exported CSV files.


