<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('glob').classList.add('active');
	document.getElementById('glb').style.display = 'block';
	document.getElementById('mg').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<a type="button" href="viewgroup" class="btn btn-primary btn-xs" >view Groups</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">Add Group</h4>
					<div class="card-content">
					<form id="institutionform" name="institutionform">
						<div class="row">
							<div class=col-md-6>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="instituteGroup">Group Title</label>
											<input type="text" class="form-control" id="instituteGroup" name="instituteGroup" placeholder="">
										</div>
										<div class="form-group">
											<label for="institutionLogo">Upload Group Logo</label>
											<input type="file" id="institutionLogo" name="institutionLogo" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
									</div>
									<div class="col-md-6">
										<img id="logoview" height="130px;" width="150px;" style="margin-top: 30px; height: 130px; width: 150px;" />
									</div>
								</div>
							</div>
							<div class=col-md-6>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="instituteSubtitle">Group SubTitle</label>
											<input type="text" class="form-control" id="instituteSubtitle" name="instituteSubtitle" placeholder="">
										</div>
										<div class="form-group">
											<label for="backgroundImg">Upload Background Image</label>
											<input type="file" id="backgroundImg" name="backgroundImg" class="form-control" accept="image/png,image/jpeg" onchange="displayImages(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;" />
										</div>
									</div>
									<div class="col-md-6">
										<img id="background" height="130px;" width="150px;" style="margin-top: 30px;height: 130px; width: 150px;" />
									</div>
								</div>
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="description" class="form-label" style="font-weight: 600">Description<span class="text-danger ">*</span></label>
								<textarea id="description" name="description"></textarea>
							</div>
							<!-- <div class="col-md-12" style="margin-top: 20px;">
								<label for="termsCondition" class="form-label" style="font-weight: 600">Terms & Condition<span class="text-danger ">*</span></label>
								<textarea id="termsCondition" name="termsCondition"></textarea>
							</div> -->
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




<input type="hidden" id="sno" name="sno" value="0">
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
							
							description : {
								required : function() {
									 CKEDITOR.instances.description.updateElement();
								}
							},
						},

						messages : {
														
							instituteGroup : {
								required : "Please Enter Group Name",
							},
							
						},

						submitHandler : function(form) {
							var sno = $("#sno").val();
							var instituteGroup = $("#instituteGroup").val();
							var institutionLogo = $("#institutionLogo")[0].files[0];
							var backgroundImg = $("#backgroundImg")[0].files[0];
							var instituteSubtitle = $("#instituteSubtitle").val();
							var description = CKEDITOR.instances['description'].getData();
							
							if(sno==0){
							if(institutionLogo != "" && institutionLogo != null){
							var obj = {};
							obj.institution_group = instituteGroup;
							obj.sub_title = instituteSubtitle;
							obj.description = description;
							var fd = new FormData();
      						fd.append("institution_group_logo",institutionLogo),
      						fd.append("background_image", backgroundImg),
      						fd.append("institutiondata", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'add_group',
	 							type : 'post',
	 							data : fd,
	 							contentType :  false,
	 							processData : false,
	 							success : function(data) {

	 								if (data['status'] == 'Success') {
	 									$('#institutionTable').DataTable().ajax.reload( null, false );
	 									Swal.fire({
											icon : 'success',
											title : 'successfully!',
											text : data['message']
										})
										$('#institution_model').modal('toggle');
									
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
								}else{
									$("#validate").css("display","block")
								}
      						}else{
      							var fd = new FormData();
      							fd.append("sno",sno),
          						fd.append("institution_group_logo",institutionLogo),
          						fd.append("institution_group", instituteGroup),
      							$.ajax({
    	 							url : 'update_group',
    	 							type : 'post',
    	 							data : fd,
    	 							contentType :  false,
    	 							processData : false,
    	 							success : function(data) {

    	 								if (data['status'] == 'Success') {
    	 									$('#institutionTable').DataTable().ajax.reload( null, false );
    	 									Swal.fire({
    											icon : 'success',
    											title : 'successfully!',
    											text : data['message']
    										})
    										$('#institution_model').modal('toggle');
    									
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
								  title: 'Deleted successfully',
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