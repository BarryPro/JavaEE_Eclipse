
<%
	/*
	 * ���ܣ� ��Ʒjson����תҳ�棬ʵ�ִ������ݵ�post�ύ
	 * ���ڣ� 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="gRes.jsp"  method="post">
			<input name ="gResInfo" id="gResInfo" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].gResInfo.value= parent.document.getElementById("global_gRes").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>