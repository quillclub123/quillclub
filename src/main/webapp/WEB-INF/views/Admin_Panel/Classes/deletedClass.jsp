<!DOCTYPE html>
<%@page import="com.quillBolt.model.InstituitonGroup"%>
<%@page import="java.util.List"%>
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
			<a href="classes" class="btn btn-primary btn-xs margin-bottom-10 waves-effect waves-light" >View Classes</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Deleted Classes Details</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="classTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Group</th>
		                        <th class="text-white">School Name</th>
		                        <th class="text-white">Class</th>
		                      <!--   <th class="text-white">Action</th> -->
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
		$("#classTable").DataTable({
				dom : 'Blfrtip',
				autoWidth : true,
				responsive: true, 
				buttons : [ {
						extend : 'pdf',
						exportOptions : {
						columns : [ 0, 1, 2,3]
					}
					},
					{
						extend : 'csv',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					
					}, 
					{
						extend : 'print',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					
					}, {
						extend : 'excel',
						exportOptions : {
						columns :  [ 0, 1, 2,3]
					}
					}, {
						extend : 'pageLength'
					} ],
						lengthChange : true,
						ordering : false,
					ajax : {
						url : "get_deletedclass",
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
						"data" : "classes"
					},
					
					
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	
	

	</script>
</body>
</html>