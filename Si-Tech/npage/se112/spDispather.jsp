
<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = (String)request.getParameter("svcNum");//手机号
	String reginCode = (String) session.getAttribute("regCode");//区域
	String loginNo   = (String)session.getAttribute("workNo");//登录工号
	String password   = (String)session.getAttribute("password");//登录密码
	String orderId   = (String)request.getParameter("orderId");//流水
	String innetMons   = (String)request.getParameter("innetMons");//客户入网月数
	String actType   = (String)request.getParameter("actType");//小类
	System.out.println("=++=======@@@@@@@@@@@@@@@@@@@@@@actType=====" + actType);
 %>
<html>
<head>
	</head>
	<body>
		<form name ="spInfoFrm" action="spInfo.jsp"  method="post">
			<input name ="spInfo" id="spInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="phoneNo" id="phoneNo" type="hidden" value = "<%=phoneNo%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="loginNo" id="loginNo" type="hidden" value = "<%=loginNo%>"/>
			<input name ="password" id="password" type="hidden" value = "<%=password%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="innetMons" id="innetMons" type="hidden" value = "<%=innetMons%>"/>
			<input name ="actType" id="actType" type="hidden" value = "<%=actType%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].spInfo.value= parent.document.getElementById("global_spInfo").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>