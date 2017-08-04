<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
%>
<html>
<head>
	</head>
	<body>
		<form name ="bankPayFeeFrm" action="payTypeInfo.jsp"  method="post">
			<input name ="bankPayFee" id="bankPayFee" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].bankPayFee.value= parent.document.getElementById("global_bankPayFee").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>