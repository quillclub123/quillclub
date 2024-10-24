<!DOCTYPE html>
<%@page import="com.quillBolt.model.Structure"%>
<%@page import="com.quillBolt.model.SelectedStudent"%>
<%@page import="org.hibernate.sql.Select"%>
<%@page import="com.quillBolt.model.Reflections"%>
<%@page import="com.quillBolt.model.StructureDescription"%>
<%@page import="com.quillBolt.model.Passage"%>
<%@page import="com.quillBolt.model.ProfileQuestionsAnswer"%>
<%@page import="com.quillBolt.model.StoryIdea"%>
<%@page import="com.quillBolt.model.Story"%>
<%@page import="java.util.List"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QCW: Story Data</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
List<SelectedStudent> selc = (List<SelectedStudent>)request.getAttribute("ss");
List<Story> st = (List<Story>)request.getAttribute("st");
List<StoryIdea> sti = (List<StoryIdea>)request.getAttribute("sti");
String sidea = "No Data Available";
if(sti.size() > 0){
	sidea = sti.get(0).getStory_idea().replace("\n", "<br>");
}
List<ProfileQuestionsAnswer> pqa = (List<ProfileQuestionsAnswer>)request.getAttribute("pqa");
List<Passage> pass = (List<Passage>)request.getAttribute("pass");
String auprofile = "No Data Available";
if(pass.size() > 0){
	auprofile =pass.get(0).getPassage().replace("\n", "<br>");;
}
List<Structure> str = (List<Structure>)request.getAttribute("str");
List<StructureDescription> sd = (List<StructureDescription>)request.getAttribute("sd");
List<Reflections> ref = (List<Reflections>)request.getAttribute("ref");
String refs = "No Data Available";
if(ref.size() > 0){
	refs =ref.get(0).getReflection();
}
%>
<section>
  <div style="padding: 0px 10px;">
    <button type="button" onclick="downloadAsWord()" class="btn btn-primary btn-xs" style="float: right;">Download Story Data</button>
  </div>
  
  <div class="container">
    <div class="mt-5">
      <h2 style="text-align: center;"><%=selc.get(0).getSchool_name() %></h2>
      <p  style="text-align: center;" id="wname"><%=selc.get(0).getName()%></p>
      <p  style="text-align: center;"><%=selc.get(0).getClass_name()%>/<%=selc.get(0).getSection() %></p>
    </div>
    <div class="questinnaire">
      <h3>All About You: </h3>
      <%
      	if(pqa.size() > 0){
      		for(ProfileQuestionsAnswer p : pqa){
      %>
      <p style="font-weight: 600;">Q<%=p.getSeq_no() %>. <%=p.getQuestion() %></p>
      <p>Ans. <%=p.getAnswer() %></p>
	 <%}}else{ %>  
	 	<p>No Data Available</p>
	 <%} %>    
    </div>
    <div class="passage">
      <h3>Full Author Profile: </h3>
		<p><%=auprofile %></p>
    </div>
    <div class="story-idea">
      <h3>Story Idea: </h3>
      <p><%=sidea %></p>
    </div>
    <div class="structure">
      <h3>Structure: </h3>
      <% if(sd.size() > 0){ %>
      <table style="width: 100% !important; border: 1px solid black; padding: 10px !important;">
        <thead>
          <tr>
            <th style="border-bottom: 1px solid;padding: 5px; text-align: left;">Description</th>
            <th style="width: 10%;border-bottom: 1px solid;border-left: 1px solid;padding: 5px;text-align: center;">Words</th>
          </tr>
        </thead>
        <tbody id="tbody">
        <%
        for(StructureDescription s : sd){ %>
          <tr>
            <td style="border-bottom: 1px solid;padding: 5px;"><%=s.getDescription()%></td>
            <td style="border-left: 1px solid;border-bottom: 1px solid;padding: 5px;text-align: center;"><%=s.getWords()%></td>
          </tr>
          <%} %>
        </tbody>
        <tfoot>
        <%if(str.size() > 0){ %>
          <tr>

            <td style="text-align: right;font-size: 20px;padding: 5px;">Total</td>
            <td style="padding: 5px;border-left: 1px solid;text-align: center;"><%=str.get(0).getTotal_words() %></td>
          </tr>
          <%} %>
        </tfoot>
      </table>
      <%}else{ %>
      <p>No Data Available</p>
      <%} %>
    </div>
    <div class="story">
      <h3>Full Story: </h3>
      <%if(st.size() > 0){%>
      <P style="font-weight: 600;">Title: <%=st.get(0).getTitle() %> </P>
      <P style="font-weight: 600;">Blurb: <%=st.get(0).getBlurb() %> </P>
	   <p><%=st.get(0).getFull_story().replace("\n", "<br>")%></p>
    <%} else{ %>
      <p>No Data Available</p>
      <%} %>
    </div>
    <div class="reflec">
      <h3>Reflection: </h3>
      <p><%=refs%></p>
    </div>
    <div style="text-align: center; margin-bottom: 10px;">
      <button type="button" onclick="downloadAsWord()" class="btn btn-primary btn-xs">Download Story Data</button>
    </div>
   
  </div>
</section>


<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  function downloadAsWord() {
	  var wname = $("#wname").html();
	  var content = 
		    '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">' +
		    '<head><meta charset="utf-8"><title>Webpage Content</title></head>' +
		    '<body>' +
		    $('body').html() +
		    '</body>' +
		    '</html>';
      var blob = new Blob(['\ufeff', content], {
          type: 'application/msword'
      });

      var link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = wname+'.doc';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
  }
</script>
</body>
</html>
