
<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="gWlan.jsp"  method="post">
			<input name ="gWlanInfo" id="gWlanInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].gWlanInfo.value= parent.document.getElementById("global_gWlan").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>