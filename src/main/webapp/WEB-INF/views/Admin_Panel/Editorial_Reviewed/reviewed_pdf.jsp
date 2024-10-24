<!DOCTYPE html>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<%List<InstituitonGroup> data = (List<InstituitonGroup>)request.getAttribute("data"); %>

<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('writ').classList.add('active');
	document.getElementById('wrt').style.display = 'block';
	document.getElementById('er').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
				<!-- <a href="deletedSection" class="btn btn-danger margin-bottom-10" >Deleted Section</a> -->
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">Reviewed and Un-reviewed PDFs</h4>
						<div style="padding: 7px 23px;">
							<form id="sectionform" Name="sectionform">
								<div class="row small-spacing">
									<div class="col-lg-4 col-xs-12">
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
									<div class="col-lg-5 col-xs-12">
										<div class="form-group">
											<label for="class_name" class="form-label"
												style="font-weight: 600">School Name<span
												class="text-danger ">*</span></label><br> <select
												id="school_name" name="school_name" class="form-control" onchange="getpdfdata()">
												<option disabled selected>Select School</option>
											</select>

										</div>
									</div>
									<div class="col-lg-3 col-xs-12">
										<div class="form-group">
											<button type="button" id="d_pdf"
												class="btn btn-primary btn-sm waves-effect waves-light"
												style="margin-top: 30px;" onclick="downloadpdf()">Download All Reviewed PDFs</button>

										</div>
									</div>
								</div>
							</form>
						</div>

						<!-- /.box-title -->
					<div class="card-content">
						<table id="pdftable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Student Name</th>
		                        <th class="text-white">Un-Reviewed(What We Had Uploaded)</th>
		                        <th class="text-white">Reviewed(And Uploaded)</th>
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
<input type="hidden" id="sno" value="0">

	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
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
	
	function getpdfdata(){
		var group_id = $("#instituteGroup").val();
		var school_id = $("#school_name").val();
		$("#pdftable").DataTable({
			 dom : "Blfrtip",
			 destroy : true,
			 autoWidth : false,
			 responsive : true,
			 buttons : [ {
					extend : 'pdf',
					exportOptions : {
					columns : [ 0, 1,2,3]
				}
				},
				{
					extend : 'csv',
					exportOptions : {
					columns : [ 0, 1,2,3]
				}
				
				}, 
				{
					extend : 'print',
					exportOptions : {
					columns : [ 0, 1,2,3]
				}
				
				}, {
					extend : 'excel',
					exportOptions : {
					columns : [ 0, 1,2,3]
				}
				}, {
					extend : 'pageLength'
				} ],
				lengthChange : false,
				ordering : false,
				scrollX : false,
				ajax : {
					url : "get_selected_students",
					type : "POST",
					"data" : {
						"group_id" : group_id,
						"school_id" : school_id,
					}
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
					"data" : "name"
				},
				{
					"data":function(data,type,dataToSet){
						var pdf = data.pdf;
	                	if(pdf != null  && pdf != ""){
	                		 return '<a class="fa fa-file-pdf-o" style="color:red;font-size: 24px;"></a>';
			      		}else{
			      			return "NA"
			      		}
			        	
			        }},
				{
			        	"data": function(data, type, dataToSet) {
			        		var pdf = data.re_pdf;
			        		var filename = data.name ? data.name.replace(/\s+/g, '_') + '.pdf' : 'download.pdf';
			        		if (pdf != null && pdf != "") {
			        			return '<a class="fa fa-file-pdf-o" href="your_pdf?url=' + encodeURIComponent(pdf) + '" target="_blank" download="' + filename + '" style="color:green;font-size: 24px;"></a>';
			        		} else {
			        			return "NA";
			        		}
			        	}},
					
				],
				"lengthMenu" : [ [-1 ], ["All" ] ],
				select : true
				});
	}
	
	function downloadpdf() {
		 var group_id = $("#instituteGroup").val();
		 var school_id = $("#school_name").val();
		 var fd  = new FormData();
		 fd.append("group_id",group_id);
		 fd.append("school_id",school_id);
		 $.ajax({
				url : 'get_reviewed_pdf',
				data : fd,
				contentType : false,
				processData : false,
				type : 'post',
				success : function(data) {
					if (data['status'] == 'Success') {
						for(var i=0; i < data['data'].length; i++){
							if(data['data'][i].re_pdf != null && data['data'][i].re_pdf != ""){
								 var link = document.createElement('a');
			                        link.href = 'your_pdf?url=' + encodeURIComponent(data['data'][i].re_pdf);
			                        var filename = data['data'][i].name ? data['data'][i].name.replace(/\s+/g, '_') + '.pdf' : 'download.pdf';
			                        link.download = filename;
			                        document.body.appendChild(link);
			                        link.click();
			                        document.body.removeChild(link);
							}
						}
					}else{
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
		
		
	</script>
</body>
</html>