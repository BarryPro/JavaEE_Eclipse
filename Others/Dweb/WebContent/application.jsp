<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>application</title>
</head>
<body>
	<%
		application.setAttribute("name", "belong");
	%>
	<%
		session.setAttribute("age", "20");
	%>
	<%
		request.setAttribute("id", "10101");
	%>
	<%
		pageContext.setAttribute("color", "red");
	%>
	<a href="applicationpage.jsp">点击</a>
</body>
</html>