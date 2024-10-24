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
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0) !important; /* Fallback color */
    background-color: rgba(0,0,0,0.9) !important; /* Black w/ opacity */
}

/* Modal Content (Image) */
.content1 {
    margin: auto;
    display: block;
    width: 80%;
    max-width: 700px;
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
    color: #fff;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
    opacity:1;
}

.close:hover,
.close:focus {
   /*  color: #bbb;
    text-decoration: none; */
    color: white !important;
    cursor: pointer;
     opacity:1 !important;
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
    .modal-content {
        width: 100%;
        
    }
}

	</style>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('testi').classList.add('active');
	document.getElementById('tst').style.display = 'block';
	document.getElementById('msq').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<button type="button" id="clear_btn" class="btn btn-primary btn-xs margin-bottom-10 waves-effect waves-light" data-toggle="modal" data-target="#question_model">Add Sample Question</button>
			<!-- <a href="deletedQuestion"  class="btn btn-danger margin-bottom-10 waves-effect waves-light" >Deleted Question</a> -->
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Question</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="questionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Question</th>
		                        <th class="text-white">Question Image</th>
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

<div class="modal fade" id="question_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document" style="width: 100%!important; margin: 0px !important;">
		<div class="modal-content" style="height: 100vh;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">Add Sample Question</h4>
			</div>
			<form id="questionform" Name="questionform">
			<div class="modal-body">
				<div class="row">
				<div class="col-md-12">
				<div class="switch primary"><input type="checkbox"  id="switch-2"><label for="switch-2">With Image ?</label></div>
					<div class="row">
						<div class="col-md-8">
							<div class="form-group" id="imageQ" style="display: none;">
								<label for="questionImg">Upload Sample Question Image</label>
								<input type="file" id="questionImg" name="questionImg" class="form-control" accept="image/png,image/jpeg" onchange="displayImage(this)" style="border: 1px solid lightgray; height: 45px;width: 100%;margin-top: 25px;" />
							</div>
								<p id="validate" style="display: none; color: red;">Please Upload Sample Question Image</p>
							</div>
						<div class="col-md-4" id="qImg" style="display: none;">
							<img id="dispImg" height="100px;" width="100px;" style="margin-top: 30px;"/>
						</div>
					</div>
				</div>
			
					<div class="col-md-12">
						<label for="question" class="form-label" style="font-weight: 600">Sample Question<span class="text-danger ">*</span></label>
						<textarea id="question" name="question"></textarea>
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
				<h4 class="modal-title" id="myModalLabel">Sample Question</h4>
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

<!-- The Modal -->
					<div id="myModal" class="modal model1">
					
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

	
		// Get the modal
		var modal = document.getElementById('myModal');

		// Get the image and insert it inside the modal - use its "alt" text as a caption
		var img = document.getElementById('dispImg');
		var modalImg = document.getElementById("img01");
		var captionText = document.getElementById("caption");
		img.onclick = function(){
		    modal.style.display = "block";
		    modalImg.src = this.src;
		    modalImg.alt = this.alt;
		    captionText.innerHTML = this.alt;
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
		     } else {
		       $("#imageQ").hide();
		       $("#qImg").hide();
		       $('#questionImg').val('');
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
		$("#questionTable").DataTable({
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
						url : "get_sampleQuestion",
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
		                "data": function (data,type,dataToSet) {
		                	var sno = data.sno;
		                	var question = data.question;
		                	let text = question.substring(0,50);
		                	var string = "<a class='fullQ'  id='question"+sno+"' onclick='fullQuestion("+sno+")'>"+text+"</a>";
		 	                return string;
		                }
					},
					{
					"data":function(data,type,dataToSet){
			      		var imageName = data.question_image;
			      		if(imageName != null  && imageName != ""){
			      			return '<img src="displaydocument?url='+imageName+'" width="50" height="50"/>';
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
								var string = "<button class='btn btn-success  fa fa-pencil' type='button'  onclick='edit("+sno+")' style='height:30px;width:40px; line-height:0'></button>";
								string += "<button class='btn btn-danger  fa fa-trash' type='button'  onclick='deletedata("+sno+")' style='height:30px;width:40px;margin-left:10px; line-height:0'></button>";
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
							editor : {
								required : true,
							},
						},

						messages : {										
							editor : {
								required : "Please enter Question"
							}
							
						},

						submitHandler : function(form) {
							var sno = $("#sno").val();
							var sn = "";
							var question = CKEDITOR.instances['question'].getData();
							var questionImg = $("#questionImg")[0].files[0];
							var imgtype="off";
							if(questionImg != null && questionImg != ""){
								imgtype="on";
							}
							
							
							var obj = {};
							obj.sno = sno;
							obj.questionImgType = imgtype;
							obj.question = question;
							var fd = new FormData();
      						fd.append("question_image",questionImg),
      						fd.append("questions", JSON.stringify(obj)),
      						
							$.ajax({
	 							url : 'add_samplequestion',
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
			  title: 'Do you want to Delete Sample Question?',
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
				  		url : 'delete_sampleQ',
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
		
		function edit(i){
			$("#sno").val(i);
			var fd = new FormData();
			fd.append("sno",i);
			$.ajax({
				url : 'edit_sampleQ',
				type : 'post',
				data : fd,
				contentType :  false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						$('#question_model').modal('toggle');
						 CKEDITOR.instances['question'].setData(data['data'][0].question);
						 $("#dispImg").attr("src", "displaydocument?url="+data['data'][0].question_image+"");
						 if(data['data'][0].question_image != null && data['data'][0].question_image !=""){
							 $("#imageQ").show();
						     $("#qImg").show();
						     $("#switch-2").attr("checked",true);
						 }
						 else if(data['data'][0].questionImgType == "off"){
							 $("#switch-2").attr("checked", false);
						        $("#imageQ").hide();
					            $("#qImg").hide();
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
				url : 'edit_sampleQ',
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
	       				url : 'updateSampleQ', //add  Course  controller name AdminController
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
			    CKEDITOR.instances['question'].setData(" ");
			    $("#cke_1_contents iframe ").contents().find('p').css("margin","1px 0px !important");
		        $("input[type='text']").val("");
		        $("#switch-2").attr("checked", false);
		        $("#imageQ").hide();
	            $("#qImg").hide();
	            if ($('.switch input[type=checkbox]').is(':checked')) {
	            	 $('.switch input[type=checkbox]').prop('checked', false);
	            	}
	            
		       
		       
		      });
	</script>
</body>
</html>