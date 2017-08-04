<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cookie</title>
</head>
<body>
	<%--cookie就是网页记录的缓存一般保留7天（不安全） session安全（在服务端） --%>
	<%
		//1.定义cookie
		Cookie c = new Cookie("www.belong.com","123456");
		//2.设置cookie的保留期
		c.setMaxAge(7*24*3600);
		//3.把新声明的cookie存到浏览器的cookie中
		response.addCookie(c);
	%>
	<h1>cookie设置成功！</h1>
	<a href="allcookiepage.jsp"><b>取得所有cookie</b></a><br>
	<a href="cookiepage.jsp"><b>取得新加cookie</b></a>
</body>
</html>