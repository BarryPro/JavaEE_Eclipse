<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function ok(){
		var regex = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
		var e = document.getElementById("email");
		if(regex.test(e.value)){
			document.all.form1.submit();
		} else {
			alert("邮箱错误");
		}
	}
</script>
</head>
<body>
	<div align="center">
		<form id="form1" name="form1" method="post" action="Message2Control.do">
			<span>姓名</span><input type="text" name="name"><br>
			<span>邮箱</span><input type="text" name="email" id="email">
			<%-- jstl就是替换<% %>中的内容 el就是替换<%= %>中的内容 --%>
			<c:if test="${requestScope.email!=null}">
				${requestScope.email}
			</c:if><br>
			<input type="hidden" name="action" value="add">	
			<span>标题</span><input type="text" name="title"><br>
			<span>内容</span><input type="text" name="content"><br>
			<input class="btn" type="button" value="提交" onclick="ok()">
			<input class="btn" type="reset" value="复位">
		</form>
		<a class="btn" href="Message2Control.do?action=show">查询</a>
		<c:if test="${requestScope.mess!=null}">
			${requestScope.mess}
		</c:if><br>
	</div>
</body>
</html>