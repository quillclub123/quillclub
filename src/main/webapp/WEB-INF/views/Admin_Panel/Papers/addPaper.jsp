<!DOCTYPE html>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	.fullQ:hover{
		 cursor: pointer;
	}
	</style>
</head>

<body>
<%List<Schools> data = (List<Schools>)request.getAttribute("data"); %>

<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
	<form id="paperform" name="paperform">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
				<div class="box-content card white" style="padding-bottom: 20px;">
					<div class="card-content">
						<div class="row">
						<div class="switch primary"><input type="checkbox"  id="switch-2" onclick="data()"><label  for="switch-2">Question With Image</label></div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="schoolName">School Name</label>
									<select class="form-control" id="schoolName" name="schoolName" onchange="getClassData()">
										<option value="">Select School Name</option>
										<%for(int i=0; i < data.size(); i++){ %>
											<option value="<%=data.get(i).getSno()%>"><%=data.get(i).getSchool_name()%></option>
										<%} %>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="className">Class Name</label>
									<select class="form-control" id="className" name="className"  onchange="data()">
										<option value="">Select Class</option>
									</select>
								</div>
							</div>
							</div>
					</div>
				</div>
			</div>
			<div class="col-lg-12 col-xs-12">
				<div class="box-content card white" style="padding-bottom: 20px;">
					<div class="card-content">
						<table id="questionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Select Question</th>
		                        <th class="text-white">Title</th>
		                        <th class="text-white">Question</th>
		                        <th class="text-white">Question Image</th>
		                      </tr>
		                  </thead>
		                 </table>
					</div>
				</div>
			</div>
		</div>
		</form>
		<jsp:include page="../footer.jsp"></jsp:include>
	</div>
</div>
<!-- Popup Model for Full Question -->

<div class="modal fade" id="question_full" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Question</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<p id="questionFull"></p>
						<img id="qqImg" style="height:100%; width: 100%; display: none;">
					</div>
				</div>
						
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm waves-effect waves-light" data-dismiss="modal">Close</button>
			</div>
			
		</div>
	</div>
</div>

<!-- Popup Model -->

