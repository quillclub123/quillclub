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
			<a type="button" href="viewgroup" class="btn btn-primary">View Group</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Deleted Group</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="institutionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">Sub_Title</th>
		                      <!--   <th class="text-white">Status</th> -->
		                       <!--  <th class="text-white">Action</th> -->
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
						url : "get_deletedgroup",
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
				
					/* {
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
					}, */
					 /* {
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
								 string += "<button class='btn btn-primary' type='button'  onclick='addschool("+sno+")' style='height:30px;width:125px;margin-left:10px; line-height:0'>Add Schools</button>";
								 return string;
								}
							} */
					
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
		
		function edit(sno){
			 var mapForm = document.createElement("form");
			// mapForm.target = "_blank";
			 mapForm.method = "POST"; // or "post" if appropriate
			 mapForm.action = "editinstitutionGroup";
			 var output = document.createElement("input");
			 output.type = "hidden";
			 output.name = "sno";
			 output.value = sno;
			 mapForm.appendChild(output);
			 document.body.appendChild(mapForm);
			 mapForm.submit();
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
	       
	       function addschool(sno){
	    		 var mapForm = document.createElement("form");
	    		// mapForm.target = "_blank";
	    		 mapForm.method = "POST"; // or "post" if appropriate
	    		 mapForm.action = "school";
	    		 var output = document.createElement("input");
	    		 output.type = "hidden";
	    		 output.name = "sno";
	    		 output.value = sno;
	    		 mapForm.appendChild(output);
	    		 document.body.appendChild(mapForm);
	    		 mapForm.submit();
	    	}
	</script>
</body>
</html>