<!DOCTYPE html>

<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>


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
			<a type="button" href="schools" class="btn btn-primary btn-xs">View School</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Deleted School Details</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="schoolTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">School Name</th>
		                        <th class="text-white">State</th>
		                        <th class="text-white">City</th>
		                        <th class="text-white">Location</th>
		                        <th class="text-white">Branch</th>
		                       <!--  <th class="text-white">status</th>
		                        <th class="text-white">Action</th> -->
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
						url : "get_deletedschool",
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
					/*  {
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
						var ex = "";
						var count = $("#count").val();
						if(count > 0){
							for(var i=2; i<=count; i++){
								var extra = $("#extra"+i).val();
								if(extra != null && extra != ""){
									if(i == 2){
										ex = extra;
									}else{
										ex += ","+extra;
									}
								}
							}
						}
						var instituteGroup = $("#instituteGroup").val();
						var schoolName = $("#schoolName").val();
						var state = $("#state").val();
						var city = $("#city").val();
						var location = $("#location").val();
						
						 var obj = {
								 "sno" :sno,
								 "institution_group_id":instituteGroup,
								 "extra" : ex,
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
											title : 'successfully!',
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
	function edit(sno){
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
	}
	</script>
</body>
</html>