<input type="hidden" id="sno" name="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	
	function getClassData() {
		data();
		 var sno = $("#schoolName").val();
		 var fd  = new FormData();
		 fd.append("schoolId",sno);
		 $.ajax({
			 	async:false,
				url : 'get_classdata',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						$("#className").empty();
						$("#className").append("<option value=''>Select Class</option>");
						for (var i = 0; i < data['data'].length; i++) {
							$("#className").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].classes+ "</option>");
							
						}
					} else{
						$("#className").empty();
						$("#className").append("<option value=''>Select Class</option>");
					}
				}
			});
		 
		}
	
	
	function data() {
		var imgdata = "off";
		if($('#switch-2').is(":checked") == true){
		 	imgdata = "on";
		}
		
		var schoolName= $("#schoolName").val();
		var className= $("#className").val();
		if(schoolName ==""){
			schoolName = 0;
		}
		if(className ==""){
			className = 0;
		}
		$("#questionTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				destroy : true,
				buttons : [ {
					extend : 'pageLength'
				} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_questionforPaper",
						type : "POST",
						"data" : {
							"school_id" : schoolName,
							"class_id" : className,
							"imgdata" : imgdata,
						},
						
					},
					columnDefs : [ {
						"defaultContent" : "-",
						"targets" : "_all"
					} ],
						serverSide : true,
					columns : [
						{
							"data":function(data,type,dataToSet){
								 var sno = data.sno;
								 var commonQuestion = data.commonQuestion;
								 if(commonQuestion == "on"){
									 return '<div class="switch primary"><input type="checkbox" checked name="qselected" onclick="savequestion('+sno+')" value="'+sno+'" id="switch-2'+sno+'"><label for="switch-2'+sno+'"></label></div>';
								 }else{
									 return '<div class="switch primary"><input type="checkbox" name="qselected" onclick="savequestion('+sno+')" value="'+sno+'" id="switch-2'+sno+'"><label for="switch-2'+sno+'"></label></div>';
								 }
								 
					        	
					       }
						},
						
						
					{
						"data" : "title"
					},
					{
		                "data": function (data,type,dataToSet) {
		                	var sno = data.sno;
		                	var question = data.question;
		                	let text = question.substring(0,50);
		                	var string = "<a class='fullQ'  id='question"+sno+"' onclick='fullQuestion("+sno+")'>"+text+".....</a>";
		 	                return string;
		                }
					},
					{
					"data":function(data,type,dataToSet){
			      		var imageName = data.question_image;
			      		if(imageName != null  && imageName != ""){
			      			return '<img src="displaydocument?url='+imageName+'" width="100" height="100"/>';
			      		}else{
			      			return "NA"
			      		}
			        	
			        }}
					],
					"lengthMenu" : [ [25, 50 ] , [25, 50 ] ],
					select : true
					});
					}
		data();
	
	 function savequestion(i){
		 var r = $("#switch-2" + i).prop("checked");
		 var schoolName= $("#schoolName").val();
		 var className= $("#className").val();
		if(schoolName !=null && schoolName != "" && className != null && className != ""){
		 if(r == true){
			 var question = $("#switch-2" + i).val();
			
				var obj ={};
				obj.school_id=schoolName;
				obj.class_id=className;
				obj.question=question;
				
				$.ajax({
					url : 'add_paper',
					type : 'post',
					data : JSON.stringify(obj),
					dataType : 'json',
					contentType :  'application/json',
					success : function(data) {
						if (data['status'] == 'Success') {
							 Swal.fire({
									icon : 'success',
									title : 'successfully!',
									text : data['message'],
									showConfirmButton: false,
									  timer: 1000
								})
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
				}else{
					 $("#switch-2" + i).prop("checked",true);
					Swal.fire({
						  title: 'Do you want to Unchecked Question?',
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
							  $("#switch-2" + i).prop("checked",false);
							  var q =  $("#switch-2" + i).val();
							  	console.log(sno);
							    console.log(status)
								var fd = new FormData();
					 			fd.append("question_id",i);
					 			fd.append("school_id",schoolName);
					 			fd.append("class_id",className);
							    
							    $.ajax({
							  		url : 'delete_paper',
							  		type : 'post',
							  		data : fd,
							  		contentType :  false,
							  		processData : false,
							  		success : function(data) {
							  			if (data['status'] == 'Success') {
										 Swal.fire({
											  icon: 'success',
											  title: 'Unchecked successfully',
											  showConfirmButton: false,
											  timer: 1500
											})
										}  
							  		}
							  	});
						   }
						});
				}
				
		 }else{
			 var q =$("#switch-2" + i).val();
			 
			 if(q != null && q != ""){
				 $("#switch-2" + i).prop("checked",true);
			 }else{
				 $("#switch-2" + i).prop("checked",false);
			 }
			
			 Swal.fire({
					icon : 'Sorry',
					title : 'Invalid!',
					text : "Please select School and Class!!!"
				})
		 }
		
	} 
	
	 $(function() {
			$("form[name='questionform']").validate(

					{
						rules : {
							title : {
								required : true,
							},
							editor : {
								required : true,
							},
						},

						messages : {
														
							title : {
								required : "Please Enter Question Title",
							},														
							editor : {
								required : "Please enter Question"
							}
							
						},

						submitHandler : function(form) {
							var sno = $("#sno").val();
							var title = $("#title").val();
							var question = CKEDITOR.instances['question'].getData();
							var questionImg = $("#questionImg")[0].files[0];
							
							var obj = {};
							obj.sno = sno;
							obj.title = title;
							obj.question = question;
							var fd = new FormData();
      						fd.append("question_image",questionImg),
      						fd.append("questions", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'add_question',
	 							type : 'post',
	 							data : fd,
	 							contentType :  false,
	 							processData : false,
	 							success : function(data) {

	 								if (data['status'] == 'Success') {
	 									$('#questionTable').DataTable().ajax.reload( null, false );
	 									Swal.fire({
											icon : 'success',
											title : 'successfully!',
											text : data['message']
										})
										$('#question_model').modal('toggle');
									
									} else if(data['status'] == 'Already_Exist'){
										//$('#institution_model').modal('toggle');
										Swal.fire({
											icon : 'warning',
											title : 'Already!',
											text : data['message']
										})
									}
									else if(data['status'] == 'Failed'){
										$('#question_model').modal('toggle');
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
			  title: 'Do you want to Delete Question?',
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
				  		url : 'delete_question',
				  		type : 'post',
				  		data : fd,
				  		contentType :  false,
				  		processData : false,
				  		success : function(data) {
				  			if (data['status'] == 'Success') {
								$('#questionTable').DataTable().ajax.reload( null, false );
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
				url : 'edit_question',
				type : 'post',
				data : fd,
				contentType :  false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						 $('#question_model').modal('toggle');
						 $("#title").val(data['data'][0].title);
						 CKEDITOR.instances['question'].setData(data['data'][0].question);
						 $("#dispImg").attr("src", "displaydocument?url="+data['data'][0].question_image+"");
						 if(data['data'][0].question_image != null && data['data'][0].question_image !=""){
							 $("#imageQ").show();
						     $("#qImg").show();
						     $("#switch-2").attr("checked",true);
						 }
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
		function fullQuestion(i){
			 $("#qqImg").css("display","none");
			var fd = new FormData();
			fd.append("sno",i);
			$.ajax({
				url : 'edit_question',
				type : 'post',
				data : fd,
				contentType :  false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						 $('#question_full').modal('toggle');
						 $("#questionFull").html(data['data'][0].question);
						 if(data['data'][0].questionImgType == "on"){
							 $("#qqImg").css("display","block");
							 $("#qqImg").attr("src", "displaydocument?url="+data['data'][0].question_image+"");
						 }
					} 
				}
			});
		}
	
	</script>
</body>
</html>