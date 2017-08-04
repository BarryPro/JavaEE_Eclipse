<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.belong.vo.*,com.belong.service.*"%>
<html>
<body>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		IUserService service = new UserRegisterServiceImp();
		if(service.login(user)){
			out.print("注册成功");
		} else {
			out.print("注册失败");
		}
	%>
	<a href="index.jsp">回到登录页</a>
</body>

</html>