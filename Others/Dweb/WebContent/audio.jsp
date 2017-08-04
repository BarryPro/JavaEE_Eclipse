<%@ page language="java" contentType="audio/mp3; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<body>
<audio autoplay="autoplay">
  <source src="D:\JavaFile\5.mp3" />
</audio>
<%=
	request.getParameter("password")
%>

</body>
</html>