<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String meansid = request.getParameter("meansid")==null?"":request.getParameter("meansid");
	String group_id = (String)session.getAttribute("groupId");
	String login_no = (String)session.getAttribute("workNo");
	String svcNum=request.getParameter("svcNum")==null?"":request.getParameter("svcNum");
	String loginAccept=request.getParameter("loginAccept")==null?"":request.getParameter("loginAccept");
	System.out.println("svcNum=================="+svcNum);
	System.out.println("meansid=================="+meansid);
	System.out.println("loginAccept=================="+loginAccept);
 %>
<s:service name="sMarketOrderWS_XML">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="PHONE_NO" type="string" value="<%=svcNum %>" />
			<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
			<s:param name="ACTIVE_NO" type="string" value="<%=meansid %>" />
			<s:param name="OPR_CODE" type="string" value="1" />
	 		<s:param name="PLAYER_CODE " type="string" value="0" />
			<s:param name="FLAG" type="string" value="1" />
			<s:param name="BUSI_ID" type="string" value="<%=loginAccept %>" />
		</s:param>
	</s:param>
</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
%>
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		core.ajax.receivePacket(response);
