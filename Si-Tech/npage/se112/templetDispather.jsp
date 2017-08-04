<%@ page contentType="text/html;charset=GBK"%>
<%
	String svcNum = (String)request.getParameter("svcNum"); 
	String brandId =request.getParameter("brandId");//品牌
	String id_no=request.getParameter("id_no");//用户ID
	String act_type =request.getParameter("act_type");//品牌
	String mode_code=request.getParameter("mode_code");//用户ID
	String powerRight =request.getParameter("powerRight");//品牌
	String belong_code=request.getParameter("belong_code");//用户ID
	String meansId = request.getParameter("meansId");
	String orderId = request.getParameter("orderId");
	String resourceMoney = request.getParameter("resourceMoney");
	String selectMeansId = request.getParameter("selectMeansId"); 	//add zhangxy 20161222
	String actId = request.getParameter("actId");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="orderTypeFrm" action="templetInfo.jsp"  method="post">
			<input name ="templet" id="templet" type="hidden"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
			<input name ="brandId" id="brandId" type="hidden" value = "<%=brandId%>"/>
			<input name ="id_no" id="id_no" type="hidden" value = "<%=id_no%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="mode_code" id="mode_code" type="hidden" value = "<%=mode_code%>"/>
			<input name ="powerRight" id="powerRight" type="hidden" value = "<%=powerRight%>"/>
			<input name ="belong_code" id="belong_code" type="hidden" value = "<%=belong_code%>"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="selectMeansId" id="selectMeansId" type="hidden" value = "<%=selectMeansId%>"/>
			<input name ="resourceMoney" id="resourceMoney" type="hidden" value = "<%=resourceMoney%>"/>
			<!-- add zhangxy 2016122 -->
			<input name ="actId" id="actId" type="hidden" value = "<%=actId%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].templet.value= parent.document.getElementById("global_templet").value;
		 		document.forms[0].submit();
		}
	</script>
</html>