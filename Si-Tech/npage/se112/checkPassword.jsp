<%
/**
*  ÃÜÂëÐ£Ñé
*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>

<%
	String loginNo = (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String password = request.getParameter("password");
	System.out.println("-------------------------sPubCustCheck_XML phoneNo:==="+phoneNo);
	System.out.println("-------------------------sPubCustCheck_XML password:==="+password);
%>
	<s:service name="sPubCustCheck_XML">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="CUST_TYPE" type="string" value="01" />
				<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" />
				<s:param name="USER_PWD" type="string" value="<%=password %>" />
				<s:param name="ID_TYPE" type="string" value="99" />
				<s:param name="ID_NO" type="string" value="" />
				<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
			</s:param>
		</s:param>
	</s:service>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);