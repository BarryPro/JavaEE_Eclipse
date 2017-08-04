<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = (String)request.getParameter("meansId");
	String svcNum = (String)request.getParameter("svcNum"); 
	String act_type = (String)request.getParameter("act_type"); 
	String reginCode = (String) session.getAttribute("regCode");//ÇøÓò
	String loginNo   = (String)session.getAttribute("workNo");//µÇÂ¼¹¤ºÅ
	String password   = (String)session.getAttribute("password");//µÇÂ¼ÃÜÂë
	String pay_moneycould   = (String)request.getParameter("pay_moneycould");//Ó¦ÊÕ½ð¶î
 %>
<html>
<head>
	</head>
	<body>
		<form name ="oldResInfoFrm" action="oldResInfo.jsp"  method="post">
			<input name ="oldResInfo" id="oldResInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="loginNo" id="loginNo" type="hidden" value = "<%=loginNo%>"/>
			<input name ="password" id="password" type="hidden" value = "<%=password%>"/>
			<input name ="pay_moneycould" id="pay_moneycould" type="hidden" value = "<%=pay_moneycould%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].oldResInfo.value= "1";
		 		document.forms[0].submit();
		 }
	</script>
</html>