<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String loginNo = request.getParameter("loginNo");
	String phoneNo = request.getParameter("phoneNo");
	String password = request.getParameter("password");
	String domCode = request.getParameter("domCode");
	System.out.println("domCode=domCode===AAAAAAAAAAAAAAAAAAAAAA====" + domCode);
 %>
<s:service name="sPassCheckWS_XML">
								<s:param name="ROOT">
								 		<s:param name="P_I_A " type="string" value="0" />
								 		<s:param name="CHN_SOURCE " type="string" value="01" />
								 		<s:param name="OP_CODE " type="string" value="m285" />
								 		<s:param name="LOGIN_NO " type="string" value="<%=loginNo %>" />
										<s:param name="LOGIN_PWD" type="string" value="<%=password %>" />
										<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" />
										<s:param name="USER_PWD" type="string" value="" />
		                                <s:param name="DOM_CODE" type="string"value="<%=domCode%>" />
		                                <s:param name="DIS_WAY" type="string"value="0" />
								</s:param>
</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
		
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");

	core.ajax.receivePacket(response);
	
