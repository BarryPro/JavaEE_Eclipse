<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-8
********************/
%>
              

<%@ include file="/npage/include/public_title_ajax.jsp" %> 

<%@ page contentType= "text/html;charset=gbk" %>


<%
	String opName = "动态信誉度申请/取消";
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNo======="+phoneNo);
	String loginAccept = request.getParameter("loginAccept");
	String opCode= request.getParameter("opCode");
	String workNo= request.getParameter("workNo");
	String noPass = (String)session.getAttribute("password");
	String orgCode= request.getParameter("orgCode");
	String idNo= request.getParameter("idNo");
	String oldCredit = request.getParameter("oldCredit");
	String newCredit = request.getParameter("newCredit");
	String expireTime = request.getParameter("expireTime");
	String handFee= request.getParameter("handFee");
	String factPay= request.getParameter("factPay");
	String sysRemark= request.getParameter("sysRemark");
	String remark= request.getParameter("remark");
	String ipAdd= request.getParameter("chgStatus");
	String asCustName = request.getParameter("asCustName");
	String asCustPhone = request.getParameter("asCustPhone");
	String asIdType = request.getParameter("asIdType");
	String asIdIccid = request.getParameter("asIdIccid");
	String asIdAddress = request.getParameter("asIdAddress");
	String asContractAddress = request.getParameter("asContractAddress");
	String asNotes = request.getParameter("asNotes");
	
	System.out.println("expireTime is : "+expireTime);
  System.out.println("expireTime is------------------------------------------- : "+ipAdd);
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

	String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("--------------------------retCode--------------------------"+retCode);
	System.out.println("--------------------------retMsg--------------------------"+retMsg);
	String errInfo = "";
	if(retCode.equals("000000")){
		errInfo  = retMsg;
	}
	else{
		errInfo  ="未知错误信息";
	} 
	//System.out.println(backInfo[].length);
	//System.out.println(errInfo[0][0]);
	//System.out.println(errInfo[0][1]);

%>


<%
	String strArray = WtcUtil.createArray("backInfo",backInfo[0].length);

%>
<%=strArray%>
<%

for(int i = 0 ; i < backInfo[0].length ; i ++){

			System.out.println("--------------------------backInfo[0]["+i+"]--------------------------"+backInfo[0][i]);
%>

backInfo[<%=0%>][<%=i%>] = "<%=backInfo[0][i].trim()%>";
<%
}
%>
var response = new AJAXPacket();


response.data.add("backString",backInfo);
response.data.add("flag1","1");
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=errInfo%>");
response.data.add("phoneNo","<%=phoneNo%>");
core.ajax.receivePacket(response);
