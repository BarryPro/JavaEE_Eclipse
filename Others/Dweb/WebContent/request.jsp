<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>request</title>
<script type="text/javascript">
	function ok(){
		window.location="requestpage.jsp?color=red";
	}
	function finish(){
		window.location="requestpage.jsp";
	}
</script>
</head>
<body>
	<%--request 只可以一次跳转 --%>
	<%--request 1 include --%>
	<jsp:include page="requestpage.jsp">
		<jsp:param value="belong" name="username"/>
	</jsp:include>
	<%--request 2 forward --%>
	<jsp:forward page="requestpage.jsp">
		<jsp:param value="123456" name="password"/>
	</jsp:forward>
	<%--request 3 <a --%>
	<a href="requestpage.jsp?age=100">点击</a>
	<%--request 4 <form --%>
	<form action="requestpage.jsp">
		<input type="text" name="txt" >
		<input type="submit">
	</form>
	<%--requeset 5 --%>
	<input type="button" value="点击" onclick="ok()">
	<%--request 6 --%>
	<%
		request.setAttribute("id", "10101");
	%>
	<jsp:include page="requestpage.jsp"></jsp:include>
	<jsp:forward page="requestpage.jsp"></jsp:include>
</body>
</html>