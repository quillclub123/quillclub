<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<div id="wrapper">
	<div class="main-content container">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<button type="button" class="btn btn-primary margin-bottom-10 waves-effect waves-light" data-toggle="modal" data-target="#question_model">Add Question</button>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Question</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="paperTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">School Name</th>
		                        <th class="text-white">Class</th>
		                        <th class="text-white">Questions</th>
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
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>
	function data() {
		$("#institutionTable").DataTable({
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
						url : "get_school",
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
						"data" : "school_name"
					},{
					{
						"data" : "class_name"
					},
					 {
						"data" : function(data, type,
								dataToSet) {
								var sno = data.sno;
								var string = "<button class='btn btn-success  fa fa-eye' type='button'  onclick='view("+sno+")' style='height:30px;width:40px; line-height:0'></button>";
								return string;
								}
							}
					
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	</script>
</body>
</html>