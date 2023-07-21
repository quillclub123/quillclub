<%@page import="com.quillBolt.model.Banner"%>
<%@page import="com.quillBolt.model.ProgramInformation"%>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.4.0/animate.min.css">

    <title>QCW | Quill Club Writers</title>


    <style>
        body {
            color: #07294d;

        }

        footer h3 {
            font-size: 1.5rem !important;
        }
        .navbar .nav-link {
            color: #fff;
        }

        section {
            overflow: hidden;
        }

        .navbar .nav-item .nav-link {
            font-size: 16px;
            font-weight: 500;
            margin-left: 2.5rem;
            padding: 0.9rem 0;
            position: relative;
        }

        .navbar .nav-item .nav-link::before {
            position: absolute;
            content: "";
            left: 0;
            bottom: 0px;
            width: 0;
            height: 3px;
            background-color: #fff;
            -webkit-transition: .5s;
            transition: .5s;
        }

        .nav-item:hover .nav-link::before {
            width: 100%;
        }

        .school-section .bg-success {
            font-size: 1rem;
            padding: 5px 40px;
		    color: white;
		    border-radius: 3px;
		    margin-bottom: 8px;
    		display: inline-block;
        }

        .school-logo img,
        .admin-logo img {
            width: 100px;
        }

        .school-section .card {
            background-color: aliceblue;
            transition: all .1s;
            margin-bottom: 20px;
        }

        .school-section .card:hover {
            cursor: pointer;
            box-shadow: 0px 0px 20px 0px rgba(0, 0, 0, 0.205);
            transform: translateY(-3px);
        }
        .about-section {
            padding: 90px 0px;
        }

        @media (max-width: 576px) {

            .school-logo img,
            .admin-logo img {
                width: 50px;
            }

            h2 {
                font-size: 1rem;
            }

            .school-section .btn {
                font-size: 0.8rem;
                padding: 0.375rem;
            }
            h3{
                text-align: center;
            }
            .about-section {
            padding: 30px 0px;
        }
        .school-section .bg-success {
            padding: 5px 5px;
        }
        }

        

        p.content {
            font-weight: 500;
            font-size: 18px;
            line-height: 30px;
            color: #4e5b68;
            margin-top: 25px;
            text-align: justify;
        }

        h3 {
            font-weight: 500;
            font-size: 40px !important;
            letter-spacing: 1.5px;
            color: #07294d;
        }

        .about-img .rotate {
            width: 100%;
        }

        .bg-img {
            background-repeat: no-repeat;
            background-position: center center;
        }

        .bg-1 {
            position: relative;
            height: 372px;
            width: 421px;
            margin: auto;
            background-size: contain;
        }

        .bg-2 {
            position: absolute;
            left: 0px;
            top: -40px;
            width: 450px;
            height: 450px;

            animation: rotate 10s infinite linear;
        }

        @keyframes rotate {
            100% {
                transform: rotate(360deg);
            }
        }

        .book-section,
        .latest-section,
        .clients-section,
        .author-section {
            padding: 30px 0px;
        }

        .h3 {
            margin-bottom: 35px;
        }
        .imgs{
            text-align: center;
        }
        .imgs h5{
            margin-top: 15px;
            font-size: 1rem
        }
        .imgs img {
            transform: scale(1);
            transition: all .5s;
            border-radius: 6px;
            padding: 15px 0px;
        }

        .imgs:hover img {
            transform: scale(1.1);
            box-shadow: 0px 0px 4px 0px rgba(0, 0, 0, 0.116);
        }

        footer {
            padding: 80px 0px;
            margin-top: 40px;
            background-position: center;
        }

        .footer,
        footer h3 {
            color: #fff !important;
        }

        footer h3 {
            font-size: 1.5rem;
        }

        .social-media {
            margin-top: 35px;
        }

        .social {
            padding: 15px 20px;
            margin-right: 10px;
            background-color: #ffffff;
            font-size: 20px;
            display: inline-block;
        }

        .social-1:hover {
            background-color: #198754 !important;
            color: white !important;
        }

        .thaught {
            color: #cecece;
           
            font-size: 14px;
        }

        footer img {
            width: 25%;
            margin-top: 10px;
        }
        .line{
            height: 2px;
            width: 50%;
            margin: 10px 0px 20px 0px;
            display: inline-block;
            background-color: #fff;
        }
    </style>
</head>

