<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String orderArrayId = request.getParameter("orderArrayId");
	System.out.println("gaopeng-----------333--"+orderArrayId);
	String opCode = request.getParameter("opCode");
	String getMsgSql = "SELECT b.function_code, TO_CHAR (a.create_accept), a.service_no, a.serv_order_id, to_char(a.order_status)"
  		+ " FROM dservordermsg a, dorderarraymsg b"
			+ " WHERE b.order_array_id = :orderArrayId"
			+ " AND a.order_array_id = b.order_array_id";
	String[] inParams = new String[2];
	inParams[0] = getMsgSql;
	inParams[1] = "orderArrayId=" + orderArrayId;
	System.out.println("========== ningtn ===== " + inParams[0]);
	System.out.println("========== ningtn ===== " + inParams[1]);
	
	String  inParamsorderNum [] = new String[2];
  inParamsorderNum[0] = "SELECT count(1) FROM dorderarraymsg where cust_order_id  =( "
	+" SELECT  cust_order_Id  FROM dorderarraymsg where order_array_id=:orderArrayId)" ;
  inParamsorderNum[1] = "orderArrayId="+orderArrayId;
  int orderNum = 0;
  
  
	
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsorderNum[0]%>"/>
    <wtc:param value="<%=inParamsorderNum[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if(result_mail.length > 0 && "000000".equals(retCode_mail)){
		orderNum = Integer.parseInt(result_mail[0][0]);
		System.out.println("gaopengSeeLog===e083====orderNum=="+orderNum);
	}

%>

		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="5">
			<wtc:param value="<%=inParams[0]%>"/>
			<wtc:param value="<%=inParams[1]%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
<%
	String functionCode = "";
	String createAccept = "";
	String serviceNo = "";
	String servOrderId = "";
	String orderStatus = "";
	if("000000".equals(code0)){
		if(result0 != null && result0.length > 0){
			functionCode = result0[0][0];
			createAccept = result0[0][1];
			serviceNo = result0[0][2];
			servOrderId = result0[0][3];
			orderStatus = result0[0][4];
		}
	}
	System.out.println(" =========gaopeng ningtn ==== functionCode==" + functionCode);
	System.out.println(" =========gaopeng ningtn ==== createAccept==" + createAccept);
	System.out.println(" =========gaopeng ningtn ==== serviceNo==" + serviceNo);
	System.out.println(" =========gaopeng ningtn ==== servOrderId==" + servOrderId);
	System.out.println(" =========gaopeng ningtn ==== opCode==" + opCode);
	System.out.println(" =========gaopeng ningtn ==== orderStatus==" + orderStatus);
	String retCode = "";
	String retMsg = "";
	String cash = "";
	String kdZdFee = "";
	String kdZd = "";
	if(("m462".equals(functionCode) || ("m028".equals(functionCode)) || ("m094".equals(functionCode)) || "e916".equals(functionCode)) && ("130".equals(orderStatus) || "131".equals(orderStatus) || "170".equals(orderStatus))){
System.out.println("gaopeng-----------111===orderStatus = "+orderStatus+"|||functionCode="+functionCode);
%>
<wtc:utype name="sReverInfo" id="retVal" scope="end"  routerKey="region" 
	 routerValue="<%=regionCode%>">
    <wtc:uparam value="<%=serviceNo%>" type="String"/>
    <wtc:uparam value="<%=servOrderId%>" type="String"/>
    <wtc:uparam value="<%=functionCode%>" type="String"/>
    <wtc:uparam value="<%=opCode%>" type="String"/>
    <wtc:uparam value="<%=createAccept%>" type="LONG"/>
</wtc:utype>
<%
	  retCode = retVal.getValue(0);
		retMsg = retVal.getValue(1);
		System.out.println(" ===========gaopeng ningtn ===== " + retCode);
		if(retCode.equals("0")){
			System.out.println(" ===========gaopeng ningtn 20131205===== 111"  );
			if("e916".equals(functionCode)){
				cash = retVal.getValue("2.4.0");
			}else{
				cash = retVal.getValue("2.4.7");
			}
			kdZdFee = retVal.getValue("2.4.3");
			kdZd = retVal.getValue("2.4.9");
			System.out.println(" ===========gaopeng ningtn 20131205===== 222-" + retCode);
			System.out.println(" ===========gaopeng ningtn 20131205===== kdZdFee-" + kdZdFee);
		}else{
			cash = "0";
		}
	}else{
		System.out.println("gaopeng-----------222==orderStatus=="+orderStatus+"|||functionCode="+functionCode);
		retCode = "0";
		cash = "0";
	}
	cash = WtcUtil.formatNumber(cash,2);
	System.out.println(" ==== ningtn  ==" + retCode + " | " + cash);
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("cash","<%=cash%>");
response.data.add("functionCode","<%=functionCode%>");
response.data.add("kdZdFee","<%=kdZdFee%>");
response.data.add("kdZd","<%=kdZd%>");
response.data.add("orderNum","<%=orderNum%>");
response.data.add("createAccept","<%=createAccept%>");

core.ajax.receivePacket(response);