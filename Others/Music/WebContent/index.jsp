<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
		<form action="MusicControl.do">
			<span>歌名</span><input type="text" name="name"><br>
			<span>歌手</span><input type="text" name="singer"><br>
			<span>专辑</span><input type="text" name="special"><br>
			<input type="hidden" name="action" value="add">
			<input type="submit" value="提交" class="btn">
			<input type="reset" value="重置">
		</form>
		<a href="MusicControl.do?action=show" class="btn">查询歌单</a>
	</div>
</body>
</html>