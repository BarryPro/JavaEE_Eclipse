
<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2011-02-23 songjia for hlj
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String H10 = request.getParameter("H10");
	String H11 = request.getParameter("H11");
	//System.out.println("actId=====meansId=dd==" + actId+"----"+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="orderTypeFrm" action="orderTypeInfo.jsp"  method="post">
			<input name ="orderType" id="orderType" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="H10" id="H10" type="hidden" value = "<%=H10%>"/>
			<input name ="H11" id="H11" type="hidden" value = "<%=H11%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].orderType.value= parent.document.getElementById("global_orderType").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>