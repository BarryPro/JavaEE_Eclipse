<%
/**
*  校验手机号码是否为TD号码 传入密码无意义 不进行密码校验
*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>

<%
	String phoneNo = request.getParameter("phoneNo");
	String loginNo = (String)session.getAttribute("workNo");
	System.out.println("-------------------------s5584LimitWS_XML phoneNo:==="+phoneNo);
%>
	<s:service name="s5584LimitWS_XML">
			<s:param name="ROOT">
				<s:param name="OP_CODE" type="string" value="d570a" />
				<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
				<s:param name="LOGIN_PWD" type="string" value="" />
				<s:param name="PHONE_NO" type="string" value="<%=phoneNo%>" />
				<s:param name="USER_PWD" type="string" value="" />
				<s:param name="LIMIT_CODE" type="string" value="64" />
			</s:param>
	</s:service>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);