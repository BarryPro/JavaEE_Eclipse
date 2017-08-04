<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String workNo     = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");
String id         = (String)request.getParameter("id");
String title      = (String)request.getParameter("title");
String content    = (String)request.getParameter("content");
String startTime  = (String)request.getParameter("startTime");
String endTime    = (String)request.getParameter("endTime");
String tskRank    = (String)request.getParameter("tskRank");


 title =  java.net.URLDecoder.decode(title, "utf-8");
 content =  java.net.URLDecoder.decode(content, "utf-8");


%>

<wtc:service name="sKeyOpr" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=id%>" />
	<wtc:param value="u" />
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="<%=title%>" />
  	<wtc:param value="<%=content%>" />
  	<wtc:param value="<%=startTime%>" />
  	<wtc:param value="<%=endTime%>" />
  	<wtc:param value="<%=tskRank%>" />	
</wtc:service>
<wtc:array id="result" scope="end" />	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);