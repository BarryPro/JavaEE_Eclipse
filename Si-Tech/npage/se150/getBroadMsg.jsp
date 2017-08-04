<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String orderArrayId = request.getParameter("orderArrayId");
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
	System.out.println(" ========= ningtn ==== " + functionCode);
	System.out.println(" ========= ningtn ==== " + createAccept);
	System.out.println(" ========= ningtn ==== " + serviceNo);
	System.out.println(" ========= ningtn ==== " + servOrderId);
	System.out.println(" ========= ningtn ==== " + opCode);
	System.out.println(" ========= ningtn ==== " + orderStatus);
	String retCode = "";
	String retMsg = "";
	String cash = "";
	if("4977".equals(functionCode) && ("130".equals(orderStatus) || "131".equals(orderStatus) || "170".equals(orderStatus))){
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
		System.out.println(" =========== ningtn ===== " + retCode);
		if(retCode.equals("0")){
			cash = retVal.getValue("2.4.7");
		}else{
			cash = "0";
		}
	}else{
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
core.ajax.receivePacket(response);