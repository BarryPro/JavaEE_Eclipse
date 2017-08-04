<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String workNo     = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");
String title      = (String)request.getParameter("title");
String content    = (String)request.getParameter("content");
String startTime  = (String)request.getParameter("startTime");
String endTime    = (String)request.getParameter("endTime");
String tskRank    = (String)request.getParameter("tskRank");
String selectDate = (String)request.getParameter("selectDate");



 title =  java.net.URLDecoder.decode(title, "utf-8");
 content =  java.net.URLDecoder.decode(content, "utf-8");

System.out.println("tskRank= "+tskRank+"&&&&&&&&"+title+"&&&&&&"+content+"&&&&&"+startTime+"&&&&&&"+endTime+"&&&&&&&&&&&&&&&&&&&&&&&");

%>
<wtc:service name="sTaskInput" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="<%=title%>" />
  	<wtc:param value="<%=content%>" />
  	<wtc:param value="<%=startTime%>" />
  	<wtc:param value="<%=endTime%>" />
  	<wtc:param value="<%=tskRank%>" />	
  	<wtc:param value="<%=selectDate%>" />		
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
