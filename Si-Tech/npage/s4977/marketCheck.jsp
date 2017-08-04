<%
/********************
 version v1.0
¿ª·¢ÉÌ: si-tech
*
*create:ningtn@2012-8-15 16:42:41
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String) session.getAttribute("workNo");
	String nopass = (String) session.getAttribute("password");
	String orderId = request.getParameter("orderId");
	String opCode = request.getParameter("opCode");
	String offerId = request.getParameter("offerId");
	String outDetailMsg = "";
	String outRlt = "";
	String outPhoneNo = "";
%>

		<wtc:service name="sCheckAccept" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="5">
			  <wtc:param value=""/>
			  <wtc:param value="01"/>
			  <wtc:param value="<%=opCode%>"/>
			  <wtc:param value="<%=workNo%>"/>
			  <wtc:param value="<%=nopass%>"/>
			  <wtc:param value=""/>
			  <wtc:param value=""/>
			  <wtc:param value="<%=orderId%>"/>
			  <wtc:param value="<%=offerId%>"/>	
			  <wtc:param value="2"/>	
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(retCode1.equals("000000") || retCode1.equals("0")){
		if(result!=null && result.length > 0){
			outDetailMsg = result[0][2];
			outRlt = result[0][3];
			outPhoneNo = result[0][4];
		}
	}
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("outDetailMsg","<%= outDetailMsg%>");
	response.data.add("outRlt","<%= outRlt%>");
	response.data.add("outPhoneNo","<%= outPhoneNo%>");
	core.ajax.receivePacket(response);