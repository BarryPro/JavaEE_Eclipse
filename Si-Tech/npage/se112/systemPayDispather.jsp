
<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2011-02-23
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("svcNum");
	
	//System.out.println("actId=====meansId=dd==" + actId+"----"+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="f4938_systemPay" action="systemPay.jsp"  method="post">
			<input name ="sysPay" id="sysPay" type="hidden"/>
			<input name ="meansId" id="meansId" type="hidden"/>
			<input name ="phoneNo" id="phoneNo" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].sysPay.value= parent.document.getElementById("global_systemPay_h").value;
		 		document.forms[0].meansId.value = "<%=meansId%>";
		 		document.forms[0].phoneNo.value = "<%=phoneNo%>";
		 		//alert(document.forms[0].stagesInfo.value ) ;
		 		document.forms[0].submit();
		 }
	</script>
</html>