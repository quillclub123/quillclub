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
			 <a href="deletedClasses" class="btn btn-danger margin-bottom-10 waves-effect waves-light" >Deleted Classes</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Classes Details</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="classTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">School Name</th>
		                        <th class="text-white">Class</th>
		                      <!--   <th class="text-white">Action</th> -->
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

<div class="modal fade" id="class_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Add Class Details</h4>
			</div>
			<form id="classform" Name="classform">
			<div class="modal-body">
				<div class="form-group">
					<label for="instituteGroup">Institution Group</label>
					<select class="form-control" id="instituteGroup" name="instituteGroup" onchange="getschoolData()">
						<option value="">Select Institution Group</option>
						<%for(int i =0; i < data.size(); i++){ %>
							<option value="<%=data.get(i).getSno()%>"><%=data.get(i).getInstitution_group()%></option>
						<%} %>
					</select>
				</div>
				<div class="form-group">
					<label for="schoolname">School Name</label>
						<select class="form-control" id="schoolname" name="schoolname">
							<option value="">Select School Name</option>
					</select>
				</div>
				<div class="form-group">
					<label for="class">Class</label>
					<input type="text" class="form-control" id="className" name="className" placeholder="">
				</div>		
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm waves-effect waves-light" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary btn-sm waves-effect waves-light" style="float: right;">Save</button>
			</div>
			</form>
		</div>
	</div>
</div>

<input type="hidden" id="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	function getschoolData() {
		 var sno = $("#instituteGroup").val();
		 var fd  = new FormData();
		 fd.append("institutionId",sno);
		 $.ajax({
			 	async : false,
				url : 'get_schooldata',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						$("#schoolname").empty();
						$("#schoolname").append("<option value=''>Select School Name</option>");
						for (var i = 0; i < data['data'].length; i++) {
							$("#schoolname").append("<option value='"+data['data'][i].sno+"'>"+ data['data'][i].school_name+ "</option>");
						}
						
					} 
				}
			});
		 
		}
	

	
	function data() {
		$("#classTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2,3]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_class",
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
						"data" : "institution_group"
					},
					{
						"data" : "school_name"
					},
					{
						"data" : "classes"
					},
					/*  {
						"data" : function(data, type,
								dataToSet) {
								var sno = data.sno;
								var string = "<button class='btn btn-success  fa fa-pencil' type='button'  onclick='edit("+sno+")' style='height:30px;width:40px; line-height:0'></button>";
								// string += "<button class='btn btn-danger  fa fa-trash' type='button'  onclick='deletedata("+sno+")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								return string;
								}
							} */
					
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	
	
	$(function() {
		$("form[name='classform']").validate(
				{
					rules : {
						instituteGroup : {
							required : true,
						},
						schoolname : {
							required : true,
						},
						className : {
							required : true,
						},
						
					},

					messages : {
													
						instituteGroup : {
							required : "Please Select Institution Group",
						},														
						schoolname : {
							required : "Please enter school Name."
						},
						className : {
							required : "Please enter Class."
						},
					},

					submitHandler : function(form) {
						var sno = $("#sno").val();
						var instituteGroup = $("#instituteGroup").val();
						var className = $("#className").val();
						var schoolname = $("#schoolname").val();
						
						 var obj = {
								 "sno" :sno,
								 "institution_group_id":instituteGroup,
								 "school_id" :schoolname,
								 "classes" :className
						 };
						$.ajax({
							url : 'add_class',
							type : 'post',
							data : JSON.stringify(obj),
							dataType : 'json',
							contentType :  'application/json',
							success : function(data) {
								if (data['status'] == 'Success') {
									$('#classTable').DataTable().ajax.reload( null, false );
									 Swal.fire({
											icon : 'success',
											title : 'successfully!',
											text : data['message']
										})
										$('#class_model').modal('toggle');
									
									} else if(data['status'] == 'Already_Exist'){
										$('#class_model').modal('toggle');
										Swal.fire({
											icon : 'warning',
											title : 'Already!',
											text : data['message']
										})
									}
									else if(data['status'] == 'Failed'){
										$('#class_model').modal('toggle');
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
		  title: 'Do you want to Delete class Details?',
		  showDenyButton: true,
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
			  		url : 'delete_class',
			  		type : 'post',
			  		data : fd,
			  		contentType :  false,
			  		processData : false,
			  		success : function(data) {
			  			if (data['status'] == 'Success') {
							$('#classTable').DataTable().ajax.reload( null, false );
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
	
	function  edit(i){
		$("#sno").val(i);
		var fd = new FormData();
		fd.append("sno",i);
		$.ajax({
			url : 'edit_class',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				
				if (data['status'] == 'Success') {
					 $("#instituteGroup > option").each(function() {
							
						    if ($(this).val() ==  data['data'][0].institution_group_id) {
						    	$(this).prop("selected", "selected");
						   	 
						    }
						  
						
						});
					 getschoolData();
					 $('#class_model').modal('toggle');
					
					 $("#schoolname > option").each(function() {
						    if ($(this).val() ==  data['data'][0].school_id) {
						    	$(this).prop("selected", "selected");
						    }
						
						});
				
					$("#className").val(data['data'][0].classes);
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