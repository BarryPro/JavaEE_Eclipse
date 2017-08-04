<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se179/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iChnSource = request.getParameter("iChnSource");
	String opCode = request.getParameter("opCode");
	String iLoginNo = request.getParameter("iLoginNo");
	String iLoginPWD = request.getParameter("iLoginPWD");
	String iPhoneNo = request.getParameter("iPhoneNo");
	String iOprAccept = request.getParameter("iOprAccept");
		
 %>
	<s:service name="sAwardCheckWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="0" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="<%=opCode %>" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iOprAccept" type="string" value="<%=iOprAccept%>" />
		</s:param>
	</s:service>
<%	
String RETURN_CODE = result.getString("RETURN_CODE");	
String RETURN_MSG = result.getString("RETURN_MSG");	
String vFlag =   result.getString("vFlag");
System.out.println("===============获取礼品冲正状态服务 [sAwardCheckWS_XML] =RETURN_CODE="+RETURN_CODE);
System.out.println("RETURN_MSG============="+RETURN_MSG);
System.out.println("vFlag============="+vFlag);
%>		
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("vFlag","<%=vFlag%>");
	core.ajax.receivePacket(response);
		
