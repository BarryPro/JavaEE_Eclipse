<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iChnSource = (String)request.getParameter("iChnSource");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPWD = (String)request.getParameter("iLoginPWD");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iOprAccept = (String)request.getParameter("iOprAccept");
	String iOfferIdStr = (String)request.getParameter("iOfferIdStr");
	System.out.println("||||||||||||||||||||||||========================================start");
	System.out.println("||||||||||||||||||||||||========================================"+iChnSource);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginNo);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginPWD);
	System.out.println("||||||||||||||||||||||||========================================"+iPhoneNo);
	System.out.println("||||||||||||||||||||||||========================================"+iOprAccept);
	System.out.println("||||||||||||||||||||||||========================================"+iOfferIdStr);
		//iUnitStr == 6
 %>
	<s:service name="sMktQryEffWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="<%=iOprAccept %>" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="g794" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iNextOfferId" type="string" value="<%=iOfferIdStr%>" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String oEffType ="";
	System.out.println("||||||||||||||||||||||||========================================"+RETURN_CODE+"~~~"+RETURN_MSG);
	if("000000".equals(RETURN_CODE)){
		oEffType = result.getString("oEffType");
		System.out.println("oEffType:"+oEffType);
	}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("oEffType","<%=oEffType%>");
		core.ajax.receivePacket(response);
