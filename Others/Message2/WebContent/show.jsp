<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.belong.vo.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>test</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
body {
	padding: 20px;
}
</style>
</head>
<body>
	<h2>我的消息</h2>
	<table class="table table-striped table-bordered">		
		<tr>
			<th>序号</th>
			<th>发布者</th>
			<th>发布邮箱</th>
			<th>标题</th>
			<th>内容</th>
			<th>时间</th>
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
	 			${m.email}
	 		</td>
	 		<td>
	 			${m.title}
	 		</td>
	 		<td>
	 			${m.content}
	 		</td>
	 		<td>
	 			${m.date}
	 		</td>
	 		<td>
	 			<a href="MessageControl.do?action=del&id=${m.id}">删除</a>
	 		</td>
	 	</tr>
	 	</c:forEach>
	</table>
</body>
</html>
