<%@page import="com.quillBolt.model.ProgramInformation"%>
<%@page import="com.quillBolt.model.Schools"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>
   

 <jsp:include page="../css.jsp"></jsp:include> 
    <title>Quill Club Writers | Test</title>
</head>

<body>
<%List<Schools> school = (List<Schools>)request.getAttribute("school");
List<ProgramInformation> pinfo = (List<ProgramInformation>)request.getAttribute("pinfo");
%>
    <section class="section-1 pt-4 pb-5 thanku-box">

        <div class="container">
            <div class="row mb-4" >
                <div class="col-md-12">
                    <div class="text-center">
                        <h5 class="mb-2"><%=pinfo.get(0).getTitle() %></h5>
                        <p class="text-center mb-1"><%=pinfo.get(0).getSubTitle() %></p>
                        <div class="school-details mb-2">
                            <img class="school-logo mb-2" style="width: 50px;" src="displaydocument?url=<%=pinfo.get(0).getLogo()%>"
                                alt="School logo">
                            <p class="mt-1 text-center"><%=school.get(0).getSchool_name() %></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-12" style="display: flex;width: 100%;justify-content: center;">
                    <div class="card" style="width: 45rem;">
                        <div class="card-body " style="padding: 1rem !important;">
                            <p class="text-center mb-0" style="color:#212529; line-height: 40px; font-size: 18px;">You have completed this test.<br>
                            We have sent you an email confirming your submission.<br>
                            You may close the browser now.<br>
                            Please check your email inbox. Please also check your Spam folder.</p>
                            <p class="text-center mb-0" style="color:#212529b0; font-weight: 500;line-height: 40px; font-size: 18px;">Thank You </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class=" text-center">
                        <div>
                            <img class="brand-logo" src="assets/Website/assets/images/QCW-Logo.jpg" alt="" style="height: 40px; width:40px; margin-bottom: 0px;">
                        </div>
                        <h4 style="font-size: 19px; margin-bottom: 1.5rem;">Quill Club Writers</h4>
                       <!--  <p class="text-center" style="font-size: 13px;">We identify talented schoolchildren and mentor and publish them. We have
                            so far <br>
                            published 3,000 young writers in 125 books, and counting</p> -->
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
  <jsp:include page="../js.jsp"></jsp:include> 
  
   <script>
        $(document).ready(function() {
            function disableBack() {
                window.history.forward()
            }
            window.onload = disableBack();
            window.onpageshow = function(e) {
                if (e.persisted)
                    disableBack();
            }
        });
    </script>

</html>