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
				<li id="dash">
					<a class="waves-effect" href="dashboard?email=<%=loginData.getEmail()%>"><i class="menu-icon fa fa-home"></i><span>Dashboard</span></a>
				</li>
				<hr style="margin: 0;">
				<li id="glob">
				    <a class="waves-effect parent-item js__control" href="#">
				        <i class="menu-icon fa fa-globe"></i>
				        <span>Global</span>
				        <span class="menu-arrow fa fa-angle-down"></span>
				    </a>
				    <ul id="glb" class="sub-menu js__content">
				        <li id="mg"><a href="viewgroup">Manage Groups</a></li>
				        <li id="ms"><a href="schools">Manage Schools</a></li>
				        <li id="mss"><a href="section">Manage Sections</a></li>
				    </ul>
				</li>
				<hr style="margin: 0;">
				<li id="testi">
				    <a class="waves-effect parent-item js__control" href="#">
				        <i class="menu-icon fa fa-indent"></i>
				        <span>Testing</span>
				        <span class="menu-arrow fa fa-angle-down"></span>
				    </a>
				    <ul id="tst" class="sub-menu js__content">
				        <li id="mmt"><a href="mailTemplate">Manage Mail Template</a></li>
				        <li id="tib"><a href="top_image_banner">Top Image Banner</a></li>
				        <li id="mqi"><a href="information">Manage QCW Info</a></li>
				        <li id="mqb"><a href="question">Manage Question Bank </a></li>
				        <li id="mpi"><a href="progarmInformation">Manage Program Info </a></li>
				        <li id="msq"><a href="sample_question">Manage Sample Question </a></li>
				        <li id="msa"><a href="sample_answer">Manage Sample Answer </a></li>
				        <li id="ma"><a href="viewAnswers">Manage Answers </a></li>
				    </ul>
				</li>
				<hr style="margin: 0;">
				<li id="writ">
				    <a class="waves-effect parent-item js__control" href="#">
				        <i class="menu-icon fa fa-pencil-square-o"></i>
				        <span>Writing</span>
				        <span class="menu-arrow fa fa-angle-down"></span>
				    </a>
				    <ul id="wrt" class="sub-menu js__content">
				        <li id="ss"><a href="manage_selected_students">Selected Students</a></li>
				        <li id="apqs"><a href="manage_profile_questions">Auth Prof Questions</a></li>
				        <li id="er"><a href="edit_review">Edit Review</a></li>
				    </ul>
				</li>
				<hr style="margin: 0;">
				<!-- <li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-envelope"></i><span>Mail Template</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="mailTemplate">Manage</a></li>
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-upload"></i><span>Top Image Banner</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="top_image_banner">Manage</a></li>
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-info"></i><span>QCW Info</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="information">Manage</a></li>
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-database"></i><span>Groups</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="viewgroup">Manage</a></li>
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-graduation-cap"></i><span>Schools</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="schools">Manage</a></li>
						
					</ul>
					
				</li>
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
					
				</li>
				
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-child"></i><span>Program Info</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						<li><a href="progarmInformation">Manage</a></li>
						
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-question-circle"></i><span>Sample</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="sample_question">Add Question</a></li>
						 <li><a href="sample_answer">Add Answer</a></li>
						
					</ul>
					
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-file-text-o"></i><span>Answers</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="viewAnswers">View Answers</a></li>
						
					</ul>
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-list-alt"></i><span>Selected Students</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="manage_selected_students">Manage</a></li>
						
					</ul>
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-list-alt"></i><span>Auth Prof Questions</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="manage_profile_questions">Manage</a></li>
				
						
					</ul>
				</li>
				<li>
					<a class="waves-effect parent-item js__control" href="#"><i class="menu-icon fa fa-list-alt"></i><span>Edit Review</span><span class="menu-arrow fa fa-angle-down"></span></a>
					<ul class="sub-menu js__content">
						 <li><a href="edit_review">Manage</a></li>
						
						
					</ul>
				</li> -->
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
		<!-- <h1 class="page-title">Home</h1> -->
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

