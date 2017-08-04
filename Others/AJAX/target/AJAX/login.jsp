<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<script type="text/javascript" src="js/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		$("#verify").click(function(){
			$.ajax({
				url:"UserControl",
				type:"post",
				data:"username="+$("#username").val(),
				dataType:"text",
				success:function(data){
					if(data=="true"){
						alert("用户名已被注册");
					} else {
						alert("可以注册");
					}
				}
			});
		});
	});
</script>
</head>
<body>	
	<form id="form1" name="form1">
		用户名：<input type="text" id="username" name="username"/><br>
		密码：<input type="password" id="pwd" name="pwd"/>
		<input type="button" id="verify" value="校验"/>
	</form>
</body>
</html>