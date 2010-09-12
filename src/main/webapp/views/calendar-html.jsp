<%@ page language="java" import="java.util.Iterator,java.util.Collection,java.text.DateFormat,java.text.SimpleDateFormat,gov.nysenate.openleg.*,gov.nysenate.openleg.model.*,gov.nysenate.openleg.model.calendar.*,gov.nysenate.openleg.model.committee.*,javax.xml.bind.*" contentType="text/html" pageEncoding="utf-8"%><%


String appPath = request.getContextPath();


CachedContentManager.fillCache(request);
Calendar calendar = (Calendar)request.getAttribute("calendar");
String title = "Calendar " + calendar.getNo() + " " + calendar.getSessionYear();
	DateFormat df = SimpleDateFormat.getDateTimeInstance(DateFormat.MEDIUM,DateFormat.SHORT);

 %>
<jsp:include page="/header.jsp">
	<jsp:param name="title" value="<%=title%>"/>
</jsp:include>

<br/>
 
<h2>Calendar no. <%=calendar.getNo()%> (<%=calendar.getType()%>) / Year: <%=calendar.getYear()%> / Session: <%=calendar.getSessionYear()%> - <%=calendar.getSessionYear()+1%></h2>
 <br/>
 
 
 <div id="content">
 <script type="text/javascript" src="http://w.sharethis.com/button/sharethis.js#publisher=51a57fb0-3a12-4a9e-8dd0-2caebc74d677&amp;type=website"></script>
 
<%
Iterator<Supplemental> itSupp = calendar.getSupplementals().iterator();
Supplemental supp = null;

while (itSupp.hasNext()){
try
{

	supp = itSupp.next();
	
	if (calendar.getType().equals("active") && supp.getSequence()==null)	
		continue;
%>
<h3>Supplemental <%=supp.getSupplementalId()%></h3>
<% if (supp.getCalendarDate()!=null){ %>
<b>Calendar Date:</b> <%=df.format(supp.getCalendarDate())%> / 
<%} %>
<% if (supp.getReleaseDateTime()!=null){ %>
<b>Released:</b> <%=df.format(supp.getReleaseDateTime())%>
<%} %>

<%

Collection<Sequence> collSeq = PMF.getDetachedObjects (Sequence.class, "id", supp.getId() + ".*", null, 0,100);

Iterator<Sequence> it = collSeq.iterator();

while (it.hasNext())
{
Sequence seq = it.next();

%>
<%if (seq.getNo()==null || seq.getNo().length()==0){ %>
<h4>Active List</h4>
<%}else{ %>
<h4>Supplemental</h4>
<%} %>
<%
seq.getActCalDate();
seq.getCalendarEntries();
seq.getNo();
seq.getNotes();

 %>
 <%if (seq.getNotes()!=null && seq.getNotes().trim().length()>0){ %>
 <h4>Notes</h4>
 <%=seq.getNotes()%>
 <hr/>
 <%} %>
 <h4>Bills</h4>
 <div class="billSummary">
	<ul>
<%
Iterator<CalendarEntry> itCals = seq.getCalendarEntries().iterator();
	while (itCals.hasNext()){
	CalendarEntry calEnt = itCals.next();
	%>
		
		<li>
		Calendar: <%=calEnt.getNo()%>
		<%if (calEnt.getBill()!=null){%>
		/ Sponsor: <a href="<%=appPath%>/sponsor/<%=calEnt.getBill().getSponsor().getFullname()%>"><%=calEnt.getBill().getSponsor().getFullname()%></a>
		<%if (calEnt.getSubBill()!=null){%>(Sub-bill Sponsor: <a href="<%=appPath%>/sponsor/<%=calEnt.getSubBill().getSponsor().getFullname()%>"><%=calEnt.getSubBill().getSponsor().getFullname()%></a>)<%}%>
		/ Printed No.: <a href="<%=appPath%>/bill/<%=calEnt.getBill().getSenateBillNo()%>"><%=calEnt.getBill().getSenateBillNo()%></a>
				<%if (calEnt.getBillHigh()!=null){ %><b style="color:green">HIGH</b><%}%>

				<%if (calEnt.getSubBill()!=null){%>(Sub-bill: <a href="<%=appPath%>/bill/<%=calEnt.getSubBill().getSenateBillNo()%>"><%=calEnt.getSubBill().getSenateBillNo()%></a>)<%}%>
		
		<%}%>
		
		<%if (calEnt.getBill().getTitle()!=null){%><br/>Title: <%=calEnt.getBill().getTitle()%><%}else if (calEnt.getSubBill()!=null && calEnt.getSubBill().getTitle()!=null){%><br/>Title: <%=calEnt.getSubBill().getTitle()%><%}%>
		
</li>
	<%}%>
	</ul>
	
	
</div>

<%}%>

<%if (supp.getSections()!=null&&supp.getSections().size()>0){%>
<hr/>
<%
Iterator<Section> itSection = supp.getSections().iterator();
while (itSection.hasNext()){
Section section = itSection.next();
%>
<h4>Section:<%=section.getName()%> (<%=section.getType()%> / <%=section.getCd()%>)</h4>
<div class="billSummary">
	<ul>
<%
Iterator<CalendarEntry> itCals = section.getCalendarEntries().iterator();
	while (itCals.hasNext()){
	CalendarEntry calEnt = itCals.next();
	%>
		
		<li>
		Calendar: <%=calEnt.getNo()%>
		<%if (calEnt.getBill()!=null){%>
		/ Sponsor: <a href="<%=appPath%>/sponsor/<%=calEnt.getBill().getSponsor().getFullname()%>"><%=calEnt.getBill().getSponsor().getFullname()%></a>
		<%if (calEnt.getSubBill()!=null){%>(Sub-bill Sponsor: <a href="<%=appPath%>/sponsor/<%=calEnt.getSubBill().getSponsor().getFullname()%>"><%=calEnt.getSubBill().getSponsor().getFullname()%></a>)<%}%>
		/ Printed No.: <a href="<%=appPath%>/bill/<%=calEnt.getBill().getSenateBillNo()%>"><%=calEnt.getBill().getSenateBillNo()%></a>
				<%if (calEnt.getBillHigh()!=null){ %><b style="color:green">HIGH</b><%}%>
				<%if (calEnt.getSubBill()!=null){%>(Sub-bill: <a href="<%=appPath%>/bill/<%=calEnt.getSubBill().getSenateBillNo()%>"><%=calEnt.getSubBill().getSenateBillNo()%></a>)<%}%>
		
		<%}%>
		
		<%if (calEnt.getBill().getTitle()!=null){%><br/>Title: <%=calEnt.getBill().getTitle()%><%}else if (calEnt.getSubBill()!=null && calEnt.getSubBill().getTitle()!=null){%><br/>Title: <%=calEnt.getSubBill().getTitle()%><%}%>
		
</li>
	<%}%>
	</ul>
<%}%>
	
	
<%}%>

<%

} catch (Exception e) {}%>

 <%}%>

</div>
  
<div id="formatBox">
<b>Formats:</b> <a href="<%=appPath%>/api/1.0/xml/calendar/<%=calendar.getId()%>">XML</a>
 </div> 

</div> 
<jsp:include page="/footer.jsp"/>
