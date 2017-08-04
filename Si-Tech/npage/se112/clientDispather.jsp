<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum"); 
	String orderId = request.getParameter("orderId");
	String act_type = request.getParameter("act_type");
	String resFeeTemp = request.getParameter("resFeeTemp");
	String scoreFeeTemp = request.getParameter("scoreFeeTemp");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="clientInfoFrm" action="clientInfo.jsp"  method="post">
			<input name ="clientInfo" id="clientInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="resFeeTemp" id="resFeeTemp" type="hidden" value = "<%=resFeeTemp%>"/>
			<input name ="scoreFeeTemp" id="scoreFeeTemp" type="hidden" value = "<%=scoreFeeTemp%>"/>
		</form> 
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].clientInfo.value= parent.document.getElementById("global_clientInfo").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>