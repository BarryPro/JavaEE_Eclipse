<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript">
	function ok(){
		var regex = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
		var email = document.getElementById("email");
		if(regex.test(email.value)){
			document.all.form1.submit();
		} else {
			alert("邮箱格式错误");
		}		
	}
</script>
</head>
<body>
<div align="center">
	<form action="Message3Control.do" method="post" id="form1" name="form1">
		姓名：<input type="text" name="name"/><br>
		邮箱：<input type="text" name="email" id="email"/>		
		<c:if test="${requestScope.email!=null}">
			${requestScope.email}
		</c:if><br>
		标题：<input type="text" name="title"/><br>
		内容：<input type="text" name="content"/><br>
		<input type="hidden" name="action" value="add"/>
		<input class="btn" type="button" value="提交" onclick="ok()"/>
		<input class="btn" type="reset" value="重置"/>
	</form>
	<a class="btn" href="Message3Control.do?action=show">显示内容</a>
	${requestScope.mess!=null?requestScope.mess:""}
</div>
</body>
</html>