<%
    /*************************************
    * ��  ��: m295
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: gaopeng @ 2015/3/27 14:31:11
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===m295====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		
		String iGroupId = request.getParameter("iGroupId");
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		int outNum = 0;
		/*
		sm295Qry
	strcpy(iLoginAccept,	input_parms[0]);
	strcpy(iChnSource,		input_parms[1]);
	strcpy(iOpCode,			input_parms[2]);
	strcpy(iLoginNo,		input_parms[3]);
	strcpy(iLoginPwd,		input_parms[4]);
	strcpy(iPhoneNo,		input_parms[5]);
	strcpy(iUserPwd,		input_parms[6]);
	strcpy(iGroupId,		input_parms[7]);  /*�ɿ�
	strcpy(iOpNote,			input_parms[8]);


	���Σ�
		transOUT = Add_Ret_Value(GPARM32_0,oOutNum);     �������
	  	transOUT = Add_Ret_Value(GPARM32_1,oRegionCode);  ����������б���
	 	transOUT = Add_Ret_Value(GPARM32_2, oRegionName); ���������������
	 	transOUT = Add_Ret_Value(GPARM32_3, oGroupId);    �����������
	 	transOUT = Add_Ret_Value(GPARM32_4, oGroupName);  ������������
	 	transOUT = Add_Ret_Value(GPARM32_5, oCfmLoginNo); �������ù���
	 	transOUT = Add_Ret_Value(GPARM32_6, oCfmOpTime);  ��������ʱ��

		
		*/
		
		
		
		try{
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name="sm295Qry" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=iGroupId%>"/>
	  <wtc:param value=""/>
	  
	</wtc:service>
<wtc:array id="result0" start="0" length="1"  scope="end"/>	
<wtc:array id="result1" start="1" length="8" scope="end"/>

	
var infoArray = new Array();


<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	if(result1.length > 0 && "000000".equals(retCode)){
		outNum = Integer.parseInt(result0[0][0]);
	}
	if(result1.length > 0 && "000000".equals(retCode)){
		for(int i=0;i<result1.length;i++){
			%>
				infoArray[<%=i%>] = new Array();
				<%
					for(int j=0;j<result1[i].length;j++){
						%>
						infoArray[<%=i%>][<%=j%>] = "<%=result1[i][j]%>";
						<%
						System.out.println("gaopengSeeLog====m295====infoArray["+i+"]["+j+"]====="+result1[i][j]);
					}
				%>
				
			<%
		}
	}
	

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "����δ����������������ϵ����Ա��";
	%>
	var infoArray = new Array();
	<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("outNum","<%=outNum%>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);