<body style="background: #b3b3b3;">
<%
List<Schools> school = (List<Schools>)request.getAttribute("school");
List<ProgramInformation> pinf = (List<ProgramInformation>)request.getAttribute("pinf");
//List<Schools> schoolLocation = (List<Schools>)request.getAttribute("schoolLocation");
List<InstituitonGroup> igroup = (List<InstituitonGroup>)request.getAttribute("igroup");
List<Banner> banner = (List<Banner>)request.getAttribute("banner");
%>
    <header>
        <nav class="navbar navbar-expand-lg bg-dark" style="padding: 0 !important;">
            <div class="container">
                <ul class="navbar-nav">
                        <li class="">
                            <a class="nav-link" href="https://twitter.com/quillcwriters?lang=en"><i class="fa-brands fa-twitter" style="color: #cecece;"></i></a>
                        </li>
                        <li class="">
                            <a class="nav-link" href="https://www.facebook.com/Quill-Club-Writers-509480372418146/"><i class="fa-brands fa-facebook" style="color: #cecece;"></i></a>
                        </li>
                        <li class="">
                            <a class="nav-link" href="https://pinterest.com"><i class="fa-brands fa-pinterest" style="color: #cecece;"></i></a>
                        </li>
                        <li class="">
                            <a class="nav-link" href="https://linkedin.com"><i class="fa-brands fa-linkedin-in" style="color: #cecece;"></i></a>
                        </li>
                        <li class="">
                            <a class="nav-link"  style="color: #cecece; font-size: 14px;">Quill Club Writers</i></a>
                        </li>
                    </ul>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <i class="text-white fa-solid fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto ">
                        <li class="nav-item">
                             <p class="thaught" style="transform: translate(10px, 7px) !important;"><i class="fa-solid fa-mobile-screen" style="padding-right: 3px;"></i>Think | Write | Publish</p>
                        </li>
                       
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <%if(banner.size() > 0) {%>
    <section>
    	<div class="container">
    		 <div class="row" style="margin-top: 10px; border-bottom: 0.3px solid lightgray;">
        	<div class="col-12" style="padding-bottom: 20px;">
        		<div class="card wow slideInUp box sceen ">
        		
        			<img class="img-fluid" src="displaydocument?url=<%=banner.get(0).getBannerImg()%>" style="height: 220px;">
              
                </div>
            </div>
       	</div>
        </div>
    </section>
      <%} %>
    <section class="school-section">
        <div class="container">
        <%if(pinf.size() > 0){
            	for(int i=0; i<pinf.size(); i++){
            	%>
            <div class="row">
                <div class="col-12" style="border-bottom: 0.3px solid lightgray; margin-top: 20px;">
                    <div class="card wow slideInUp box sceen " onclick="takeTest(<%=pinf.get(i).getSno()%>)">
                        <div class="card-body" style="background-color: <%=pinf.get(i).getBgColor()%>">
                            <div class=" d-flex justify-content-around align-items-center">
                                <div class="school-logo">
                                   <img src="displaydocument?url=<%=pinf.get(i).getLogo()%>" alt="" class="img-fluid">
                                </div>
                                <div class="scool-name text-center">
                                	<%if(pinf.get(i).getStudentOf() != null && !pinf.get(i).getStudentOf().isEmpty()) {
                                	%>
                                    <h2 class="m-0" style="font-size: 20px;"><%=pinf.get(i).getStudentOf()%></h2>
                                    <%}else{ %>
                                    <h2 class="m-0"></h2>
                                    <% }%>
                                    <h2 class="my-2 pb-2" style="font-size: 20px; font-weight: bold;"><%=igroup.get(i).getInstitution_group()%>
                                    <%for(int j =0; j <school.size(); j++) {
                                    if(school.get(j).getInstitution_group_id() == pinf.get(i).getInstitution_group_id()){
                                    if(j==0){%>
                                    <%=school.get(j).getLocation() %>
                                    <%}else{ %>
                                    
                                    	 <%=school.get(j).getLocation() %>
                                    <%}}} %>
                                    </h2>
                                    <span class="bg-success fw-normal ">Click here to take the online
                                        test</span>
                                </div>
                                <div class="admin-logo">
                                    <img src="assets/images/QCW-Logo-removebg-preview.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%}} %>
        </div>
    </section>

    <!-- =======================About Section========================= -->

   <!--  <section class="about-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="about-content">
                        <h3>About us</h3>
                        <p class="content">
                            <b> Quill Club Writers </b>turns school children into published writers of mainstream
                            fiction.
                            We have
                            so far published more than 2,500 young writers in 100 books of fiction. The writers hone
                            their
                            skills under the close guidance of a journalist-turned-author and an experienced editor. We
                            select writers through an online test and an interview. At our online mentoring sessions,
                            the
                            writers develop story ideas, structure them and write and edit their stories. Finally, a
                            brilliantly written and ruthlessly edited book is ready.
                        </p>
                        <p class="content fs-6">
                            For pictures, videos and latest news, visit us on our facebook page
                        </p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="about-img bg-img bg-1" style="background-image: url(assets/images/globe.png);">
                        <div class=" bg-img bg-2" style="background-image: url(assets/images/about-round-img.png);">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    ===========================Latest Release Section=========================
    <section class="latest-section">
        <div class="container">
            <h3 class="h3">Latest Releases</h3>
            <div class="row">
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/View-Fm-Top.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/DPSARN-Fireflies.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Sunbeam-Varanasi.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Eme-Hgts-Childs-Play.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/DPS-VNN-Embark.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/The-Moon-MRIS-Ggn.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    ========================Book Section =================================

    <section class="book-section">
        <div class="container">
            <h3 class="h3">All Our Books</h3>
            <div class="row">
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book1.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book2.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book3.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book4.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book6.jpg" alt="">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/book5.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    ========================Clients Section =================================
    <section class="clients-section">
        <div class="container">
            <h3 class="h3">What Our Clients Say</h3>
            <div class="row">
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Gautam.jpg" alt="">
                        <h5> Gautam Rajgarhia</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Sunil.jpg" alt="">
                        <h5>Sunil Agarwal</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Aditi.jpg" alt="">
                        <h5>Aditi Misra</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Amit.jpg" alt="">
                        <h5>Amit Bhalla</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Tanya.jpg" alt="">
                        <h5>Tanya Pandey</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/Kavin.jpg" alt="">
                        <h5>Kavin Kandasamy</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>


    ========================Clients Section =================================

    <section class="author-section">
        <div class="container">
            <h3 class="h3">Our Authors</h3>
            <div class="row">
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author1.jpg" alt="">
                        <h5>Harshita Pandey</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author2.jpg" alt="">
                        <h5>Nishta Sawhney</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author3.jpg" alt="">
                        <h5>Tvesa Kishore</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author4.jpg" alt="">
                        <h5>Tarini Agarwal
                        </h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author5.jpg" alt="">
                        <h5>Sanjna Vivek</h5>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="imgs wow slideInUp">
                        <img class="img-fluid" src="assets/images/author6.jpg" alt="">
                        <h5>Francesca Fowler</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>

    =====================Footer===============================
    <footer class="footer bg-dark" style="background-image: url(assets/images/footer-bg.png);">
        <div class="container">
            <div class="row">
                <div class="col-md-3 pb-3">
                    <h3>Quill Club Writers</h3>
                    <span class="line"></span>
                    <p class="thaught">Think | Write | Publish</p>
                    <div class="social-media">
                        <a class="social" target="_blank" href="https://twitter.com/QuillCWriters"><i class="fa-brands fa-twitter"></i></a>
                        <a class="social" target="_blank" href="https://www.facebook.com/people/Quill-Club-Writers/100063670726337/"><i class="fa-brands fa-facebook-f"></i></a>
                    </div>
                </div>
                <div class="col-md-3 pb-3">
                    <h3 class="text-start">Aditi Mishra</h3>
                    <span class="line"></span>
                   <div>
                    <img src="assets/images/Aditi.jpg" alt="">
                   </div>
                </div>
                <div class="col-md-6 pb-3">
                    <div class="footer-content fs-5">
                        <p>“Hemant and Ruchira are brilliant mentors… The entire experience of working with them was
                            enriching-” Aditi Misra, Principal, DPS Gurgaon</p>
                    </div>
                </div>
            </div>
        </div>
    </footer> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js">
    </script>
    <script>
        wow = new WOW(
            {
                boxClass: 'wow',      // default
                animateClass: 'animated', // change this if you are not using animate.css
                offset: 0,          // default
                mobile: true,       // keep it on mobile
                live: true        // track if element updates
            }
        )
        wow.init();
        
       /*  $(document).ready(function () {
            $(".school-section .row:nth-child(2)").attr("data-wow-delay", ".2s");
            $(".school-section .row:nth-child(3)").attr("data-wow-delay", ".4s");
            $(".school-section .row:nth-child(4)").attr("data-wow-delay", ".6s");
            $(".school-section .row:nth-child(5)").attr("data-wow-delay", ".8s");
            $(".school-section .row:nth-child(6)").attr("data-wow-delay", "1s");
            $(".school-section .row:nth-child(7)").attr("data-wow-delay", "1.2s");
            $(".school-section .row:nth-child(8)").attr("data-wow-delay", ".6s");
            $(".school-section .row:nth-child(9)").attr("data-wow-delay", ".6s");
            $(".school-section .row:nth-child(10)").attr("data-wow-delay", ".6s");
            $(".school-section .row:nth-child(11)").attr("data-wow-delay", ".6s");
        }); */
    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>

<script>
function takeTest(sno){
	 var mapForm = document.createElement("form");
	// mapForm.target = "_blank";
	 mapForm.method = "POST"; // or "post" if appropriate
	 mapForm.action = "testInformation";
	 var output = document.createElement("input");
	 output.type = "hidden";
	 output.name = "sno";
	 output.value = sno;
	 mapForm.appendChild(output);
	 document.body.appendChild(mapForm);
	 mapForm.submit();
}
</script>
</body>

</html>