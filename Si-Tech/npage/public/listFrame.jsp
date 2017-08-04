<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	Map map = request.getParameterMap();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	</head>
	<frameset rows="100%" cols="0,*" framespacing="0" frameborder="no" border="0">
		<frame src="" name="leftFrame" scrolling="Yes" noresize="noresize" id="leftFrame" />
		<frame src="list.jsp?<%=PageListNav.writeRequestUrl(map)%>" name="mainFrame" id="mainFrame" />
	</frameset>
</html>
