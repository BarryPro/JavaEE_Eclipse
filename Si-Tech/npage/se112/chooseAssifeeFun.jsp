<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = (String)request.getParameter("svcNum");//�ֻ���
	String reginCode = (String) session.getAttribute("regCode");//����
	String loginNo   = (String)session.getAttribute("workNo");//��¼����
	String password   = (String)session.getAttribute("password");//��¼����
	String orderId   = (String)request.getParameter("orderId");//��ˮ
	String H11_effDateStr   = (String)request.getParameter("H11_effDateStr");//���Ӫ�����ʷѵĿ�ʼʱ��
	String act_type   = (String)request.getParameter("act_type");//�С��
	String H15   = (String)request.getParameter("H15");//�Ƿ��п����Ա
	String contracttime   = (String)request.getParameter("contracttime");
	System.out.println("**********************act_type*************" + act_type);
	System.out.println("**********************H15*************" + H15);
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="gAssiFee.jsp"  method="post">
			<input name ="assiFeeInfo" id="assiFeeInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="phoneNo" id="phoneNo" type="hidden" value = "<%=phoneNo%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="loginNo" id="loginNo" type="hidden" value = "<%=loginNo%>"/>
			<input name ="password" id="password" type="hidden" value = "<%=password%>"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="H11_effDateStr" id="H11_effDateStr" type="hidden" value = "<%=H11_effDateStr%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="H15" id="H15" type="hidden" value = "<%=H15%>"/>
			<input name ="contracttime" id="H15" type="hidden" value = "<%=contracttime%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].assiFeeInfo.value= parent.document.getElementById("global_assiFeeInfo").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>