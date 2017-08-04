<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GuessLetter</title>
<style type="text/css">
body{
	background-color: grey;
}
.s2{
	font-size: 20px;
	color:red;
}
.s3{
	font-size: 30px;
	color:white;
}
.s4{
	color:black;
}
</style>

</head>
<body>

	<h1 class="s4">猜字母游戏</h1>
	<b class="s2">当前的随机数字母是：</b>
	<%
		Random r = new Random();
		for(int i = 0;i<1;i++){
			char ch = (char)(r.nextInt(26)+97);
	%>
	<div class="s3">
		<%=
			ch 
		%>	
	</div>	
	<script type="text/javascript">
	function finish(){
		var t = document.getElementById("text");
		if(t.value=="<%=ch%>"){
			window.location="resultletter.jsp";
		} else {
			window.location="failpage.jsp";
		}		
	}
	</script>
		<br>
	<%	
		}
	%>
	<form>
		<b>请输入你猜的字母是：</b>
		<input type="text" id="text" name="text" value=""/>
		<input type="button" value="提交" onclick="finish()" />
	</form>
</body>
</html>