<%@page import="com.quillBolt.model.Section"%>
<%@page import="com.quillBolt.model.Information"%>
<%@page import="com.quillBolt.model.SampleQuestion"%>
<%@page import="com.quillBolt.model.ProgramInformation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>

<jsp:include page="../css.jsp"></jsp:include>
    <title>Quill Club Writers | New</title>
    <style>
       /*  body{
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
            color: #000;
            text-shadow: 0px 0px 10px white;
        }
        body p{
            color: #000 ;
        } */
        .mymodel p, .mymodel h6, .mymodel h5{
            color: black;
        }
        #extra0{
        	margin-top: 0;
        }
        .line p{
        line-height: 1.7;
        font-size: 15px;
        }
        .fontterm p{
        	font-size: 13px;
        }
         .sampQT{
         	text-align: center;
         	border: 1px solid gray;
         	border-radius: 4px;
         	width: 50%;
         	margin: auto;
         	padding: 7px 0px;
         }
        .sampQT a{
        	color: gray !important;
        	font-size: 12px;
        	text-align: center;
        }
       .check{
       	display: flex;
       	align-items: center;
       	margin-bottom: 10px;
       }
       .check input{
       	margin-right: 10px;
       }
       .check label{
       	margin-bottom: 0px; 
       }
       .footer-content .para{
       		text-align: center;
       }
       .sampQ p{
       	font-size: 13px;
       	line-height: 30px;
       	font-weight: 500;
       	color: gray;
       }
    </style>
