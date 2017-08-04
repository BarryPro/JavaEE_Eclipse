<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ERROR</title>
</head>
<body>
	<h1>出错了</h1><br>
	<h3>错误内容如下：</h3><br>
	<%--hr是水平线 --%>
	<hr>
	<font color="red"><%=exception.getMessage()%></font>
</body>
</html>