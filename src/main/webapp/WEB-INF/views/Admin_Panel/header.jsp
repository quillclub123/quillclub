<%@page import="com.quillBolt.model.AdminLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%AdminLogin loginData = (AdminLogin)session.getAttribute("loginData"); %>
<div class="main-menu">
	<header class="header">
		<a href="index.html" class="logo">Quill Club Writers</a>
		<button type="button" class="button-close fa fa-times js__menu_close"></button>
		<!-- <div class="user">
			<a href="#" class="avatar"><img src="http://placehold.it/80x80" alt=""><span class="status online"></span></a>
			<h5 class="name"><a href="#">Administrator</a></h5>
			
		</div> -->
		<!-- /.user -->
	</header>
	<!-- /.header -->
	<div class="content">

		<div class="navigation">
			<!-- /.title -->
			<ul class="menu js__accordion">
				<li class="current">
					<a class="waves-effect" href="dashboard?email=<%=loginData.getEmail()%>"><i class="menu-icon fa fa-home"></i><span>Dashboard</span></a>
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-envelope"></i><span>Mail Template</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="mailTemplate">Manage</a></li>
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-upload"></i><span>Top Image Banner</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="top_image_banner">Manage</a></li>
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-info"></i><span>QCW Info</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="information">Manage</a></li>
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-database"></i><span>Groups</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="viewgroup">Manage</a></li>
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-graduation-cap"></i><span>Schools</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="schools">Manage</a></li>
						
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
<!-- 				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-child"></i><span>Classes</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="classes">Classes Details</a></li>
						
					</ul>
					/.sub-menu js__content
				</li> -->
				 <li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-folder-open"></i><span>Section</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="section">Manage</a></li>
						
					</ul>
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-question-circle"></i><span>Question Bank</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="question">Manage</a></li>
						
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-child"></i><span>Program Info</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="progarmInformation">Manage</a></li>
						
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-question-circle"></i><span>Sample</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="sample_question">Add Question</a></li>
						 <li><a href="sample_answer">Add Answer</a></li>
						
					</ul>
					<!-- /.sub-menu js__content -->
				</li>
				<!-- <li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-paperclip"></i><span> Set Papers</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="addPaper">Set Paper</a></li>
						 <li><a href="viewPaper">View Paper</a></li>
						
					</ul>
				</li> -->
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-file-text-o"></i><span>Answers</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="viewAnswers">View Answers</a></li>
						<!--  <li><a href="viewPaper">View Paper</a></li> -->
						
					</ul>
				</li>
				
			</ul>
			<!-- /.menu js__accordion -->
		</div>
		<!-- /.navigation -->
	</div>
	<!-- /.content -->
</div>
<!-- /.main-menu -->

<div class="fixed-navbar">
	<div class="pull-left">
		<button type="button" class="menu-mobile-button glyphicon glyphicon-menu-hamburger js__menu_mobile"></button>
		<h1 class="page-title">Home</h1>
		<!-- /.page-title -->
	</div>
	<!-- /.pull-left -->
	<div class="pull-right">
		<div class="ico-item">
			<a href="#" class="ico-item fa fa-search js__toggle_open" data-target="#searchform-header"></a>
			<form action="#" id="searchform-header" class="searchform js__toggle"><input type="search" placeholder="Search..." class="input-search"><button class="fa fa-search button-search" type="submit"></button></form>
			<!-- /.searchform -->
		</div>
		<!-- /.ico-item -->
		<div class="ico-item fa fa-arrows-alt js__full_screen"></div>
		
		
		<a href="logout" class="ico-item fa fa-power-off"></a>
	</div>
	<!-- /.pull-right -->
</div>
<!-- /.fixed-navbar -->

<div id="notification-popup" class="notice-popup js__toggle" data-space="75">
	<h2 class="popup-title">Your Notifications</h2>
	<!-- /.popup-title -->
	<div class="content">
		<ul class="notice-list">
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">John Doe</span>
					<span class="desc">Like your post: “Contact Form 7 Multi-Step”</span>
					<span class="time">10 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Anna William</span>
					<span class="desc">Like your post: “Facebook Messenger”</span>
					<span class="time">15 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar bg-warning"><i class="fa fa-warning"></i></span>
					<span class="name">Update Status</span>
					<span class="desc">Failed to get available update data. To ensure the please contact us.</span>
					<span class="time">30 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/128x128" alt=""></span>
					<span class="name">Jennifer</span>
					<span class="desc">Like your post: “Contact Form 7 Multi-Step”</span>
					<span class="time">45 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Michael Zenaty</span>
					<span class="desc">Like your post: “Contact Form 7 Multi-Step”</span>
					<span class="time">50 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Simon</span>
					<span class="desc">Like your post: “Facebook Messenger”</span>
					<span class="time">1 hour</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar bg-violet"><i class="fa fa-flag"></i></span>
					<span class="name">Account Contact Change</span>
					<span class="desc">A contact detail associated with your account has been changed.</span>
					<span class="time">2 hours</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Helen 987</span>
					<span class="desc">Like your post: “Facebook Messenger”</span>
					<span class="time">Yesterday</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/128x128" alt=""></span>
					<span class="name">Denise Jenny</span>
					<span class="desc">Like your post: “Contact Form 7 Multi-Step”</span>
					<span class="time">Oct, 28</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Thomas William</span>
					<span class="desc">Like your post: “Facebook Messenger”</span>
					<span class="time">Oct, 27</span>
				</a>
			</li>
		</ul>
		<!-- /.notice-list -->
		<a href="#" class="notice-read-more">See more messages <i class="fa fa-angle-down"></i></a>
	</div>
	<!-- /.content -->
</div>
<!-- /#notification-popup -->

<div id="message-popup" class="notice-popup js__toggle" data-space="75">
	<h2 class="popup-title">Recent Messages<a href="#" class="pull-right text-danger">New message</a></h2>
	<!-- /.popup-title -->
	<div class="content">
		<ul class="notice-list">
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">John Doe</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">10 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Harry Halen</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">15 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Thomas Taylor</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">30 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/128x128" alt=""></span>
					<span class="name">Jennifer</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">45 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/80x80" alt=""></span>
					<span class="name">Helen Candy</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">45 min</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/128x128" alt=""></span>
					<span class="name">Anna Cavan</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">1 hour ago</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar bg-success"><i class="fa fa-user"></i></span>
					<span class="name">Jenny Betty</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">1 day ago</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="avatar"><img src="http://placehold.it/128x128" alt=""></span>
					<span class="name">Denise Peterson</span>
					<span class="desc">Amet odio neque nobis consequuntur consequatur a quae, impedit facere repellat voluptates.</span>
					<span class="time">1 year ago</span>
				</a>
			</li>
		</ul>
		<!-- /.notice-list -->
		<a href="#" class="notice-read-more">See more messages <i class="fa fa-angle-down"></i></a>
	</div>
	<!-- /.content -->
</div>