<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String custOrderId = (String)request.getParameter("custOrderId");
%>
	<s:service name="sMktKDCfmNoWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="" />
			<s:param name="iChnSource" type="string" value="01" />
			<s:param name="iOpCode" type="string" value="g794" />
			<s:param name="iLoginNo" type="string" value="" />
			<s:param name="iLoginPWD" type="string" value="" />
			<s:param name="iPhoneNo" type="string" value="" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iCustOrderId" type="string" value="<%=custOrderId%>" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String netCode = result.getString("OUT_DATA.netCode");
%>			
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	
	response.data.add("netCode","<%=netCode%>");
	core.ajax.receivePacket(response);
