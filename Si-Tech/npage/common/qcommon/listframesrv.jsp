<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String reqJsp = request.getParameter("reqJsp")==null?"list.jsp":request.getParameter("reqJsp");
		Map map = request.getParameterMap();
		String pageTitle = request.getParameter("pageTitle");
%>

<html>
	<head>
		<title><%=pageTitle%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	</head>
	<body>
		<iframe src="<%=reqJsp%>?<%=PageListNav.writeRequestUrl(map)%>" name="mainFrame" id="mainFrame" frameborder="0" style="width:98%;overflow:hidden" scrolling="no" />
	</body>
</html>
