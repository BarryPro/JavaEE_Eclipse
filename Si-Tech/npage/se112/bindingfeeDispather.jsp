<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	
	//System.out.println("actId=====meansId=dd==" + actId+"----"+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="bindingfee.jsp"  method="post">
			<input name ="bindingFeeInfo" id="bindingFeeInfo" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].bindingFeeInfo.value= parent.document.getElementById("global_bindingFeeInfo").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>