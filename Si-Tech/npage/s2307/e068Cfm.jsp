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
	System.out.println("----------------zss---------------"+newCredit);
	String expireTime = request.getParameter("expireTime");
	String handFee= request.getParameter("handFee");
	String factPay= request.getParameter("factPay");
	String sysRemark= request.getParameter("sysRemark");
	String remark= request.getParameter("remark");
	String ipAdd= request.getParameter("chgStatus");
	System.out.println("----------------zss---------------"+ipAdd);
	String asCustName = request.getParameter("asCustName");
	String asCustPhone = request.getParameter("asCustPhone");
	String asIdType = request.getParameter("asIdType");
	String asIdIccid = request.getParameter("asIdIccid");
	String asIdAddress = request.getParameter("asIdAddress");
	String asContractAddress = request.getParameter("asContractAddress");
	String asNotes = request.getParameter("asNotes");
	//System.out.println("loginAccept is :"+loginAccept);
	//System.out.println("opCode is :"+opCode);
	//System.out.println("workNo is :"+workNo);
	//System.out.println("noPass is :"+noPass);
	//System.out.println("orgCode is :"+orgCode);
	//System.out.println("idNo is :"+idNo);
	//System.out.println("handFee is :"+handFee);
	//System.out.println("factPay is :"+factPay);
	//System.out.println("sysRemark is :"+sysRemark);
	//System.out.println("remark is :"+remark);
	//System.out.println("ipAdd is :"+ipAdd);
	System.out.println("expireTime is : "+expireTime);
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
	
	response.data.add("backString",backInfo);
	response.data.add("flag1","1");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	
	core.ajax.receivePacket(response);
