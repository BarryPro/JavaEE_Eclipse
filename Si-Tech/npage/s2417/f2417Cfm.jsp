
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 

<%
	String regionCode = (String)session.getAttribute("regCode");
	String opName = "用户积分修改";
	String loginAccept = request.getParameter("loginAccept");
	String opCode= request.getParameter("opCode");
	String workNo= request.getParameter("workNo");
	String noPass = (String)session.getAttribute("password");
	String orgCode= request.getParameter("orgCode");
	String phoneNo= request.getParameter("phoneNo");
	String handFee= request.getParameter("handFee");
	String factPay= request.getParameter("factPay");
	String sysRemark= request.getParameter("sysRemark");
	String remark= request.getParameter("remark");
	String ipAdd= request.getParameter("ipAdd");
	String addPoint = request.getParameter("addPoint");
	String asCustName = request.getParameter("asCustName");
	String asCustPhone = request.getParameter("asCustPhone");
	String asIdType = request.getParameter("asIdType");
	String asIdIccid = request.getParameter("asIdIccid");
	String asIdAddress = request.getParameter("asIdAddress");
	String asContractAddress = request.getParameter("asContractAddress");
	String jifentype = request.getParameter("jifentype");
	
	String asNotes = request.getParameter("asNotes");
	String startCust = (String)request.getParameter("startCust")+"000000";
	String endCust = (String)request.getParameter("endCust")+"235959";
	//System.out.println("loginAccept is :"+loginAccept);
	//System.out.println("opCode is :"+opCode);
	//System.out.println("workNo is :"+workNo);
	//System.out.println("noPass is :"+noPass);
	//System.out.println("orgCode is :"+orgCode);
	//System.out.println("phoneNo is :"+phoneNo);
	//System.out.println("handFee is :"+handFee);
	//System.out.println("factPay is :"+factPay);
	//System.out.println("sysRemark is :"+sysRemark);
	//System.out.println("remark is :"+remark);
	//System.out.println("ipAdd is :"+ipAdd);
	//System.out.println("addPoint is : "+addPoint);

%>              
	<wtc:service name="s2417Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=addPoint%>"/>
		<wtc:param value="<%=handFee%>"/>
		<wtc:param value="<%=factPay%>"/>
		<wtc:param value="<%=asNotes%>"/>

		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAdd%>"/>
			<wtc:param value="<%=jifentype%>"/>		
		<wtc:param value="<%=asCustName%>"/>
		<wtc:param value="<%=asCustPhone%>"/>
		<wtc:param value="<%=asIdType%>"/>
		<wtc:param value="<%=asIdIccid%>"/>
		<wtc:param value="<%=asIdAddress%>"/>
		<wtc:param value="<%=asContractAddress%>"/>
		<wtc:param value="<%=sysRemark%>"/>
		<wtc:param value="<%=startCust%>"/>
		<wtc:param value="<%=endCust%>"/>
			
	</wtc:service>
	<wtc:array id="backInfo_t" scope="end"/>

<%
	System.out.println("----------retCode--------------"+retCode);
	System.out.println("----------retMsg--------------"+retMsg);
	System.out.println("----------backInfo_t[]][]--------------=="+backInfo_t[0][0]);
	
	String errInfo = "";
	
	if(retCode.equals("000000"))
		errInfo = retCode;
	else
		errInfo =retMsg;
%>

<%
	String strArray = WtcUtil.createArray("backInfo",backInfo_t[0].length);
%>
<%=strArray%>
<%
	for(int i = 0 ; i < backInfo_t[0].length ; i ++){
	System.out.println("-----------backInfo["+0+"]["+i+"]--------------"+backInfo_t[0][i]);
%>

	backInfo[<%=0%>][<%=i%>] = "<%=backInfo_t[0][i].trim()%>";
<%
	}
%>
var response = new AJAXPacket();

response.data.add("backString",backInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=errInfo%>");

core.ajax.receivePacket(response);
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode
		+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept
		+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime; 
%>
<jsp:include page="<%=url%>" flush="true" />
