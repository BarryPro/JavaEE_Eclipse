 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
  <c:set var="userid" value="${sessionScope.user.id==null?999:sessionScope.user.id}"></c:set>
<div class="pagination">
	<ul>
		
		<c:if test="${pb.curPage==1}">
		
			<li><a href="">首页</a></li>
			<li><a href="">前一页</a></li>
		</c:if>
		<c:if test="${pb.curPage!=1}">
		
		
		
		
			<li><a href="ArticleControl?action=query&curpage=1&userid=${userid}">首页</a></li>
			<li><a href="ArticleControl?action=query&curpage=${pb.curPage-1}&userid=${userid}">前一页</a></li>
		
		</c:if>
			<c:forEach begin="1" end="${pb.maxPage}" var="i">
				<li><a href="ArticleControl?action=query&curpage=${i}&userid=${userid}">${i}</a></li>
			</c:forEach>
		
		<c:if test="${pb.curPage==pb.maxPage}">
		
			<li>下一页</li>
			<li>尾页</li>
		
		</c:if>
		<c:if test="${pb.curPage!=pb.maxPage}">
		
		
			<li><a href="ArticleControl?action=query&curpage=${pb.curPage+1}&userid=${userid}">下一页</a></li>
			<li><a href="ArticleControl?action=query&curpage=${pb.maxPage}&userid=${userid}">尾页</a></li>
		</c:if>
	</ul>
</div>