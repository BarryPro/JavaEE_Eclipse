<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>显示歌单</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<style>
body{
	padding:20px;
}
</style>
</head>
<body>
	<h1>歌单信息</h1><br>
	<table class="table table-striped table-bordered">
		<tr>
			<th>序号</th>
			<th>歌名</th>
			<th>歌手</th>
			<th>专辑</th>
			<th>发布如期</th>
			<th>操作</th>
		</tr>
		<c:set var="list" value="${requestScope.mlist}"/>
		<c:set var="count" value="0"/>
		<c:forEach items="${list}" var="m">
	 	<tr>
	 		<td>
	 			<c:set var="count" value="${count+1}"/>
	 			${count}
	 		</td>
	 		<td>
	 			${m.name}
	 		</td>
	 		<td>
	 			${m.singer}
	 		</td>
	 		<td>
	 			${m.special}
	 		</td>
	 		<td>
	 			${m.date}
	 		</td>
	 		<td>
	 			<a href="MusicControl.do?action=del&id=${m.id}">删除</a>
	 		</td>
	 	</tr>
	 	</c:forEach>
	</table>
</body>
</html>