<%@ Page Title="About" Language="C#" MasterPageFile="~/Users/Guest/Guest.Master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Custom CSS for the About Us Page --%>
    <style>
        /* --- General Enhancements for this page --- */
        .section-padding { padding: 80px 0; }
        .section-title { text-align: center; margin-bottom: 60px; font-size: 2.8em; font-weight: 700; color: #2c3e50; position: relative; }
        .section-title::after { 
            content: ''; 
            position: absolute; 
            bottom: -15px; 
            left: 50%; 
            transform: translateX(-50%); 
            width: 100px; 
            height: 4px; 
            background: linear-gradient(90deg, #7928ca, #581845); 
            border-radius: 2px;
            transition: width 0.3s ease-in-out;
        }
        .section-title:hover::after {
            width: 150px;
        }

        /* --- About Hero Section --- */
        .about-hero-section {
            background: linear-gradient(45deg, rgba(88, 24, 69, 0.9), rgba(121, 40, 202, 0.85)), url('../../images/about-us-background.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 120px 0;
            margin: -20px -15px 30px -15px;
        }
        .about-hero-section h1 { font-size: 4em; font-weight: 700; text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3); animation: fadeInDown 1s ease-in-out; }
        .about-hero-section p { font-size: 1.4em; max-width: 800px; margin: 20px auto 0; opacity: 0; animation: fadeInUp 1s 0.5s ease-in-out forwards; }

        /* --- Our Story Section --- */
        .our-story-section { background-color: #ffffff; }
        .our-story-section .content-column { padding-right: 40px; }
        .our-story-section h3 { font-size: 2em; font-weight: 600; color: #2c3e50; margin-bottom: 20px; }
        .our-story-section p { color: #7f8c8d; line-height: 1.8; font-size: 1.1em; }
        .our-story-section .image-column { overflow: hidden; border-radius: 8px; } /* Added for clean hover effect */
        .our-story-section .image-column img { 
            border-radius: 8px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.4s ease;
        }
        .our-story-section .image-column:hover img {
            transform: scale(1.05);
        }
        
        /* --- Our Values Section --- */
        .our-values-section { background-color: #f9f9f9; }
        .value-card { text-align: center; padding: 30px; background: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 30px; transition: all 0.3s ease; border-top: 4px solid #7928ca; }
        .value-card:hover { transform: translateY(-10px); box-shadow: 0 12px 24px rgba(44, 62, 80, 0.15); border-top-color: #581845; }
        .value-card .icon { font-size: 3em; color: #7928ca; margin-bottom: 20px; transition: transform 0.3s ease; }
        .value-card:hover .icon { transform: scale(1.1); }
        .value-card h4 { font-weight: 600; color: #2c3e50; margin-bottom: 15px; }

        /* --- Team Section --- */
        .team-section { background-color: #ffffff; }
        .team-member-card { 
            text-align: center; 
            margin-bottom: 40px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            padding: 10px;
            border-radius: 8px;
        }
        .team-member-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(44, 62, 80, 0.12);
        }
        .team-member-card .photo-wrapper { position: relative; overflow: hidden; border-radius: 50%; width: 180px; height: 180px; margin: 0 auto 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .team-member-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s ease; }
        .team-member-card:hover img { transform: scale(1.1); }
        .team-member-card h4 { font-size: 1.4em; font-weight: 600; color: #2c3e50; margin-bottom: 5px; }
        .team-member-card p { font-size: 1em; color: #7928ca; font-weight: 500; }
        
        /* --- Call to Action Section --- */
        .join-us-cta {
            background: linear-gradient(45deg, #581845, #7928ca);
            padding: 60px 0;
            text-align: center;
            color: #fff;
            margin: 30px -15px -20px -15px;
        }
        .join-us-cta h2 { font-size: 2.5em; font-weight: 700; margin-bottom: 20px; }
        .join-us-cta p { font-size: 1.2em; margin-bottom: 30px; }
        .btn-cta-join { 
            background: transparent; 
            color: #fff; 
            font-weight: 600; 
            border: 2px solid #fff; 
            padding: 15px 40px; 
            font-size: 1.2em; 
            border-radius: 50px; 
            transition: all 0.3s ease;
        }
        .btn-cta-join:hover { 
            background-color: #fff;
            color: #581845; 
            transform: translateY(-3px); 
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3); 
        }

        /* --- Animation Keyframes --- */
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
    </style>

    <%-- HERO SECTION --%>
    <div class="about-hero-section">
        <div class="container">
            <h1>Connecting IT Talent with Opportunity</h1>
            <p>We are a passionate team dedicated to bridging the gap between brilliant tech professionals and innovative companies.</p>
        </div>
    </div>

    <%-- OUR STORY SECTION --%>
    <div class="our-story-section section-padding">
        <div class="container">
            <div class="row">
                <div class="col-md-6 content-column">
                    <h3>Our Story</h3>
                    <p>Jobify was founded in 2024 by a group of software engineers and recruiters who saw a broken hiring process in the IT industry. Generic job boards were flooded with irrelevant roles, and talented developers were tired of wasting time. We envisioned a smarter platform—a place built by tech people, for tech people.</p>
                    <p>Our mission is to create the most efficient and enjoyable job-seeking experience for the tech community. We focus exclusively on IT roles, from software development and cybersecurity to data science and cloud computing, ensuring every listing is relevant and high-quality.</p>
                </div>
                <div class="col-md-6 image-column">
                    <%-- IMPORTANT: Add an image 'our-story-image.jpg' to your 'images' folder --%>
                    <img src="../../images/our-story-image.jpg" class="img-responsive" alt="A team of developers collaborating" />
                </div>
            </div>
        </div>
    </div>

    <%-- OUR VALUES SECTION --%>
    <div class="our-values-section section-padding">
        <div class="container">
            <div class="row"><div class="col-md-12"><h2 class="section-title">Our Core Values</h2></div></div>
            <div class="row">
                <div class="col-md-4"><div class="value-card"><div class="icon"><span class="glyphicon glyphicon-ok"></span></div><h4>Quality First</h4><p>We prioritize curated, high-quality job listings over sheer quantity to respect our users' time and ambition.</p></div></div>
                <div class="col-md-4"><div class="value-card"><div class="icon"><span class="glyphicon glyphicon-flash"></span></div><h4>Community Focused</h4><p>We are committed to building a supportive community where IT professionals can grow their careers.</p></div></div>
                <div class="col-md-4"><div class="value-card"><div class="icon"><span class="glyphicon glyphicon-eye-open"></span></div><h4>Transparency</h4><p>We believe in clear, honest communication between employers and job seekers, fostering trust in the hiring process.</p></div></div>
            </div>
        </div>
    </div>

    <%-- MEET THE TEAM SECTION --%>
    <div class="team-section section-padding">
        <div class="container">
            <div class="row"><div class="col-md-12"><h2 class="section-title">Meet the Team</h2></div></div>
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="team-member-card">
                        <%-- IMPORTANT: Add team member photos to 'images/team' folder --%>
                        <div class="photo-wrapper"><img src="../../images/team/member1.jpg" alt="Team Member Jane Doe" /></div>
                        <h4>Jane Doe</h4>
                        <p>Founder & CEO</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="team-member-card">
                        <div class="photo-wrapper"><img src="../../images/team/member2.jpg" alt="Team Member John Smith" /></div>
                        <h4>John Smith</h4>
                        <p>Lead Developer</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="team-member-card">
                        <div class="photo-wrapper"><img src="../../images/team/member3.jpg" alt="Team Member Emily Jones" /></div>
                        <h4>Emily Jones</h4>
                        <p>Head of Product</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="team-member-card">
                        <div class="photo-wrapper"><img src="../../images/team/member4.jpg" alt="Team Member Michael Brown" /></div>
                        <h4>Michael Brown</h4>
                        <p>Community Manager</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- CALL TO ACTION SECTION --%>
    <div class="join-us-cta">
        <div class="container">
            <h2>Join the Fastest-Growing IT Community</h2>
            <p>Whether you're looking for your next role or your next hire, Jobify is your partner in tech.</p>
            <asp:Button runat="server" ID="btnJoinNow" Text="Get Started Now" CssClass="btn btn-cta-join" PostBackUrl="~/Account/Register.aspx" />
        </div>
    </div>

</asp:Content>

