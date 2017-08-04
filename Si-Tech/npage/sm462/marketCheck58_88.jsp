<%
/********************
 version v1.0
¿ª·¢ÉÌ: si-tech
*
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");

	String orderId = request.getParameter("orderId");
	
	String outPhoneNo = "";
%>

		<wtc:service name="sCheckNetAct" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="5">
			  <wtc:param value="<%=orderId%>"/>	
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(retCode1.equals("000000") || retCode1.equals("0")){
		if(result!=null && result.length > 0){
			outPhoneNo = result[0][0];
		}
	}
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("outPhoneNo","<%= outPhoneNo%>");
	core.ajax.receivePacket(response);