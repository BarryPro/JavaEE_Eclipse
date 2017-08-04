<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>include</title>
</head>
<body>
<%--可以传参数  刷新本页就可以了--%>
<jsp:include page="head.jsp">
	<jsp:param value='<%=java.net.URLEncoder.encode("于成龙","utf-8") %>' name="username"/>
	<jsp:param value="123456" name="password"/>
</jsp:include>
</body>
</html>