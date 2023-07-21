<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	.fullQ:hover{
		 cursor: pointer;
	}
	.chosen-container-multi{
		width: 100% !important;
	}
	
	/* Style the Image Used to Trigger the Modal */


.modal1 {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto ; /* Enable scroll if needed */
    background-color: rgb(0,0,0) !important; /* Fallback color */
    background-color: rgba(0,0,0,0.9) !important; /* Black w/ opacity */
}

/* Modal Content (Image) */
.content1 {
    margin: auto;
    display: block;
    height:100vh;
}


/* Caption of Modal Image (Image Text) - Same Width as the Image */
#caption {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
    text-align: center;
    color: #ccc;
    padding: 10px 0;
    height: 150px;
}

/* Add Animation - Zoom in the Modal */
.modal-content, #caption {
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
}

@-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)}
    to {-webkit-transform:scale(1)}
}

@keyframes zoom {
    from {transform:scale(0)}
    to {transform:scale(1)}
}

/* The Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 35px;
    color: black;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
    opacity:1;
}

.close:hover,
.close:focus {
   /*  color: #bbb;
    text-decoration: none; */
    color: black !important;
    cursor: pointer;
     opacity:1 !important;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
        
    }
}

.chosen-choices{
height : 40px !important;
}
#question_model .close{
	display:none !important;
}
.cke_editable  p{
	margin: 10px 0px !important;
}
	</style>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<button type="button" id="clear_btn" class="btn btn-primary margin-bottom-10 waves-effect waves-light" data-toggle="modal" data-target="#question_model">Upload Top Image Banner</button>
			
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Banners</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="questionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Banner Image</th>
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

<div class="modal fade p-0" id="question_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="padding: 0 !important;">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header" style="padding: 5px !important;">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Top Image Banner</h4>
			</div>
			<form id="questionform" Name="questionform">
			<div class="modal-body">
				<div class="row">
				<div class="col-md-5">
							<div class="form-group" id="imageQ">
								<label for="bqannerImg">Upload Banner</label>
								<input type="file" id="bqannerImg" name="bqannerImg" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;margin-top: 0;" />
							</div>
								<p id="validate" style="display: none; color: red;">Please Upload Top Image Banner</p>
							</div>
						<div class="col-md-4" id="qImg">
							<img id="dispImg" height="100px;" width="150px;"/>
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
<!-- Popup Model for Full Question -->

<div class="modal fade" id="question_full" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width: 70% !important;">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Question</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<p id="questionFull"></p>
						<img id="qqImg" style="height:25%; width: 50%; margin: auto; display: none;">
					</div>
				</div>
						
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm waves-effect waves-light" data-dismiss="modal">Close</button>
			</div>
			
		</div>
	</div>
</div>

<!-- The Modal -->
					<div id="myModal" class="modal model1" >
					
					  <!-- The Close Button -->
					  <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>
					
					  <!-- Modal Content (The Image) -->
					  <img class="modal-content content1" id="img01">
					
					  <!-- Modal Caption (Image Text) -->
					  <div id="caption"></div> 
					</div>

<input type="hidden" id="sno" name="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	$(document).ready(function() {
		  $('#instructionQ').keyup('input', function() {
		    var lines = $(this).val().split('\n');
		    if (lines.length > 3) {
		    	alert(lines.length );
		      lines = lines.slice(0, 3);
		      $(this).val(lines.join('\n'));
		    }
		  });
		});
	
	
		// Get the modal
		var modal = document.getElementById('myModal');

		// Get the image and insert it inside the modal - use its "alt" text as a caption
		var img = document.getElementById('dispImg');
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		img.onclick = function(){
		    if(dispImg.src != ""){
		    	modal.style.display = "block";
		    	modal.style.overflow = "hidden";
			    modalImg.src = this.src;
			    modalImg.alt = this.alt;
			    captionText.innerHTML = this.alt;
		    }
		    else{
		    	modal.style.display = "none";
		    }
		}

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}

	
	
	
	
	/* $(document).ready(function() {
	

	}); */
	$(function() {
		   $("#switch-2").click(function() {
		     if ($("#switch-2").is(":checked")) {
		       $("#imageQ").show();
		       $("#qImg").show();
		       $("#imgQoutes").show();
		     } else {
		       $("#imageQ").hide();
		       $("#qImg").hide();
		       $("#imgQoutes").hide();
		       $('#bqannerImg').val('');
		       $('#dispImg').removeAttr('src');
		     }
		   });
		 });
	function displayImage(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('dispImg').src = e.target.result;
		    }
		    reader.readAsDataURL(input.files[0]);
		  }
		}
	
	function data() {
		var imgdata = "off";
		if($('#switch-3').is(":checked") == true){
		 	imgdata = "on";
		}
		$("#questionTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				destroy : true,
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
						url : "get_banner",
						type : "POST"
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
					"data":function(data,type,dataToSet){
			      		var imageName = data.bannerImg;
			      		if(imageName != null  && imageName != ""){
			      			return '<img src="displaydocument?url='+imageName+'" width="150" height="80"/>';
			      		}else{
			      			return "NA"
			      		}
			        	
			        }},
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
	
	
	
	 $(function() {
			$("form[name='questionform']").validate(

					{
						rules : {
							bqannerImg : {
								required : true,
							},
							
						},

						messages : {
														
							bqannerImg : {
								required : "Please upload Image Banner",
							},	
						},

						submitHandler : function(form) {
							var bqannerImg = $("#bqannerImg")[0].files[0];
							var fd = new FormData();
      						fd.append("bannerImg",bqannerImg),
							$.ajax({
	 							url : 'add_banner',
	 							type : 'post',
	 							data : fd,
	 							contentType :  false,
	 							processData : false,
	 							success : function(data) {

	 								if (data['status'] == 'Success') {
	 									$('#questionTable').DataTable().ajax.reload( null, false );
	 									Swal.fire({
											icon : 'success',
											title : 'Successful!',
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
			  title: 'Do you want to Delete Banner?',
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
				  		url : 'delete_banner',
				  		type : 'post',
				  		data : fd,
				  		contentType :  false,
				  		processData : false,
				  		success : function(data) {
				  			if (data['status'] == 'Success') {
								$('#questionTable').DataTable().ajax.reload( null, false );
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
	       				url : 'updatbanner', //add  Course  controller name AdminController
	       				type : 'post',
	       				data : JSON.stringify(fd),
	       				contentType : 'application/json',
	       				dataType : 'json',
	       				success : function(data) {
	       					if (data['status'] == 'Success') {
	       					 $('#questionTable').DataTable().ajax.reload( null, false );								
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
			$("#class_name").chosen("destroy").chosen({
		        max_selected_options: 13,
		        hide_results_on_select: false
		       
		    });
			var targetIndex = $('.search-choice-close:last').index();
			//alert(targetIndex);
			  $('[data-option-array-index="' + targetIndex + '"]').css('display', 'none');
			$("#class_name option").prop("selected", true);
		    $("#class_name").trigger("chosen:updated");		
		    CKEDITOR.instances['question'].setData(" ");
		    $("#cke_1_contents iframe ").contents().find('p').css("margin","1px 0px !important");
	        $("input[type='text']").val("");
	        $("input[type='hidden']").val("0");
	        $("#imageQ").hide();
            $("#qImg").hide();
            $("#imgQoutes").hide();
            if ($('#question_model .switch input[type=checkbox]').is(':checked')) {
            	 $('#question_model .switch input[type=checkbox]').prop('checked', false);
            	}
            
	      });
		 
		
		
	</script>
</body>
</html>