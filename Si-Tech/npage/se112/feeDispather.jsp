<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	String brandId =request.getParameter("brandId");//Ʒ��
	String orderId =request.getParameter("orderId");//Ʒ��
	String phoneNo = (String)request.getParameter("svcNum");//�ֻ���
	String mode_code =request.getParameter("mode_code");//�����ʷѴ���
	String id_no=request.getParameter("id_no");//�û�ID
	String powerRight= request.getParameter("powerRight");//����Ȩ��
	String belong_code=request.getParameter("belongCode");//�û�����
	String reginCode = (String) session.getAttribute("regCode");//����
	String act_type = (String) request.getParameter("act_type");//�С��
	String startTime = (String) request.getParameter("startTime");//�С��
	String H15   = (String)request.getParameter("H15");//�С��
	String netFlag   = (String)request.getParameter("netFlag");//�С��
	
	System.out.println("act_type&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+act_type);
	System.out.println("startTime&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+startTime);
	System.out.println("H15&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+H15);
	System.out.println("netFlag&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+netFlag);
	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="feeInfoFrm" action="feeInfo.jsp"  method="post">
			<input name ="PRI_FEE_CODE" id="PRI_FEE_CODE" type="hidden"/>
			<input name ="ssfeeInfo" id="ssfeeInfo" type="hidden"/>
			<input name ="PRI_FEE_NAME" id="PRI_FEE_NAME" type="hidden"/>
			<input name ="orderId" id="orderId" type="hidden" value = "<%=orderId%>"/>
			<input name ="meansId" id="meansId" type="hidden" value = "<%=meansId%>"/>
			<input name ="brandId" id="brandId" type="hidden" value = "<%=brandId%>"/>
			<input name ="mode_code" id="mode_code" type="mode_code" value = "<%=mode_code%>"/>
			<input name ="id_no" id="id_no" type="id_no" value = "<%=id_no%>"/>
			<input name ="powerRight" id="powerRight" type="powerRight" value = "<%=powerRight%>"/>
			<input name ="belong_code" id="belong_code" type="belong_code" value = "<%=belong_code%>"/>
			<input name ="phoneNo" id="phoneNo" type="hidden" value = "<%=phoneNo%>"/>
			<input name ="reginCode" id="reginCode" type="hidden" value = "<%=reginCode%>"/>
			<input name ="act_type" id="act_type" type="hidden" value = "<%=act_type%>"/>
			<input name ="startTime" id="startTime" type="hidden" value = "<%=startTime%>"/>
			<input name ="H15" id="H15" type="hidden" value = "<%=H15%>"/>
			<input name ="netFlag" id="netFlag" type="hidden" value = "<%=netFlag%>"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].ssfeeInfo.value= parent.document.getElementById("global_ssfeeInfo").value;
		 		document.forms[0].PRI_FEE_CODE.value= parent.document.getElementById("priFee<%=meansId%>").value;
		 		document.forms[0].PRI_FEE_NAME.value= parent.$("#priFee<%=meansId%> option:selected").text();
		 		document.forms[0].submit();
		 }
	</script>
</html>