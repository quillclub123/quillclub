<!DOCTYPE html>
<%@page import="com.quillBolt.model.Classes"%>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	#select_chosen{
		width: 100% !important;
	}
	.chosen-search-input{
		width: 100% !important;
		padding: 17px !important;
	}
	#selectclass_chosen{
	width: 100% !important;
	}
	</style>
</head>

<body>
<%
List<Schools> data = (List<Schools>)request.getAttribute("data");
List<Classes> data1 = (List<Classes>)request.getAttribute("data1");
String groupName = (String)request.getAttribute("groupName");
%>
<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('glob').classList.add('active');
	document.getElementById('glb').style.display = 'block';
	document.getElementById('ms').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<a type="button" href="viewSchool" class="btn btn-primary btn-xs" >view School</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">Add School</h4>
					<div class="card-content">
					<form id="schoolform" name="schoolform">
						<div class="row">
							<div class=col-md-6>
								<div class="form-group">
									<label for="instituteGroup">Program Information</label>
									<input type="text" class="form-control" id="title" value="<%=data.get(0).getTitle() %>" name="title" placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="subtitle">Sub Title</label>
									<input type="text" class="form-control" id="subtitle" value="<%=data.get(0).getSubTitle() %>" name="subtitle" placeholder="">
								</div>
							</div>
							<div class=col-md-12>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="schoolLogo">Upload School Logo</label>
											<input type="file" id="schoolLogo" name="schoolLogo" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
										
										<div class="form-group">
											<label for="group">Group</label>
											<select  id="group" name="group" class="form-control">
												<option value="<%=data.get(0).getInstitution_group_id()%>" selected><%=groupName%></option>
											</select>
										</div>
										<!-- <div class="form-group">
											<label for="backgroundImg">Upload Background Image</label>
											<input type="file" id="backgroundImg" name="backgroundImg" class="form-control" accept="image/png,image/jpeg" onchange="displayImages(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div> -->
									</div>
									<div class="col-md-6">
										<img id="logoview" src="displaydocument?url=<%=data.get(0).getLogo()%>" height="130px;" width="150px;" style="margin-top: 30px" />
										<!-- <img id="background" height="130px;" width="150px;" style="margin-top: 30px" /> -->
									</div>
								</div>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="description" class="form-label" style="font-weight: 600">Description<span class="text-danger ">*</span></label>
								<textarea id="description" name="description"><%=data.get(0).getDescription()%></textarea>
							</div>
							<div class="col-md-6" style="margin-top: 20px;">
								<label for="schoolName" class="form-label" style="font-weight: 600">School Name<span class="text-danger ">*</span></label>
								<input type="text" class="form-control" id="schoolName" value="<%=data.get(0).getSchool_name() %>" name="schoolName">
							</div>
							<div class="col-md-6" style="margin-top: 20px;">
								<label for="class_name" class="form-label" style="font-weight: 600">Classes<span class="text-danger ">*</span></label><br>
								<select  id="select_class" name="class_name" class="form-control"  multiple="multiple" disabled>
								<%for(int i=0; i< data1.size(); i++){ %>
									<option value="1" <%if(data1.get(i).getClasses().equals("1")){%>selected<%} %>>1</option>
									<option value="2" <%if(data1.get(i).getClasses().equals("2")){%>selected<%} %>>2</option>
									<option value="3" <%if(data1.get(i).getClasses().equals("3")){%>selected<%} %>>3</option>
									<option value="4" <%if(data1.get(i).getClasses().equals("4")){%>selected<%} %>>4</option>
									<option value="5" <%if(data1.get(i).getClasses().equals("5")){%>selected<%} %>>5</option>
									<option value="6" <%if(data1.get(i).getClasses().equals("6")){%>selected<%} %>>6</option>
									<option value="7" <%if(data1.get(i).getClasses().equals("7")){%>selected<%} %>>7</option>
									<option value="8" <%if(data1.get(i).getClasses().equals("8")){%>selected<%} %>>8</option>
									<option value="9" <%if(data1.get(i).getClasses().equals("9")){%>selected<%} %>>9</option>
									<option value="10" <%if(data1.get(i).getClasses().equals("10")){%>selected<%} %>>10</option>
									<option value="11" <%if(data1.get(i).getClasses().equals("11")){%>selected<%} %>>11</option>
									<option value="12" <%if(data1.get(i).getClasses().equals("12")){%>selected<%} %>>12</option>
								<%} %>
									
								</select>
							</div></div>
							<div class="row">
							<div class="col-md-6" style="margin-top: 20px;">
								<label for="state" class="form-label" style="font-weight: 600">State<span class="text-danger ">*</span></label>
								<input type="text" class="form-control" id="state" name="state" value="<%=data.get(0).getState() %>">
							</div>
							<div class="col-md-6" style="margin-top: 20px;">
								<label for="city" class="form-label" style="font-weight: 600">City<span class="text-danger ">*</span></label>
								<input type="text" class="form-control" id="city" name="city" value="<%=data.get(0).getCity() %>">
							</div>
							<div class="col-md-6" style="margin-top: 20px;">
								<label for="location" class="form-label" style="font-weight: 600">Location<span class="text-danger ">*</span></label>
								<input type="text" class="form-control" id="location" name="location" value="<%=data.get(0).getLocation() %>">
							</div>
							<div class="col-md-6" style="margin-top: 58px;">
								<div class="switch primary"><input type="checkbox" <%for(int j = 0; j <data1.size(); j++){if(data1.get(j).getImageType().equalsIgnoreCase("on")){ %>checked<%break;}} %>  id="switch-2"><label for="switch-2">Classes For Question Image</label></div>
							</div>
							</div>
							<div class="row">
							<div id="clsss" class="col-md-6" style="margin-top: 20px; display: none;">
								<label for="class_name" class="form-label" style="font-weight: 600">Select Classes for assign Image Question<span class="text-danger ">*</span></label><br>
								<select  id="selectclass" name="class_name" class="form-control"  multiple="multiple">
									<%for(int i=0; i< data1.size(); i++){ %>
									<option value="<%=data1.get(i).getClasses() %>" <%if(data1.get(i).getImageType().equals("on")){%>selected<%} %>><%=data1.get(i).getClasses() %></option>
									<%-- <option value="1" <%if(data1.get(i).getClasses().equals("1") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>1</option>
									<option value="2" <%if(data1.get(i).getClasses().equals("2") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>2</option>
									<option value="3" <%if(data1.get(i).getClasses().equals("3") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>3</option>
									<option value="4" <%if(data1.get(i).getClasses().equals("4") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>4</option>
									<option value="5" <%if(data1.get(i).getClasses().equals("5") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>5</option>
									<option value="6" <%if(data1.get(i).getClasses().equals("6") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>6</option>
									<option value="7" <%if(data1.get(i).getClasses().equals("7") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>7</option>
									<option value="8" <%if(data1.get(i).getClasses().equals("8") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>8</option>
									<option value="9" <%if(data1.get(i).getClasses().equals("9") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>9</option>
									<option value="10" <%if(data1.get(i).getClasses().equals("10") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>10</option>
									<option value="11" <%if(data1.get(i).getClasses().equals("11") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>11</option>
									<option value="12" <%if(data1.get(i).getClasses().equals("12") && data1.get(i).getImageType().equals("on")){%>selected<%} %>>12</option> --%>
								<%} %>
									
								</select>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="termsCondition" class="form-label" style="font-weight: 600">Terms & Condition<span class="text-danger ">*</span></label>
								<textarea id="termsCondition" name="termsCondition"><%=data.get(0).getTermsCondition() %></textarea>
							</div>
							<div class="col-lg-6">
								<button class="btn add_field_button" style="margin-top: 30px; width: 100%">Add More Fields</button>
							</div>
							<div class="col-lg-12">
							<div class="form-group">
							<div class=" row input_fields_wrap">
							</div>
							</div>
						</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<div>
									<button type="submit" class="btn btn-primary" style="float: right;">Submit</button>
								</div>
							</div>
					</div>
				</form>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
</div>




<input type="hidden" id="sno" name="sno" value="<%=data.get(0).getSno()%>">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	$(document).ready(function(){
		  $(".chosen-search-input").val("Select Classes");
	});
	$(document).ready(function(){
		if ($("#switch-2").is(":checked")) {
		       $("#clsss").show();
		     } else {
		       $("#clsss").hide();
		     }
	});
	
	$(function() {
		   $("#switch-2").click(function() {
		     if ($("#switch-2").is(":checked")) {
		       $("#clsss").show();
		     } else {
		       $("#clsss").hide();
		     }
		   });
		 });
	
	$(document).ready(function() {
		var max_fields      = 11; 
		var wrapper   		= $(".input_fields_wrap"); 
		var add_button      = $(".add_field_button"); 
		
		var x = 1; 
		$(add_button).click(function(e){ 
			e.preventDefault();
			if(x < max_fields){ 
				x++; 
				$("#count").val(x);
				$(wrapper).append('<div class="col-md-6"><input type="text" id="extra'+x+'" class="form-control" name="mytext[]" style="margin-top:15px;"/><a href="#" class="remove_field" style="color:red;">Remove</a></div>'); //add input box
			}
		});
		
		$(wrapper).on("click",".remove_field", function(e){
			e.preventDefault(); $(this).parent('div').remove(); x--;
		})
	});
	function displayImage(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('logoview').src = e.target.result;
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		}
	function displayImages(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('background').src = e.target.result;
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		}
	
	 $(function() {
			$("form[name='schoolform']").validate(

					{
						rules : {
							title : {
								required : true,
							},
							subtitle : {
								required : true,
							},
							group : {
								required : true,
							},
							schoolName : {
								required : true,
							},
							state : {
								required : true,
							},
							city : {
								required : true,
							},
							location : {
								required : true,
							},
							
							description : {
								required : function() {
									 CKEDITOR.instances.description.updateElement();
								}
							},
						},

						messages : {
														
							title : {
								required : "Please Enter Program Information",
							},
							subtitle : {
								required : "Please Enter Sub title"
							},
							group : {
								required : "Please Select Group"
							},
							schoolName : {
								required : "Please Enter School Name"
							},
							state : {
								required : "Please Enter State"
							},
							city : {
								required : "Please Enter City"
							},
							location : {
								required : "Please Enter Location"
							},
							
						},

						submitHandler : function(form) {
							debugger;
							var sno = $("#sno").val();
							var ex = "";
							var count = $("#count").val();
							if(count > 0){
								for(var i=2; i<=count; i++){
									var extra = $("#extra"+i).val();
									if(extra != null && extra != ""){
										if(i == 2){
											ex = extra;
										}else{
											ex += ","+extra;
										}
									}
								}
							}
							var title = $("#title").val();
							var subtitle = $("#subtitle").val();
							var group = $("#group").val();
							var logo = $("#schoolLogo")[0].files[0];
							var description = CKEDITOR.instances['description'].getData();
							var schoolName = $("#schoolName").val();
							var select_class = $("#select_class").val();
							var selectclass = $("#selectclass").val();
							var state = $("#state").val();
							var city = $("#city").val();
							var location = $("#location").val();
							var selectclass = $("#selectclass").val();
							var termsCondition = CKEDITOR.instances['termsCondition'].getData();
							var obj = {};
							obj.sno = sno;
							obj.institution_group_id = group;
							obj.title = title;
							obj.subTitle = subtitle;
							obj.select_classes = select_class;
							obj.imgClasses = selectclass;
							obj.state = state;
							obj.school_name = schoolName;
							obj.city = city;
							obj.location = location;
							obj.description = description;
							obj.termsCondition = termsCondition;
							obj.extra = ex;
							var fd = new FormData();
      						fd.append("logo",logo),
      						fd.append("schooldata", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'update_school',
	 							type : 'post',
	 							data : fd,
	 							contentType :  false,
	 							processData : false,
	 							success : function(data) {

	 								if (data['status'] == 'Success') {
	 									Swal.fire({
											icon : 'success',
											title : 'successfully!',
											text : data['message']
										})
										$(location).attr('href',viewSchool);
									} else if(data['status'] == 'Already_Exist'){
										
										Swal.fire({
											icon : 'warning',
											title : 'Already!',
											text : data['message']
										})
									}
									else if(data['status'] == 'Failed'){
										Swal.fire({
											icon : 'Sorry',
											title : 'Invalid!',
											text : data['message']
										})
									}
	 							}
	 						});
						}
					});

		});
	 
	 function deletedata(sno)
		{	 
		 Swal.fire({
			  title: 'Do you want to Delete Institution Group?',
			  showDenyButton: true,
			  //showCancelButton: true,
			  confirmButtonText: 'Yes',
			  denyButtonText: 'No',
			  customClass: {
			    actions: 'my-actions',
			    cancelButton: 'order-1 right-gap',
			    confirmButton: 'order-2',
			    denyButton: 'order-3',
			  }
			}).then((result) => {
			  if (result.isConfirmed) {
				 
				  	console.log(sno);
				    console.log(status)
					var fd = new FormData();
		 			fd.append("sno",sno);
				    
				    $.ajax({
				  		url : 'delete_group',
				  		type : 'post',
				  		data : fd,
				  		contentType :  false,
				  		processData : false,
				  		success : function(data) {
				  			if (data['status'] == 'Success') {
								$('#institutionTable').DataTable().ajax.reload( null, false );
							 Swal.fire({
								  icon: 'success',
								  title: 'Delete successfully',
								  showConfirmButton: false,
								  timer: 1500
								})
							}  
				  		}
				  	});
			   }
			});
		}; 
		
		function edit(i){
			$("#sno").val(i);
			var fd = new FormData();
			fd.append("sno",i);
			$.ajax({
				url : 'edit_group',
				type : 'post',
				data : fd,
				contentType :  false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						 $('#institution_model').modal('toggle');
						 $("#instituteGroup").val(data['data'][0].institution_group);
						 $("#logoview").attr("src", "displaydocument?url="+data['data'][0].institution_group_logo+"");
					} else {
						Swal.fire({
							icon : 'Opps',
							title : 'Warning!',
							text : 'Invalid Details'
						})
					}
				}
			});
			
			 
		}
	
	</script>
</body>
</html>