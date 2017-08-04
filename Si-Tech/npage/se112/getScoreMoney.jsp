<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%


	String GIFT_CODE = (String)request.getParameter("GIFT_CODE");
	String PHONE_NO = (String)request.getParameter("PHONE_NO");
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========GIFT_CODE="+GIFT_CODE);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========PHONE_NO="+PHONE_NO);
%>
	<s:service name="WsMktGiftCodeCheck">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO %>" />
				<s:param name="GIFT_CODE" type="string" value="<%=GIFT_CODE%>" />
				<s:param name="FLAG" type="string" value="0" />
			</s:param>
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String GIFT_MONEY = result.getString("MONEY_VALUE");
	String BUSI_ID = result.getString("ORDER_ID");
	System.out.println("||||||||||||||||||||||||======WsMktGiftCodeCheck============RETURN_CODE==="+RETURN_CODE+"===RETURN_MSG="+RETURN_MSG);
%> 			
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>"); 
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("GIFT_MONEY","<%=GIFT_MONEY%>");
	response.data.add("BUSI_ID","<%=BUSI_ID%>");
	core.ajax.receivePacket(response);
