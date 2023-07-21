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

<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			
			<a type="button" href="progarmInformation" class="btn btn-primary">View Program Information</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Programs Details</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="programTable" class="table table-striped table-bordered display dataTable" style="width:102%;overflow: hidden;">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">Program Title</th>
		                        <th class="text-white">Logo</th>
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

<input type="hidden" id="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	function data() {
		$("#programTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns :  [ 0, 1, 2]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns :  [ 0, 1, 2]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns :  [ 0, 1, 2]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_Deleted_program",
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
						"data" : "title"
					},
					{
					"data":function(data,type,dataToSet){
			      		var imageName = data.logo;
			        	return '<img src="displaydocument?url='+imageName+'" width="50" height="50"/>';
			        }}
					
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	
	
	
	
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
							$('#programTable').DataTable().ajax.reload( null, false );
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
    				url : 'updateprogram', //add  Course  controller name AdminController
    				type : 'post',
    				data : JSON.stringify(fd),
    				contentType : 'application/json',
    				dataType : 'json',
    				success : function(data) {
    					if (data['status'] == 'Success') {
    					 $('#programTable').DataTable().ajax.reload( null, false );								
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
    
   
	 function edit(sno){
		 var mapForm = document.createElement("form");
		// mapForm.target = "_blank";
		 mapForm.method = "POST"; // or "post" if appropriate
		 mapForm.action = "editProgarmInformation";
		 var output = document.createElement("input");
		 output.type = "hidden";
		 output.name = "sno";
		 output.value = sno;
		 mapForm.appendChild(output);
		 document.body.appendChild(mapForm);
		 mapForm.submit();
	} 
	
	$("#clear_btn").click(function() {
		$("#instituteGroup > option").prop("selected", false);
        $("input[type='text']").val("");
      });
	</script>
</body>
</html>