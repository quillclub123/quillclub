<!doctype html>
<%@page import="com.quillBolt.model.DraftPassage"%>
<%@page import="com.quillBolt.model.AuthorProfileQuestion"%>
<%@page import="java.util.List"%>
<%@page import="com.quillBolt.model.QuestionList"%>
<html lang="en">
<head>

<jsp:include page="../css.jsp"></jsp:include>

<style>
.tabset .tab-panel {
	display: none;
}

.tabset>input:first-child:checked ~ .tab-panels>.tab-panel:first-child,
	.tabset>input:nth-child(3):checked ~ .tab-panels>.tab-panel:nth-child(2),
	.tabset>input:nth-child(5):checked ~ .tab-panels>.tab-panel:nth-child(3),
	.tabset>input:nth-child(7):checked ~ .tab-panels>.tab-panel:nth-child(4),
	.tabset>input:nth-child(9):checked ~ .tab-panels>.tab-panel:nth-child(5),
	.tabset>input:nth-child(11):checked ~ .tab-panels>.tab-panel:nth-child(6)
	{
	display: block;
}

.tabset>label {
	position: relative;
	display: inline-block;
	padding: 15px 15px 25px;
	border: 1px solid transparent;
	border-bottom: 0;
	cursor: pointer;
	
}

.tabset>label::after {
	content: "";
	position: absolute;
	left: 15px;
	bottom: 10px;
	width: 22px;
	height: 4px;
	background: #8d8d8d;
}

input:focus-visible+label {
	outline: 2px solid rgba(0, 102, 204, 1);
	border-radius: 3px;
}

.tabset>label:hover, .tabset>input:focus+label, .tabset>input:checked+label
	{
	color: #06c;
}

.tabset>label:hover::after, .tabset>input:focus+label::after, .tabset>input:checked+label::after
	{
	background: #06c;
}

.tabset>input:checked+label {
	border-color: #ccc;
	border-bottom: 1px solid #fff;
	margin-bottom: -1px;
}

.tab-panel {
	padding: 30px 0;
	border-top: 1px solid #ccc;
}

/*
 Demo purposes only
*/
*, *:before, *:after {
	box-sizing: border-box;
}

.tabset {
	max-width: 100%;
}
</style>

</head>
<body>
<%
List<QuestionList> ql =(List<QuestionList>)request.getAttribute("qlist");
List<AuthorProfileQuestion> apq = (List<AuthorProfileQuestion>)request.getAttribute("apq");
List<DraftPassage> dp = (List<DraftPassage>)request.getAttribute("dp");
int q=0;
int cnt=0;
if(apq.size() > 0){
	q= apq.get(0).getSno();
}
int d=0;
if(dp.size() > 0){
	d= dp.get(0).getSno();
	 String fullStory = dp.get(0).getPassage();
	    fullStory = fullStory.replaceAll("\\s+", " ").trim();
	    String[] words = fullStory.split(" ");
	    cnt = words.length;
}
%>
<input type="hidden" id="apq" name="apq"  value="<%=q%>">
<input type="hidden" id="dp" name="dp"  value="<%=d%>">
	<!-- Preloader -->
	<!-- <div class="prel" id="preloader">
  <div aria-busy="true" aria-label="Loading, please wait." role="progressbar">
    <h1 class="pheader">Welcome To Author Panel</h1>
  </div>
</div> -->
	<div class="wrapper" id="maincont" style="display: block;">
		<jsp:include page="../header.jsp"></jsp:include>

		<div class="main-panel">
			<jsp:include page="../sidebar.jsp"></jsp:include>
