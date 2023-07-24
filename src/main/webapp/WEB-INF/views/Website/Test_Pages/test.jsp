<%@page import="com.quillBolt.model.Information"%>
<%@page import="com.quillBolt.model.ProgramInformation"%>
<%@page import="com.quillBolt.model.SampleAnswer"%>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="com.quillBolt.model.Section"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.quillBolt.model.Questions"%>
<%@page import="com.quillBolt.model.QuestionPaper"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>
   <jsp:include page="../css.jsp"></jsp:include> 


    <title>Quill Club Writers | Test</title>

    <style>
        .footer-content {
            padding: 3rem 0rem;
        }

        @media (max-width: 991px) {
            .footer-content {
                border-top: none;
            }

            .footer-content {
                padding: 1rem 0rem;
            }
        }
        .questionp p {
        	line-height: 1.7;
        	font-size: 13px;
        }
        .qheading p{
        	font-size: 13px;
        	line-height: 1.7;
        }
        .qheading span{
        	font-size: 14px;
        }
        .qheading h4{
        	font-size: 17px;
        	text-align: center;
        }
        .sampTerm a{
        font-size: 14px;
        margin-left: -31px;
        color: gray;
        }
        .card,
        .img-ques-area img {
            border-radius: 10px;
        }

        .img-ques-area img {
           min-height: 600px;
		   max-height: 600px;
		   width: 400px;
        }
        .img-ques-area, .img-ans-area form{
            display: flex;
            flex-direction: column;
        }
    </style>
</head>

