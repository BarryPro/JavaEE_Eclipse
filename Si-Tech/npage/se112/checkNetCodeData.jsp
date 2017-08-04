<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String returnCode = "000000";
	String returnMsg = "";
	String netcode = request.getParameter("netcode");
	System.out.println("||||||||||||||||||||||||========================================netcode"+netcode);
%>
	<s:service name="sQryBroadInfoWS_XML">
		<s:param name="ROOT">
		<s:param name="LOGIN_ACCEPT " type="string" value="0" />
		<s:param name="CHN_CODE " type="string" value="0" />
		<s:param name="OP_CODE " type="string" value="g794" />
		<s:param name="LOGIN_NO " type="string" value="" />
		<s:param name="LOGIN_PWD " type="string" value="" />
		<s:param name="PHONE_NO " type="string" value="" />
		<s:param name="USER_PWD " type="string" value="" />
		<s:param name="BD_CODE " type="string" value="<%=netcode %>" />
		<s:param name="OPER_TYPE " type="string" value="3" />
		</s:param>
	</s:service>
<%
	returnCode = retCode; 
	returnMsg = retMsg;
 %>		
	var response = new AJAXPacket();
	response.data.add("returnCode","<%=returnCode%>");
	response.data.add("returnMsg","<%=returnMsg%>");
	core.ajax.receivePacket(response);
