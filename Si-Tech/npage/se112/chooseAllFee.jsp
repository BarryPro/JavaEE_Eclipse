<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	String brandId =request.getParameter("brandId");//Ʒ��
	String mode_code =request.getParameter("mode_code");//�����ʷѴ���
	String id_no=request.getParameter("id_no");//�û�ID
	String powerRight= request.getParameter("powerRight");//����Ȩ��
	String belong_code=request.getParameter("belong_code");//�û�����
	String orderId =request.getParameter("orderId");//Ʒ��
	String phoneNo = (String)request.getParameter("svcNum");//�ֻ���
	String reginCode = (String) session.getAttribute("regCode");//����
	System.out.println("+++++++++++++++++++++++++++++meansId :"+meansId);
	System.out.println("+++++++++++++++++++++++++++++Ʒ��brandId :"+brandId);
	System.out.println("+++++++++++++++++++++++++++++�����ʷѴ��� mode_code:"+mode_code);
	System.out.println("+++++++++++++++++++++++++++++�û�ID id_no :"+id_no);
	System.out.println("+++++++++++++++++++++++++++++����Ȩ��powerRight :"+powerRight);
	System.out.println("+++++++++++++++++++++++++++++�û����� belong_code:"+belong_code);
 %>
<html>
<head>
	</head>
	<body>
		<form name ="feeInfoFrm" action="allFee.jsp"  method="post">
			<input name ="ALL_PRI_FEE_CODE" id="ALL_PRI_FEE_CODE" type="hidden"/>
			<input name ="allFeeInfo" id="allFeeInfo" type="hidden"/>
			<input name ="ALL_PRI_FEE_NAME" id="ALL_PRI_FEE_NAME" type="hidden"/>
			<input name ="ALL_PAY_MONEY" id="ALL_PAY_MONEY" type="hidden"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="brandId" id="brandId" type="hidden" value = "<%=brandId%>"/>
			<input name ="mode_code" id="mode_code" type="mode_code" value = "<%=mode_code%>"/>
			<input name ="id_no" id="id_no" type="id_no" value = "<%=id_no%>"/>
			<input name ="powerRight" id="powerRight" type="powerRight" value = "<%=powerRight%>"/>
			<input name ="belong_code" id="belong_code" type="belong_code" value = "<%=belong_code%>"/>
			<input name ="phoneNo" id="phoneNo" type="hidden" value = "<%=phoneNo%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
		
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].allFeeInfo.value= parent.document.getElementById("global_allFee").value;
		 		var value = parent.document.getElementById("allPriFee<%=meansId%>").value;
		 		var array = value.split("&");
		 		document.forms[0].ALL_PRI_FEE_CODE.value= array[0];
		 		document.forms[0].ALL_PAY_MONEY.value = array[1];
		 		document.forms[0].ALL_PRI_FEE_NAME.value = parent.$("#allPriFee<%=meansId%> option:selected").text();
		 		document.forms[0].submit();
		 }
	</script>
</html>