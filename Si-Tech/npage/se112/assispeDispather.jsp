
<%
	/*
	 * ���ܣ� ��Ʒjson����תҳ�棬ʵ�ִ������ݵ�post�ύ
	 * ���ڣ� 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("svcNum");
	System.out.println("actId=====meansId=dd=="+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="AssiSpecialFrm" action="assispecialfunds.jsp"  method="post">
			<input name ="assispecialfunds" id="assispecialfunds" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden"/>
			<input name ="phoneNo" id="phoneNo" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].assispecialfunds.value= parent.document.getElementById("global_assispecialfunds").value;
		 		document.forms[0].phoneNo.value = "<%=phoneNo%>";
		 		document.forms[0].meansId.value = "<%=meansId%>";
		 		document.forms[0].submit();
		 }
	</script>
</html>