<body>
<%
List<Questions> qp = (List<Questions>)request.getAttribute("questions");
//List<Section> section = (List<Section>)request.getAttribute("section");
List<Schools> school = (List<Schools>)request.getAttribute("school");
List<ProgramInformation> pInfo = (List<ProgramInformation>)request.getAttribute("pInfo");
String al = (String)request.getAttribute("al");
String email = (String)request.getAttribute("email");
String extra = (String)request.getAttribute("extra");
String section = (String)request.getAttribute("section");
String class_name = (String)request.getAttribute("class_name");
List<SampleAnswer> sampleAnswers = (List<SampleAnswer>)request.getAttribute("sampleAnswers");
List<Information> infor = (List<Information>)request.getAttribute("infor");
%>
<input type="hidden" id="name" value="<%=al%>">
<input type="hidden" id="school_id" value="<%=school.get(0).getSno()%>">
<input type="hidden" id="class_id" value="<%=class_name%>">
<input type="hidden" id="group_id" value="<%=school.get(0).getInstitution_group_id()%>">
<input type="hidden" id="section_id" value="<%=section%>">
<input type="hidden" id="email" value="<%=email%>">
<input type="hidden" id="extra" value="<%=extra%>">
 <%if(qp.get(0).getQuestionImgType().equalsIgnoreCase("off")){ %>
     <section class="section-1 ques-ans">
        <div class="container mb-4">
            <div class="row">
                <div class="col-md-12 col-lg-5">
                    <div class="question-area">
                        <div class="headings text-center qheading" style="padding: 0px 1.5rem;">
                            <h4><%=qp.get(0).getInstructionHeadingQ() %></h4>
                            <p style="color: gray;font-size: 13px; text-align: center;"><%=qp.get(0).getInstructionQ() %></p>
                            <!-- <h4 style="color: gray;font-size: 13px;"> Answer the question at the end of the passage.</h4>
                            <h4 style="color: gray;font-size: 13px;"> Answer the question at the end of the passage.</h4> -->
                        </div>

                        <div class="card" style="border-radius: 10px; min-height: 375px; min-width: 375px;">
                            <div class="card-body questionp" style="padding: .5rem 1.5rem !important;">
                                <p>
                                <%=qp.get(0).getQuestion() %>
                                </p>
                            </div>
                        </div>
                        <div class="ques-and-term mt-3 mb-5">
                            <div class="">

                                <!----------------Popup for sample Question---------------------  -->
                              

                                <!-- Popup -->
                                <div class="modal mymodel fade" id="exampleModal1" tabindex="-1"
                                    aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog text-start">
                                        <div class="modal-content overflow-hidden"
                                            style=" background-image: linear-gradient(300deg, #ffffffd9, #ffffffd9), url(assets/images/watercolor-school-bg.png);">

                                            <div class="modal-header light_grey"  style="padding:2rem;">
                                                <h6 class="modal-title" id="exampleModalLabel">Sample Answer
                                                </h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body" style="padding: 2rem;">
                                                <!-- <h5 class="mb-4">Explain the importance of NCERT Solutions for Class 10
                                                    from BYJU’S.</h5> -->
                                                    <%if(sampleAnswers.size() > 0){ %>
                                                    <p><%=sampleAnswers.get(0).getAnswer() %></p>
                                                    <%} %>
                                            </div>
                                            <div class="modal-footer light_grey" style="padding: 1rem 2rem;">
                                                <button style="margin: 0px;" type="" id="agree-btn" class="btn btn-success btn-linear-1"
                                                    data-bs-dismiss="modal">Got It</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             <div class="">
                            
                                <!--2----------------- Pop up for term & Conditions---------------------------- -->
                             

                                <!-- Popup -->
                                <div class="modal mymodel fade" id="exampleModal" tabindex="-1"
                                    aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog text-start">
                                        <div class="modal-content overflow-hidden"
                                            style=" background-image: linear-gradient(300deg, #ffffffd9, #ffffffd9), url(assets/images/watercolor-school-bg.png);">

                                            <div class="modal-header light_grey" style="padding: 2rem;">
                                                <h6 class="modal-title" id="exampleModalLabel">Term and
                                                    Conditions
                                                </h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body"  style="padding: 2rem;">
                                                <h5 class="mb-4">QCW- <%=school.get(0).getSchool_name() %> | <%=pInfo.get(0).getTitle() %></h5>
                                                <p class=""><%=pInfo.get(0).getTermsCondition() %></p>
                                              
                                            </div>
                                            <div class="modal-footer light_grey" style="padding: 1rem 2rem;">
                                                <button style="margin: 0px;" type="" id="agree-btn" class="btn btn-success btn-linear-1"
                                                    data-bs-dismiss="modal">Agree</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">

                </div>
                <div class="col-md-12 col-lg-5">
                    <div class="ans-area">
                        <div class="headings text-center qheading" style="padding: 0px 1.6rem;">
                            <h4><%=qp.get(0).getInstructionHeadingA() %></h4>
                            <p style="text-align: center;"><%=qp.get(0).getInstructionA()%></p>
                           <!--  <span class="italic mb-3">Your story may remain incomplete. Leave it that way</span> -->
                        </div>
                        <form name="register" id="register">
                            <div class="card" style="border-radius: 10px;">
                                <div class="card-body" style="">
                                    <textarea name="answer" id="answer" rows=""
                                        placeholder="Type Your Answer Here...." required style="line-height: 2; font-size: 14px; color: #464646;border:none !important; padding-bottom: 0px !important;"></textarea>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: -32px;">
                <div class="col-md-7">
                    <div class="col-md-9 text-center sampTerm" >
                        <a class="nav-link" data-bs-toggle="modal" data-bs-target="#exampleModal1" style="padding: 0px; align-self: flex-end;">Sample
                            Answer</a>
                           <!--  <a class="nav-link " data-bs-toggle="modal" style="padding: 0px; align-self: flex-end;"
                            data-bs-target="#exampleModal">Terms & Conditions</a>  -->
                    </div>
                    
                </div>
                <div class="col-md-5 text-center words_limit">
                    <span class="f14  d-block text-center">Word Counter: <span id="count" style="color: red;">90</span> words remaining</span>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <div class="container mt-4">
            <div >
                <div class="footer-content align-items-center" style=" display: flex; width: 100%; padding-top:0px;">
                    <div class="row">
                        
                    </div>
                    <div class="col-md-12 col-lg-7 order-2 order-lg-1" style=" display: table-cell; padding: 16px;">
                    <div class="col-md-9">
                        <div  class="footer-content text-center" style="padding-bottom: 0px; border: none;">
                            <div>
                                <img class="brand-logo" src="assets/Website/assets/images/QCW-Logo.jpg" alt="">
                            </div>
                            <h4>Quill Club Writers</h4>
                            <div class="para" style="width: 100%;padding:2px;margin:10px auto">
		                        <%if(infor != null && !infor.isEmpty()) {%>
		                        <p class="text-center"><%=infor.get(0).getInformation() %></p>
		                        <%} %>
		                       </div>
                            <!-- <p class="text-center" style="padding: 0px 1rem;">We identify talented schoolchildren and mentor and publish them. We
                                have so far <br>
                                published 3,000 young writers in 125 books, and counting</p> -->
                        </div>
                    </div>
                    </div>
                    <div class="col-md-12 col-lg-5 order-1 order-lg-2" style=" display: table-cell; padding: 16px; margin-top: 132px;" >
                        <div class="text-center">
                            <button type="button" id="submitBtn" class="btn btn-success btn-linear-1 submit" style="height: 60px; width: 250px; margin-bottom: 1rem; margin-left:75px;" onclick="submitAns()">Submit Answer</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <%}else{ %>
    <section class="section-1 ques-ans">
        <div class="container mb-4">
            <div class="row">
                <div class="col-md-12 col-lg-5">
                    <div class="headings qheading">
                        <h4><%=qp.get(0).getInstructionHeadingQ() %></h4>
                        <p style="color: gray;font-size: 13px;"><%=qp.get(0).getInstructionQ() %></p>
                        <span style="color: gray;font-size: 13px; text-align: left;"><%=qp.get(0).getQuestion() %></span>
                    </div>
                </div>
                <div class="col-lg-2"></div>
                <div class="col-md-12 col-lg-5">
                    <div class="headings qheading">
                         <h4><%=qp.get(0).getInstructionHeadingA() %></h4>
                          <p><%=qp.get(0).getInstructionA()%></p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-5">
                    <div class="img-ques-area">
                        <div class="card" style="width: 400px; margin: auto;">
                            <div class="card-body p-0">
                                <img class="" src="displaydocument?url=<%=qp.get(0).getQuestion_image()%>" alt="">
                            </div>
                        </div>
                        <div>
                           <p class="text-center mt-3" style="width: 80%; margin: auto; font-size: 12px;"><%=qp.get(0).getQuotes() %></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">

                </div>
                <div class="col-md-12 col-lg-5">
                    <div class="img-ans-area">
                        <form id="" name="">
                            <div class="card" style="height: 450px;]">
                                <div class="card-body">
                                    <textarea name="answer" id="answer" rows="" placeholder="Type Your Answer Here...."
                                        required style="font-size: 14px;"></textarea>
                                </div>
                            </div>
                            <div class="text-center">
                                <p class="text-center mt-3" style="font-size: 13px;"> Word Counter: <span id="count" style="color: red;">90</span> words remaining</p>
                                <button type="button" id="submitBtn" class="btn btn-success btn-linear-1" style="height: 60px;width: 250px;
                                    font-weight: 600; margin-top: 41px;" onclick="submitAns()">Submit Answer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="footer-content text-center pt-5">
                        <div>
                            <img class="brand-logo" src="assets/images/QCW-Logo.jpg" alt=""
                                style="height: 40px; width:40px; margin-bottom: 0px;">
                        </div>
                        <h4>Quill Club Writers</h4>
                         <div class="para" style="width: 40%;padding:2px;margin:10px auto">
                        <%if(infor != null && !infor.isEmpty()) {%>
                        <p class="text-center"><%=infor.get(0).getInformation() %></p>
                        <%} %>
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
       
     
    <%} %>
    





   <jsp:include page="../js.jsp"></jsp:include> 
    <script>
   /*  $(document).ready(function() {
    	  $("#answer").keyup(function() {
    	    let text = $.trim($("textarea").val());
    	    let words = text.split(/\s+/); // Split by one or more whitespace characters
    	    let count = words.length;
    	    $("#count").html(count);
    	  });
    	}); */



    
       /*  $(".submit").click(function () {


        if($("#answer").val() == ""){
            $('<label for="answer" class="text-danger ans-error">Please enter your answer</label>').insertBefore("#answer");
            $("#answer").focus();
            $("#answer").css("outline", "none");
            $("#answer").css("border", "1px solid red");

        }
        else{
            $('.ans-error').remove();
            $("#answer").css("border", "1px solid gray");
            alert($("#answer").val());
        }

        }); */
        
        function submitAns(){
        	var school_id = $("#school_id").val();
        	var group_id = $("#group_id").val();
        	var class_id = $("#class_id").val();
        	var section_id = $("#section_id").val();
        	var name = $("#name").val();
        	var email = $("#email").val();
        	var answer = $("#answer").val();
        	var extra = $("#extra").val();
        	if(answer != null && answer != ""){
        	Swal.fire({
  			  html: '<p style="text-align:center;font-size:16px;">Are you sure?</p><p style="text-align:center;font-size:16px;line-height:1.7">Once you click Yes, the answer will be submitted.<br> And you will be logged out</p>',
  			  showDenyButton: true,
  			  //showCancelButton: true,
  			  confirmButtonText: 'Yes, Submit',
  			  denyButtonText: "No, Don't Submit",
  			  customClass: {
  			    actions: 'my-actions',
  			    cancelButton: 'order-1 right-gap',
  			    confirmButton: 'order-2',
  			    denyButton: 'order-3',
  			  }
  			}).then((result) =>{
  				if (result.isConfirmed) {
        	
        		$("#submitBtn").prop('disabled',true);
        		var obj = {
        			"school_id" : school_id,	
        			"group_id" : group_id,	
        			"class_name" : class_id,	
        			"section" : section_id,	
        			"name" : name,	
        			"email" : email,	
        			"extra" : extra,	
        			"answer" : answer,	
        		};
        		$.ajax({
					url : 'add_answer',
					type : 'post',
					data : JSON.stringify(obj),
					dataType : 'json',
					contentType :  'application/json',
					success : function(data) {
						if (data['status'] == 'Success') {
							var mapForm = document.createElement("form");
							 // mapForm.target = "_blank";
							  mapForm.method = "POST";
							  mapForm.action = "submission";
							  
							  var output = document.createElement("input");
							  output.type = "hidden";
							  output.name = "group_id";
							  output.value = group_id;
							  
							  var output2 = document.createElement("input");
							  output2.type = "hidden";
							  output2.name = "school_id";
							  output2.value = school_id;
							  
							  mapForm.appendChild(output);
							  mapForm.appendChild(output2);
							  document.body.appendChild(mapForm);
							  mapForm.submit();
					}else if(data['status'] == 'Failed'){
						Swal.fire({
							icon : 'warning',
							title : 'Invalid!',
							text : data['message']
						}) 
					}
				 }
				});
        	
  			}
        });
  			}else{
        		$("#answer").css('border-color', 'red');
        	}

        }
        
        $(document).ready(function() {
            function disableBack() {
                window.history.forward();
            }
            window.onload = disableBack();
            window.onpageshow = function(e) {
                if (e.persisted)
                    disableBack();
            }
        });

    </script>
</body>

</html>