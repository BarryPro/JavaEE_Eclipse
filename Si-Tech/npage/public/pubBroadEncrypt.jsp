<%
/********************
 version v2.0
开发商: si-tech
*
*create:ningtn@2011-11-30 铁通及广电加密
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String encryptType = request.getParameter("encryptType") == null? "encrypt" : request.getParameter("encryptType");
	String password = WtcUtil.repNull(request.getParameter("password"));
	String returnPwd = "";
%>

		<wtc:service name="sTripleDES" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="1">
			  <wtc:param value="<%=encryptType%>"/>
			  <wtc:param value="<%=password%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(retCode1.equals("000000") || retCode1.equals("0")){
		if(result!=null && result.length > 0){
			returnPwd = result[0][0];
		}
	}
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("returnPwd","<%= returnPwd%>");
	core.ajax.receivePacket(response);