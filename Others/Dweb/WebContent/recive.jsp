<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>recive</title>
</head>
<body>
	<%--通过form名字name接收的 --%>
	<jsp:useBean id="a" class="com.belong.vo.Animal">
		<jsp:setProperty property="*" name="a"/>
	</jsp:useBean>
	<jsp:getProperty property="name" name="a"/>
	<jsp:getProperty property="age" name="a"/>
	<%=
		request.getParameter("password")
	%>
	<%=
			java.net.URLDecoder.decode(request.getParameter("username"),"utf-8")
	%>
</body>
</html>