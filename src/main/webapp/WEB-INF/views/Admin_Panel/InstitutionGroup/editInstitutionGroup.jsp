<!DOCTYPE html>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<%List<InstituitonGroup> data = (List<InstituitonGroup>)request.getAttribute("data"); %>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<a type="button" href="institution" class="btn btn-primary" >View Institution</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Institution Group</h4>
					<div class="card-content">
					<form id="institutionform" name="institutionform">
						<div class="row">
							<div class=col-md-6>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="instituteGroup">Institution Title</label>
											<input type="text" class="form-control" id="instituteGroup" name="instituteGroup" value="<%=data.get(0).getInstitution_group()%>" placeholder="">
										<input type="hidden" id="sno" name="sno" value="<%=data.get(0).getSno()%>">
										</div>
										<div class="form-group">
											<label for="institutionLogo">Upload Institution Logo</label>
											<input type="file" id="institutionLogo" name="institutionLogo" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
									</div>
									<div class="col-md-6">
										<%-- <img id="logoview" src="displaydocument?url=<%=data.get(0).getInstitution_group_logo()%>" height="130px;" width="150px;" style="margin-top: 30px" /> --%>
									</div>
								</div>
							</div>
							<div class=col-md-6>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="instituteSubtitle">Institution SubTitle</label>
											<input type="text" class="form-control" id="instituteSubtitle" name="instituteSubtitle" value="<%=data.get(0).getSub_title()%>" placeholder="">
										</div>
										<div class="form-group">
											<label for="backgroundImg">Upload Background Image</label>
											<input type="file" id="backgroundImg" name="backgroundImg" class="form-control" accept="image/png,image/jpeg" onchange="displayImages(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
									</div>
									<div class="col-md-6">
										<%-- <img id="background" src="displaydocument?url=<%=data.get(0).getBackground_image()%>" height="130px;" width="150px;" style="margin-top: 30px" /> --%>
									</div>
								</div>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="description" class="form-label" style="font-weight: 600">Description<span class="text-danger ">*</span></label>
								<%-- <textarea id="description" name="description"><%=data.get(0).getDescription()%></textarea> --%>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<div>
									<button type="submit" class="btn btn-primary" style="float: right;">Update</button>
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





	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	
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
			$("form[name='institutionform']").validate(

					{
						rules : {
							instituteGroup : {
								required : true,
							},
							instituteSubtitle : {
								required : true,
							},
							description : {
								required : function() {
									 CKEDITOR.instances.description.updateElement();
								}
							},
							
						},

						messages : {
														
							instituteGroup : {
								required : "Please Enter Institution Group Name",
							},														
							instituteSubtitle : {
								required : "Please Enter Subtitle"
							},
							description : {
								required : "Please Enter Description"
							},
							
							
						},

						submitHandler : function(form) {
							var sno = $("#sno").val();
							var instituteGroup = $("#instituteGroup").val();
							var institutionLogo = $("#institutionLogo")[0].files[0];
							var backgroundImg = $("#backgroundImg")[0].files[0];
							var instituteSubtitle = $("#instituteSubtitle").val();
							var description = CKEDITOR.instances['description'].getData();
							
							
							var obj = {};
							obj.sno = sno;
							obj.institution_group = instituteGroup;
							obj.sub_title = instituteSubtitle;
							obj.description = description;
							
							var fd = new FormData();
      						fd.append("institution_group_logo",institutionLogo),
      						fd.append("background_image", backgroundImg),
      						fd.append("institutiondata", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'update_group',
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
										setTimeout(function() {
										  parent.history.back();
										}, 2000);
									} else if(data['status'] == 'Already_Exist'){
										//$('#institution_model').modal('toggle');
										Swal.fire({
											icon : 'warning',
											title : 'Already!',
											text : data['message']
										})
									}
									else if(data['status'] == 'Failed'){
										$('#institution_model').modal('toggle');
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
	 
	
	</script>
</body>
</html>