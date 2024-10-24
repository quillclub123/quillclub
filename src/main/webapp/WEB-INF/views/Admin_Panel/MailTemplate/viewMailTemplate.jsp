<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	.fullA:hover{
		cursor: pointer;
	}
	</style>
	
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
			<a type="button" href="addMailTemplate" class="btn btn-primary btn-xs">Add Mail Template</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Mail Template</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="mailTable" class="table table-striped table-bordered display dataTable" style="width:102%;overflow: hidden;">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">No</th>
		                        <th class="text-white">Subject</th>
		                        <th class="text-white">Mail Template</th>
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

<!-- Popup Model for Full Question -->

<div class="modal fade" id="answer_full" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="margin-left: 241px;">
		<div class="modal-content modal-lg">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Full Template</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
					<textarea class="form-control" id="mailvalue" style="width: 100%;height: 470px !important;"></textarea>
					</div>
				</div>
						
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm waves-effect waves-light" data-dismiss="modal">Close</button>
			</div>
			
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
		$("#mailTable").DataTable({
			dom : "Blfrtip",
			destroy : true,
			autoWidth : true,
			responsive : true,
			lengthChange : true,
			ordering : false,
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns : [ 0, 1, 2 ]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns : [ 0, 1, 2 ]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns : [ 0, 1, 2 ]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_mailTemplate",
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
						"data" : "subject"
					},
					{
		                "data": function (data,type,dataToSet) {
		                	var sno = data.sno;
		                	var string = "<a  class='fullA' id='temp"+sno+"' onclick='fullTemp("+sno+")'>View Template</a>";
		 	                return string;
		                }
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
								var string = "<button class='btn btn-danger  fa fa-trash' type='button'  onclick='deletedata("+sno+")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								 if(status == "Active"){
								 string += "<button class='btn btn-danger  fa fa-times' type='button'  onclick='updateStatus("+sno+",\"Deactive\")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
								 }else{
									 string += "<button class='btn btn-success fa fa-check' type='button'  onclick='updateStatus("+sno+",\"Active\")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
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
				  		url : 'delete_Template',
				  		type : 'post',
				  		data : fd,
				  		contentType :  false,
				  		processData : false,
				  		success : function(data) {
				  			if (data['status'] == 'Success') {
								$('#mailTable').DataTable().ajax.reload( null, false );
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
	       				url : 'updatemailTemplate', //add  Course  controller name AdminController
	       				type : 'post',
	       				data : JSON.stringify(fd),
	       				contentType : 'application/json',
	       				dataType : 'json',
	       				success : function(data) {
	       					if (data['status'] == 'Success') {
	       					 $('#mailTable').DataTable().ajax.reload( null, false );								
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
	       
	       function fullTemp(i){
	    	   $("#mailvalue").empty();
				var fd = new FormData();
				fd.append("sno",i);
				$.ajax({
					url : 'get_templateData',
					type : 'post',
					data : fd,
					contentType :  false,
					processData : false,
					success : function(data) {
						if (data['status'] == 'Success') {
							 $("#mailvalue").empty();
							 
							 $('#answer_full').modal('toggle');
							
							 $("#mailvalue").text(data['data'][0].messageBody);
							
						} 
					}
				});
			}
	</script>
</body>
</html>