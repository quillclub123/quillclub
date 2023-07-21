<!DOCTYPE html>
<%@page import="java.util.Date"%>
<%@page import="com.quillBolt.model.Schools"%>
<%@page import="com.quillBolt.model.Answers"%>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	.fullA:hover{
		 cursor: pointer;
	}
	.odd td{
		font-size: 11px !important;
	}
	.even td{
		font-size: 11px !important;
	}
	</style>
</head>

<body>
<%List<Answers> data = (List<Answers>)request.getAttribute("data");
List<Schools> school = (List<Schools>)request.getAttribute("school");
List<InstituitonGroup> group = (List<InstituitonGroup>)request.getAttribute("group");
List<String> section = (List<String>)request.getAttribute("section");
List<String> class_name = (List<String>)request.getAttribute("class_name");
List<String> name = (List<String>)request.getAttribute("name");
List<Date> createdAt = (List<Date>)request.getAttribute("createdAt");
%>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Answers Details</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="answerTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">No</th>
		                        <th class="text-white"><select id="name" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important;"><option value="">Name</option><%if(name.size() > 0){for(String a : name){ %><option value="<%=a%>"><%=a%></option><%}} %> </select></th>
		                        <th class="text-white"><select id="cls" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important; width: 55px !important;"><option value="">Cls</option><%if(class_name.size() > 0){for(String a : class_name){ %><option value="<%=a%>"><%=a%></option><%}} %>  </select></th>
		                        <th class="text-white"><select id="sec" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important; width: 55px !important;"><option value="">Sec</option><%if(section.size() > 0){for(String a : section){ %><option value="<%=a%>"><%=a%></option><%}} %>  </select></th>
		                        <th class="text-white"><select id="group" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important;"><option value="">Group</option><%if(data.size() > 0){for(InstituitonGroup g : group){ %><option value="<%=g.getSno()%>"><%=g.getInstitution_group()%></option><%}} %></select></th>
		                        <th class="text-white"><select id="school" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important;"><option value="">School</option><%if(data.size() > 0){for(Schools s : school){ %><option value="<%=s.getSno()%>"><%=s.getSchool_name()%></option><%}} %>  </select></th>
		                        <th class="text-white"><select id="date" class="viewsearch form-control text-white bg-primary" style="height: 30px !important; padding: 0 !important;"><option value="">Date</option><%if(createdAt.size() > 0){for(Date a : createdAt){ %><option value="<%=a%>"><%=a%></option><%}} %>  </select></th>
		                        <th class="text-white">Answer</th>
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
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Full Answer</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<p id="answerFull"></p>
					</div>
				</div>
						
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm waves-effect waves-light" data-dismiss="modal">Close</button>
			</div>
			
		</div>
	</div>
