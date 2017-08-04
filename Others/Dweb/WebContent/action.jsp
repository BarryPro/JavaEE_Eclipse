<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.belong.vo.Animal"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>action</title>
</head>
<body>
	<form action="" align="right">
		用户名<input type="text" value="用户名">
	</form>
	<%--上下两句是相等的 --%>
	<jsp:useBean id="a" class="com.belong.vo.Animal"></jsp:useBean>
	<%Animal a1 = new Animal(); %>
	<%--表达式语句不能有分号 --%>
	<%=
		a.getAge()
	%>
	<%--动作中的属性name必须是usebean中的id相同  --%>
	<jsp:setProperty property="name" name="a" value="狗"/>
	<%
		a1.setName("gou");
	%>
	<jsp:getProperty property="name" name="a"/>
	<%
		a1.getName();
	%>
	
</body>
</html>