<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//取出所有的cookie记录
		Cookie [] cookie = request.getCookies();
		for(Cookie c:cookie){
			if(c.getName().equals("www.belong.com")){				
	%>
	Cookie:<input type="text" value="<%=c.getValue()%>"><br>
	<%	
			}
		}
	%>
</body>
</html>