
<!DOCTYPE html>
<html lang="en">
<head>
	

	<title>Administrator | Login</title>
	 <jsp:include page="css.jsp"></jsp:include> 

</head>

<body>

<div id="single-wrapper">
	<form action="dashboard" id="login" name ="login" class="frm-single" method="POST">
		<div class="inside">
			<div class="title"><strong>Quill Club Writers </strong></div>
			<!-- /.title -->
			<div class="frm-title">Login</div>
			<!-- /.frm-title -->
			<div class="frm-input"><input type="text" placeholder="Username or Email" id="email" name="email" class="frm-inp"><i class="fa fa-user frm-ico"></i></div>
			<!-- /.frm-input -->
			<div class="frm-input"><input type="password" placeholder="Password" id="password" name="password" class="frm-inp"><i class="fa fa-lock frm-ico"></i></div>
			<!-- /.frm-input -->
			<div class="clearfix margin-bottom-20">
				<div class="pull-left">
					<div class="checkbox primary"><input type="checkbox" id="rememberme"><label for="rememberme">Remember me</label></div>
					<!-- /.checkbox -->
				</div>
				<!-- /.pull-left -->
				<div class="pull-right"><a href="change_password" class="a-link"><i class="fa fa-unlock-alt"></i>Change password?</a></div>
				<!-- /.pull-right -->
			</div>
			<!-- /.clearfix -->
			<button type="submit" class="frm-submit">Login<i class="fa fa-arrow-circle-right"></i></button>
			
		
			
			<div class="frm-footer">Lemniscate Technologies © 2023.</div>
			<!-- /.footer -->
		</div>
		<!-- .inside -->
	</form>
	
</div>
 <jsp:include page="js.jsp"></jsp:include> 
 
 <script>
 $(function() {
		$("form[name='login']").validate(

				{
					rules : {
						email : {
							required : true,
						},
						password : {
							required : true,
						}
					},

					messages : {
													
						email : {
							required : "Please select email",
						},														
						password : {
							required : "Please enter password."
						}
					},

					submitHandler : function(form) {
						var email = $("#email").val();
						var password = $("#password").val();
						var fd = new FormData();
						fd.append("email",email);
						fd.append("password",password);
						$.ajax({
							url : 'checklogin',
							type : 'post',
							data : fd,
							contentType :  false,
							processData : false,
							success : function(data) {

								if (data['status'] == 'Success') {
								form.submit();
								} else {
									Swal.fire({
										icon : 'error',
										title : 'Invalid!',
										text : "Invalid Username/Email or Password"
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