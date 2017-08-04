
<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	System.out.println("-------------------------f4938_memNumberDispather.jsp-------------------------meansId=" + meansId);
	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="memNumberFrm" action="memNumber.jsp"  method="post">
			<input name ="memNumber" id="memNumber" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].memNumber.value= parent.document.getElementById("memNumber<%=meansId%>").value;
		 		document.forms[0].meansId.value= "<%=meansId%>";
		 		document.forms[0].submit();
		 }
	</script>
</html>