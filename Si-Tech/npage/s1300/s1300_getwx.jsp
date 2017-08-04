<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String workno = (String)session.getAttribute("workNo");
		String nopass = (String)session.getAttribute("password");
		String[] inParas = new String[2];
		String opCode = "1302";
		String opName="微信缴费";
		String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
		String s_pay_money = WtcUtil.repStr(request.getParameter("s_pay_money")," ");
		String org_code = (String)session.getAttribute("orgCode");
        String regionCode = org_code.substring(0,2);
		String s_notes="微信支付"; //sCreateOrder addBankPosInf
	 
%>
		<wtc:service name="sCreateOrder" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=s_pay_money%>"/>
			<wtc:param value="<%=org_code%>"/>
			<wtc:param value="<%=s_notes%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		String s_user_id="";
		String s_ddh="";
		String s_zfdh="";
		
		if(retCode1=="000000" ||retCode1.equals("000000"))
		{
			s_user_id=result1[0][1];
			s_ddh=result1[0][2];
			s_zfdh=result1[0][3];
		}
%>
		 
  
 
		var response = new AJAXPacket();
		var retCode="<%=retCode1%>";
		var retMsg = "<%=retMsg1%>";
		var s_user_id = "<%=s_user_id%>";
		var s_ddh = "<%=s_ddh%>";
		var s_zfdh = "<%=s_zfdh%>";
		response.data.add("s_user_id",s_user_id);
		response.data.add("s_ddh",s_ddh);
		response.data.add("s_zfdh",s_zfdh);
		response.data.add("retCode",retCode);
		response.data.add("retMsg",retMsg);
		core.ajax.receivePacket(response);


 