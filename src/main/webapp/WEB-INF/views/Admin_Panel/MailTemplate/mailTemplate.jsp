<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('testi').classList.add('active');
	document.getElementById('tst').style.display = 'block';
	document.getElementById('mmt').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<a type="button" href="mailTemplate" class="btn btn-primary btn-xs">View Mail Template</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">Add Mail Template</h4>
					<div class="card-content">
					<form id="mailTemplateform" name="mailTemplateform">
						<div class="row">
						<div class="col-md-12" style="margin-top: 20px;">
								<label for="subject" class="form-label" style="font-weight: 600">Subject<span class="text-danger ">*</span></label>
								<Input id="subject" class="form-control" name="subject">
					
							</div>
							<div class="col-md-12" style="margin-top: 20px;">
								<label for="mailTemplate" class="form-label" style="font-weight: 600">Message Body<span class="text-danger ">*</span></label>
								<textarea id="mailTemplate" name="mailTemplate"></textarea>
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
			$("form[name='mailTemplateform']").validate(

					{
						rules : {
							subject : {
								required : true,
							},
						},

						messages : {
							subject : {
								required : "Please Enter Subject",
							},
						},

						submitHandler : function(form) {
							debugger;
							var sno = $("#sno").val();
							var subject = $("#subject").val();
							var mailTemplate = CKEDITOR.instances['mailTemplate'].getData();
							
							 var obj = {
									 "sno" :sno,
									 "messageBody":mailTemplate,
									 "subject" :subject
									 
							 };
							$.ajax({
								url : 'add_mailTemplate',
								type : 'post',
								data : JSON.stringify(obj),
								dataType : 'json',
								contentType :  'application/json',
								success : function(data) {
									if (data['status'] == 'Success') {
										$('#mailTable').DataTable().ajax.reload( null, false );
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