<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String login_no = (String)session.getAttribute("workNo");
	String phone_no = (String)request.getParameter("svcNum");
	String actId = (String)request.getParameter("actId");
 %>
<s:service name="sMarketOrderWS_XML">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="PHONE_NO" type="string" value="<%=phone_no %>" />
			<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
			<s:param name="ACTIVE_NO" type="string" value="<%=actId %>" />
			<s:param name="OPR_CODE" type="string" value="1" />
	 		<s:param name="PLAYER_CODE " type="string" value="0" />
			<s:param name="FLAG" type="string" value="0" />
			<s:param name="BUSI_ID" type="string" value="0" />
		</s:param>
	</s:param>
</s:service>
<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	System.out.println("checkAct.jsp sMarketOrderWS_XML RETURN_CODE:"+RETURN_CODE);
	System.out.println("checkAct.jsp sMarketOrderWS_XML RETURN_MSG:"+RETURN_MSG);

%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	core.ajax.receivePacket(response);

