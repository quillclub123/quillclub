<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="../css.jsp"></jsp:include>
	<style>
	.fullQ:hover{
		 cursor: pointer;
	}
	</style>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<script>
	document.getElementById('testi').classList.add('active');
	document.getElementById('tst').style.display = 'block';
	document.getElementById('mqb').classList.add('sidecolor');
</script>
<div id="wrapper">
	<div class="main-content">
		<div class="row small-spacing">
			<div class="col-lg-12 col-xs-12">
			<a href="question" class="btn btn-primary btn-xs margin-bottom-10 waves-effect waves-light">View Question</a>
				<div class="box-content card white" style="padding-bottom: 20px;">
					<h4 class="box-title">View Deleted Question</h4>
					<!-- /.box-title -->
					<div class="card-content">
						<table id="questionTable" class="table table-striped table-bordered display dataTable" style="width:100%">
		                  <thead class="bg-primary">
		                     <tr>
		                        <th class="text-white">Sr.No</th>
		                        <th class="text-white">Title</th>
		                        <th class="text-white">Question</th>
		                        <th class="text-white">Question Image</th>
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

<div class="modal fade" id="question_full" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Question</h4>
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
<input type="hidden" id="sno" name="sno" value="0">
	<jsp:include page="../js.jsp"></jsp:include>
	
	<script>

	
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
						url : "get_Deletedquestion",
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
						"data" : "title"
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
			      			return '<img src="displaydocument?url='+imageName+'" width="100" height="100"/>';
			      		}else{
			      			return "NA"
			      		}
			        	
			        }},
					
					
					],
					"lengthMenu" : [ [ 5, 10, 25, 50 ] , [ 5, 10, 25, 50 ] ],
					select : true
					});
					}
		data();
	
	
		function fullQuestion(i){
			$("#qqImg").css("display","none");
			var fd = new FormData();
			fd.append("sno",i);
			$.ajax({
				url : 'edit_question',
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
	
	</script>
</body>
</html>