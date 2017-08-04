<%@ page contentType="text/html;charset=GBK"%>
<%
	String phoneNo = (String)request.getParameter("svcNum");//ÊÖ»úºÅ
	String imeiCode = (String)request.getParameter("imeiCode");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="orderTypeFrm" action="cardTypeInfo.jsp"  method="post">
			<input name ="phoneNo" id="phoneNo" type="hidden" value = "<%=phoneNo%>"/>
			<input name ="imeiCode" id="imeiCode" type="hidden" value = "<%=imeiCode%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].submit();
		 }
	</script>
</html>