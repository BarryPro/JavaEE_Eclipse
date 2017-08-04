<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>personalresume</title>
<style type="text/css">

</style>
<script type="text/javascript">
</script>
</head>
<body >
	
	<div align="center">
	
	<form action="resumeresponse.jsp" method="get" id="ida">
		<table border="1px">
			<tr>
				<td>
					<img alt="图片" src="赵丽颖.jpeg" >
				</td>
			</tr>
			<tr>
				<td>					
					<b>姓名</b><input type="text" width="100px" id="user" value="用户名" name="username"/><br>
					<b>密码</b><input type="password" name="pwd"/><br>
					<b>确认密码</b><input type="password" name="pwd1"/><br>					
				</td>				
			</tr>
			<tr>
				<td><b>性别</b><input type="radio" name="sex" value="男">男
					<input type="radio" name="r1" value="女">女
				</td>
			</tr>
				<tr>
							<td><b>出生日期</b>
					<select name="year">
					<%
						for(int i = 1990;i<=2016;i++){
					%>
						<option><%= i %></option>
					<% 	
						}
					%>				
					</select><b>年</b>					
					<select name="month">
					<%
						for(int i = 1;i<=12;i++){
					%>
						<option><%= i %></option>
					<% 	
						}
					%>							
					</select><b>月</b>					
					<select name="day">
					<%
						for(int i = 1;i<31;i++){
					%>
						<option><%= i %></option>
					<% 	
						}
					%>							
					</select><b>日</b>
				</td>
				</tr>
			<tr>	
				<td>
					<b>爱好</b>
					<input type="checkbox" name="interest" value="游泳"/>游泳
					<input type="checkbox" name="interest" value="跑步"/>跑步
					<input type="checkbox" name="interest" value="太极"/>太极
					<input type="checkbox" name="interest" value="唱歌"/>唱歌
					<input type="checkbox" name="interest" value="跳舞"/>跳舞
					<input type="checkbox" name="interest" value="编码"/>编码
					<input type="checkbox" name="interest" value="开车"/>开车
					<input type="checkbox" name="interest" value="健身"/>健身
				</td>			
			</tr>
			<tr>
				<td><b>理想薪资</b>
					<select name="wage">
					<%
						for(int i = 5000;i<=30000;i+=1000){
					%>
						<option><%= i %></option>
					<% 	
						}
					%>		
				</td>
			</tr>
			<tr>
				<td>
					<b>毕业院校</b><input type="text" name="school"/>
				</td>
			</tr>
			<tr>
			<td>
				<b>专业</b><input type="text" name="profession"/>
			</td>
			</tr>
			<tr>
				<td>
					<b>家庭住址</b><input type="text" name="address"/>
				</td>
			</tr>
			<tr>
				<td>
					<b>电子邮件</b><input type="text" name="email"/>
				</td>
			</tr>
			<tr>
				<td>
					<b>个人简历</b>
					<textarea cols="100px" name="txta">个人简历</textarea>
				</td>
			</tr>
		</table>
		<input type="submit" id="submit"/>
		<input type="reset" id="reset"/><br>
		</form>
	</div>
</body>
</html>