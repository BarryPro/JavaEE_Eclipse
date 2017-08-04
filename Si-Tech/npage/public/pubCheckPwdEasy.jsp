<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghfa@2010-8-9 密码过于简单验证
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
	String pwd = WtcUtil.repStr(request.getParameter("password"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String idNo = WtcUtil.repStr(request.getParameter("idNo"), "");
	String contractNo = WtcUtil.repStr(request.getParameter("contractNo"), "");
	String custId = WtcUtil.repStr(request.getParameter("custId"), "");
	String pwdName = WtcUtil.repStr(request.getParameter("pwdName"), "");
	String type = "0";
	String sql = "";
	String workNo = (String)session.getAttribute("workNo");
  String passwordss = (String)session.getAttribute("password"); 
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String ipAddrss = (String)session.getAttribute("ipAddr");
  if(opCode.trim().equals("")) {
  	opCode="1104";
  }
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== pwd = " + pwd);
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== phoneNo = " + phoneNo);
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== idNo = " + idNo);
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== contractNo = " + contractNo);
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== custId = " + custId);
	System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== opCode = " + opCode);
	
	if (idNo.equals("") && !"".equals(contractNo)) {
		sql = "select phone_no from dcustmsg where id_no = (select id_no from dconusermsg where contract_no = '" + contractNo + "')";
%>
	<wtc:service name="sCustTypeQryG"  routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1" retmsg="retMsg1" >
							<wtc:param value="0" />
							<wtc:param value="01" />	
							<wtc:param value="<%=opCode%>" />	
							<wtc:param value="<%=workNo%>" />
							<wtc:param value="<%=passwordss%>" />
							<wtc:param value="" />
							<wtc:param value="" />
							<wtc:param value="<%=contractNo%>" />
	</wtc:service>								
<wtc:array id="phone_result" scope="end" />
<%
		if ("000000".equals(retCode1) && phone_result.length > 0) {
			phoneNo = phone_result[0][0];
			System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== 手机1 = " + phoneNo);
		}
	}

	if (phoneNo.equals("") && !"".equals(custId)) {
		sql = "select phone_no from dcustmsg where cust_id = '" + custId + "'";
		String beizhussdese="根据custid=["+custId+"]进行查询";
%>

   <wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>" retmsg="retMsg2" retcode="retCode2">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=passwordss%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
			<wtc:param value="<%=custId%>" />
</wtc:service>
<wtc:array id="returnFlag" start="0" length="30" scope="end"/>
<wtc:array id="phoneNo_result" start="31" length="40" scope="end"/>
	
<%
System.out.println("====pubCheckPwdEasy.jsp====wanghfa== 手机2 = " + phoneNo_result.length);
		if ("000000".equals(retCode2) && phoneNo_result.length > 0) {
			for (int i = 0; i < phoneNo_result.length; i ++ ) {
				System.out.println("====pubCheckPwdEasy.jsp====wanghfa== 手机2 = " + phoneNo_result[i][6]);

				if (phoneNo_result[i][6].indexOf(pwd) != -1) {
					type = "3";
				}
			}
		}
	}

	if (idNo.equals("") && !"-1".equals(type) && !"".equals(contractNo)) {
		sql = "select id_iccid from dcustdoc where cust_id = (select con_cust_id from dconmsg where contract_no = '" + contractNo + "')";
%>

	
	<wtc:service name="sCustTypeQryD"  routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode3" retmsg="retMsg3" >
							<wtc:param value="0" />
							<wtc:param value="01" />	
							<wtc:param value="<%=opCode%>" />	
							<wtc:param value="<%=workNo%>" />
							<wtc:param value="<%=passwordss%>" />
							<wtc:param value="" />
							<wtc:param value="" />
							<wtc:param value="<%=contractNo%>" />
	</wtc:service>								
	<wtc:array id="idNo_result" scope="end" />
		
<%
		if ("000000".equals(retCode3) && idNo_result.length > 0) {
			idNo = idNo_result[0][2];
			System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== 证件1 = " + idNo);
		}
	}

	if (idNo.equals("") && !"".equals(custId)) {
		sql = "select id_iccid from dcustdoc where cust_id = '" + custId + "'";
//		System.out.println("===============wanghfa============= sql = " + sql);
		String beizhussdese="根据custid=["+custId+"]进行查询";
%>
   <wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regionCode%>" retmsg="retMsg4" retcode="retCode4">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=passwordss%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
			<wtc:param value="<%=custId%>" />
</wtc:service>

<wtc:array id="idNo_result" scope="end" />
<%
		if ("000000".equals(retCode4) && idNo_result.length > 0) {
			idNo = idNo_result[0][13];
			System.out.println("====pubCheckPwdEasy.jsp====wanghfa==== 证件2 = " + idNo);
		}
	}

	if (pwd.equals("000000") || pwd.equals("111111") || pwd.equals("222222") || pwd.equals("333333")
		 || pwd.equals("444444") || pwd.equals("555555") || pwd.equals("666666") || pwd.equals("777777")
		 || pwd.equals("888888") || pwd.equals("999999")) {
		type = "1";
	} else if ("01234567890".indexOf(pwd) != -1) {
		type = "2";
	} else if (phoneNo.indexOf(pwd) != -1) {
		type = "3";
	} else if (idNo.indexOf(pwd) != -1) {
		type = "4";
	}
	

%>

var response = new AJAXPacket();
var retResult = <%=type%>;

response.data.add("retResult",retResult);
<%if("e887".equals(opCode.trim())) {%>
		response.data.add("pwdName","<%=pwdName%>");
<%}%>

core.ajax.receivePacket(response);
