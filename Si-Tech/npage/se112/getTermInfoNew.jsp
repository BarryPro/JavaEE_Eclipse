<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%


	String res_value = (String)request.getParameter("res_value");
	System.out.println("||||||||||||||||||||||||==================getTermInfoNew========res_value="+res_value);
 %>
	<s:service name="getTermInfoNew">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="OP_TYPE" type="string" value="res_code" />
				<s:param name="RES_VALUE" type="string" value="<%=res_value%>" />
			</s:param>
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	System.out.println("||||||||||||||||||||||||======getTermInfoNew============RETURN_CODE==="+RETURN_CODE+"===RETURN_MSG="+RETURN_MSG);
	String res_cost_fee ="";
	if("000000".equals(RETURN_CODE)){
		res_cost_fee = result.getString("OUT_DATA.RES_LISTS.RES_INFO.RES_PRICE");
		System.out.println("res_cost_fee:"+res_cost_fee);
		
	}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>"); 
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("res_cost_fee","<%=res_cost_fee%>");
		core.ajax.receivePacket(response);
