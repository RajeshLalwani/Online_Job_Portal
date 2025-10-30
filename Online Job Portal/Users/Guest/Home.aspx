<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Users/Guest/Guest.Master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Custom CSS themed with the purple gradient and enhanced effects --%>
    <style>
        /* --- General Enhancements --- */
        .section-padding {
            padding: 80px 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 60px;
            font-size: 2.8em;
            font-weight: 700;
            color: #3a0ca3; /* Deep Purple */
            position: relative;
        }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 4px;
                background: linear-gradient(120deg, #7928ca, #3a0ca3); /* Purple Gradient */
                border-radius: 2px;
            }

        /* --- Hero Section --- */
        .hero-section {
            background: linear-gradient(45deg, rgba(45, 2, 84, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/it-hero-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 140px 0;
            margin: -20px -15px 30px -15px;
        }

            .hero-section h1 {
                font-size: 4.5em;
                font-weight: 700;
                text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
                animation: fadeInDown 1s ease-in-out;
            }

            .hero-section p {
                font-size: 1.5em;
                margin-bottom: 40px;
                opacity: 0;
                animation: fadeInUp 1s 0.5s ease-in-out forwards;
            }

            .hero-section .hero-cta {
                opacity: 0;
                animation: fadeInUp 1s 1s ease-in-out forwards;
            }

        /* --- MODIFIED: Hero CTA Button (Modern Ghost Style) --- */
        .btn-hero-cta {
            background: transparent;
            color: #fff;
            font-weight: 600;
            border: 2px solid #fff;
            padding: 15px 40px;
            font-size: 1.2em;
            border-radius: 50px;
            transition: all 0.4s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

            .btn-hero-cta:hover {
                background: #fff;
                color: #5b21a8;
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(255, 255, 255, 0.3);
            }

        /* --- Animated Stats Section (Purple Theme) --- */
        .stats-section {
            background-color: #ffffff;
            padding: 40px 0;
            text-align: center;
            border-bottom: 1px solid #ecf0f1;
        }

        .stat-item {
            padding: 20px;
            transition: transform 0.3s ease;
        }

            .stat-item:hover {
                transform: translateY(-8px);
            }

            .stat-item .glyphicon {
                font-size: 2.5em;
                color: #7928ca;
                margin-bottom: 10px;
                display: block;
                transition: color 0.3s ease;
            }

            .stat-item:hover .glyphicon {
                color: #3a0ca3;
            }

            .stat-item h3 {
                font-size: 3em;
                font-weight: 700;
                margin: 0;
                color: #34495e;
            }

            .stat-item p {
                font-size: 1.1em;
                color: #7f8c8d;
                font-weight: 500;
                margin-top: 5px;
            }

        /* --- How It Works Section (Purple Theme) --- */
        .how-it-works-section {
            background-color: #f9f9f9;
        }

        .step-card {
            text-align: center;
            padding: 30px 20px;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            position: relative;
            background-color: #fff;
            overflow: hidden;
        }

            .step-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 24px rgba(58, 12, 163, 0.1);
            }

            .step-card .step-number {
                position: absolute;
                top: -10px;
                left: -10px;
                font-size: 3em;
                font-weight: 700;
                color: rgba(121, 40, 202, 0.05);
                z-index: 0;
            }

            .step-card .icon {
                font-size: 3.5em;
                color: #7928ca;
                margin-bottom: 20px;
                transition: transform 0.4s ease;
                position: relative;
                z-index: 1;
            }

            .step-card:hover .icon {
                transform: scale(1.1) rotate(10deg);
            }

            .step-card h4 {
                font-weight: 600;
                color: #3a0ca3;
                margin-bottom: 15px;
            }

            .step-card p {
                color: #7f8c8d;
            }

        /* --- Why Choose Us Section --- */
        .why-choose-us-section {
            background-color: #ffffff;
        }

        .feature-card {
            text-align: center;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 24px rgba(58, 12, 163, 0.1);
            }

            .feature-card .icon {
                font-size: 3em;
                color: #7928ca;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }

            .feature-card:hover .icon {
                transform: rotate(360deg) scale(1.1);
            }

            .feature-card h4 {
                font-weight: 600;
                margin-bottom: 15px;
                color: #3a0ca3;
            }

        /* --- Top Companies Section --- */
               /* --- Top Companies Section --- */
        .companies-section { background-color: #f9f9f9; }
        
        /* CORRECTED: Ensures all logo containers are the same height and centered */
        .company-logo { 
            padding: 20px; 
            text-align: center; 
            height: 100px; /* Set a uniform height for the container */
            display: flex; /* Use flexbox for centering */
            align-items: center; /* Vertical centering */
            justify-content: center; /* Horizontal centering */
        }
        
        /* CORRECTED: Fixes image sizing to be uniform */
        .company-logo img { 
            max-width: 100%; /* Prevent image from overflowing its container */
            height: 60px; /* Set a fixed height for all logos */
            object-fit: contain; /* Scale image to fit within 60px height, maintaining aspect ratio */
            filter: grayscale(0%); 
            opacity: 0.6; 
            transition: all 0.4s ease; 
        }
        .company-logo:hover img { 
            filter: grayscale(0%); 
            opacity: 1; 
            transform: scale(1.1); 
        }
        

        /* --- Call to Action Section (Purple Theme) --- */
        .cta-section {
            background: linear-gradient(120deg, #3a0ca3, #240046);
            padding: 80px 0;
            text-align: center;
            margin: 30px -15px -20px -15px;
            color: #fff;
        }

        .cta-panel h3 {
            font-weight: 700;
            font-size: 2.2em;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
        }

        .cta-panel p {
            margin-bottom: 30px;
            font-size: 1.1em;
            opacity: 0.9;
        }

        /* --- CTA Buttons (Themed like About page) --- */
        .cta-panel .btn {
            background: transparent;
            border: 2px solid #fff;
            color: #fff;
            font-weight: 600;
            padding: 12px 25px;
            transition: all 0.3s ease;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

            .cta-panel .btn:hover {
                background: #fff;
                color: #3a0ca3;
                transform: translateY(-3px) scale(1.05);
                box-shadow: 0 6px 20px rgba(0,0,0,0.2);
            }

        .cta-panel .btn-lg {
            min-width: 300px;
            white-space: nowrap;
        }

        @media (max-width: 991px) {
            .cta-panel-right {
                margin-top: 50px;
            }
        }

        /* --- Animation Keyframes --- */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <%-- HERO SECTION --%>
    <div class="hero-section">
        <div class="container">
            <h1>Your Next Tech Role Awaits</h1>
            <p>The premier job portal for developers, engineers, and IT professionals.</p>
            <div class="hero-cta">
                <asp:Button runat="server" ID="btnBrowseJobs" Text="Browse Tech Jobs" CssClass="btn btn-hero-cta" PostBackUrl="~/Jobs.aspx" />
            </div>
        </div>
    </div>

    <%-- ANIMATED STATS SECTION --%>
    <div class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="stat-item"><span class="glyphicon glyphicon-briefcase"></span>
                        <h3 class="counter">
                            <asp:Literal ID="ltLiveJobs" runat="server">0</asp:Literal></h3>
                        <p>Live Tech Jobs</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-item"><span class="glyphicon glyphicon-tower"></span>
                        <h3 class="counter">
                            <asp:Literal ID="ltCompanies" runat="server">0</asp:Literal></h3>
                        <p>IT Companies</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-item"><span class="glyphicon glyphicon-user"></span>
                        <h3 class="counter">
                            <asp:Literal ID="ltJobSeekers" runat="server">0</asp:Literal></h3>
                        <p>Developers</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-item"><span class="glyphicon glyphicon-ok-sign"></span>
                        <h3 class="counter">
                            <asp:Literal ID="ltApplications" runat="server">0</asp:Literal></h3>
                        <p>Total Applications</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- HOW IT WORKS SECTION (NEW) --%>
    <div class="how-it-works-section section-padding">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="section-title">Get Hired in 3 Simple Steps</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">01</div>
                        <div class="icon"><span class="glyphicon glyphicon-user"></span></div>
                        <h4>Create Your Profile</h4>
                        <p>Build a professional profile that highlights your skills, experience, and tech stack for employers to see.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">02</div>
                        <div class="icon"><span class="glyphicon glyphicon-search"></span></div>
                        <h4>Search & Apply</h4>
                        <p>Browse thousands of curated IT jobs. Use our advanced filters to find the perfect role and apply with one click.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">03</div>
                        <div class="icon"><span class="glyphicon glyphicon-ok"></span></div>
                        <h4>Get Hired</h4>
                        <p>Connect directly with recruiters and hiring managers from top tech companies and land your dream job.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- WHY CHOOSE US SECTION --%>
    <div class="why-choose-us-section container section-padding">
        <div class="row">
            <div class="col-md-12">
                <h2 class="section-title">Why Choose Jobify for IT?</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="icon"><span class="glyphicon glyphicon-flash"></span></div>
                    <h4>Curated Tech Roles</h4>
                    <p>We filter out the noise, providing you with only high-quality, relevant job listings from the tech industry.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="icon"><span class="glyphicon glyphicon-send"></span></div>
                    <h4>Direct to Recruiters</h4>
                    <p>Our platform connects you directly with tech recruiters and hiring managers at top-tier companies.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="icon"><span class="glyphicon glyphicon-bell"></span></div>
                    <h4>Tech Skill Alerts</h4>
                    <p>Get instant notifications for jobs that match your specific tech stack, skills, and career goals.</p>
                </div>
            </div>
        </div>
    </div>

    <%-- TOP COMPANIES SECTION --%>
    <div class="companies-section section-padding">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2 class="section-title">Top Tech Companies Hiring</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/innovatech.png" alt="Innovatech" /></div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/codebase.png" alt="Codebase" /></div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/nexgen-sys.png" alt="NexGen Systems" /></div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/data-sphere.png" alt="Data Sphere" /></div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/quantum-leap.png" alt="QuantumLeap" /></div>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6">
                    <div class="company-logo">
                        <img src="../../images/logos/cyber-secure.png" alt="CyberSecure" /></div>
                </div>
            </div>
        </div>
    </div>

    <%-- CALL TO ACTION SECTION --%>
    <div class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="cta-panel">
                        <h3>Are You a Tech Professional?</h3>
                        <p>Showcase your portfolio and GitHub profile to get noticed by leading tech firms today.</p>
                        <asp:Button runat="server" ID="btnRegisterSeeker" Text="Create Your Developer Profile" CssClass="btn btn-lg" PostBackUrl="~/Account/RegisterSeeker.aspx" />
                    </div>
                </div>
                <div class="col-md-6 cta-panel-right">
                    <div class="cta-panel">
                        <h3>Are You a Tech Employer?</h3>
                        <p>Post a job and connect with our talent pool of skilled developers, engineers, and designers.</p>
                        <asp:Button runat="server" ID="btnPostJob" Text="Post a Tech Job Now" CssClass="btn btn-lg" PostBackUrl="~/Account/RegisterCompany.aspx" />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- CORRECTED: Re-added the JavaScript for Counter Animation --%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const counters = document.querySelectorAll('.counter');
            const speed = 200;

            const animateCounter = (counter) => {
                const target = +counter.innerText.replace(/,/g, '');
                counter.innerText = '0';

                const updateCount = () => {
                    const count = +counter.innerText.replace(/,/g, '');
                    const increment = target / speed;

                    if (count < target) {
                        counter.innerText = Math.ceil(count + increment).toLocaleString();
                        setTimeout(updateCount, 10);
                    } else {
                        counter.innerText = target.toLocaleString();
                    }
                };
                updateCount();
            };

            const observer = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting && !entry.target.classList.contains('animated')) {
                        animateCounter(entry.target);
                        entry.target.classList.add('animated');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                    threshold: 0.5
                });

            counters.forEach(counter => {
                observer.observe(counter);
            });
        });
    </script>
</asp:Content>

