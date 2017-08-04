<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>response</title>
</head>
<body>
	<%--直接就就跳转（相当于jsp版的超链） --%>
	<%
		response.sendRedirect("personalresume.jsp");//跳转就是重定向
	%>
</body>
</html>