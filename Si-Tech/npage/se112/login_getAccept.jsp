<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
		
 %>
						<s:service name="getSMaxSysAccept">
								 <s:param name="REQUEST_INFO">
								</s:param>
						</s:service>
<%	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String LOGIN_ACCEPT=result.getString("OUT_DATA.LOGIN_ACCEPT");	
	
 %>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("LOGIN_ACCEPT","<%=LOGIN_ACCEPT%>");
		core.ajax.receivePacket(response);

