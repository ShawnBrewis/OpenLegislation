<%@ page language="java" import="java.util.*, java.text.*,java.io.*,gov.nysenate.openleg.*,gov.nysenate.openleg.model.*" pageEncoding="UTF-8"%>
<%

String appPath = request.getContextPath();
session.removeAttribute("term");

String searchPath = appPath + "/committee";

%>

<jsp:include page="/header.jsp">
	<jsp:param name="title" value="Committees"/>
</jsp:include>
 	<h2>Committees</h2>


 <div id="content">
 
<%

//Collection<Object> committees = PMF.getDetachedObjects(Committee.class,"name",".*","name ascending", 1, 100);
ArrayList<String> committees = PMF.getCommittees();

Iterator<String> it = committees.iterator();

while (it.hasNext())
{

//Committee comm = (Committee)it.next();
String commName = it.next();

if (commName == null)
	continue;
 %>	
 <div class="billSummary">
<h4><%=commName%></h4>
<div>
View:
<a href="<%=appPath%>/committee/<%=commName%>">Current Bills</a>,

<a href="<%=appPath%>/meetings/<%=commName%>">Committee Meetings</a> 
</div>
</div>
<%
}
 %>	
</div>
   
 <jsp:include page="/footer.jsp"/>
   
    
