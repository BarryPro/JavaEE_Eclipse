<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pageContext</title>
</head>
<body>
	<%--pageContext可以调有其他的四种 --%>
	<%
		pageContext.setAttribute("name", "belong");//page
		pageContext.getRequest().setAttribute("age", "100");//request
		pageContext.getSession().setAttribute("id", "10101");//session
		pageContext.getServletContext().setAttribute("color", "red");//application
	%>
	<a href="pageContextpage.jsp">点击</a>
	<%--pageContext可以用参数来改变是那种调用 --%>
	<%@include file="pageContextpage.jsp" %>
	<%
		pageContext.setAttribute("pname", "p",pageContext.PAGE_SCOPE);
	%>
	<%
		pageContext.setAttribute("rname", "r",pageContext.REQUEST_SCOPE);
	%>
	<%
		pageContext.setAttribute("sname", "s",pageContext.SESSION_SCOPE);
	%>
	<%
		pageContext.setAttribute("aname", "a",pageContext.APPLICATION_SCOPE);
	%>
</body>
</html>