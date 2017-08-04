<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pageContextpage</title>
</head>
<body>
	<%=
		pageContext.getAttribute("name")
	%>
	<%=
		request.getAttribute("age")
	%>
	<%=
		session.getAttribute("id")
	%>
	<%=
		application.getAttribute("color")
	%>
	<%=
		pageContext.getAttribute("pname",pageContext.PAGE_SCOPE)
	%>
	<%=
		pageContext.getAttribute("rname",pageContext.REQUEST_SCOPE)
	%>
	<%=
		pageContext.getAttribute("sname",pageContext.SESSION_SCOPE)
	%>
	<%=
		pageContext.getAttribute("aname",pageContext.APPLICATION_SCOPE)
	%>
</body>
</html>