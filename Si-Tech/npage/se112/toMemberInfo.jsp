<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String orderId = request.getParameter("orderId");
	String netCode = request.getParameter("netCode");
	String actType = request.getParameter("actType");
	String svcNum = request.getParameter("svcNum");
	System.out.println("=======toMemberInfo==========meansId==============="+meansId);
	System.out.println("=======toMemberInfo==========orderId==============="+orderId);
	System.out.println("=======toMemberInfo==========netCode==============="+netCode);
	System.out.println("=======toMemberInfo==========actType==============="+actType);
	System.out.println("=======toMemberInfo==========svcNum==============="+svcNum);
 %>
<html>
<head>
	</head>
	<body>
		<form name ="memberInfo" action="memberInfo.jsp"  method="post">
			<input name ="memNo" id="memNo" type="hidden"/>
			<input name ="memFee" id="memFee" type="hidden"/>
			<input name ="memAddFee" id="memAddFee" type="hidden"/>
			<input name ="memFund" id="memFund" type="hidden"/>
			<input name ="memSysFee" id="memSysFee" type="hidden"/>
			<input name ="familyLowType" id="familyLowType" type="hidden"/>
			<input name ="netScoreMoney" id="netScoreMoney" type="hidden"/>
			<input name ="spNetFlag" id="spNetFlag" type="hidden"/>
			<input name ="orderId" id="orderId" type="hidden" value="<%=orderId %>"/>
			<input name ="meansId" id="meansId" type="hidden" value="<%=meansId %>"/>
			<input name ="netCode" id="netCode" type="hidden" value="<%=netCode %>" />
			<input name ="actType" id="actType" type="hidden" value="<%=actType %>" />
			<input name ="svcNum" id="svcNum" type="hidden" value="<%=svcNum %>" />
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].memNo.value= parent.document.getElementById("global_memNo").value;
		 		document.forms[0].memFee.value= parent.document.getElementById("global_memFee").value;
		 		document.forms[0].memAddFee.value= parent.document.getElementById("global_memAddFee").value;
		 		document.forms[0].memFund.value= parent.document.getElementById("global_memFund").value;
		 		document.forms[0].memSysFee.value= parent.document.getElementById("global_memSysFee").value;
		 		document.forms[0].familyLowType.value= parent.document.getElementById("global_familyLowType").value;
		 		document.forms[0].netScoreMoney.value= parent.document.getElementById("global_netScoreMoney").value;
		 		document.forms[0].spNetFlag.value= parent.document.getElementById("global_spNetFlag").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>