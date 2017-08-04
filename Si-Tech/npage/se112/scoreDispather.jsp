<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="scoreInfoFrm" action="scoreInfo.jsp"  method="post">
			<input name ="scoreInfo" id="scoreInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].scoreInfo.value= parent.document.getElementById("global_scoreInfo").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>