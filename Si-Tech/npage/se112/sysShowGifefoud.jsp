<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String H08 = request.getParameter("H08");
	System.out.println("actId=====meansId=dd==----"+meansId);	
	System.out.println("actId=====H08=dd==----"+H08);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="systemGife" action="marketGif.jsp"  method="post">
			<input name ="marketGif" id="marketGif" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden"/>
			<input name ="H08" id="H08" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].marketGif.value= parent.document.getElementById("global_giftInfo").value;
		 		document.forms[0].meansId.value = "<%=meansId%>";
		 		document.forms[0].H08.value = "<%=H08%>";
		 		//alert(document.forms[0].stagesInfo.value ) ;
		 		document.forms[0].submit();
		 }
	</script>
</html>