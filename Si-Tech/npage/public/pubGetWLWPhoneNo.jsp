<%
    /*************************************
    * ��  ��: ���ڶ��������ʷѲ��������Ĭ���Ż��ĺ�
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: gaopeng @ 2015/9/18 9:38:08
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===sDataBusiCfm====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		String regionCode = regCode;
		String offerId = request.getParameter("offerId");
		
		
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
<%
		
		
		String opNote = "����"+workNo+"��������������ת������";
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String phoneNoRet = "";
		
		try{		
		
%>

<wtc:service name="sm317Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
		    <wtc:param value="<%=sysAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
			  <wtc:param value=""/>
		  </wtc:service>  
		  <wtc:array id="result_sTSInfoBack"  scope="end"/>
	


	
var infoArray = new Array();


<%
	
	retCode11 = retCode_sTSInfoBack;
	retMsg11 = retMessage_sTSInfoBack;
	if("000000".equals(retCode11) && result_sTSInfoBack.length > 0){
		phoneNoRet = result_sTSInfoBack[0][0];
	}

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "����δ����������������ϵ����Ա��";
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("phoneNoRet","<%=phoneNoRet%>");
core.ajax.receivePacket(response);
