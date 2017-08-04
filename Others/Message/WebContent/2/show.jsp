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
		 <%			
			List <Message> list=(ArrayList)request.getAttribute("mlist");
			int count=0;
			for(Message m : list){
		%>	 
		<%--${}===<%=%>   <c:……===<%%> --%>
	<%--	<c:set var="list" value="${requestScope.mlist }"></c:set>
		<c:set var="count" value="0"></c:set>--%>
		<%--item表示的是引用 var表示的是具体项 --%>
	<%--	<c:forEach items="${list}" var="m">--%>
			<tr>
				<td>
					 <%=++count %> 
				<%--	<c:set var="count" value="${count+1}">
						${count}
					</c:set>--%>
				</td>
				<td>
					 <%=m.getName() %> 
				<%--	${m.name}--%>
				</td>
				<td>
					 <%=m.getEmail() %> 
				<%--	${m.email }--%>
				</td>
				<td>
					 <%=m.getTitle() %> 
					<%--${m.title }--%>
				</td>
				<td>
					 <%=m.getContent()%> 
					<%--${m.contect }--%>
				</td>
				<td>
					 <%=m.getDate()%> 
				<%--	${m.date }--%>
				</td>
				
				<td>
					 <a href="MessageControl.do?action=del&id=<%=m.getId()%>">删除</a> 
					<%--<a href="MessageControl.do?action=del&id=${m.id}">删除</a>--%>
				</td>		
			</tr>
		<%--	</c:forEach>	--%>
		 <%		
			}
		%>		 
	</table>
</body>
</html>
