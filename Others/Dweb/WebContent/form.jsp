<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>form</title>
<script type="text/javascript">
	alert("ok");
</script>
</head>
<body>
	<%--form中的method 中的get与post的区别是 get可以在地址栏上看到而post看不到且post比get传输的数据大 --%>
	<form id="form1" name="form1" method="get" action="recive.jsp">
	<%--input中的构件名name必须和useBean中的成员变量一致 --%>
		<b>宠物名字</b><input type="text" name="name" /><br>
		<b>宠物年龄</b><input type="text" name="age" /><br>
		<input type="submit" value="提交"/>
	</form>
</body>
</html>