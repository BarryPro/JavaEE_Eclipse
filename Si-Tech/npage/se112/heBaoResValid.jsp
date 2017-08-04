<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String imeiCode = request.getParameter("imeiCode");
 %>
<s:service name="heBaoResValid">
								<s:param name="ROOT">
									<s:param name="REQUEST_INFO">
								 		<s:param name="OP_TYPE " type="string" value="1" />
								 		<s:param name="IMEI_NO " type="string" value="<%=imeiCode %>" />
		                             </s:param>
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
	
