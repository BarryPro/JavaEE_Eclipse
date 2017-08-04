<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String loginNo = request.getParameter("loginNo");
	String phoneNo = request.getParameter("phoneNo");
	String password = request.getParameter("password");
	String cardCode = request.getParameter("StringCode");
	String group_id = request.getParameter("group_id");
	System.out.println("cardCode=cardCode===AAAAAAAAAAAAAAAAAAAAAA====" + cardCode);
 %>
<s:service name="sm285Update_XML">
								<s:param name="ROOT">
								 		<s:param name="LoginAccept " type="string" value="0" />
								 		<s:param name="ChnSource " type="string" value="01" />
								 		<s:param name="OpCode " type="string" value="m285" />
								 		<s:param name="LoginNo " type="string" value="<%=loginNo %>" />
										<s:param name="LoginPwd" type="string" value="<%=password %>" />
										<s:param name="PhoneNo" type="string" value="<%=phoneNo %>" />
										<s:param name="UserPwd" type="string" value="" />
		                                <s:param name="StringCode" type="string"value="<%=cardCode%>" />
		                                <s:param name="OpStatus" type="string"value="2" />
		                                <s:param name="OpNote" type="string"value="ะฃั้" />
		                                <s:param name="UpdateGroup" type="string"value="" />
		                                <s:param name="GroupId" type="string"value="<%=group_id%>" />
								</s:param>
</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String oRanPassFlag = "";
	String oEffFlag ="";
	String oConvertMoney = "";
	String oErrStringCode = "";
	String oErrMsg = "";
	if("000000".equals(RETURN_CODE)){
		oRanPassFlag = result.getString("oRanPassFlag");	
		oEffFlag = result.getString("oEffFlag");	
		oConvertMoney = result.getString("oConvertMoney");	
		oErrStringCode = result.getString("oErrStringCode");	
		oErrMsg = result.getString("oErrMsg");	
	}
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
    System.out.println("oRanPassFlag============="+oRanPassFlag);
    System.out.println("oEffFlag============="+oEffFlag);
    System.out.println("oConvertMoney============="+oConvertMoney);
    System.out.println("oErrStringCode============="+oErrStringCode);
    System.out.println("oErrMsg============="+oErrMsg);
		
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("oEffFlag","<%=oEffFlag%>");
	response.data.add("oRanPassFlag","<%=oRanPassFlag%>");
	response.data.add("oConvertMoney","<%=oConvertMoney%>");
	response.data.add("oErrStringCode","<%=oErrStringCode%>");
	response.data.add("oErrMsg","<%=oErrMsg%>");

	core.ajax.receivePacket(response);
	
