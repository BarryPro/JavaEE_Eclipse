<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>session</title>
<script type="text/javascript">
	function ok(){
		//跳转关系request 不好使了  request只可以一次跳转
		window.location="sessionpage.jsp";
	}
</script>
</head>
<body>
	<input type="button" onclick="ok()" value="点击">
	<%
		String str = "belong";
	%>
	<%
		session.setAttribute("name",str);
	%>
	<input type="text" name="txt">
</body>
</html>