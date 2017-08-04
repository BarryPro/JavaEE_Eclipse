<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	Map map = request.getParameterMap();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	</head>
	<!--<frameset rows="100%" cols="0,*" framespacing="0" frameborder="no" border="0">
		<frame src="" name="leftFrame" scrolling="Yes" noresize="noresize" id="leftFrame" />
		<frame src="list.jsp?<%=PageListNav.writeRequestUrl(map)%>" name="mainFrame" id="mainFrame" />
	</frameset>-->
	<iframe id="ifram" align="top" src="sqlList.jsp?<%=PageListNav.writeRequestUrl(map)%>" frameborder="0" noresize width="100%" height="500" scrolling="no"></iframe>
</html>
