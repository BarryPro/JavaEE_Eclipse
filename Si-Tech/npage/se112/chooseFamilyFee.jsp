<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="familyFee.jsp"  method="post">
			<input name ="familyFeeInfo" id="familyFeeInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].familyFeeInfo.value= parent.document.getElementById("familyFee<%=meansId%>").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>