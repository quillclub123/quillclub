<%@page import="com.quillBolt.model.SelectedStudent"%>
<%
SelectedStudent sl = (SelectedStudent)session.getAttribute("student_data");
%>
<div class="sidebar">

    <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->


    	<div class="sidebar-wrapper" style="background-image: url('assets/AuthorWeb/assets/img/bgim.jpg');background-repeat: no-repeat; background-size: cover;">
            <div class="logo">
                <a href="http://www.quillclubwriters.com/" class="simple-text" target="_blank" style="font-size: 12px;"> 
                    <img alt="" src="assets/qcwlg.jpeg" style="width: 40px;">  Quill Club Writers
                </a>
            </div>

            <ul class="nav">
               <!--  <li>
                    <a href="dashboard.html">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li> -->
                <li id="a_profile" class="">
                    <a href="author_profile?student_id=<%=sl.getStudent_id()%>">
                        <i class="pe-7s-user"></i>
                        <p>Author Profile</p>
                    </a>
                </li>
                <li id="s_idea" class="">
                    <a href="manage_story_idea">
                        <i class="pe-7s-note2"></i>
                        <p>Story Idea</p>
                    </a>
                </li>
                <li id="structu" class="">
                    <a href="manage_structure">
                        <i class="pe-7s-news-paper"></i>
                        <p>Structure</p>
                    </a>
                </li>
                <li id="f_story" class="">
                    <a href="manage_full_story">
                        <i class="pe-7s-science"></i>
                        <p>Full Story</p>
                    </a>
                </li>
                <li id="reflec" class="">
                    <a href="reflections">
                        <i class="pe-7s-science"></i>
                        <p>Reflections</p>
                    </a>
                </li>
                <li id="r_pdf" class="">
                    <a href="editorial_review">
                        <i class="pe-7s-pendrive"></i>
                        <p>Editorial Review</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>
    
    

    