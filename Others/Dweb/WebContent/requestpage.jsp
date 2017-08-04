<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>requestpage</title>
</head>
<body>
	<%--前5种可以改变一次地址栏因为有请求 --%>
	<%--1 --%>
	<%=
		request.getParameter("username")
	%>
	<%--2 --%>
	<%=
		request.getParameter("password")
	%>
	<%--3 --%>
	<%=
		request.getParameter("age")
	%>
	<%--4 --%>
	<%=
		request.getParameter("txt")
	%>
	<%--5 --%>
	<%=
		request.getParameter("color")
	%>
	<%--6 地址栏不可以改变 因为没有请求关系--%>
	<%=
		request.getAttribute("id")
	%>
</body>
</html>