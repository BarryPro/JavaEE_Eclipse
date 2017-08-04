<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	SUCCESS
	<%
		String username = request.getParameter("username");
		String pwd = request.getParameter("pwd");
		String a = username+"OK"+pwd+"Belong";
		PrintWriter out1 = response.getWriter();//（从服务器向客户端发送）输出
		out1.write(a);
		out1.flush();
		out1.close();
	%>
</body>
</html>