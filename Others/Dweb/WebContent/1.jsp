<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	background-color: grey;
}
</style>
</head>
<body>
	<%
		for(int i = 0;i<100;i++){
			out.print("helloworld");
	%>
		<br>
	<%	
		}		
	%>
	<%!
		private int scord;
		public void fun(){
			System.out.println("helloworld!");
		}
	%>
</body>
</html>