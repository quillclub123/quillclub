<!doctype html>
<%@page import="com.quillBolt.model.Reflections"%>
<%@page import="java.util.List"%>
<%@page import="com.quillBolt.model.DraftedReflections"%>
<html lang="en">
<head>

<jsp:include page="../css.jsp"></jsp:include>

</head>
<body>
	<%
	List<DraftedReflections> ds = (List<DraftedReflections>) request.getAttribute("ds");
	List<Reflections> si = (List<Reflections>) request.getAttribute("si");
	int d = 0;
	int cnt=0;
	if (ds.size() > 0) {
		d = ds.get(0).getSno();
		 String fullStory = ds.get(0).getReflection();
		    fullStory = fullStory.replaceAll("\\s+", " ").trim();
		    String[] words = fullStory.split(" ");
		    cnt = words.length;
	}
	int s = 0;
	if (si.size() > 0) {
		s = si.get(0).getSno();
		 String fullStory = si.get(0).getReflection();
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
<script>document.getElementById('reflec').classList.add('active');</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">Reflections</h4>
								</div>
								<div class="content">
									<form id="idea_form" name="idea_form">
										<div class="row">
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right btn-xs sbmt">Save</button>
												<div class="clearfix"></div>
											</div>
											<!--  <div class="col-md-12">
                                            <div class="form-group" >
                                                <label>Blurb</label>
                                                 <input type="text" class="form-control" id="blurb" name="blurb">
                                            </div>
                                           
                                        </div> -->
											<div class="col-md-12">
												<div class="form-group">
													<label>Reflections</label>
													<p style="float: right;color: red;">Words: <span id="count"><%=cnt%><span></p>
													<textarea class="form-control" rows="10" id="reflections"
														name="reflections" placeholder="Write story idea here"></textarea>
												</div>
											</div>
											<div class="col-md-12">
												<button type="submit"
													class="btn btn-info btn-fill pull-right sbmt">Save</button>
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
/* $(document).ready(function() {
    $("#reflections").keyup(function() {
        let text = $.trim($(this).val());
        let count = text.length === 0 ? 0 : text.split(/\s+/).length;
        $("#count").html(count);
    });
}); */
$(document).ready(function() {
    $("#reflections").on("input", function(event) {
        let text = $.trim($(this).val());
        let words = text.length === 0 ? [] : text.split(/\s+/);
        let wordCount = words.length;

        // Update the word count display
        $("#count").html(wordCount);

        // Check if the word count exceeds the limit
        if (wordCount > 300) {
            event.preventDefault(); // Prevent additional input
            let limitedText = words.slice(0, 300).join(" ");
            $(this).val(limitedText); // Trim the input to the first 300 words

            // Display the warning message
            alert("You have reached the word limit of 300.");
        } else {
            // Hide the warning if within the limit
            $("#warning").html("").hide();
        }
    });
});

	let student_id = $("#student_id").val();
	let group_id = $("#group_id").val();
	let school_id = $("#school_id").val();
	let ds = $("#ds").val();
	let si = $("#si").val();
	if (si != 0) {
		$(".sbmt").html("Update");
		$(".sbmt").css("background", "#002945");
		$(".sbmt").css("border", "none");
	}

	$(function() {
		$("form[name='idea_form']").validate({
			rules : {
				reflections : {
					required : true,
				},
			},
			messages : {
				reflections : {
					required : "Please write reflection....",
				},
			},
			submitHandler : function(form) {
				var reflections = $('#reflections').val();
				var fd = {
					'student_id' : student_id,
					'group_id' : group_id,
					'school_id' : school_id,
					'reflection' : reflections,
				};
				$.ajax({
					url : 'add_reflection', //controller name ReflectionsController
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
	function callApi() {
		var reflections = $('#reflections').val();
		if (reflections != null
				&& reflections != "") {
			var fd = {
				'student_id' : student_id,
				'group_id' : group_id,
				'school_id' : school_id,
				'reflection' : reflections,
			};
			$.ajax({
				url : 'add_draftreflection',
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
			url : 'get_reflection',
			type : 'post',
			data : fd,
			contentType : false,
			processData : false,
			success : function(data) {
				if (data['status'] == 'Success') {
					$("#reflections").val(data['data'][0].reflection);
				}
			}
		});
	}
</script>
</html>
