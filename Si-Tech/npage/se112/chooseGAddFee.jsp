
<%
	/*
	 * ���ܣ� ��Ʒjson����תҳ�棬ʵ�ִ������ݵ�post�ύ
	 * ���ڣ� 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum");//�ֻ���
	String reginCode = (String) session.getAttribute("regCode");//����
	String loginNo   = (String)session.getAttribute("workNo");//��¼����
	String password   = (String)session.getAttribute("password");//��¼����
	String orderId   = (String)request.getParameter("orderId");//��ˮ
	String groupId = (String)session.getAttribute("groupId");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="gAddFee.jsp"  method="post">
			<input name ="gAddFeeInfo" id="gAddFeeInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="svcNum" id="svcNum" type="hidden" value = "<%=svcNum%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="loginNo" id="loginNo" type="hidden" value = "<%=loginNo%>"/>
			<input name ="password" id="password" type="hidden" value = "<%=password%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="groupId" id="groupId" type="hidden" value = "<%=groupId%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].gAddFeeInfo.value= parent.document.getElementById("global_gAddFee").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>