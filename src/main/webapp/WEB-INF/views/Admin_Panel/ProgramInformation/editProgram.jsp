<!DOCTYPE html>
<%@page import="com.quillBolt.model.ProgramInformation"%>
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
List<ProgramInformation> data = (List<ProgramInformation>)request.getAttribute("data");
List<InstituitonGroup> data2 = (List<InstituitonGroup>)request.getAttribute("data2");
%>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<!-- <a type="button" href="viewSchool" class="btn btn-primary" >view Program Information</a> -->
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">Edit Program Information</h4>
					<div class="card-content">
					<form id="schoolform" name="schoolform">
						<div class="row">
							<div class=col-md-6>
								<div class="form-group">
									<label for="instituteGroup">Program Title</label>
									<input type="text" class="form-control" id="title" value="<%=data.get(0).getTitle() %>" name="title" placeholder="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="subtitle">Sub Title<span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="subtitle" value="<%=data.get(0).getSubTitle() %>" name="subtitle" placeholder="">
								</div>
							</div>
							<div class=col-md-12>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="programLogo">Upload Programs Logo<span class="text-danger">*</span></label>
											<input type="file" id="programLogo" name="programLogo" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
										
										<div class="form-group">
											<label for="group">Group<span class="text-danger">*</span></label>
											<select  id="group" name="group" class="form-control" onchange="getschoolData()">
											<option value="">Select Group</option>
											<%if(data2.size() > 0){
												for(int i=0; i < data2.size(); i++){%>
												<option value="<%=data2.get(i).getSno()%>" <%if(data2.get(i).getSno() == data.get(0).getInstitution_group_id()){ %>selected<%}%>><%=data2.get(i).getInstitution_group()%></option>
											<%}} %>
											</select>
										</div>
									</div>
									<div class="col-md-2">
										<img id="logoview" src="displaydocument?url=<%=data.get(0).getLogo()%>" height="130px;" width="150px;" style="margin-top: 30px" />
									</div>
									<div class="col-md-4" style="margin-top: 5px;">
										<label for="studentOf">Student Of<span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="studentOf" name="studentOf" value="<%=data.get(0).getStudentOf()%>">
										<label for="bgColor" style="margin-top: 10px;">Background Color<span class="text-danger">*</span></label>
										<input type="color" class="form-control" id="bgColor" name="bgColor" value="<%=data.get(0).getBgColor()%>">
									</div>
								</div>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
										<label for="class_name" class="form-label" style="font-weight: 600">School Name<span class="text-danger ">*</span></label><br>
										<select  id="school_name" name="school_name" class="form-control" >
										
										</select>
									</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="description" class="form-label" style="font-weight: 600">Body Description<span class="text-danger ">*</span></label>
								<textarea id="description" name="description"><%=data.get(0).getDescription() %></textarea>
							</div>
							</div>
							<div class="row">
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="termsCondition" class="form-label" style="font-weight: 600">Terms & Conditions<span class="text-danger ">*</span></label>
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
									<button type="button" class="btn btn-secondary" id="closeBtn" style="margin-left: 84%;">Close</button>
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
<input type="hidden" id="sno" value="<%=data.get(0).getSno()%>">
<input type="hidden" id="count" value="0">
<input type="hidden" id="schoolId" value="<%=data.get(0).getSchool_id()%>">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	$(document).ready(function() {
		var sno = $("#group").val();
		var schoolId = $("#schoolId").val();
		var school = schoolId.split(",");
		 var fd  = new FormData();
		 fd.append("institutionId",sno);
		 $.ajax({
			 	async:false,
				url : 'get_schooldata',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						  $('#school_name').attr('multiple','multiple');
						$("#school_name").empty();
						for (var i = 0; i < data['data'].length; i++) {
							 for(var j=0;j<school.length;j++){
								if(data['data'][i].sno == school[j]){ 
									console.log(data['data'][i].sno);
									$("#school_name").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].school_name+ "</option>");
								 }
							} 
							
						}
					
						/* $("#school_name").chosen("destroy").chosen({
					        max_selected_options: 12,
					        hide_results_on_select: false
					    }); */
					    getschoolData();
						$('#school_name').find('option').each(function() {
						    var $this = $(this);
						    for (var j = 0; j < school.length; j++) {
						        if ($this.val() == school[j]) {
						            $this.attr('selected', true);
						            $(this).val($this.val()).trigger("chosen:updated");
						        }
						    }
						});
					} 
				}
			});
	});
	function getschoolData() {
		 var sno = $("#group").val();
		 var fd  = new FormData();
		 fd.append("institutionId",sno);
		 $.ajax({
			 	async:false,
				url : 'get_schooldata',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						  $('#school_name').attr('multiple','multiple');
						$("#school_name").empty();
						for (var i = 0; i < data['data'].length; i++) {
							console.log( data['data'][i].school_name);
							$("#school_name").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].school_name+ "</option>");
						}
					
						$("#school_name").chosen("destroy").chosen({
					        max_selected_options: 12,
					        hide_results_on_select: false
					    });
							
					} 
				}
			});
		 
		}
	
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
							studentOf : {
								required : true,
							},
							bgColor : {
								required : true,
							},
							group : {
								required : true,
							},
							school_name : {
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
							studentOf : {
								required : "Please Enter Student of"
							},
							bgColor : {
								required : "Please Select Color"
							},
							group : {
								required : "Please Select Group"
							},
							school_name : {
								required : "Please Enter School Name"
							},
						},

						submitHandler : function(form) {
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
							
							var sno = $("#sno").val();
							var title = $("#title").val();
							var subtitle = $("#subtitle").val();
							var bgColor = $("#bgColor").val();
							var studentOf = $("#studentOf").val();
							var group = $("#group").val();
							var logo = $("#programLogo")[0].files[0];
							var description = CKEDITOR.instances['description'].getData();
							var schoolName = $("#school_name").val();
							var ss = "";
							for(var i=0; i < schoolName.length; i++){
								if(i == 0){
									ss = schoolName[i];
								}else{
									ss += ","+schoolName[i];
								}
							}
							
							var termsCondition = CKEDITOR.instances['termsCondition'].getData();
							
							
							
							var obj = {};
							obj.sno = sno;
							obj.institution_group_id = group;
							obj.school_id = ss;
							obj.title = title;
							obj.bgColor = bgColor;
							obj.studentOf = studentOf;
							obj.subTitle = subtitle;
							obj.description = description;
							obj.termsCondition = termsCondition;
							obj.extra = ex;
							var fd = new FormData();
      						fd.append("logo",logo),
      						fd.append("programdata", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'add_program',
	 							type : 'post',
	 							data : fd,
	 							contentType :  false,
	 							processData : false,
	 							success : function(data) {

	 								if (data['status'] == 'Success') {
	 									Swal.fire({
											icon : 'success',
											title : 'Successful!',
											text : data['message']
										})
										setTimeout(function() {
										    window.history.back();
										  }, 2000);
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
	
		
		$(function() {
			   $("#closeBtn").click(function() {
				   window.history.back();
			   });
			 });
	</script>
</body>
</html>