</div>


	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	function data() {
		$("#answerTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				destroyee : true,
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2,3,4,5,6,7],
						 format: {
					            header: function(data, columnIdx) {
					              // Custom column header string
					              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
					              return columnHeader[columnIdx];
					            }
					          }
					        }
					},
					{
						extend : 'csv',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6,7],
					 format: {
				            header: function(data, columnIdx) {
				              // Custom column header string
				              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
				              return columnHeader[columnIdx];
				            }
				          }
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6,7],
					 format: {
				            header: function(data, columnIdx) {
				              // Custom column header string
				              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
				              return columnHeader[columnIdx];
				            }
				          }
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns :  [ 0, 1, 2,3,4,5,6,7],
					 format: {
				            header: function(data, columnIdx) {
				              // Custom column header string
				              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
				              return columnHeader[columnIdx];
				            }
				          }
					}
					}, 
					{
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_answer",
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
						"data" : "name"
					},
					{
						"data" : "class_name"
					},
					{
						"data" : "section"
					},
					{
						"data" : "group"
					},
					{
						"data" : "school"
					},
					{
						"data" : function(data, type,
								dataToSet) {
							var date = data.createdAt;
							 var dateobj    = new Date(date);
						     var formattedstring =dateobj.getFullYear()+"-"+(dateobj.getMonth()+1)+"-"+ dateobj.getDate();
							 var string =  formattedstring;
							 return string;
						}
					},
					{
		                "data": function (data, type, dataToSet) {
		                	 var sno = data.sno;
		                     var answer = data.answer;
		                     var text = answer.substring(0, 35);
		                     var fullText = answer; // Store the full answer separately
		                     var string = "<a style='display:block;  width:100px; height:15px; overflow:hidden;' class='fullA' id='answer" + sno + "' onclick='fullAnswer(" + sno + ")'>" + answer + "</a>";
		                     return string; // Return an object with both display and full answer
		                }
		                
		            }
					],
					"lengthMenu" : [ [25, 50,-1 ], [25, 50,"All" ] ],
					select : true
					});
		
						var headerData = $("#answerTable").DataTable().columns().header().to$().find('th').map(function() {
					        return $(this).text().trim();
					    }).get();
					}
		data();
	
		 $(".viewsearch")
		 .change(
				 function(){
					let name = $("#name").val();
					//alert(authorisedPersonSearch);
					let cls = $("#cls").val();
					let sec = $("#sec").val();
					let group = $("#group").val();
					let school = $("#school").val();
					let date = $("#date").val();
					$("#answerTable").DataTable().clear();
					var table = $("#answerTable").DataTable({
						dom : "Blfrtip",
						destroy : true,
						autoWidth : true,			
						buttons : [ {
							extend : 'pdf',
							exportOptions : {
							columns : [ 0, 1, 2,3,4,5,6,7],
							 format: {
						            header: function(data, columnIdx) {
						              // Custom column header string
						              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
						              return columnHeader[columnIdx];
						            }
						          }
						}
						},
						{
							extend : 'csv',
							exportOptions : {
							columns :  [ 0, 1, 2,3,4,5,6,7], format: {
					            header: function(data, columnIdx) {
						              // Custom column header string
						              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
						              return columnHeader[columnIdx];
						            }
						          }
						}
						
						}, 
						{
							extend : 'print',
							exportOptions : {
							columns :  [ 0, 1, 2,3,4,5,6,7], format: {
					            header: function(data, columnIdx) {
						              // Custom column header string
						              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
						              return columnHeader[columnIdx];
						            }
						          }
						}
						
						}, {
							extend : 'excel',
							exportOptions : {
								columns :  [ 0, 1, 2,3,4,5,6,7], format: {
						            header: function(data, columnIdx) {
							              // Custom column header string
							              var columnHeader = ['No','Name', 'Cls', 'Sec', 'Group', 'School', 'Date', 'Answer'];
							              return columnHeader[columnIdx];
							            }
							          }
							}
						}, {
							extend : 'pageLength'
						} ],
							lengthChange : true,
							ordering : false,
						ajax : {
							url : "get_answer",
							type : "POST",
							"data" : {
								"name" :name,
								"class_name" :cls,
								"section" :sec,
								"group_id" :group,
								"school_id" :school,
								"createdAt" :date,
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
							"data" : "class_name"
						},
						{
							"data" : "section"
						},
						{
							"data" : "group"
						},
						{
							"data" : "school"
						},
						{
							"data" : function(data, type,
									dataToSet) {
								var date = data.createdAt;
								 var dateobj    = new Date(date);
							       var formattedstring =dateobj.getFullYear()+"-"+(dateobj.getMonth()+1)+"-"+ dateobj.getDate();
								var string = "<span id='category'>"+ formattedstring + "</span>"
								return string;
							}
						},
						{
			                "data": function (data, type, dataToSet) {
			                	 var sno = data.sno;
			                     var answer = data.answer;
			                     var text = answer.substring(0, 35);
			                     var fullText = answer; // Store the full answer separately
			                     var string = "<a style='display:block;  width:100px; height:15px; overflow:hidden;' class='fullA' id='answer" + sno + "' onclick='fullAnswer(" + sno + ")'>" + answer + "</a>";
			                     return string; // Return an object with both display and full answer
			                }
			                
			            },
						],
						 "lengthMenu" : [ [-1 ], ["All" ] ],
						select : true 
						
					});

				 });
		
		
		function fullAnswer(i){
			var fd = new FormData();
			fd.append("sno",i);
			$.ajax({
				url : 'get_answerdata',
				type : 'post',
				data : fd,
				contentType :  false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						 $('#answer_full').modal('toggle');
						 $("#answerFull").html(data['data'][0].answer);
					} 
				}
			});
		}
	
	</script>
</body>
</html>