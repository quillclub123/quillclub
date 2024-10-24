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
#listTable_info, #listTable_paginate{
	display: none !important;
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
	document.getElementById('apqs').classList.add('sidecolor');
</script>
	<div id="wrapper">
		<div class="main-content">
			<div class="row small-spacing">
				<div class="col-lg-12 col-xs-12">
					<button type="button" id="clear_btn"
						class="btn btn-primary btn-xs waves-effect waves-light"
						data-toggle="modal" data-target="#school_model">Add
						Questions</button>
					<!-- <a href="assets/Students-List.xlsx" download>
						    <button type="button" class="btn btn-success btn-xs">Download Excel Format</button>
						</a> -->
					<div class="box-content card white" style="padding-bottom: 20px;">
						<h4 class="box-title">Profile Questions</h4>
						<!-- /.box-title -->
						<div class="card-content">
							<table id="schoolTable"
								class="table table-striped table-bordered display dataTable"
								style="width: 102%; overflow: hidden;">
								<thead class="bg-primary">
									<tr>
										<th class="text-white">No</th>
										<th class="text-white">Group Name</th>
										<th class="text-white">School Name</th>
										<th class="text-white">Question List</th>
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

	<div class="modal fade" id="school_model" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content modal-lg">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Add Profile Question</h4>
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
						<div class="row g-2">
							<div class="col-12 mb-0">
								<div>
									<h6 class="stock-content" style="margin-top: 15px;">Questions</h6>
								</div>
								<hr>
								<table class="table table-bordered" id="stockentrytable">
									<thead class="bg-primary text-white">
										<tr>
											<th class="text-center text-white" style="width: 10%;">S.NO</th>
											<th class="text-center text-white">Question</th>
										</tr>
									</thead>
									<tbody id="tbody">
										<tr>

											<td><input type="text" class="form-control"
												name="seq_no1" id="seq_no1"></td>
											<td><input type="text" class="form-control"
												name="question1" id="question1"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="space-between">

								<div style="text-align: end;">
									<button type="button"
										class=" btn btn-primary btn-xs add fa fa-plus"
										onclick="addrow()" name="add"></button>
									<button type="button"
										class="btn btn-danger btn-xs remove1 fa fa-minus"></button>
								</div>

							</div>
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

	<div class="modal fade" id="qlist_model" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content modal-lg">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Question List</h4>
				</div>
				<table id="listTable"
					class="table table-striped table-bordered display dataTable"
					style="width: 102%; overflow: hidden;">
					<thead class="bg-primary">
						<tr>
							<th class="text-white" style="width: 8%;">Seq No</th>
							<th class="text-white">Questions</th>
						</tr>
					</thead>
				</table>

			</div>
		</div>
	</div>

	<input type="hidden" id="count" value="0">
	<input type="hidden" id="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>

	<script>
	function addrow() {
		var count = $('#tbody > tr').length;
		var i = parseInt(count) + 1;
		var seq_no = $("#seq_no" + count).val();
		var question = $("#question" + count).val();
		var html = '';
		if (seq_no != null && seq_no != ""
				&& question != null && question != "") {
			html += '<tr id="rowss'+i+'">';
			html += '<td><input type="text" name="seq_no'+i+'" class="form-control "  id="seq_no'+i+'"/></td>';
			html += '<td><input type="text" name="question'+ i+ '" class="form-control "  id="question'+ i+ '"/></td>';
			html += '</tr>';
			$('#tbody').append(html);
			
		} else {
			alert("Please Enter Sequence number and Question.");
		}
	}

	$(document).on('click', '.remove1', function() {
	var count = $('#tbody > tr').length;
	$('#tbody > tr:last').remove();
	});
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
	
	
	
	
	function data() {
	    $("#schoolTable").DataTable({
	        dom: 'Blfrtip',
	        autoWidth: true,
	        responsive: true,
	        buttons: [
	            {
	                extend: 'pdf',
	                exportOptions: {
	                    columns: [0, 1, 2]
	                }
	            },
	            {
	                extend: 'csv',
	                exportOptions: {
	                    columns: [0, 1, 2]
	                }
	            },
	            {
	                extend: 'print',
	                exportOptions: {
	                    columns: [0, 1, 2]
	                }
	            },
	            {
	                extend: 'excel',
	                exportOptions: {
	                    columns: [0, 1, 2]
	                }
	            },
	            {
	                extend: 'pageLength'
	            }
	        ],
	        lengthChange: true,
	        ordering: false,
	        ajax: {
	            url: "get_profile_questions",
	            type: "POST",
	        },
	        columnDefs: [
	            {
	                "defaultContent": "-",
	                "targets": "_all"
	            }
	        ],
	        serverSide: true,
	        columns: [
	            {
	                data: 'SrNo',
	                render: function (data, type, row, meta) {
	                    return meta.row + meta.settings._iDisplayStart + 1;
	                }
	            },
	            {
	                data: "group_name"
	            },
	            {
	                data: "school_name"
	            },
	            {
	                data: function (data, type, dataToSet) {
	                    var sno = data.sno;
	                    return "<button class='btn btn-secondary fa fa-eye' type='button' onclick='viewlist(" + sno + ")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
	                }
	            },
	            {
	                data: function (data, type, dataToSet) {
	                    var sno = data.sno;
	                    var status = data.status;
	                    var string = "";
	                    if (status == "Active") {
	                        string = "<span class='badge bg-success font-weight-bold p-1' id='status" + sno + "' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>" + status + "</span>";
	                    } else if (status == "Deactive") {
	                        string = "<span class='badge bg-danger font-weight-bold' id='status" + sno + "' style='line-height: 1.5;border-radius: 3px !important;width:60px; font-size:10px;'>" + status + "</span>";
	                    }
	                    return string;
	                }
	            },
	            {
	                data: function (data, type, dataToSet) {
	                    var sno = data.sno;
	                    var status = data.status;
	                    var string = "";
	                    string = "<button class='btn btn-success fa fa-pencil-square-o' type='button' onclick='edit(" + sno + ")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
	                    if (status == "Active") {
	                        string += "<button class='btn btn-danger fa fa-times' type='button' onclick='updateStatus(" + sno + ",\"Deactive\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
	                    } else {
	                        string += "<button class='btn btn-success fa fa-check' type='button' onclick='updateStatus(" + sno + ",\"Active\")' style='height:30px;width:35px;margin-left:2px; line-height:0'></button>";
	                    }
	                    return string;
	                }
	            }
	        ],
	        lengthMenu: [[5, 10, 25, 50], [5, 10, 25, 50]],
	        select: true
	    });
	}

	data();

	function viewlist(i){
		$('#qlist_model').modal('toggle');
		$("#listTable").DataTable({
			 dom : "Blfrtip",
			 destroy : true,
			 autoWidth : false,
			 responsive : true,
			 buttons : [ {
					extend : 'pdf',
					exportOptions : {
					columns : [ 0, 1]
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
					columns :[ 0, 1]
				}
				
				}, {
					extend : 'excel',
					exportOptions : {
					columns : [ 0, 1]
				}
				}, {
					extend : 'pageLength'
				} ],
				lengthChange : false,
				ordering : false,
				scrollX : false,
				ajax : {
					url : "get_question_list",
					type : "POST",
					"data" : {
						"sno" : i,
						
					}
				},
				columnDefs : [ {
					"defaultContent" : "-",
					"targets" : "_all"
				} ],
					serverSide : true,
				columns : [
				{
					"data" : "seq_no"
				},
				{
					"data" : "question"
				},
				],
				"lengthMenu" : [ [-1 ], ["All" ] ],
				select : true
				});
		
	}
	
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
					},

					messages : {
													
						instituteGroup : {
							required : "Please Select Institution Group",
						},														
						school_name : {
							required : "Please Select School Name."
						}
					},

					submitHandler : function(form) {
						var sno = $("#sno").val();
						var instituteGroup = $("#instituteGroup").val();
						var schoolName = $("#school_name").val();
						var totaldata2 = $('#tbody > tr').length;
						var totalrows2 = parseInt(totaldata2);
						var fd = {
								'sno' : sno,
								'group_id' : instituteGroup,
								'school_id' : schoolName,
								'qlist' : []
							};
							for (var i = 1; i <= totalrows2; i++) {
								var str = "#seq_no" + i;
								var str1 = "#question" + i;
								if ($(str).val() == '') {
									alert("sequence no can't be empty");
									return; 
								}
								if ($(str1).val() == '') {
									alert("Question can't be empty");
									return;
								}
								var seq_no = $(str).val();
								var question = $(str1).val();
								fd.qlist.push({
									'seq_no' : seq_no,
									'question' : question,
								});
							}
							$.ajax({
								url : 'add_profile_question', //add company Master controller name LocationController
								type : 'post',
								dataType : 'json',
								data : JSON.stringify(fd),
								contentType : 'application/json',
								success : function(data) {
									if (data['status'] == 'Success') {
										$('#school_model').modal('toggle');
										 $('#schoolTable').DataTable().ajax.reload(null, false);
										Swal.fire({
											icon : 'success',
											title : 'Successfully!',
											text : data['message']
										})
									} else {
										Swal.fire({
											icon : 'warning',
											title : 'OOPS!',
											text : data['message']
										})
									}
								}
							});	

					}
				});

	});
	
	function edit(sno){
		$('#school_model').modal('toggle');
		$("#sno").val(sno);
		 var fd  = new FormData();
		 fd.append("sno",sno);
		 $.ajax({
			 	async:false,
				url : 'get_question_list',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						$("#instituteGroup > option").each(function() {
						    if (this.value ==  data['pdata'][0].group_id) {
						    	$(this).prop("selected", "selected");
						    }
						});
						getschoolData();
						$("#school_name > option").each(function() {
						    if (this.value ==  data['pdata'][0].school_id) {
						    	$(this).prop("selected", "selected");
						    }
						});
						var html = '';

						for (var k = 0; k < data['data'].length; k++) {
						    if (k === 0) {
						        $("#seq_no1").val(data['data'][0].seq_no);
						        $("#question1").val(data['data'][0].question);
						    } else {
						        var i = k + 1; 
						        html = '<tr id="rowss' + i + '">';
						        html += '<td><input type="text" name="seq_no' + i + '" class="form-control" id="seq_no' + i + '" value="' + data['data'][k].seq_no + '"/></td>';
						        html += '<td><input type="text" name="question' + i + '" class="form-control" id="question' + i + '" value="' + data['data'][k].question + '"/></td>';
						        html += '</tr>';
						        $('#tbody').append(html);
						    }
						}
					}
				}
			});
		
	}
	
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