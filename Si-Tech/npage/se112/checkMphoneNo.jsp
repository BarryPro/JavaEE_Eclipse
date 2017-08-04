<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String phoneNo = request.getParameter("phoneNo")==null?"":request.getParameter("phoneNo");
	String phoneNoB = request.getParameter("phoneNoB")==null?"":request.getParameter("phoneNoB");
	String num = request.getParameter("num")==null?"":request.getParameter("num");
	String assPassWord = request.getParameter("assPassWord")==null?"":request.getParameter("assPassWord");
	System.out.println("phoneNo============="+phoneNo);
	System.out.println("phoneNoB============="+phoneNoB);
	System.out.println("num============="+num);
	System.out.println("assPassWord============="+assPassWord);
	
 %>
<s:service name="sMktUnitChkWS_XML">
								<s:param name="ROOT">
										<s:param name="iLoginAccept" type="string" value="" />
										<s:param name="iChnSource" type="string" value="" />
										<s:param name="iOpCode" type="string" value="" />
										<s:param name="iLoginNo" type="string" value="" />
										<s:param name="iLoginPwd" type="string" value="" />
								 		<s:param name="iPhoneNo" type="string" value="<%=phoneNo%>" />
								 		<s:param name="iUserPwd" type="string" value="<%=assPassWord %>" />
										<s:param name="iPhoneNoB" type="string" value="<%=phoneNoB%>" />
								</s:param>
</s:service>

<%
	StringBuffer buf = new StringBuffer(80);
	String RETURN_CODE =result.getString("RETURN_CODE");
	String RETURN_MSG =result.getString("RETURN_MSG");
	String CUST_NAME = result.getString("OUT_DATA.CUST_NAME").trim();
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
    System.out.println("CUST_NAME============="+CUST_NAME);
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("CUST_NAME","<%=CUST_NAME%>");
	response.data.add("num","<%=num%>");
	
	core.ajax.receivePacket(response);
