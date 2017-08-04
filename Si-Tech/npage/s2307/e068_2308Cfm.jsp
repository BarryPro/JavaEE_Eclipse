<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
	String regionCode=(String)session.getAttribute("regCode");
	String phoneNo = (String)request.getParameter("phoneNo");
	String opName = "用户信誉度修改";
	String loginAccept = request.getParameter("loginAccept");
	String opCode= request.getParameter("opCode");
	String workNo= request.getParameter("workNo");
	String noPass = (String)session.getAttribute("password");
	String orgCode= request.getParameter("orgCode");
	String idNo= request.getParameter("idNo");
	String oldCredit = request.getParameter("oldCredit");
	String newCredit = request.getParameter("newCredit");
	System.out.println("-AAAAAAAAAAAAAAAAAAAAAAAA---------------zss-----------idNo is----"+idNo);
	String expireTime = request.getParameter("expireTime");
	String handFee= request.getParameter("handFee");
	String factPay= request.getParameter("factPay");
	String sysRemark= request.getParameter("sysRemark");
	String remark= request.getParameter("remark");
	String ipAdd= request.getParameter("chgStatus");
	System.out.println("----------------zss---------------"+opCode);
	String asCustName = request.getParameter("asCustName");
	String asCustPhone = request.getParameter("asCustPhone");
	String asIdType = request.getParameter("asIdType");
	String asIdIccid = request.getParameter("asIdIccid");
	String asIdAddress = request.getParameter("asIdAddress");
	String asContractAddress = request.getParameter("asContractAddress");
	String asNotes = request.getParameter("asNotes");
	String flag_final = request.getParameter("flag_final");
	String dqsj = request.getParameter("dqsj");
	String lxrxm = request.getParameter("lxrxm");
	String lxfs = request.getParameter("lxfs");
	String jlxm = request.getParameter("jlxm");
	String jllxfs = request.getParameter("jllxfs");
	String codeDetail = request.getParameter("codeDetail");
	String ed= request.getParameter("ed");
	//newCredit=ed;
	ed=newCredit;
	//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA new newCredit is "+newCredit);
	System.out.println("QQQQQQQQQQQQQQQQQQQQQQQ lxfs is : "+lxfs+" and jlxm is "+jlxm+" and jllxfs is "+jllxfs);
	//System.out.println("oldCredit is :"+oldCredit);
	//System.out.println("newCredit is :" + newCredit);
/**	ArrayList arr = F2307Wrapper.s2307Cfm(loginAccept,opCode,workNo,
	                                   noPass,orgCode,idNo,oldCredit,newCredit,expireTime,handFee,
	                                   factPay,sysRemark,remark,ipAdd,asCustName,asCustPhone,asIdType,
	                                   asIdIccid,asIdAddress,asContractAddress,
	                                   asNotes);
	       **/
//	String[][] backInfo = (String[][])arr.get(0);
//	String[][] errInfo = (String[][])arr.get(1);
	//xl add for fanyan
	String sx_phone_no0 = request.getParameter("sx_phone_no0");
	String sx_zw0 = request.getParameter("sx_zw0");
	String sx_phone_no1 = request.getParameter("sx_phone_no1");
	String sx_zw1 = request.getParameter("sx_zw1");
	String sx_phone_no2 = request.getParameter("sx_phone_no2");
	String sx_zw2 = request.getParameter("sx_zw2");
%>
	<wtc:service name="s2307Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=idNo%>"/>
		<wtc:param value="<%=oldCredit%>"/>
		<wtc:param value="<%=newCredit%>"/>
		<wtc:param value="<%=expireTime%>"/>
		<wtc:param value="<%=handFee%>"/>
		<wtc:param value="<%=factPay%>"/>
		<wtc:param value="<%=sysRemark%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAdd%>"/>
		<wtc:param value="<%=asCustName%>"/>
		<wtc:param value="<%=asCustPhone%>"/>
		<wtc:param value="<%=asIdType%>"/>
		<wtc:param value="<%=asIdIccid%>"/>
		<wtc:param value="<%=asIdAddress%>"/>
		<wtc:param value="<%=asContractAddress%>"/>
		<wtc:param value="<%=asNotes%>"/>
		
		<wtc:param value="<%=codeDetail%>"/>
		<wtc:param value="<%=ed%>"/>
		<wtc:param value="<%=dqsj%>"/>
		<wtc:param value="<%=lxrxm%>"/>
		<wtc:param value="<%=lxfs%>"/>
		<wtc:param value="<%=jlxm%>"/>
		<wtc:param value="<%=jllxfs%>"/>
		<wtc:param value="<%=flag_final%>"/>
		<wtc:param value="<%=sx_phone_no0%>"/>
		<wtc:param value="<%=sx_zw0%>"/>
		<wtc:param value="<%=sx_phone_no1%>"/>
		<wtc:param value="<%=sx_zw1%>"/>
		<wtc:param value="<%=sx_phone_no2%>"/>
		<wtc:param value="<%=sx_zw2%>"/>
	</wtc:service>
	<wtc:array id="backInfo" scope="end"/>
<%
	String  errCode = retCode;
	String  errMsg = retMsg;
	String cnntAccept = "";
	if(errCode.equals("000000")&&backInfo.length>0){
		cnntAccept = backInfo[0][0];
	}
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="未知错误信息";
		}
	} 
	//System.out.println(backInfo.length);
	//System.out.println(errCode);
	//System.out.println(errMsg);
	String url ="/npage/contact/upCnttInfo_boss.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
		+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+cnntAccept
		+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;

%>
<jsp:include page="<%=url%>" flush="true" />

<%
	String strArray = CreatePlanerArray.createArray("backInfo",backInfo.length);

%>
<%=strArray%>
<%

	for(int i = 0 ; i < backInfo.length ; i ++){
	      for(int j = 0 ; j < backInfo[i].length ; j ++){


%>

	backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";
<%
}
}
%>
	var response = new AJAXPacket();
	
	response.data.add("backString2307",backInfo);
	response.data.add("flag1","1");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	
	core.ajax.receivePacket(response);