<script>document.getElementById('a_profile').classList.add('active');</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">Author Profile</h4>
								</div>
								<div class="content">
									<div class="tabset">
										<!-- Tab 1 -->
										<input type="radio" name="tabset" id="tab1"
											aria-controls="marzen" checked style="display: none;">
										<label for="tab1">All About You</label>
										<!-- Tab 2 -->
										<input type="radio" name="tabset" id="tab2"
											aria-controls="rauchbier" style="display: none;" disabled> <label
											for="tab2">Full Author Profile</label>

										<div class="tab-panels">
											<section id="marzen" class="tab-panel">
												<!-- <h2>6A. Märzen</h2> -->
												<input type="hidden" id="size" name="size" value="<%=ql.size()%>">
												<form id="questionnaire" name="questionnaire"> 
													<div style="padding-right: 7px;">
														<button type="submit" class="btn btn-info btn-fill pull-right btn-xs qbtn" style="margin-top: -60px;">Save</button>
													</div>
													<div class="row p-0"><%
													for (int i = 0; i < ql.size(); i++) {
													%>
													
														<div class="col-md-12">
															<div class="form-group">
															<input type="hidden" id="question_id<%=i %>" name="question_id<%=i %>" name="question_id<%=i %>" value="<%=ql.get(i).getSno()%>">
																<label>Q<span id="seq_no<%=i%>"><%=ql.get(i).getSeq_no()%></span>.<%=ql.get(i).getQuestion()%>
																</label>
																<textarea class="form-control" rows="3" id="answer<%=i %>" name="answer<%=i %>"
																	placeholder="Write answer here..."></textarea>
															</div>
															</div>
															<%
															}
															%>
															<div class="col-md-12">
																<button type="submit" class="btn btn-info btn-fill pull-right qbtn">Save</button>
																<div class="clearfix"></div>
														</div>
														
													</div>
													
													
												</form>
											</section>
											<section id="rauchbier" class="tab-panel">
												<form id="passage_form" name="passage_form">
													<div class="row p-0">
													<div style="padding-right: 7px;">
														<button type="submit" class="btn btn-info btn-fill pull-right btn-xs pbtn" style="margin-top: -60px;">Save</button>
													</div>
														<div class="col-md-12">
															<div class="form-group">
																<label>Full Author Profile 
																</label>
																<p style="float: right;color: red;">Words: <span id="count"><%=cnt%><span></p>
																<textarea id="passage" name="passage" class="form-control" rows="15"
																	placeholder="Write passage here..."></textarea>
															</div>
			
														</div>
														<div class="col-12">
															<button type="submit" class="btn btn-info btn-fill pull-right pbtn">Save</button>
															<div class="clearfix"></div>
														</div>
													</div>
												</form>
											</section>
										</div>

									</div>
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
$(document).ready(function() {
    $("#passage").keyup(function() {
        let text = $.trim($(this).val());
        let count = text.length === 0 ? 0 : text.split(/\s+/).length;
        $("#count").html(count);
    });
});

	let student_id = $("#student_id").val();
	let group_id = $("#group_id").val();
	let school_id = $("#school_id").val();
	let apq = $("#apq").val();
	let dp = $("#dp").val();
	if(apq != 0){
		$("#tab2").prop("disabled",false);
		$(".qbtn").html("Update");
		$(".qbtn").css("background","#002945");
		$(".qbtn").css("border","none");
		var fd = new FormData();
		fd.append("sno",apq);
		$.ajax({
			url : 'get_qa',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
				 	for(var i = 0; i < data['data'].length; i++){
				 		$("#answer"+i).val(data['data'][i].answer);
				 	}
				}
			}
		});
	}
	if(dp != 0){
		$(".pbtn").html("Update");
		$(".pbtn").css("background","#002945");
		$(".pbtn").css("border","none");
		var fd = new FormData();
		fd.append("sno",dp);
		fd.append("student_id",student_id);
		$.ajax({
			url : 'get_passage',
			type : 'post',
			data : fd,
			contentType :  false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
					$("#passage").val(data['data'][0].passage);
				}
			}
		});
	}
	
	$(function() {
		$("form[name='questionnaire']").validate(
				{
					rules : {},
					messages : {},
					submitHandler : function(form) {
						var totaldata2 = $('#size').val();
						var totalrows2 = parseInt(totaldata2);
						var fd = {
								'student_id' : student_id,
								'group_id' : group_id,
								'school_id' : school_id,
								'ps' : []
							};
							for (var i = 0; i < totalrows2; i++) {
								var str = "#question_id" + i;
								var str1 = "#answer" + i;
								var str2 = "#seq_no" + i;
								var q_id = $(str).val();
								var answer = $(str1).val();
								var seq_no = $(str2).val();
								fd.ps.push({
									'question_id' : q_id,
									'answer' : answer,
									'seq_no' : seq_no,
								});
							}
							$.ajax({
								url : 'add_apq', //add company Master controller name LocationController
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
	$(function() {
		$("form[name='passage_form']").validate(
				{
					rules : {
						passage : {
							required : true,
						},
					},
					messages : {
						passage : {
							required : "Please write full author profile.",
						},
					},
					submitHandler : function(form) {
						var passage = $('#passage').val();
						var fd = {
								'student_id' : student_id,
								'group_id' : group_id,
								'school_id' : school_id,
								'passage' : passage,
							};
							$.ajax({
								url : 'add_passage', //add company Master controller name LocationController
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
										    	$(".pbtn").html("Update");
												$(".pbtn").css("background","#002945");
												$(".pbtn").css("border","none");
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
	
	function callApi() {
		if ($('#tab2').is(':checked'))  {
			var passage = $('#passage').val();
			if(passage != null && passage != ""){
				var fd = {
						'student_id' : student_id,
						'group_id' : group_id,
						'school_id' : school_id,
						'passage' : passage,
					};
					$.ajax({
						url : 'add_draftpassage', //add company Master controller name LocationController
						type : 'post',
						dataType : 'json',
						data : JSON.stringify(fd),
						contentType : 'application/json',
						success : function(data) {
						}
					});
			}
		}
    }
    setInterval(callApi, 30000);
    callApi();
</script>
</html>
