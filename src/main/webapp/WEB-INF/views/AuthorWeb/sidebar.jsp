		
		<%@page import="com.quillBolt.model.SelectedStudent"%>
<%
		SelectedStudent sel = (SelectedStudent)session.getAttribute("student_data");

		%>
		<nav class="navbar navbar-default navbar-fixed" style="background-image: url('assets/AuthorWeb/assets/img/bgim.jpg');background-repeat: no-repeat; background-size: cover;">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" style="color: white; font-size: 12px;"><%=sel.getName() %> (<%=sel.getClass_name()%> <%=sel.getSection() %>)</a>
                    <a class="navbar-brand"  style="color: white; font-size: 12px;"><%=sel.getSchool_name()%> </a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="logout">
                                <p style="color: white; font-size: 12px;">Log out</p>
                            </a>
                        </li>
						<li class="separator hidden-lg hidden-md"></li>
                    </ul>
                </div>
            </div>
        </nav>
        <input type="hidden" id="student_id" name="student_id" value="<%=sel.getStudent_id()%>">
        <input type="hidden" id="group_id" name="group_id" value="<%=sel.getGroup_id()%>">
        <input type="hidden" id="school_id" name="school_id" value="<%=sel.getSchool_id()%>">