<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>include</title>
<style type="text/css">
body{
	background-color: grey;
}
</style>
</head>
<body>
	<span>头</span>
	<%=
		java.net.URLDecoder.decode(request.getParameter("username"),"utf-8")
	%>
	<%=
		request.getParameter("password")		
	%>