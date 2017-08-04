<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<script type="text/javascript" src="js/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(function(){
		//任何控件都有load（）方法
		/* $("#btn").click(function(){
			$("#msg").load(
				"page.jsp",	//要请求的页
				$("#form1").serialize(),//要发送的内容
				function(response,status,xml){//核心响应方法(主要是第三个参数的实现异步)
					alert(response);
				}
			);	
		}); */
		/* $("#btn").click(function(){
			$.get(//得到参数的参数
				"page.jsp",
				$("#form1").serialize(),
				function(response){//回调函数
					$("#msg").html(response);
					alert(response);
				}
			);
		}); */
		//ctrl+shift+c是快速注释
// 		$("#btn").click(function(){
// 			$.post(//得到参数的参数和get一样
// 				"page.jsp",
// 				$("#form1").serialize(),
// 				function(response){//回调函数
// 					$("#msg").html(response);
// 					alert(response);
// 				}
// 			);
// 		});
		//前三种的底层都是ajax()这个函数
		$("#btn").click(function(){
			$.ajax({
				url:"page.jsp",//要请求的页是那个页
				type:"post",//提交的请求类型
				data:$("#form1").serialize(),//前段向后端发送的数据是什么（必须是键直对形式）
				dataType:"text",//后端向前端发送的数据类型
				success:function(data){//回调函数
					alert(data);
				}
			});
		});
	});
</script>
</head>
<body>
	<form id="form1" name="form1">
		<span>用户名：</span><input type="text" id="username" name="username" /><br>
		<span>密码：</span><input type="text" id="pwd" name="pwd" />
	</form>
	Belong
	<a href="page.jsp">点击</a>
	<button id="btn">点击</button>
	<div id="msg"></div>
</body>
</html>