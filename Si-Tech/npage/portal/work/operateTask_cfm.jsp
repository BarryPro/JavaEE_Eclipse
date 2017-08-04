<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String workNo = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");
String id = (String)request.getParameter("id");
String flag = (String)request.getParameter("flag");
String title = (String)request.getParameter("title");
String content = (String)request.getParameter("content");
String startTime = (String)request.getParameter("startTime");
String endTime = (String)request.getParameter("endTime");

 title =  java.net.URLDecoder.decode(title, "utf-8");
 content =  java.net.URLDecoder.decode(content, "utf-8");

System.out.println("&&&"+id+"&&"+flag+"&&&"+title+"&&&&&&"+content+"&&&&&"+startTime+"&&&&&&"+endTime+"&&&&&&&&&&&&&&&&&&&&&&&");

%>

<wtc:service name="sKeyOpr" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=id%>" />
	<wtc:param value="<%=flag%>" />
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="<%=title%>" />
  	<wtc:param value="<%=content%>" />
  	<wtc:param value="<%=startTime%>" />
  	<wtc:param value="<%=endTime%>" />
</wtc:service>
<wtc:array id="result" scope="end" />	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);