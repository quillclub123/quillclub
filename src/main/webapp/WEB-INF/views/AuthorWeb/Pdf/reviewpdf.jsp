<!doctype html>

<%@page import="java.util.List"%>
<%@page import="com.quillBolt.model.SelectedStudent"%>
<html lang="en">
<head>
<jsp:include page="../css.jsp"></jsp:include>

</head>
<body>
	<%
		SelectedStudent selc = (SelectedStudent)session.getAttribute("student_data");
	List<SelectedStudent> st = (List<SelectedStudent>)request.getAttribute("stt");
	%>
<input type="hidden" id="count" name="count" value="<%=st.get(0).getCount()%>">
	<div class="wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<div class="main-panel">
			<jsp:include page="../sidebar.jsp"></jsp:include>
			<script>
				document.getElementById('r_pdf').classList.add('active');
			</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">Editorial Review</h4>
								</div>
								<div class="row">
									<div class="col-md-6">
									 <%if(selc.getPdf() != null && !selc.getPdf().isEmpty()){
									 	 String pdfUrl = selc.getPdf();
									    String pdfName = selc.getName() + ".pdf";
									    %>
										<iframe src="your_pdf?url=<%=selc.getPdf()%>" width="100%" height="600px">
										    This browser does not support PDFs. Please download the PDF to view it: 
										   <a href="your_pdf?url=<%= pdfUrl %>" download="<%= pdfName %>"><%= pdfName %></a>
										</iframe>
									<%}else{ %>
									<p style="color: red;margin: 47px 10px;">PDF Not Available For Review</p>
									<%}%>
										
									</div>
									<div class="col-md-6">
										<div class="content">
											<form id="pdf_form" name="pdf_form">
											<input type="hidden" id="sno" name="sno" value="<%=selc.getSno()%>">
												<div class="row">
												<% if (selc.getPdf() != null && !selc.getPdf().isEmpty()) { 
												    String filename = selc.getName() + ".pdf"; 
												%>
												    <div class="col-md-12">
												        <a href="your_pdf?url=<%= selc.getPdf() %>" 
												           class="btn btn-success btn-fill btn-sm" 
												           download="<%= filename %>" style="margin-top: -30px;">Download PDF</a>
												        <div class="clearfix"></div>
												    </div>
												<% } %>
													<div class="col-md-12">
														<div class="form-group">
															<label>Upload PDF</label> <input type="file"
																class="form-control" id="pdf" name="pdf"
																accept="application/pdf" <%if(selc.getPdf() == null || selc.getPdf().isEmpty()) {%>disabled<%} %>>
														</div>
													</div>
													<div class="col-md-12">
														<button type="submit" id="sbmt"
															class="btn btn-primary btn-fill pull-right btn-sm" <%if(selc.getPdf() == null || selc.getPdf().isEmpty()) {%>disabled<%} %> style="margin-left: 15px;">Upload</button>
														<a href="javascript:void(0)" onclick="secondtime()" id="secondtime" class="pull-right" style="margin-top: 7px; display: none;">Upload a second time? </a>
														<div class="clearfix"></div>
													</div>
												</div>
												
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
		</div>
	</div>


</body>

<jsp:include page="../js.jsp"></jsp:include>
<script>
	let student_id = $("#student_id").val();
	let group_id = $("#group_id").val();
	let school_id = $("#school_id").val();
	let count = $("#count").val();
	$("#title").html("Your PDF");
	if(count == 1){
		$("#pdf").attr("disabled",true);
		$("#sbmt").attr("disabled",true);
		$("#sbmt").html("Uploaded");
		$("#secondtime").css("display","block");
	}
	if(count > 1){
		$("#secondtime").css("display","none");
		$("#pdf").attr("disabled",true);
		$("#sbmt").attr("disabled",true);
		$("#sbmt").html("Your file uploaded a second time");
	}
	function secondtime(){
		$("#pdf").attr("disabled",false);
		$("#sbmt").attr("disabled",false);
		$("#sbmt").html("Upload Again");
	}
	$(function() {
		$("form[name='pdf_form']").validate(
				{
					rules : {
						
						pdf : {
							required : true,
						},
					},

					messages : {
													
						
						pdf : {
							required : "Please choose PDF"
						},
						
					},
					submitHandler : function(form) {
						var sno = $("#sno").val();
						var pdf = $("#pdf")[0].files[0];
						
						var fd = new FormData();
						fd.append("sno",sno);
						fd.append("pdf",pdf);
						fd.append("type","Student");
						
						$.ajax({
							url : 'upload_pdf',
							type : 'post',
							data : fd,
							contentType :  false,
							processData : false,
							success : function(data) {
								if (data['status'] == 'Success') {
									//$('#sectionTable').DataTable().ajax.reload( null, false );
									Swal.fire({
									    icon: 'success',
									    title: 'Successfully!',
									    text: data['message']
									}).then(() => {
									    setTimeout(() => {
									        location.reload();
									    }, 500);
									});
									} 
									else if(data['status'] == 'Failed'){
										
									}
							}
						});

					}
				});

	});
</script>
</html>
