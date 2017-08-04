<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean class="com.belong.vo.Animal" id="a"></jsp:useBean>
	<c:set target="${a }" property="name" value="gou"/>
	<c:set target="${a }" property="age" value="10"/>
	<c:out value="${a.name }"></c:out> 
	<c:out value="${a.age }"/>
	<c:set var="ses" value="sjih"/>
	<c:out value="${ses }"></c:out>
	<table>
		<tr>
			<td>${ses}</td>
		</tr>		
	</table>
	${ses }
	<c:if test="${a.age==100 }" >
		<c:out value="你太老了" ></c:out>
	</c:if>
	<c:choose>
		<c:when test="${a.age>20 }">
			大叔
		</c:when>
		<c:otherwise>
			<font color="red">yeye</font>
		</c:otherwise>
		
	</c:choose>
	<c:out value="sdglsdj"/>
	<%--${dgslg} 其中的dgslg表示的是变量 --%>
	<c:out value="${dfslg }" default="inexistence"/><br>
	<%--引用类型必须要提前把它引导内存中 --%>
	<%
		List<String> list = new ArrayList<String>();
		list.add("gou");
		list.add("mao");
		list.add("huli");
		list.add("zhu");		
		list.add("ji");	
		request.setAttribute("list", list);
	%>
	<c:forEach items="${list }" var="a" varStatus="status">
		<c:choose>
			<c:when test="${status.first}">
				<font color="blue">${a}</font><br>
			</c:when>
			<c:when test="${status.last}">
				<font color="red">${a}</font><br>
			</c:when>
			<c:otherwise>${a}<br></c:otherwise>
		</c:choose>	
	</c:forEach><br>
	<c:forEach var="i" begin="1" end="20" step="2">
		${i }<br>
	</c:forEach>
	<c:set var="b" value="a,b,d,d,g,d,d"/>
	${b}<br>
	<c:forEach items="${b }" var="i">
		${i }<br>
	</c:forEach>
	
	<%--<c:redirect url="1.jsp"/> --%>
	<%--字符串null 不等于null --%>
	null=="null" :${null=="null"}<br>
	"empty"==null :${empty null}<br>
	""==null :${empty "" }
	${null== "" }<br>
	<c:set var="d" value="嵌套"/>
	<hr>
	${{}}
	<hr>
	<table align="center" bgcolor="green" border="1">
		<tr>
			<th bgcolor="blue">姓名</th>
			<th>年龄</th>
		</tr>
		<tr>
			<td>
				<input type="text" >
			</td>
			<td>
				<input type="text" >
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" >
			</td>
			<td>
				<input type="text" >
			</td>
		</tr>
	</table><hr>
	<c:set var="name" value="belong" scope="session"/>
	<c:out value="${sessionScope.name }"></c:out>
</body>
</html>