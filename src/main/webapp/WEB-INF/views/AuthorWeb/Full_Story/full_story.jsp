<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.quillBolt.model.Story"%>
<%@page import="com.quillBolt.model.DraftStory"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>

<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.16.0/ckeditor.js"
	integrity="sha512-7My1gsUz5JUQgT8+P0sHKaPel/77X3zjGZsXbTS8Y7MhDEJ+f9xg9H+pPzONFL5djye0zWLlxFLApGsWQ1gdfA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
.full-screen {
	width: 100vw;
	height: 100vh !important;
	position: fixed; /* Fixed position to cover the viewport */
	top: 0;
	left: 0;
	border: none; /* Remove border */
	box-shadow: none; /* Remove shadow */
	z-index: 9999; /* Ensure it is on top */
	resize: none; /* Disable manual resizing when full screen */
	padding-top: 38px;
}

.mbtn {
	position: absolute;
	top: 100px;
	right: 15px;
	padding: 0px 6px;
	font-size: 20px;
	cursor: pointer;
	z-index: 10000;
	color: black;
	font-weight: 900;
}
.mmbtn{
    margin-top: -174px;
    margin-right: 40px;
}
.maximize-btn {
	display: block;
}

.minimize-btn {
	display: none;
	transform: translate(54px, -306px);
}
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
	List<DraftStory> ds = (List<DraftStory>) request.getAttribute("ds");
	List<Story> si = (List<Story>) request.getAttribute("si");
	int d = 0;
	int cnt = 0;
	if (ds.size() > 0) {
	    d = ds.get(0).getSno();
	    String fullStory = ds.get(0).getFull_story();
	    fullStory = fullStory.replaceAll("\\s+", " ").trim();
	    String[] words = fullStory.split(" ");
	    cnt = words.length;
	}

	int s = 0;
	if (si.size() > 0) {
		s = si.get(0).getSno();
		 String fullStory = si.get(0).getFull_story();
		    fullStory = fullStory.replaceAll("\\s+", " ").trim();
		    String[] words = fullStory.split(" ");
		    cnt = words.length;
	}
	%>
	<input type="hidden" id="ds" name="ds" value="<%=d%>">
	<input type="hidden" id="si" name="si" value="<%=s%>">
	<div class="wrapper">
		<jsp:include page="../header.jsp"></jsp:include>

		<div class="main-panel">
			<jsp:include page="../sidebar.jsp"></jsp:include>
