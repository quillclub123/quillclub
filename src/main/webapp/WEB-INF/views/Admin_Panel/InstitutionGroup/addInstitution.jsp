<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<button type="button" id="clear_btn" class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target="#group_model">Add Group</button>
			<a type="button" href="deletedGroup" class="btn btn-danger">Deleted Groups</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Groups</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="institutionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">Sub-Title</th>
		                        <th class="text-white">Status</th>
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

<div class="modal fade" id="group_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Add Group</h4>
			</div>
			<form id="groupform" Name="groupform">
			<div class="modal-body">
				<div class="form-group">
					<label for="groupName">Group Name<span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="groupName" name="groupName">
				</div>
				<div class="form-group">
					<label for="subTitle">Sub Title</label>
					<input type="text" class="form-control" id="subTitle" name="subTitle" placeholder="">
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
	
	function data() {
		$("#institutionTable").DataTable({
			dom : "Blfrtip",
			destroy : true,
			autoWidth : true,
			responsive : true,
			lengthChange : true,
			ordering : false,
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1 ]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns : [ 0, 1]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns : [ 0, 1 ]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns : [ 0, 1 ]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_group",
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
						"data" : "sub_title"
					},
					
					{
		                "data": function (data,type,dataToSet) {
		                	var sno = data.sno;
		                	var status = data.status;
		                	var string="";
		                	if(status=="Active"){
		                		 string = "<span class='badge bg-success font-weight-bold p-1' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:70px;'>"+status+"</span>"
		 	                    return string;
		                	}else if(status=="Deactive"){
		                		string = "<span class='badge bg-danger font-weight-bold' id='status"+sno+"' style='line-height: 1.5;border-radius: 3px !important;width:70px;'>"+status+"</span>"
		 	                    return string;
		                	}
		                   
		                }
					},
					 {
						"data" : function(data, type,
								dataToSet) {
								var sno = data.sno;
								var status = data.status;
								var string = "<button class='btn btn-success  fa fa-pencil' type='button'  onclick='edit("+sno+")' style='height:30px;width:40px; line-height:0'></button>";
							     string += "<button class='btn btn-danger  fa fa-trash' type='button'  onclick='deletedata("+sno+")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								 if(status == "Active"){
								 string += "<button class='btn btn-danger  fa fa-times' type='button'  onclick='updateStatus("+sno+",\"Deactive\")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								 }else{
									 string += "<button class='btn btn-success fa fa-check' type='button'  onclick='updateStatus("+sno+",\"Active\")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								 }
								// string += "<button class='btn btn-primary' type='button'  onclick='addschool("+sno+")' style='height:30px;width:125px;margin-left:10px; line-height:0'>Add Schools</button>";
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
			$("form[name='groupform']").validate(
					{
						rules : {
							groupName : {
								required : true,
							}
						},

						messages : {
														
							groupName : {
								required : "Please Enter Group Name",
							}	
						},
						submitHandler : function(form) {
							debugger;
							var sno = $("#sno").val();
							var groupName = $("#groupName").val();
							var subTitle = $("#subTitle").val();
							
							 var obj = {
									 "sno" :sno,
									 "institution_group":groupName,
									 "sub_title" :subTitle
									 
							 };
							$.ajax({
								url : 'add_group',
								type : 'post',
								data : JSON.stringify(obj),
								dataType : 'json',
								contentType :  'application/json',
								success : function(data) {
									if (data['status'] == 'Success') {
										$('#institutionTable').DataTable().ajax.reload( null, false );
										 Swal.fire({
												icon : 'success',
												title : 'Successful!',
												text : data['message']
											})
											$('#group_model').modal('toggle');
										
										} else if(data['status'] == 'Already_Exist'){
											$('#group_model').modal('toggle');
											Swal.fire({
												icon : 'warning',
												title : 'Already!',
												text : data['message']
											})
										}
										else if(data['status'] == 'Failed'){
											$('#group_model').modal('toggle');
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
						 $('#group_model').modal('toggle');
						 $("#groupName").val(data['data'][0].institution_group);
						 $("#subTitle").val(data['data'][0].sub_title);
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
	       				url : 'updateInstitutiondata', //add  Course  controller name AdminController
	       				type : 'post',
	       				data : JSON.stringify(fd),
	       				contentType : 'application/json',
	       				dataType : 'json',
	       				success : function(data) {
	       					if (data['status'] == 'Success') {
	       					 $('#institutionTable').DataTable().ajax.reload( null, false );								
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
	    	   $("input[type='hidden']").val("0");
	           $("input[type='text']").val("");
	         });
	      
	</script>
</body>
</html>