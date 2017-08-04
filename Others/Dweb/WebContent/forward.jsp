<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>forword</title>
</head>
<body>
	<%
		String str[] = {"tom","jack","rose"};
		for(String s:str){
			if(s.equals("jack")){
				%>	
				<%--地址栏不发生该变 只能是内网自动跳转 --%>
				<jsp:forward page="recive.jsp">
					<jsp:param value="1234565" name="password"/>
					<jsp:param value='<%=java.net.URLEncoder.encode("小骨","utf-8") %>' name="username"/>
				</jsp:forward>	
				<%
			} 
		}
	%>
	
</body>
</html>