<!DOCTYPE html>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="com.quillBolt.model.SelectedStudent"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
<jsp:include page="../css.jsp"></jsp:include>
<style>
.student-card {
	width: 100%;
	max-width: 350px;
	margin: 20px auto;
	border-radius: 0.5rem;
	overflow: hidden;
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
	background: linear-gradient(to bottom right, #0a2a56, #3b5998, #a6b1e1);
	color: white;
	padding: 20px;
	text-align: center;
}

.student-card .student-name {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 15px;
}

.student-card .student-details {
	font-size: 1rem;
	margin-bottom: 20px;
}

.student-card .card-footer {
	display: flex;
	justify-content: space-between;
}

</style>
</head>

<body>
	<%
	List<SelectedStudent> st = (List<SelectedStudent>) request.getAttribute("st");
	List<InstituitonGroup> data = (List<InstituitonGroup>) request.getAttribute("data");
	String snoa = "";
	if (st.size() > 0) {
		for (int i = 0; i < st.size(); i++) {
			if (i > 0) {
		snoa = snoa + "," + st.get(i).getSno();
			} else {
		snoa = "" + st.get(i).getSno();
			}
		}
	}
	%>
	
	<jsp:include page="../header.jsp"></jsp:include>
	<script>document.getElementById('dash').classList.add('active');</script>
	<div id="wrapper">
		<div class="main-content">
			<div class="row">
				<div class="col-12">
					<form id="sectionform" Name="sectionform">
						<div class="row" style="padding: 0px 15px;">
							<div class="col-lg-6 col-xs-12">
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
							</div>
							<div class="col-lg-6 col-xs-12">
								<div class="form-group">
									<label for="class_name" class="form-label"
										style="font-weight: 600">School Name<span
										class="text-danger ">*</span></label><br> <select
										id="school_name" name="school_name" class="form-control"
										onchange="getstudentdata()">
										<option disabled selected>Select School</option>
									</select>

								</div>
							</div>
							<div class="col-12"  id="alll" style="display: none;">
					<!-- "Select All" Checkbox -->
					<div class="switch success" style="padding: 0px 17px;">
						<input type="checkbox" id="switch-all"
							onclick="toggleAllCheckboxes(this)"> <label
							for="switch-all"><span id="alllebel"></span></label>
					</div>
				</div>
						</div>
					</form>
				</div>
			</div>

			<!-- Loop through student data -->
			<div class="row" id="students-container">
				<%-- <%
				if (st.size() > 0) {
					for (int i = 0; i < st.size(); i++) {
				%>
				<div class="col-md-3">
					<div class="student-card">
						<div class="student-name"><%=st.get(i).getName()%></div>
						<div class="student-details">
							<!-- Individual checkboxes for each student -->
							<div class="switch primary">
								<input type="checkbox" class="student-checkbox"
									onclick="updateStatus(<%=st.get(i).getSno()%>)"
									id="switch-<%=i%>"
									<%if (st.get(i).getStatus().equalsIgnoreCase("Active")) {%>
									checked <%}%>> <label for="switch-<%=i%>"></label>
							</div>
							<p>
								ID:
								<%=st.get(i).getStudent_id()%></p>
							<p>
								Pass:
								<%=st.get(i).getPassword()%></p>
							<p><%=st.get(i).getSchool_name()%></p>
						</div>
						<div class="card-footer">
							<button type="button"
								onclick="view('<%=st.get(i).getStudent_id()%>')"
								class="btn btn-success btn-xs">View Full Data</button>
							<button type="button" onclick="upload('<%=st.get(i).getSno()%>')"
								class="btn btn-primary btn-xs">Upload PDF</button>
						</div>
					</div>
				</div>
				<%
				}
				}
				%> --%>
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
		</div>
	</div>
	<!-- Popup Model -->

	<div class="modal fade" id="pdf_model" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Upload PDF</h4>
				</div>
				<form id="pdf_form" Name="pdf_form">
					<div class="modal-body">
						<div class="form-group">
							<label for="pdf">Select PDF</label> <input type="file"
								class="form-control" id="pdf" name="pdf" accept=".pdf">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button"
							class="btn btn-default btn-xs waves-effect waves-light"
							data-dismiss="modal">Close</button>
						<button type="submit"
							class="btn btn-primary btn-xs waves-effect waves-light"
							style="float: right;">Upload</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<input type="hidden" id="sno" name="sno">
	<input type="hidden" id="snoa" name="snoa">
	<jsp:include page="../js.jsp"></jsp:include>
	<script type="text/javascript">
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
	function getstudentdata(){
		$("#students-container").html("");
		 var group_id = $("#instituteGroup").val();
		 var school_id = $("#school_name").val();
		 var fd  = new FormData();
		 fd.append("group_id",group_id);
		 fd.append("school_id",school_id);
		 $.ajax({
			 	async:false,
				url : 'get_reviewed_pdf',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						$("#alll").css("display","block");
						var snoa = "";
						for (var i = 0; i < data['data'].length; i++) {
						    var student = data['data'][i];
							if (i > 0) {
								snoa = snoa + "," + student.sno;
							} else {
								snoa = "" + student.sno;
							}
						    var sts = "";
						    if (student.status === 'Active') {
						        sts = "checked";
						    }
						    var pdfname = "Upload PDF";
						    if (student.pdf !== null && student.pdf !== undefined && student.pdf !== "") {
						        pdfname = "Uploaded";
						    }

						    
						    var html = "<div class='col-md-3'>" +
						        "<div class='student-card'>" +
						            "<div class='student-name'>" + student.name + "</div>" +
						            "<div class='student-details'>" +
						                "<!-- Individual checkboxes for each student -->" +
						                "<div class='switch success'>" +
						                    "<input type='checkbox' class='student-checkbox' " +
						                        "onclick='updateStatus(" + student.sno + ")' " +
						                        "id='switch-" + i + "' " + sts + ">" +  // Concatenate 'checked' status properly
						                    "<label for='switch-" + i + "'></label>" +
						                "</div>" +
						                "<p>ID: " + student.student_id + "</p>" +
						                "<p>Pass: " + student.password + "</p>" +
						                "<p>" + student.school_name + "</p>" +
						            "</div>" +
						            "<div class='card-footer'>" +
						                "<button type='button' onclick='view(\"" + student.student_id + "\")' class='btn btn-success btn-xs'>View Full Data</button>" +
						                "<button type='button' onclick='upload(\"" + student.sno + "\")' class='btn btn-primary btn-xs'>"+pdfname+"</button>" +
						            "</div>" +
						        "</div>" +
						    "</div>";

						    // Append or insert `html` into the DOM, e.g., append to a container element
						    document.getElementById("students-container").innerHTML += html;
						}
						$("#snoa").val(snoa);
						checkedornot();

					}else{
						$("#alll").css("display","none");
						Swal.fire({
							  icon: 'error',
							  title: 'No Data Found',
							  showConfirmButton: false,
							  timer: 1500
							})
					}
				}
			});
	}
		function view(student_id){
			var mapForm = document.createElement("form");
			 mapForm.target = "_blank";
			 mapForm.method = "POST"; // or "post" if appropriate
			 mapForm.action = "story_data";
			 var output = document.createElement("input");
			 output.type = "hidden";
			 output.name = "student_id";
			 output.value = student_id;
			 mapForm.appendChild(output);
			 document.body.appendChild(mapForm);
			 mapForm.submit();
		}
		function upload(i){
			$("#pdf_model").modal('toggle');
			$("#sno").val(i);
		}
		$(function() {
			$("form[name='pdf_form']").validate(
					{
						rules : {
							
							pdf : {
								required : true,
							},
						},

						messages : {
														
							
							pdf : {
								required : "Please choose pdf."
							},
							
						},
						submitHandler : function(form) {
							var sno = $("#sno").val();
							var pdf = $("#pdf")[0].files[0];
							
							var fd = new FormData();
							fd.append("sno",sno);
							fd.append("pdf",pdf);
							fd.append("type","Admin");
							
							$.ajax({
								url : 'upload_pdf',
								type : 'post',
								data : fd,
								contentType :  false,
								processData : false,
								success : function(data) {
									if (data['status'] == 'Success') {
										//$('#sectionTable').DataTable().ajax.reload( null, false );
										 Swal.fire({
												icon : 'success',
												title : 'successfully!',
												text : data['message']
											})
											$('#pdf_model').modal('toggle');
										
										} 
										else if(data['status'] == 'Failed'){
											$('#pdf_model').modal('toggle');
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

		    function toggleAllCheckboxes(source) {
		    	var snoa = $("#snoa").val();
		        var isChecked = $(source).is(':checked');
		        $('.student-checkbox').prop('checked', isChecked);
		        updateStatus(snoa); 
		    }

		    function updateStatus(sno) {
		    	 var isChecked = $('#switch-all').is(':checked');
		        var fd = new FormData();
		        fd.append("sno", sno);
		        fd.append("boxstatus", isChecked);
		        $.ajax({
		            url: 'update_status',
		            type: 'post',
		            data: fd,
		            contentType: false,
		            processData: false,
		            success: function(data) {
		                if (data['status'] == 'Success') {
		                    // Success logic if needed
		                }
		            }
		        });

		        var totalCheckboxes = $('.student-checkbox').length;
		        var checkedCount = $('.student-checkbox:checked').length;
		        var uncheckedCount = totalCheckboxes - checkedCount;

		        var allChecked = totalCheckboxes === checkedCount;

		        if (allChecked) {
		            $('#switch-all').prop('checked', true); 
		            $('#alllebel').html('All Are On');
		        } else if (checkedCount === 0) {
		            $('#switch-all').prop('checked', false); 
		            $('#alllebel').html('Allow All');
		        } else {
		            $('#switch-all').prop('checked', false); 
		            $('#alllebel').html('Some Are Off (' + checkedCount + '/' + totalCheckboxes + ')');
		        }

		    }

		   function checkedornot() {
			   var totalCheckboxes = $('.student-checkbox').length;
			   var checkedCount = $('.student-checkbox:checked').length;
			   var uncheckedCount = totalCheckboxes - checkedCount;

			   var allChecked = totalCheckboxes === checkedCount;

			   if (allChecked) {
			       $('#switch-all').prop('checked', true); 
			       $('#alllebel').html('All Are On');
			   } else if (checkedCount === 0) {
			       $('#switch-all').prop('checked', false); 
			       $('#alllebel').html('Allow All');
			   } else {
			       $('#switch-all').prop('checked', false); 
			       $('#alllebel').html('Some Are Off (' + checkedCount + '/' + totalCheckboxes + ')');
			   }

		        
		    }
		
	</script>
</body>
</html>