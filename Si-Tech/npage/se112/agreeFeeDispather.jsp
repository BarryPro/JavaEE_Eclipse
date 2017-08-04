<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = (String)request.getParameter("meansId");
	String svcNum = (String)request.getParameter("svcNum"); 
	String brandId =request.getParameter("brandId");//品牌
	String orderId =request.getParameter("orderId");//品牌
	String mode_code =request.getParameter("mode_code");//旧主资费代码
	String id_no=request.getParameter("id_no");//用户ID
	String powerRight= request.getParameter("powerRight");//工号权限
	String belong_code=request.getParameter("belongCode");//用户归属
	String act_type = (String)request.getParameter("act_type"); 
	String reginCode = (String) session.getAttribute("regCode");//区域
	String loginNo   = (String)session.getAttribute("workNo");//登录工号
	String password   = (String)session.getAttribute("password");//登录密码
	String contracttime = (String)request.getParameter("contracttime");//合约期
	String validMode = (String)request.getParameter("validmode");//合约期的生效方式
	String selectvalidMode = (String)request.getParameter("selectvalidMode");//选择的生效方式
	System.out.println("=++=======contracttime=====" + contracttime);
	System.out.println("=++=======validMode=====" + validMode);
	System.out.println("=++=======selectvalidMode=====" + selectvalidMode);
 %>
<html> 
<head>
	</head>
	<body>
		<form name ="agreeFeeInfoFrm" action="agreeFeeInfo.jsp"  method="post">
			<input name ="agreeFeeInfo" id="agreeFeeInfo" type="hidden"/>
			<input name ="assiFeeInfo" id="assiFeeInfo" type="hidden"/>
			<input name ="giftMoney" id="giftMoney" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="loginNo" id="loginNo" type="hidden" value = "<%=loginNo%>"/>
			<input name ="password" id="password" type="hidden" value = "<%=password%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="brandId" id="brandId" type="hidden" value = "<%=brandId%>"/>
			<input name ="mode_code" id="mode_code" type="mode_code" value = "<%=mode_code%>"/>
			<input name ="id_no" id="id_no" type="id_no" value = "<%=id_no%>"/>
			<input name ="powerRight" id="powerRight" type="powerRight" value = "<%=powerRight%>"/>
			<input name ="belong_code" id="belong_code" type="belong_code" value = "<%=belong_code%>"/>
			<input name ="contracttime" id="contracttime" type="hidden" value = "<%=contracttime%>"/>
			<input name ="validMode" id="validMode" type="hidden" value = "<%=validMode%>"/>
			<input name ="selectvalidMode" id="selectvalidMode" type="hidden" value = "<%=selectvalidMode%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].agreeFeeInfo.value= parent.document.getElementById("global_agreementfee").value;
		 		document.forms[0].assiFeeInfo.value= parent.document.getElementById("global_assiFeeInfo").value;
		 		document.forms[0].giftMoney.value= parent.document.getElementById("global_GiftMoney").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>