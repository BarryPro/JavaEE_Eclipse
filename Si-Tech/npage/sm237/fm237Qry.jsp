<%
    /*************************************
    * ��  ��: m237
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: gaopeng @ 2015/3/27 14:31:11
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===m237====");
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));//�ʷѴ���
		String offerName = WtcUtil.repNull(request.getParameter("offerName"));//С������
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		String hiddenFlag = "";//�Ƿ���ʾС������
		String retCode11 = "";
		String retMsg11 = "";
		/*
		"���ʷѴ���
		(inOffer)"
		"���ʷ�����
		(vProdOfferName)"
		"�ʷѴ���+�ʷ�����
		(vBothName)"
		"�û���ǰС������
		��vFlagCode��"
		"�û���ǰС������
		��vFlagName��"
		"�û���ǰС������+С������
		��vBothFlagName��"
		
		*/
		String inOffer = "";
		String vProdOfferName = "";
		String vBothName = "";
		String vFlagCode = "";
		String vFlagName = "";
		String vBothFlagName = "";
		System.out.println("gaopengSeeLog===m237====offerId==="+offerId);
		System.out.println("gaopengSeeLog===m237====offerName==="+offerName);
		
		try{
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name="sAttrChgQry" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=offerId%>"/>
	  <wtc:param value="<%=offerName%>"/>
	</wtc:service>
	
<wtc:array id="result1" start="0" length="1"  scope="end"/>
<wtc:array id="result2" start="1" length="2"  scope="end"/>
<wtc:array id="result3" start="3" length="6"  scope="end"/>
	
var infoArray = new Array();


<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	System.out.println("gaopengSeeLog===m237====retCode==="+retCode);
	System.out.println("gaopengSeeLog===m237====result2.length==="+result2.length);
	if(result2.length > 0 && "000000".equals(retCode)){
		for(int i=0;i<result2.length;i++){
			%>
				infoArray[<%=i%>] = new Array();
				infoArray[<%=i%>][0] = "<%=result2[i][0]%>";
				infoArray[<%=i%>][1] = "<%=result2[i][1]%>";
			<%
			System.out.println("gaopengSeeLog====m237====infoArray["+i+"][0]====="+result2[i][0]);
			System.out.println("gaopengSeeLog====m237====infoArray["+i+"][1]====="+result2[i][1]);
		}
	}
	if(result3.length > 0 && "000000".equals(retCode)){
		inOffer = result3[0][0];
		vProdOfferName = result3[0][1];
		vBothName = result3[0][2];
		vFlagCode = result3[0][3];
		vFlagName = result3[0][4];
		vBothFlagName = result3[0][5];
		System.out.println("gaopengSeeLog====m237====inOffer====="+inOffer);
		System.out.println("gaopengSeeLog====m237====vProdOfferName====="+vProdOfferName);
		System.out.println("gaopengSeeLog====m237====vBothName====="+vBothName);
		System.out.println("gaopengSeeLog====m237====vFlagCode====="+vFlagCode);
		System.out.println("gaopengSeeLog====m237====vFlagName====="+vFlagName);
		System.out.println("gaopengSeeLog====m237====vBothFlagName====="+vBothFlagName);
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
response.data.add("infoArray",infoArray);
response.data.add("inOffer","<%=inOffer%>");
response.data.add("vProdOfferName","<%=vProdOfferName%>");
response.data.add("vBothName","<%=vBothName%>");
response.data.add("vFlagCode","<%=vFlagCode%>");
response.data.add("vFlagName","<%=vFlagName%>");
response.data.add("vBothFlagName","<%=vBothFlagName%>");
core.ajax.receivePacket(response);
