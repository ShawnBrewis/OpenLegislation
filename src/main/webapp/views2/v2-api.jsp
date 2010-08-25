<%@ page language="java" import="javax.jdo.*,java.util.*,java.text.*,gov.nysenate.openleg.*,gov.nysenate.openleg.search.*,gov.nysenate.openleg.util.*,gov.nysenate.openleg.model.*,gov.nysenate.openleg.model.committee.*,gov.nysenate.openleg.model.calendar.*,gov.nysenate.openleg.xstream.*" contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%

String cacheKey = (String)request.getAttribute("path");
int cacheTime = OpenLegConstants.DEFAULT_CACHE_TIME;
 
String appPath = request.getContextPath();

String term = (String)request.getAttribute("term");
String type = (String)request.getAttribute("type");
String format = (String)request.getAttribute("format");
String pageIdx = (String)request.getAttribute("pageIdx");
String pageSize = (String)request.getAttribute("pageSize");

int start = 0;
int size = 1;

if(pageIdx == null || pageSize == null) {
	start = 0;
	size = 1;
}



System.out.println(format + " : " + type + " : " + term);

out.write(XStreamBuilder.writeResponse(format,SearchEngine.getApiV2Search(format,type,term,null,start,size,true)));


%>