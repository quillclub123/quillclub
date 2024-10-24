<!DOCTYPE html>

<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
		.error{
			padding: 0 !important;
		}
	</style>
</head>

<body>
<%List<InstituitonGroup> data = (List<InstituitonGroup>)request.getAttribute("data"); %>

<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('glob').classList.add('active');
	document.getElementById('glb').style.display = 'block';
	document.getElementById('ms').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<button type="button" id="clear_btn" class="btn btn-primary btn-xs waves-effect waves-light" data-toggle="modal" data-target="#school_model">Add School</button>
			<a type="button" href="viewDeletedSchool" class="btn btn-danger btn-xs">Deleted Schools</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Schools</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="schoolTable" class="table table-striped table-bordered display dataTable" style="width:102%;overflow: hidden;">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">School</th>
		                        <th class="text-white">State</th>
		                        <th class="text-white">City</th>
		                        <th class="text-white">Location</th>
		                        <th class="text-white">Branch</th>
		                        <th class="text-white">status</th>
		                        <th class="text-white">Action</th>
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

<div class="modal fade" id="school_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Add School</h4>
			</div>
			<form id="schoolform" Name="schoolform">
			<div class="modal-body">
				<div class="form-group">
					<label for="instituteGroup">Group<span class="text-danger">*</span></label>
					<select class="form-control" id="instituteGroup" name="instituteGroup" onchange="getschoolData()">
						<option value="">Select Group</option>
						<%for(int i =0; i < data.size(); i++){ %>
							<option value="<%=data.get(i).getSno()%>"><%=data.get(i).getInstitution_group()%></option>
						<%} %>
					</select>
				</div>
				<div class="form-group">
					<label for="schoolName">School Name<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="schoolName" name="schoolName">
							
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label for="state">State<span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="state" name="state">
							
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="city">City<span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="city" name="city">
							
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="location">Location<span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="location" name="location">
							
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="branch">Branch</label>
							<input type="text" class="form-control" id="branch" name="branch">
							
						</div>
					</div>
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

<input type="hidden" id="count" value="0">
<input type="hidden" id="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
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
	
	
	function data() {
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
						url : "get_school",
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
						"data" : "state"
					},
					{
						"data" : "city"
					},
					{
						"data" : "location"
					},
					{
						"data" : "branch"
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
					 {
						"data" : function(data, type,
								dataToSet) {
								var sno = data.sno;
								var status = data.status;
								var string = "<button class='btn btn-success  fa fa-pencil' type='button'  onclick='edit("+sno+")' style='height:30px;width:35px;margin-left:-7px; line-height:0'></button>";
								 string += "<button class='btn btn-danger  fa fa-trash' type='button'  onclick='deletedata("+sno+")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
								 if(status == "Active"){
									 string += "<button class='btn btn-danger  fa fa-times' type='button'  onclick='updateStatus("+sno+",\"Deactive\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
									 }else{
										 string += "<button class='btn btn-success fa fa-check' type='button'  onclick='updateStatus("+sno+",\"Active\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
									 }
									 return string;
									}
								}
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	
	
	$(function() {
		$("form[name='schoolform']").validate(
				{
					rules : {
						instituteGroup : {
							required : true,
						},
						schoolName : {
							required : true,
						},
						state : {
							required : true,
						},
						city : {
							required : true,
						},
						location : {
							required : true,
						},
					},

					messages : {
													
						instituteGroup : {
							required : "Please Select Institution Group",
						},														
						schoolName : {
							required : "Please enter School Name."
						},
						state : {
							required : "Please enter State."
						},
						city : {
							required : "Please enter City."
						},
						location : {
							required : "Please enter Locatio."
						},
					},

					submitHandler : function(form) {
						var sno = $("#sno").val();
						var instituteGroup = $("#instituteGroup").val();
						var schoolName = $("#schoolName").val();
						var state = $("#state").val();
						var city = $("#city").val();
						var location = $("#location").val();
						var branch = $("#branch").val();
						
						 var obj = {
								 "sno" :sno,
								 "institution_group_id":instituteGroup,
								 "branch" : branch,
								 "school_name" :schoolName,
								 "state" :state,
								 "city" :city,
								 "location" :location
						 };
						$.ajax({
							url : 'add_school',
							type : 'post',
							data : JSON.stringify(obj),
							dataType : 'json',
							contentType :  'application/json',
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
	
	/* function edit(i){
		$("#sno").val(i);
		var fd = new FormData();
		fd.append("sno",i);
		$.ajax({
			url : 'edit_school',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
					 $('#school_model').modal('toggle');
					 $("#instituteGroup > option").each(function() {
						    if (this.value ==  data['data'][0].institution_group_id) {
						    	$(this).prop("selected", "selected");
						    }
						});
					 $("#schoolName").val(data['data'][0].school_name);
					 $("#state").val(data['data'][0].state);
					 $("#city").val(data['data'][0].city);
					 $("#location").val(data['data'][0].location);
				} else {
					Swal.fire({
						icon : 'Opps',
						title : 'Warning!',
						text : 'Invalid Details'
					})
				}
			}
		});
		
		 
	} */
	
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
    
    function edit(i){
		$("#sno").val(i);
		var fd = new FormData();
		fd.append("sno",i);
		$.ajax({
			url : 'edit_school',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
					 $('#school_model').modal('toggle');
					 $("#instituteGroup > option").each(function() {
						    if (this.value ==  data['data'][0].institution_group_id) {
						    	$(this).prop("selected", "selected");
						    }
						});
					 $("#schoolName").val(data['data'][0].school_name);
					 $("#state").val(data['data'][0].state);
					 $("#city").val(data['data'][0].city);
					 $("#location").val(data['data'][0].location);
					 $("#branch").val(data['data'][0].branch);
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
	/* function edit(sno){
		 var mapForm = document.createElement("form");
		// mapForm.target = "_blank";
		 mapForm.method = "POST"; // or "post" if appropriate
		 mapForm.action = "editSchool";
		 var output = document.createElement("input");
		 output.type = "hidden";
		 output.name = "sno";
		 output.value = sno;
		 mapForm.appendChild(output);
		 document.body.appendChild(mapForm);
		 mapForm.submit();
	} */
	
	$("#clear_btn").click(function() {
		$("#instituteGroup > option").prop("selected", false);
        $("input[type='text']").val("");
        $("input[type='hidden']").val("0");
      });
	</script>
</body>
</html>