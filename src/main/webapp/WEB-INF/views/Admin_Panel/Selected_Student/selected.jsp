<!DOCTYPE html>

<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<jsp:include page="../css.jsp"></jsp:include>
<style>
.error {
	padding: 0 !important;
}
</style>
</head>

<body>
	<%
	List<InstituitonGroup> data = (List<InstituitonGroup>) request.getAttribute("data");
	%>

	<jsp:include page="../header.jsp"></jsp:include>
	<script>
	document.getElementById('writ').classList.add('active');
	document.getElementById('wrt').style.display = 'block';
	document.getElementById('ss').classList.add('sidecolor');
</script>
	<div id="wrapper">
		<div class="main-content">
			<div class="row small-spacing">
				<div class="col-lg-12 col-xs-12">
					<button type="button" id="clear_btn"
						class="btn btn-primary btn-xs waves-effect waves-light"
						data-toggle="modal" data-target="#school_model">Add
						Selected Student</button>
						<a href="assets/Students-List.xlsx" download>
						    <button type="button" class="btn btn-success btn-xs">Download Excel Format</button>
						</a>
					<div class="box-content card white" style="padding-bottom: 20px;">
						<h4 class="box-title">Selected Students</h4>
						<div style="padding: 7px 23px;">
							<form id="sectionform" Name="sectionform">
								<div class="row small-spacing">
									<div class="col-lg-6 col-xs-12">
										<div class="form-group">
											<label for="group_name">Group<span
												class="text-danger">*</span></label> <select class="form-control"
												id="group_name" name="group_name"
												onchange="getschooldata()">
												<option value="">Select Group</option>
												<%
												for (int i = 0; i < data.size(); i++) {
												%>
												<option value="<%=data.get(i).getSno()%>"><%=data.get(i).getInstitution_group()%></option>
												<%
												}
												%>
											</select>
										</div>
									</div>
									<div class="col-lg-6 col-xs-12">
										<div class="form-group">
											<label for="class_name" class="form-label"
												style="font-weight: 600">School Name<span
												class="text-danger ">*</span></label><br> <select
												id="schoolname" name="schoolname" class="form-control" onchange="getselectedstudent()">
												<option disabled selected>Select School</option>
											</select>

										</div>
									</div>
								</div>
							</form>
						</div>
						<!-- /.box-title -->
						<div class="card-content">
							<table id="schoolTable"
								class="table table-striped table-bordered display dataTable"
								style="width: 102%; overflow: hidden;">
								<thead class="bg-primary">
									<tr>
										<th class="text-white">No</th>
										<th class="text-white">Student ID</th>
										<th class="text-white">Password</th>
										<th class="text-white">Name</th>
										<th class="text-white">Class</th>
										<th class="text-white">Section</th>
										<th class="text-white">status</th>
										<!-- <th class="text-white">Action</th> -->
									</tr>
								</thead>
							</table>
						</div>
						<!-- /.card-content -->
					</div>
					<!-- /.box-content -->
				</div>

			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
		</div>
	</div>

	<!-- Popup Model -->

	<div class="modal fade" id="school_model" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content modal-lg">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Add Selected Students</h4>
				</div>
				<form id="schoolform" Name="schoolform">
					<div class="modal-body">
						<div class="form-group">
							<label for="instituteGroup">Group<span
								class="text-danger">*</span></label> <select class="form-control"
								id="instituteGroup" name="instituteGroup"
								onchange="getschoolData()">
								<option value="">Select Group</option>
								<%
								for (int i = 0; i < data.size(); i++) {
								%>
								<option value="<%=data.get(i).getSno()%>"><%=data.get(i).getInstitution_group()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="class_name" class="form-label"
								style="font-weight: 600">School Name<span
								class="text-danger ">*</span></label><br> <select id="school_name"
								name="school_name" class="form-control">
								<option disabled selected>Select School</option>
							</select>

						</div>
						<div class="form-group">
							<label for="attachment">Upload List<span class="text-danger">*</span></label>
							<input type="file" class="form-control" id="attachment" name="attachment" accept=".xls,.xlsx">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button"
							class="btn btn-default btn-sm waves-effect waves-light"
							data-dismiss="modal">Close</button>
						<button type="submit"
							class="btn btn-primary btn-sm waves-effect waves-light"
							style="float: right;">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<input type="hidden" id="count" value="0">
	<input type="hidden" id="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>

	<script>
	function getschooldata(){
		 var sno = $("#group_name").val();
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
						$('#schoolname').empty();
						$("#schoolname").append("<option disabled selected>Select School</option>");
						for (var i = 0; i < data['data'].length; i++) {
							$("#schoolname").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].school_name+' '+data['data'][i].branch+"</option>");
						}
					}
				}
			});
		 
		}
	function getschoolData() {
		 var sno = $("#instituteGroup").val();
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
						$('#school_name').empty();
						$("#school_name").append("<option disabled selected>Select School</option>");
						for (var i = 0; i < data['data'].length; i++) {
							$("#school_name").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].school_name+' '+data['data'][i].branch+"</option>");
						}
					}
				}
			});
		 
		}
	
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
	function getselectedstudent(){
		var group_id = $("#group_name").val();
		var school_id = $("#schoolname").val();
		var schoolName = $("#schoolname option:selected").text();
		$("#schoolTable").DataTable({
			 dom : "Blfrtip",
			 destroy : true,
			 autoWidth : false,
			 responsive : true,
			 buttons: [{
	                extend: 'pdf',
	                exportOptions: {
	                    columns: [0, 1, 2, 3, 4, 5, 6]  // Include the school_name column
	                },
	                filename: function() {
	                    return schoolName;  // Set the filename as the school name
	                }
	            },
	            {
	                extend: 'csv',
	                exportOptions: {
	                    columns: [0, 1, 2, 3, 4, 5, 6]  // Include the school_name column
	                },
	                filename: function() {
	                    return schoolName;  // Set the filename as the school name
	                }
	            },
	            {
	                extend: 'print',
	                exportOptions: {
	                    columns: [0, 1, 2, 3, 4, 5, 6]  // Include the school_name column
	                }
	            },
	            {
	                extend: 'excel',
	                exportOptions: {
	                    columns: [0, 1, 2, 3, 4, 5, 6]  // Include the school_name column
	                },
	                filename: function() {
	                    return schoolName;  // Set the filename as the school name
	                }
	            },
	            {
	                extend: 'pageLength'
	            }
	        ],
				lengthChange : false,
				ordering : false,
				scrollX : false,
				ajax : {
					url : "get_selected_students",
					type : "POST",
					"data" : {
						"group_id" : group_id,
						"school_id" : school_id,
					}
				},
				columnDefs : [ {
					"defaultContent" : "-",
					"targets" : "_all"
				} ],
					serverSide : true,
				columns : [
					{data: 'SrNo',
				           render: function (data, type, row, meta) {
				                return meta.row + meta.settings._iDisplayStart + 1;
				           }
				        },
				{
					"data" : "student_id"
				},
				{
					"data" : "password"
				},
				{
					"data" : "name"
				},
				{
	                "data": function (data,type,dataToSet) {
	                	var cname = parseInt(data.class_name);
	                	return cname;
	                   
	                }
				},
				{
					"data" : "section"
				},
				{
	                "data": function (data,type,dataToSet) {
	                	var sno = data.sno;
	                	var status = data.status;
	                	var string="";
	                	if(status=="Active"){
	                		 string = "<span class='badge bg-success font-weight-bold p-1' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>"+status+"</span>"
	 	                    return string;
	                	}else if(status=="Deactive"){
	                		string = "<span class='badge bg-danger font-weight-bold' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>"+status+"</span>"
	 	                    return string;
	                	}
	                   
	                }
				},
					
				],
				"lengthMenu" : [ [-1 ], ["All" ] ],
				select : true
				});
	}
	
	/* function data() {
		$("#schoolTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2,3,4,5,6]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_selected_students",
						type : "POST",
						
					},
					columnDefs : [ {
						"defaultContent" : "-",
						"targets" : "_all"
					} ],
						serverSide : true,
					columns : [
						{data: 'SrNo',
					           render: function (data, type, row, meta) {
					                return meta.row + meta.settings._iDisplayStart + 1;
					           }
					        },
					{
						"data" : "student_id"
					},
					{
						"data" : "password"
					},
					{
						"data" : "group_name"
					},
					{
						"data" : "school_name"
					},
					{
						"data" : "name"
					},
					{
		                "data": function (data,type,dataToSet) {
		                	var cname = parseInt(data.class_name);
		                	return cname;
		                   
		                }
					},
					{
						"data" : "section"
					},
					{
		                "data": function (data,type,dataToSet) {
		                	var sno = data.sno;
		                	var status = data.status;
		                	var string="";
		                	if(status=="Active"){
		                		 string = "<span class='badge bg-success font-weight-bold p-1' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>"+status+"</span>"
		 	                    return string;
		                	}else if(status=="Deactive"){
		                		string = "<span class='badge bg-danger font-weight-bold' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>"+status+"</span>"
		 	                    return string;
		                	}
		                   
		                }
					},
				    /* {
						"data" : function(data, type,
								dataToSet) {
								var sno = data.sno;
								var status = data.status;
								var string = "";
								 if(status == "Active"){
									    string = "<button class='btn btn-danger  fa fa-times' type='button'  onclick='updateStatus("+sno+",\"Deactive\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
									 }else{
										 string = "<button class='btn btn-success fa fa-check' type='button'  onclick='updateStatus("+sno+",\"Active\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
									 }
									 return string;
									}
								} 
					], 
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data(); */
	
	
	$(function() {
		$("form[name='schoolform']").validate(
				{
					rules : {
						instituteGroup : {
							required : true,
						},
						school_name : {
							required : true,
						},
						attachment : {
							required : true,
						},
					},

					messages : {
													
						instituteGroup : {
							required : "Please Select Institution Group",
						},														
						school_name : {
							required : "Please Select School Name."
						},
						attachment : {
							required : "Please upload Students List."
						}
					},

					submitHandler : function(form) {
						var instituteGroup = $("#instituteGroup").val();
						var schoolName = $("#school_name").val();
						var attachment = $("#attachment")[0].files[0];
						var fd  = new FormData();
						fd.append("group_id",instituteGroup);
						fd.append("school_id",schoolName);
						fd.append("attechment",attachment);
						$.ajax({
							url : 'add_selected_students',
							type : 'post',
							data : fd,
							contentType :  false,
 							processData : false,
							success : function(data) {
								if (data['status'] == 'Success') {
									$('#schoolTable').DataTable().ajax.reload( null, false );
									 Swal.fire({
											icon : 'success',
											title : 'Successful!',
											text : data['message']
										})
										$('#school_model').modal('toggle');
									
									} else if(data['status'] == 'Already_Exist'){
										$('#school_model').modal('toggle');
										Swal.fire({
											icon : 'warning',
											title : 'Already!',
											text : data['message']
										})
									}
									else if(data['status'] == 'Failed'){
										$('#school_model').modal('toggle');
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
		  title: 'Do you want to Delete School Details?',
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
			  		url : 'delete_school',
			  		type : 'post',
			  		data : fd,
			  		contentType :  false,
			  		processData : false,
			  		success : function(data) {
			  			if (data['status'] == 'Success') {
							$('#schoolTable').DataTable().ajax.reload( null, false );
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
	function updateStatus(sno,status)
    {	 
     Swal.fire({
    	  title: 'Do you want to change the status?',
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
    			var fd = {
    		    	"sno":sno,
    		    	"status":status.trim(),	
    		    	};					
    			$.ajax({
    				url : 'updateschooldata', //add  Course  controller name AdminController
    				type : 'post',
    				data : JSON.stringify(fd),
    				contentType : 'application/json',
    				dataType : 'json',
    				success : function(data) {
    					if (data['status'] == 'Success') {
    					 $('#schoolTable').DataTable().ajax.reload( null, false );								
    						Swal.fire({
    							icon : 'success',
    							title : 'Status Updated!',
    							text : 'Status updated succesfully'
    						})
    					}  
    				}
    			});
    	  
    	   }
    	});
    }; 
	$("#clear_btn").click(function() {
		$("#instituteGroup > option").prop("selected", false);
        $("input[type='text']").val("");
        $("input[type='hidden']").val("0");
      });
	</script>
</body>
</html>