</head>
<%
List<Schools> schooldata = (List<Schools>)request.getAttribute("schooldata");
List<ProgramInformation> pinfo = (List<ProgramInformation>)request.getAttribute("pinfo");
List<SampleQuestion> sans = (List<SampleQuestion>)request.getAttribute("sans");
List<InstituitonGroup> instituitonGroups = (List<InstituitonGroup>)request.getAttribute("instituitonGroups");
List<String> data8 = (List<String>)request.getAttribute("data8");
List<Information> infor = (List<Information>)request.getAttribute("infor");
List<Section> sec = (List<Section>)request.getAttribute("sec");
%>
<body>
   <section class="section-1">

        <div class="container">

            <div class="row">
                <div class="col-md-12 col-lg-5">
                    <div class="box-1">
                        <h2 class="form-head" style="font-size: 22px; color: gray;"><%=pinfo.get(0).getTitle()%></h2>
                        <h4 style="font-size: 18px; color: gray;"><%=pinfo.get(0).getSubTitle()%></h4>
                        <div class="school-details mb-4 mt-3">
                             <img class="school-logo" src="displaydocument?url=<%=pinfo.get(0).getLogo()%>" alt="School logo">
                            <h4 class="mt-3" style="color: gray;font-size: 18px;"><%=instituitonGroups.get(0).getInstitution_group()%></h4>
                        </div>
                        <div class="line">
                        <p >
                            <%=pinfo.get(0).getDescription() %>
                        </p>
                        </div>
                        
                       
                        <div class="ques-and-term mt-5">
                            <div class="">

                                <!----------------Popup for sample Question---------------------  -->


                                <!-- Popup -->
                                <div class="modal mymodel  fade" id="exampleModal1" tabindex="-1"
                                    aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg text-start mt-2 mb-0">
                                        <div class="modal-content overflow-hidden"
                                            style=" background-image: linear-gradient(300deg, #ffffffd9, #ffffffd9), url(assets/images/watercolor-school-bg.png);">

                                            <div class="modal-header light_grey" style="padding:2rem;">
                                                <h6 class="modal-title" id="exampleModalLabel">Sample Question
                                                </h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>

                                            <div id="carouselExampleControls" class="carousel slide"
                                                data-bs-ride="carousel">
                                                <div class="carousel-inner">
                                                 <%
                                                
                                                 if(sans.size() > 0){
                                                	 
                                                	 for(int i=0; i<sans.size(); i++){
                                                		 int count = 0;
                                                		 if(sans.get(i).getQuestionImgType().equalsIgnoreCase("off")){
                                                	 	if(count == 0){
                                                	 %>
                                                 
                                                    <div class="carousel-item active">
                                                        <div class="modal-body sampQ" style="height :435px; padding: 2rem 2.4rem;">
                                                            <p><%=sans.get(i).getQuestion()%></p>
                                                        </div>
                                                    </div>
                                                    <% count++; }else{%>
                                                    	<div class="carousel-item">
                                                        <div class="modal-body sampQ" style="height :435px; padding: 2rem 2.4rem;">
                                                            <p><%=sans.get(i).getQuestion()%></p>
                                                        </div>
                                                    </div>
                                                   <%}}}}
                                                    
                                                 if(sans.size() > 0){
                                                	 for(int i=0; i<sans.size(); i++){
                                                		 if(sans.get(i).getQuestionImgType().equalsIgnoreCase("on")){
                                                	 
                                                
                                                    %>
                                                    <%-- <div class="carousel-item">
                                                        <div class="modal-body"  style="height :435px; padding: 2rem 2.4rem;">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="question-area text-center">
                                                                        <div class="headings "
                                                                            style="padding: 0px 0rem 20px 0rem;">


                                                                            <p style="margin: 0px; text-align:center !important;"> <%=sans.get(i).getQuestion() %></p>
                                                                        </div>


                                                                        <img style="height:250px; width: 350px;"
                                                                            src="displaydocument?url=<%=sans.get(i).getQuestion_image()%>">
                                                                       <!--  <h6
                                                                            style="font-weight: bold; padding-top: 20px;">
                                                                            Question: What do you think the boy is
                                                                            doing? And why?</h6> -->

                                                                    </div>
                                                                </div>
                                                                <!-- <div class="col-md-6">
                                                                    <div class="ans-area"
                                                                        style="background: #e1e1e1; padding: 30px; border-radius: 10px;">
                                                                        <div class="headings text-left"
                                                                            style="padding: 0px 0px 20px 0px;">
                                                                            <span class="mb-3"
                                                                                style="font-weight: bold;">Sample
                                                                                Answer</span>
                                                                        </div>
                                                                        <form name="register" id="register">
                                                                            <div class="card"
                                                                                style="border-radius:10px;">
                                                                                <div class="card-body"
                                                                                    style="padding: 1.5rem 1.5rem !important;height: 360px; background: #eee;">
                                                                                    <p>
                                                                                        In a quiet room, a young boy
                                                                                        sits engrossed in his world of
                                                                                        words. With his back turned to
                                                                                        us, he listens intently to the
                                                                                        radio's melodic whispers. On the
                                                                                        table before him, a tower of
                                                                                        books stands tall, brimming with
                                                                                        knowledge and inspiration.
                                                                                        Sheets of paper and letters
                                                                                        scatter haphazardly around him,
                                                                                        evidence of his creative
                                                                                        endeavors. Amidst this serene
                                                                                        chaos, the boy finds solace,
                                                                                        finding solace in the magic of
                                                                                        literature and the rhythmic
                                                                                        cadence of his pen dancing
                                                                                        across the paper.
                                                                                    </p>
                                                                                </div>
                                                                            </div>

                                                                        </form>
                                                                    </div>
                                                                </div> -->
                                                            </div>
                                                        </div>
                                                    </div> --%>
                                                    <%}}} %>

                                                </div>
                                                <button class="carousel-control-prev" type="button"
                                                    data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                                                    <span class="carousel-control-prev-icon" aria-hidden="true"><i class="fa-solid fa-arrow-left"></i></span>
                                                    <span class="visually-hidden">Previous</span>
                                                </button>
                                                <button class="carousel-control-next" type="button"
                                                    data-bs-target="#carouselExampleControls" data-bs-slide="next">
                                                    <span class="carousel-control-next-icon" aria-hidden="true"><i class="fa-solid fa-arrow-right"></i></span>
                                                    <span class="visually-hidden">Next</span>
                                                </button>
                                            </div>
                                            <div class="modal-footer light_grey" style="padding: 1rem 2rem;">
                                                <button type="" id="agree-btn" class="btn btn-success"
                                                    data-bs-dismiss="modal" style="margin:0px;">Got It</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="">
                                <!------------------- Pop up for term & Conditions---------------------------->

                                <!-- Popup -->
                                <div class="modal mymodel fade" id="exampleModal" tabindex="-1"
                                    aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg text-start">
                                        <div class="modal-content overflow-hidden"
                                            style=" background-image: linear-gradient(300deg, #ffffffd9, #ffffffd9), url(assets/images/watercolor-school-bg.png);">

                                            <div class="modal-header light_grey" style="padding: 2rem;">

                                                <h6 class="modal-title" id="exampleModalLabel">Terms and
                                                    Conditions
                                                </h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body fontterm" style="padding: 2rem;">
                                                <h5 class="mb-4"><%=pinfo.get(0).getTitle() %></h5>
                                                <p> <%=pinfo.get(0).getTermsCondition() %></p>
                                                <!-- <p class="px-2">Students of class 5 and above are eligible to
                                                    participate
                                                    in this
                                                    programme</p>
                                                <p class="head mb-0">NO PREPARATION REQUIRED</p>
                                                <p class="px-2">You do not need any special preparation to take the
                                                    test.
                                                </p>
                                                <p class="head mb-0">AFTER THE TEST</p>
                                                <p class="px-2">Lorem ipsum dolor sit amet, consectetur adipisicing
                                                    elit.
                                                    Facilis
                                                    animi, eaque rerum amet similique doloremque aspernatur
                                                    itaque
                                                    beatae nostrum quisquam?</p>
                                                <p class="head mb-0">ELIGIBILITY</p>
                                                <p class="px-2">Students of class 5 and above are eligible to
                                                    participate
                                                    in this
                                                    programme</p>
                                                <p class="head mb-0">NO PREPARATION REQUIRED</p>
                                                <p class="px-2">You do not need any special preparation to take the
                                                    test.
                                                </p>
                                                <p class="head mb-0">AFTER THE TEST</p>
                                                <p class="px-2">Lorem ipsum dolor sit amet, consectetur adipisicing
                                                    elit.
                                                    Facilis
                                                    animi, eaque rerum amet similique doloremque aspernatur
                                                    itaque
                                                    beatae nostrum quisquam?</p>
                                                <p class="head mb-0">ELIGIBILITY</p>
                                                <p class="px-2">Students of class 5 and above are eligible to
                                                    participate
                                                    in this
                                                    programme</p>
                                                <p class="head mb-0">NO PREPARATION REQUIRED</p>
                                                <p class="px-2">You do not need any special preparation to take the
                                                    test.
                                                </p>
                                                <p class="head mb-0">AFTER THE TEST</p>
                                                <p class="px-2">Lorem ipsum dolor sit amet, consectetur adipisicing
                                                    elit.
                                                    Facilis
                                                    animi, eaque rerum amet similique doloremque aspernatur
                                                    itaque
                                                    beatae nostrum quisquam?</p> -->
                                            </div>
                                            <div class="modal-footer light_grey" style="padding: 1rem 2rem;">
                                                <button type="" id="agree-btn" class="btn btn-success"
                                                    style="margin:0px;" data-bs-dismiss="modal">Got it</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2"></div>
                <div class="col-md-12 col-lg-5">
                    <div class="form-area">
                        <h2 class="form-head mb-4 pb-3 text-center" style="color: gray; font-size: 22px;"> Enter Your Details Here</h2>

                        <form name="login" id="login">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="input-field mb-4">

                                        <input type="text" class="form-control" id="name" name="name"
                                            placeholder="Name">

                                    </div>
                                </div>


                                <div class="col-md-12">
                                    <div class="input-field mb-4">

                                        <select class="form-select" id="school" name="school" onchange="getClassData()" style="color: gray;">
                                            <option selected disabled>Select School</option>
                                          <%for(Schools s : schooldata){ %>
                                           		<option value="<%=s.getSno()%>"><%=s.getSchool_name()%> <%=s.getBranch()%></option>
                                           <%} %>
                                        </select>
                                    </div>
                                </div>




                                <div class="col-md-6">
                                    <div class="input-field mb-4">
                                         <select class="form-select" id="className" name="className" onchange="getSectionData()" style="color: gray;">
                                            <option selected disabled>Select Class</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="input-field mb-4">
										<!-- <input type="text" class="form-control" id="section" name="section"
                                            placeholder="Section"> -->
                                        <select class="form-select" id="section" name="section"  style="color: gray;">
                                         <option selected disabled>Select Section</option>
                                         <%for(Section s : sec){ %>
                                           		<option value="<%=s.getSection_name()%>"><%=s.getSection_name()%></option>
                                           <%} %>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12">

                                    <div class="input-field mb-4">

                                        <input type="text" class="form-control" id="email" name="email"
                                            placeholder="Email">

                                    </div>
                                </div>
                                <div class="col-md-12">

                                    <div class="input-field mb-4">

                                        <input type="text" class="form-control" id="confirmemail" name="confirmemail"
                                            placeholder="Confirm Email">
                                            <span id="emailerr"></span>

                                    </div>
                                    <div id="error-message" style="color: red;"></div>
                                </div>
                                <div class="col-md-12"  style="margin-top: -20px; padding-bottom: 25px;">
										<div class="row extra">
										</div>
                                </div>
                                <div class="col-md-12">
                                    <div class="check">
                                        <input type="checkbox" id="agree" name="agree" class="">
                                        <label class="form-label fw-bold d-inline" for="agree">I have read the <a
                                                class="nav-link d-inline-block" data-bs-toggle="modal"
                                                data-bs-target="#exampleModal">Terms & Conditions</a> of
                                            the programme & agree with them</label>
                                    </div>
                                    <div class="check mb-4">
                                        <input type="checkbox" id="second-agree" name="second-agree" class="">
                                        <label class="form-label fw-bold" for="second-agree"> I am taking this test on a computer, and not on a mobile device</label>
                                    </div>
                                </div>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 2.5rem;">
                <div class="col-md-5" style="align-self: flex-end;">
                    
                        <div class="sampQT">
                            <a style="padding: 0px; align-self: flex-end;" class="nav-link" data-bs-toggle="modal"
                                data-bs-target="#exampleModal1">Sample
                                Question</a>
                            <a style="padding: 0px; align-self: flex-end; padding-top: 2px;" class="nav-link d-inline-block"
                                data-bs-toggle="modal" data-bs-target="#exampleModal">Terms & Conditions</a>

                        </div>
                    
                </div>
                 <div class="col-lg-2"></div>
                <div class="col-md-5">
                    <div class="text-center">
                        <button type="submit" id="bttn" class="btn btn-success btn-linear-1" onclick="goForTest()" style="height: 60px;width: 250px;
                            font-weight: 600;">Proceed To
                            Test</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="footer-content text-center pt-5 mt-5">
                        <div>
                            <img class="brand-logo" src="assets/Website/assets/images/QCW-Logo.jpg" alt="">
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
   <input type="hidden" id="count" value="0">
