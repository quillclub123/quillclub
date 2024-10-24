<!doctype html>
<%@page import="com.quillBolt.model.Structure"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>

<jsp:include page="../css.jsp"></jsp:include>

</head>
<body>
	<%
	List<Structure> structures = (List<Structure>) request.getAttribute("structures");
	int sno = 0;
	if (structures.size() > 0) {
		sno = structures.get(0).getSno();
	}
	%>
	<input type="hidden" id="sno" name="sno" value="<%=sno%>">
	<div class="wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<div class="main-panel">
			<jsp:include page="../sidebar.jsp"></jsp:include>
<script>document.getElementById('structu').classList.add('active');</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">Structure</h4>
								</div>
								<div class="content">
									<form id="structure_form" name="structure_form">
										<div class="row">
											<div class="col-md-12">
													<button type="submit" class="btn btn-info btn-fill pull-right btn-xs sbmt">Save</button>
													<div class="clearfix"></div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<table class="table table-bordered" id="stockentrytable">
														<thead style="background: #002945;">
															<tr>
																<th style="color: white;font-size: 14px;"><p
																		style="margin-left: 12px;line-height: 1 !important;">Description</p></th>
																<th style="width: 10%; color: white; font-size: 14px; text-align: center;"><p style="line-height: 1 !important;">Words</p></th>
															</tr>
														</thead>
														<tbody id="tbody">
															<tr>

																<td><input type="text" class="form-control"
																	name="description1" id="description1"></td>
																<td><input type="text" class="form-control count"
																	name="words1" id="words1" onfocus="addrow()"
																	onchange="count(1)" style="width:100%; text-align: center;"></td>
															</tr>
														</tbody>
														<tfoot>
															<tr>

																<td style="text-align: right; font-size: 24px;">Total</td>
																<td><input type="text" class="form-control"
																	name="total_words" id="total_words" value="0" disabled style="width:95%; text-align: center;"></td>
															</tr>
														</tfoot>
													</table>
													<!-- <div class="space-between">
													<div>
														<button type="button"
															class="btn btn-danger btn-xs remove1">Remove Row</button>
													</div>
					
												</div> -->
												</div>

											</div>
											<div class="col-md-12">
											
													<button type="submit" class="btn btn-info btn-fill pull-right sbmt" style="margin-left: 5px;">Save</button>
													<button type="button" class="btn btn-success btn-fill pull-right btn-sm" onclick="addrow()" style="padding: 7px 15px;">+</button>
													<div class="clearfix"></div>
											</div>
										</div>

									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
		</div>
	</div>


</body>

<jsp:include page="../js.jsp"></jsp:include>
<script>

    let student_id = $("#student_id").val();
	let group_id = $("#group_id").val();
	let school_id = $("#school_id").val();
	let sno = $("#sno").val();
    $(document).ready(function() {
        // Allow only integer numbers in inputs with class "integer-only"
        $('.count').on('keypress', function(e) {
            // Check if the pressed key is a digit (0-9) or a control key (backspace, delete, etc.)
            if (e.which < 48 || e.which > 57) {
                e.preventDefault();
            }
        });

        // Also handle pasting and other non-keyboard inputs
        $('.count').on('input', function() {
            // Remove any non-digit characters
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });
    function addrow() {
		var count = $('#tbody > tr').length;
		var i = parseInt(count) + 1;
		var description1 = $("#description" + count).val();
		var html = '';
		if (description1 != null && description1 != "") {
			html += '<tr id="rowss'+i+'">';
			html += '<td><input type="text" name="description'+i+'" class="form-control "  id="description'+i+'"/></td>';
			html += '<td><input type="text" name="words'+ i+ '" class="form-control count"  id="words'+ i+ '" onfocus="addrow()" onchange="count('+i+')" style="width:100%; text-align: center;"/></td>';
			html += '</tr>';
			$('#tbody').append(html);
		} 
	}

	$(document).on('click', '.remove1', function() {
	var count = $('#tbody > tr').length;
		if(count > 1){
			var total= $("#total_words").val();
			var wo= $("#words"+count).val();
			var fin = parseInt(total) - parseInt(wo);
			$("#total_words").val(fin);
			$('#tbody > tr:last').remove();
		}
	});
	
	
	function count(i) {
		var total = $("#total_words").val();
       var words = $("#words"+i).val();
       
        var value = parseInt(total) + parseInt(words);

        if (!isNaN(value)) {
        	total = value;
        }
        $('#total_words').val(total);
    }
	$(function() {
		$("form[name='structure_form']").validate(
				{
					rules : {},
					messages : {},
					submitHandler : function(form) {
						var total_words = $("#total_words").val();
						var totaldata2 = $('#tbody > tr').length;
						var totalrows2 = parseInt(totaldata2);
						var fd = {
								'student_id' : student_id,
								'group_id' : group_id,
								'school_id' : school_id,
								'total_words' : total_words,
								'sd' : []
							};
							for (var i = 1; i <= totalrows2; i++) {
								var str = "#description" + i;
								var str1 = "#words" + i;
								var desc = $(str).val();
								var words = $(str1).val();
								if(desc != null && desc != "" && words != null && words != ""){
									fd.sd.push({
										'description' : desc,
										'words' : words,
									});
								}
								
							}
							$.ajax({
								url : 'add_structure', //add company Master controller name LocationController
								type : 'post',
								dataType : 'json',
								data : JSON.stringify(fd),
								contentType : 'application/json',
								success : function(data) {
									if (data['status'] == 'Success') {
										Swal.fire({
										    icon: 'success',
										    title: 'Successfully!',
										    text: data['message']
										}).then(() => {
										    setTimeout(() => {
										        location.reload();
										    }, 500);
										});
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
	if(sno != 0){
		$(".sbmt").html("Update");
		$(".sbmt").css("background","#002945");
		$(".sbmt").css("border","none");
		var fd = new FormData();
		fd.append("sno",sno);
		$.ajax({
			url : 'get_structuredata',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
					$("#total_words").val(data['data'][0].total_words);
				 	for(var j = 0; j < data['data1'].length; j++){
				 		if(j==0){
				 			$("#description1").val(data['data1'][j].description);
				 			$("#words1").val(data['data1'][j].words);
				 		}else{
				 			var html = '';
				 			var i = j+1;
				 			html += '<tr id="rowss'+i+'">';
							html += '<td><input type="text" name="description'+i+'" class="form-control " value="'+data['data1'][j].description+'" id="description'+i+'"/></td>';
							html += '<td><input type="text" name="words'+ i+ '" class="form-control count" value="'+data['data1'][j].words+'"  id="words'+ i+ '" onfocus="addrow()" onchange="count('+i+')" style=" width:100%; text-align: center;"/></td>';
							html += '</tr>';
							$('#tbody').append(html);
				 		}
				 	}
				}
			}
		});
	}
    </script>
</html>