<script>document.getElementById('f_story').classList.add('active');</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<!-- <div class="header">
									<h4 class="title">Full Story</h4>
								</div> -->
								<div class="content">
									<form id="story_form" name="story_form">
									<div class="tabset">
										<!-- Tab 1 -->
										<input type="radio" name="tabset" id="tab1"
											aria-controls="marzen" checked style="display: none;">
										<label for="tab1">Title & Blurb</label>
										<!-- Tab 2 -->
										<input type="radio" name="tabset" id="tab2"
											aria-controls="rauchbier" style="display: none;"> <label
											for="tab2">Full Story</label>

										<div class="tab-panels">
											<section id="marzen" class="tab-panel">
												<div class="row">
													<div class="col-md-12">
														<div class="form-group">
															<label>Title</label> <input type="text"
																class="form-control" id="title" name="title">
														</div>
													</div>
													<div class="col-md-12">
														<div class="form-group">
															<label>Blurb</label> <input type="text"
																class="form-control" id="blurb" name="blurb">
														</div>
		
													</div>
												</div>
											</section>
											<section id="rauchbier" class="tab-panel">
												<div class="row">
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right btn-xs sbmt" style="margin-top: -64px;">Save</button>
												<div class="clearfix"></div>
											</div>
											
											<div class="col-md-12">
												<div class="form-group" style="margin-top: -60px;">
													<p style="float: right;color: red;transform: translate(-3px, 14px);">Words: <span id="count"><%=cnt%><span></p>
													<textarea class="form-control" rows="40" id="story_idea"
														name="story_idea" placeholder="Write story here"></textarea>
													<button type="button" id="maximizeButton"
														class="btn maximize-btn mbtn mmbtn">⛶</button>
													<button type="button" id="minimizeButton"
														class="btn minimize-btn mbtn">↩</button>
												</div>
											</div>
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right sbmt">Save</button>
												<div class="clearfix"></div>
											</div>
										</div>
											</section>
										</div>

									</div>
										<%-- <div class="row">
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right btn-xs sbmt">Save</button>
												<div class="clearfix"></div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label>Title</label> <input type="text"
														class="form-control" id="title" name="title">
												</div>
											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label>Blurb</label> <input type="text"
														class="form-control" id="blurb" name="blurb">
												</div>

											</div>
											<div class="col-md-12">
												<div class="form-group">
													<label>Story</label>
													<p style="float: right;color: red;transform: translate(-3px, 14px);">Words: <span id="count"><%=cnt%><span></p>
													<textarea class="form-control" rows="10" id="story_idea"
														name="story_idea" placeholder="Write story here"></textarea>
													<button type="button" id="maximizeButton"
														class="btn maximize-btn mbtn">⛶</button>
													<button type="button" id="minimizeButton"
														class="btn minimize-btn mbtn">↩</button>
												</div>
											</div>
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right sbmt">Save</button>
												<div class="clearfix"></div>
											</div>
										</div> --%>

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

	<jsp:include page="../js.jsp"></jsp:include>
	<script>
	$(document).ready(function() {
	    $("#story_idea").keyup(function() {
	        let text = $.trim($(this).val());
	        let count = text.length === 0 ? 0 : text.split(/\s+/).length;
	        $("#count").html(count);
	    });
	});
		let student_id = $("#student_id").val();
		let group_id = $("#group_id").val();
		let school_id = $("#school_id").val();
		let ds = $("#ds").val();
		let si = $("#si").val();
		var textArea = document.getElementById('story_idea');
		var maximizeButton = document.getElementById('maximizeButton');
		var minimizeButton = document.getElementById('minimizeButton');

		maximizeButton.addEventListener('click', function() {
			textArea.classList.add('full-screen');
			document.body.style.overflow = 'hidden'; // Prevent page scroll
			maximizeButton.style.display = 'none';
			minimizeButton.style.display = 'block';
		});

		minimizeButton.addEventListener('click', function() {
			textArea.classList.remove('full-screen');
			document.body.style.overflow = ''; // Restore page scroll
			maximizeButton.style.display = 'block';
			minimizeButton.style.display = 'none';
		});
		if (si != 0) {
			$(".sbmt").html("Update");
			$(".sbmt").css("background", "#002945");
			$(".sbmt").css("border", "none");
		}

		$(function() {
			$("form[name='story_form']").validate({
				rules : {
					title : {
						required : true,
					},
					blurb : {
						required : true,
					},
					story_idea : {
						required : true,
					},
				},
				messages : {
					title : {
						required : "Please enter title",
					},
					blurb : {
						required : "Please enter blurb",
					},
					story_idea : {
						required : "Please write Story Idea....",
					},
				},
				submitHandler : function(form) {
					var title = $('#title').val();
					var blurb = $('#blurb').val();
					var story_idea = $('#story_idea').val();
					var fd = {
						'student_id' : student_id,
						'group_id' : group_id,
						'school_id' : school_id,
						'title' : title,
						'blurb' : blurb,
						'full_story' : story_idea,
					};
					$.ajax({
						url : 'add_story', //controller name StoryController
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
								    	$(".sbmt").html("Update");
										$(".sbmt").css("background","#002945");
										$(".sbmt").css("border","none");
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
			var title = $('#title').val();
			var blurb = $('#blurb').val();
			var story_idea = $('#story_idea').val();
			if (title != null && title != "" && story_idea != null
					&& story_idea != "" && blurb != null && blurb != "") {
				var fd = {
					'student_id' : student_id,
					'group_id' : group_id,
					'school_id' : school_id,
					'title' : title,
					'blurb' : blurb,
					'full_story' : story_idea,
				};
				$.ajax({
					url : 'add_draftstory',
					type : 'post',
					dataType : 'json',
					data : JSON.stringify(fd),
					contentType : 'application/json',
					success : function(data) {
					}
				});
			}
		}
		setInterval(callApi, 30000);
		callApi();

		if (ds != 0) {
			var fd = new FormData();
			fd.append("sno", ds);
			fd.append("student_id", student_id);
			$.ajax({
				url : 'get_draftstory',
				type : 'post',
				data : fd,
				contentType : false,
				processData : false,
				success : function(data) {
					if (data['status'] == 'Success') {
						$("#title").val(data['data'][0].title);
						$("#blurb").val(data['data'][0].blurb);
						$("#story_idea").val(data['data'][0].full_story);
					}
				}
			});
		}
	</script>
</body>
</html>
