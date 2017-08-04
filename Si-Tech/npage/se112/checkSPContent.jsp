<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iSpCode = (String)request.getParameter("iSpCode");
	String iBizCode = (String)request.getParameter("iBizCode");
	String actType = (String)request.getParameter("actType");
	String iBoxId = (String)request.getParameter("iBoxId");
	String spType = (String)request.getParameter("spType");
	System.out.println("||||||||||||||||||||||||========================================start");
	System.out.println("||||||||||||||||||||||||========================================"+iPhoneNo);
	System.out.println("||||||||||||||||||||||||========================================"+iSpCode);
	System.out.println("||||||||||||||||||||||||========================================"+iBizCode);
	System.out.println("||||||||||||||||||||||||========================================"+actType);
	System.out.println("||||||||||||||||||||||||========================================"+iBoxId);
	System.out.println("||||||||||||||||||||||||========================================"+spType);
	System.out.println("||||||||||||||||||||||||========================================end");

 %>
	<s:service name="WsCheckSPContent">
	  <s:param name="ROOT">
		<s:param name="REQUEST_INFO">
			<s:param name="PHONE_NO" type="string" value="<%=iPhoneNo%>" />
			<s:param name="SP_CODE" type="string" value="<%=iSpCode%>" />
			<s:param name="BIZ_CODE" type="string" value="<%=iBizCode%>" />
			<s:param name="ACT_TYPE" type="string" value="<%=actType%>" />
			<s:param name="BOX_ID" type="string" value="<%=iBoxId%>" />
			<s:param name="SP_TYPE" type="string" value="<%=spType%>" />
		</s:param>
	  </s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String DETAIL_MSG =result.getString("DETAIL_MSG");
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
	System.out.println("DETAIL_MSG============="+DETAIL_MSG);
%>			
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("DETAIL_MSG","<%=DETAIL_MSG%>");
	core.ajax.receivePacket(response);
