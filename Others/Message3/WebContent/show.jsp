<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>显示</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
	body {
	padding: 20px;
}
</style>
</head>
<body>
	<h1>我的信息</h1><hr>
	<table class="table table-striped table-bordered">
		<tr>
			<th>序号</th>
			<th>发布者</th>
			<th>邮箱</th>
			<th>标题</th>
			<th>内容</th>
			<th>时间</th>
			<th>操作</th>
		</tr>
		<c:set var="list" value="${mlist}"/>
		<c:set var="count" value="0"/>
		<c:forEach items="${list}" var="m">
			<tr>
				<td>
					<c:set var="count" value="${count+1 }"/>
					${count}
				</td>
				<td>${m.name}</td>
				<td>${m.email}</td>
				<td>${m.title}</td>
				<td>${m.content}</td>
				<td>${m.date}</td>
				<td>
					<a class="btn" href="Message3Control.do?action=del&id=${m.id}">删除</a>
				</td>
			</tr>
		</c:forEach>		
	</table>
</body>
</html>