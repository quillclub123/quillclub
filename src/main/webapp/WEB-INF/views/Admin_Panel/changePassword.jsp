
<!DOCTYPE html>
<html lang="en">
<head>
	

	<title>Administrator | Login</title>
	 <jsp:include page="css.jsp"></jsp:include> 

</head>

<body>

<div id="single-wrapper">
	<form id="resetpass" name="resetpass" class="frm-single">
		<div class="inside">
			<div class="title"><strong>Quill Club Writers </strong></div>
			<!-- /.title -->
			<div class="frm-title">Reset Password</div>
			<!-- /.frm-title -->
			<!-- /.frm-input -->
			<div class="frm-input"><input type="text" placeholder="Current Password" id="currentpassword" name="currentpassword" class="frm-inp"><i class="fa fa-lock frm-ico"></i></div>
			<div class="frm-input"><input type="password" placeholder="New Password" id="newpassword" name="newpassword" class="frm-inp"><i class="fa fa-lock frm-ico"></i></div>
			<div class="frm-input"><input type="text" placeholder="Confirm Password" id="password" name="password" class="frm-inp"><i class="fa fa-lock frm-ico"></i></div>
			<!-- /.frm-input -->
			<div class="clearfix margin-bottom-20">
				<!-- <div class="pull-left">
					<div class="checkbox primary"><input type="checkbox" id="rememberme"><label for="rememberme">Remember me</label></div>
					/.checkbox
				</div> -->
				<!-- /.pull-left -->
				<div class="pull-right"><a href="Adminlogin" class="a-link"><i class="fa fa-unlock-alt"></i>Login</a></div>
				<!-- /.pull-right -->
			</div>
			
			<!-- /.clearfix -->
			<button type="submit" class="frm-submit">Reset<i class="fa fa-arrow-circle-right"></i></button>
			
		
			
			<div class="frm-footer">Lemniscate Technologies © 2023.</div>
			<!-- /.footer -->
		</div>
		<!-- .inside -->
	</form>
	
</div>
 <jsp:include page="js.jsp"></jsp:include> 
 
 <script>
 $(function() {
		$("form[name='resetpass']").validate(

				{
					rules : {
						currentpassword : {
							required : true,
						},
						newpassword : {
							required : true,
						},
						password : {
							required : true,
							 equalTo: "#newpassword",
						},
					},

					messages : {
													
						currentpassword : {
							required : "Please enter current password",
						},														
						newpassword : {
							required : "Please enter new password.",
						},
						password : {
							required : "Please enter confirm password.",
							equalTo: "Password does not match",
						},
					},

					submitHandler : function(form) {
						var currentpassword = $("#currentpassword").val();
						var password = $("#newpassword").val();
						var fd = new FormData();
						fd.append("currentpassword",currentpassword);
						fd.append("password",password);
						$.ajax({
							url : 'change_password',
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
										location.href = "Adminlogin";
										  }, 2000);
									
								} else if(data['status'] == 'Failure') {
									Swal.fire({
										icon : 'error',
										title : 'Invalid!',
										text : "Please enter valid current password"
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