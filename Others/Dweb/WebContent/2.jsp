<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.s1{
	color: green;
}
.s2{
	color: white;
}
#s2{
	font-size: 36px;
}
body{
	background-color: grey;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<%--定义声明脚本 --%>
	<%!
		private String name = "狗";
		public String fun(){
			return name;
		}
	%>
	<%--表达式脚本 --%>
	<%=fun() %>
	<%--小脚本元素 java除了定义的功能 --%>
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");		
	%>	
	<%=sdf.format(new Date()) %>
	<%
		//System.out.println("HelloWorld");//java的输出函数
		out.print("Helloworld");//jsp的输出函数是out
	%>
	<br>
	<%--span 是段内定义文档字行 --%>
	
	<%
		for(int i = 0;i<20;i++){
			if(i%2==0){
	%>		
		<span class="s1" id="s2">HelloWorld</span>
		<%=i %><br>
	<%
			} else {
	%>
		<span class="s2" id="s2">HelloWorld</span>
		<%=i %><br>
	<%
			}
		}
	%>
</body>
</html>