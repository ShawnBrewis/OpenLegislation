<%@ page language="java" import="java.util.regex.Matcher,java.util.regex.Pattern,javax.jdo.*,java.util.*,java.text.*,gov.nysenate.openleg.search.*,gov.nysenate.openleg.*,gov.nysenate.openleg.model.*,gov.nysenate.openleg.model.committee.*,gov.nysenate.openleg.model.calendar.*" contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%

String cacheKey = (String)request.getAttribute("path");
int cacheTime = 0;//OpenLegConstants.DEFAULT_CACHE_TIME;
 
String appPath = request.getContextPath();


%>
 <!--<cache:cache key="<%=cacheKey%>" time="<%=cacheTime %>" scope="application">-->
<%

CachedContentManager.fillCache(request);
Bill bill = (Bill)request.getAttribute("bill");
			
String titleText = "";
if (bill.getTitle()!=null)
	titleText = bill.getTitle();
else if (bill.getSummary()!=null)
	titleText = bill.getSummary();

String title = bill.getSenateBillNo() + " - NY Senate Open Legislation - " + titleText;

 %>
 
 <html>
<head> <title>
</title>
<link rel="stylesheet" type="text/css" media="screen" href="<%=appPath%>/style-print.css"/> 

</head>
 
 <body>
    
 <div id="content">
  <pre>
<%

String billText = bill.getFulltext();

StringTokenizer st = new StringTokenizer(bill.getFulltext(), "\n");


boolean redact = false;
int r_start = -1;
int r_end = -1;
boolean cap = false;
int capCount = 0;
int start = -1;
int end = -1;

while(st.hasMoreTokens()) {
	String line = st.nextToken();
	
	Pattern p = Pattern.compile("^\\s{3,4}\\d{1,2}\\s*");
	Matcher m = p.matcher(line);

	if(m.find()) {
		String text = line.substring(m.end());
		String lineNo = line.substring(m.start(), m.end());
		
		char[] textChar = text.toCharArray();
		
		for(int i = 0; i < textChar.length; i++) {
			if(textChar[i] == '[') {
				redact = true;
				r_start = i+1;
			}
			else if(textChar[i] == ']') {
				redact = true;
				r_end = i;
			}
			
			if(Character.isUpperCase(textChar[i])) {
				if(!cap) {
					cap = true;
					if(i < 6) {
						start = 0;
					}
					else {
						start = i;
					}
				}
				capCount++;
			}
			else if(Character.isLowerCase(textChar[i])) {
				if(cap) {
					if(capCount > 2) {
						end = i - 1;
						cap = false;
						capCount = 0;
					}
					else {
						start = -1;
						end = -1;
						cap = false;
						capCount = 0;
					}
				}
			}
		}
		
		if(start != -1) {
			if(cap) {
				text += "</u>";
			}
			else {
				text = text.substring(0, end) + "</u>" + text.substring(end);
			}
			text = text.substring(0,start) + "<u>" + text.substring(start);
		}
		if(redact) {
			if(r_start != -1 && r_end != -1) {
				text = text.substring(0, r_end) + "</del>" + text.substring(r_end);
				text = text.substring(0,r_start) + "<del>" + text.substring(r_start);
				redact = false;
			}
			else if(r_end != -1) {
				text = "<del>" + text.substring(0,r_end) + "</del>" + text.substring(r_end);
				redact = false;
			}
			else if(r_start != -1) {
				text = text.substring(0,r_start) + "<del>" + text.substring(r_start) + "</del>" ;
			}
			else{
				text = "<del>" + text + "</del>";
			}
			r_start = -1;
			r_end = -1;
		}

		out.write(lineNo + text + "\n");
		
		start = -1;
		end = -1;
		cap = false;
		capCount = 0;
	}
	else {
		out.write(line + "\n");
	}
}
%>
	
  </pre>
 <br/>
  
 </div>
  <script type="text/javascript">
  setTimeout("window.print();",2000);
  </script>
 </body>
 </html>
 
  <!--</cache:cache>-->
 