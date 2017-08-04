<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String ORDER_ID = (String)request.getParameter("ORDER_ID");
	System.out.println("||||||||||||||||||||||||========================================"+ORDER_ID);
		//iUnitStr == 6
 %>
	<s:service name="WsGetConsumeMsg">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="ORDER_ID" type="string" value="<%=ORDER_ID%>" />
			</s:param>		
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String prcNo =   result.getString("prcNo");
	String prcName =   result.getString("prcName");
	String prcMoney =   result.getString("prcMoney");
	String consumeTime =   result.getString("consumeTime");
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		
		response.data.add("prcNo","<%=prcNo%>");
		response.data.add("prcName","<%=prcName%>");
		response.data.add("prcMoney","<%=prcMoney%>");
		response.data.add("consumeTime","<%=consumeTime%>");
		
		core.ajax.receivePacket(response);
