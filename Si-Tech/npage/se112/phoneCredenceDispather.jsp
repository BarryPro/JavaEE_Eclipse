<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	
	//System.out.println("actId=====meansId=dd==" + actId+"----"+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="phoneCredenceform" action="phoneCredence.jsp"  method="post">
			<input name ="phoneCredence" id="phoneCredence" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].phoneCredence.value= parent.document.getElementById("global_phoneCredence").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>