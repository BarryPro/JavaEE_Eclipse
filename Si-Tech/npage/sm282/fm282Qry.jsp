<%
    /*************************************
    * 功  能: m282
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: gaopeng @ 2015/3/27 14:31:11
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===m282====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		
		String retCode11 = "";
		String retMsg11 = "";
		/*
		strcpy(inLoginAccept,	input_parms[0]);
		strcpy(inChnSource,		input_parms[1]);
		strcpy(inOpCode,		input_parms[2]);
		strcpy(inLoginNo,		input_parms[3]);
		strcpy(inLoginPwd,		input_parms[4]);
		strcpy(inPhoneNo,		input_parms[5]);
		strcpy(inUserPwd,		input_parms[6]);
		
		*/
		
		
		try{
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name="sM282Qry" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  
	</wtc:service>
	
<wtc:array id="result1"  scope="end"/>

	
var infoArray = new Array();


<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	System.out.println("gaopengSeeLog===m282====retCode==="+retCode);
	System.out.println("gaopengSeeLog===m282====result1.length==="+result1.length);
	if(result1.length > 0 && "000000".equals(retCode)){
		for(int i=0;i<result1.length;i++){
			%>
				infoArray[<%=i%>] = new Array();
				infoArray[<%=i%>][0] = "<%=result1[i][2]%>";
				infoArray[<%=i%>][1] = "<%=result1[i][3]%>";
				infoArray[<%=i%>][2] = "<%=result1[i][4]%>";
			<%
			System.out.println("gaopengSeeLog====m282====infoArray["+i+"][0]====="+result1[i][2]);
			System.out.println("gaopengSeeLog====m282====infoArray["+i+"][1]====="+result1[i][3]);
			System.out.println("gaopengSeeLog====m282====infoArray["+i+"][2]====="+result1[i][4]);
		}
	}
	

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);
