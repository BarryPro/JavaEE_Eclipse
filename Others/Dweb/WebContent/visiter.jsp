<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>visiter</title>
</head>
<body>
	<%--只要服务器一重启就会有回到最初的初始值 --%>
	<%	
		int count = 0;
		if(application.getAttribute("count")==null){//内存中是空的计数器
			count = Integer.parseInt(application.getInitParameter("mycount"));//取出值初始化计数器
			application.setAttribute("count",count);//把内存中的值用mycount的初始值来替换
		} else {
			application.setAttribute("count",Integer.parseInt(application.getAttribute("count").toString())+1);
		}
	%>
	<b>你是</b>
	<%
		char ch[] = application.getAttribute("count").toString().toCharArray();//把字符转换成对应的数字字符
		for(char i:ch){//把数字字符转换成对应的图片
	%>
		<img alt="图片" src="countimg\<%=i%>.gif">
	<%		
		}
	%>
	<b>访客</b>
</body>
</html>