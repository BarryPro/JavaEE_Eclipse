<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String order_id = request.getParameter("ORDER_ID")==null?"":request.getParameter("ORDER_ID");
	String meansId   = request.getParameter("MEANS_ID")==null?"":request.getParameter("MEANS_ID");
	String groupid   = request.getParameter("GROUP_ID")==null?"":request.getParameter("GROUP_ID");
	
	System.out.println("order_id============"+order_id);
	System.out.println("meansId============"+meansId);
	System.out.println("groupid============"+groupid);
 %>
<s:service name="WsGetImeiOpType">
								<s:param name="ROOT">
								 <s:param name="REQUEST_INFO">
								 		<s:param name="ORDER_ID " type="string" value="<%=order_id %>" />
								 		<s:param name="MEANS_ID " type="string" value="<%=meansId %>" />
								 		<s:param name="GROUP_ID " type="string" value="<%=groupid %>" />
									</s:param>
								</s:param>
</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String OP_TYPE =result.getString("OP_TYPE");
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
	System.out.println("OP_TYPE============="+OP_TYPE);
		
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("OP_TYPE","<%=OP_TYPE%>");

	core.ajax.receivePacket(response);
