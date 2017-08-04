<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.belong.vo.*,com.belong.service.*"%>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	User user = new User();//把新建的用户传给服务器端的用户名单
	user.setUsername(username);
	user.setPassword(password);
	IUserService service = new UserServiceImp();//通过service来访问dao服务器（修饰保护机制）
	if(service.login(user)){//看是否登录成功
		session.setAttribute("username", username);
		response.sendRedirect("success.jsp");
	} else {
		response.sendRedirect("index.jsp");
	}
%>