<jsp:include page="../js.jsp"></jsp:include> 
  <script>
  
  $('#confirmemail').keyup(function(e) {
      var email = $("#email").val();
      var confirmemail = $(this).val();
      var length = confirmemail.length;
     var mail_length = email.substring(0,length);
     for(var i =0; i<mail_length.length;i++){
    	 if (confirmemail.charAt(i) == mail_length.charAt(i)){
    		 $('#emailerr').text('');
    	 }else{
    		  $('#emailerr').css('color','red');
    		  $('#emailerr').text('Enter Correct Email ID');
    	 }
     }
  });
  
  $(function () {

      $("form[name='login']").validate(
          {
              rules: {
                  name: {
                      required: true,
                  },
                  email: {
                      required: true,
                      email: true,

                  },
                  confirmemail: {
                      required: true,
                      equalTo: "#email",
                  },
                  school: {
                      required: true,
                  },
                  class: {
                      required: true,
                  },
                  section: {
                      required: true,
                  },
                  agree: {
                      required: true,
                  }

              },

              messages: {

                  name: {
                      required: "Please enter name",
                  },
                  email: {
                      required: "Please enter email",
                  },
                  confirmemail: {
                      required: "Enter Correct Email ID",
                      equalTo: "Enter Correct Email ID"
                  },
                  school: {
                      required: "Please Select school",
                  },
                  class: {
                      required: "Please Select class",
                  },
                  section: {
                      required: "Please Select section",
                  },
                  agree: {
                      required: "I agree"
                  },
                  errorPlacement: function (error, element) {
                      error.insertAfter(element);
                  },
              }
          });
  });
  
  
  
  
  $(".validate").change(function(){
	  if(this.value != "" && this.value!= null){
		  $(this).css('border-color', '#ced4da');
	  }
	});
  
  
  function goForTest() {
	  var ex = "";
		var count = $("#count").val();
		if(count > 0){
			for(var i=0; i<count; i++){
				var extra = $("#extra"+i).val();
				if(extra != null && extra != ""){
					if(i == 0){
						ex = extra;
					}else{
						ex += ","+extra;
					}
				}
			}
		}
	  var name = $("#name").val();
	  var a = $("#school").val();
	  var b = $("#className").val();
	  var section = $("#section").val();
	  var email = $("#email").val();
	  var reenteremail = $("#confirmemail").val();
	  if(name != null && name != ""){
		 if(a != null && a != ""){
			if(b != null && b != ""){
				if(section != null && section != ""){
					if(email != null && email != ""){
						if(reenteremail != null && reenteremail != ""){
							if( $("#agree").prop("checked") == true){
								if( $("#second-agree").prop("checked") == true){
									if(email == reenteremail){
									var mapForm = document.createElement("form");
									 // mapForm.target = "_blank";
									  mapForm.method = "POST";
									  mapForm.action = "test";
									  
									  var output = document.createElement("input");
									  output.type = "hidden";
									  output.name = "school_id";
									  output.value = a;
									  
									  var output1 = document.createElement("input");
									  output1.type = "hidden";
									  output1.name = "class_name";
									  output1.value = b;
									  
									  var output2 = document.createElement("input");
									  output2.type = "hidden";
									  output2.name = "name";
									  output2.value = name;
									 
									  var output3 = document.createElement("input");
									  output3.type = "hidden";
									  output3.name = "section";
									  output3.value = section;
									  
									  var output4 = document.createElement("input");
									  output4.type = "hidden";
									  output4.name = "email";
									  output4.value = email;
									  
									  var output5 = document.createElement("input");
									  output5.type = "hidden";
									  output5.name = "extra";
									  output5.value = ex;
									  
									  mapForm.appendChild(output);
									  mapForm.appendChild(output1);
									  mapForm.appendChild(output2);
									  mapForm.appendChild(output3);
									  mapForm.appendChild(output4);
									  mapForm.appendChild(output5);
									  
									  document.body.appendChild(mapForm);
									  mapForm.submit();
									 }else{
										 $("#reenteremail").css('border-color', 'red');
									 }
								}else{
									alert("Please checked Test with computer");
								}
							 }else{
								 alert("Please checked Terms and Condition");
							 }
						}else{
							 $("#reenteremail").css('border-color', 'red');
						}
					}else{
						 $("#email").css('border-color', 'red');
					}
				}else{
					 $("#section").css('border-color', 'red');
				}
			}else{
				 $("#className").css('border-color', 'red');
			}
		 } else{
			 $("#school").css('border-color', 'red');
		 }
	  }else{
		  $("#name").css('border-color', 'red');
	  }
	}

    </script>
</body>

</html>