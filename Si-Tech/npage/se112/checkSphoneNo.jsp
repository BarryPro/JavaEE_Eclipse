<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String assPhoneNo = request.getParameter("assPhoneNo")==null?"":request.getParameter("assPhoneNo");
	String num = request.getParameter("num")==null?"":request.getParameter("num");
	String assPassWord = request.getParameter("assPassWord")==null?"":request.getParameter("assPassWord");
	String phoneNo = request.getParameter("phoneNo")==null?"":request.getParameter("phoneNo");
	String group_id = (String)session.getAttribute("groupId");
	String login_no = (String)session.getAttribute("workNo");//µÇÂ¼¹¤ºÅ
 %>
<s:service name="sMarkCheckNewWS_XML">
								<s:param name="ROOT">
								 		<s:param name="PHONE_NO " type="string" value="<%=assPhoneNo %>" />
										<s:param name="ACT_ID" type="string" value="1" />
										<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
										<s:param name="OP_CODE" type="string" value="g794" />
										<s:param name="PHONE_NO_A" type="string" value="<%=phoneNo %>" />
										<s:param name="USER_PWD" type="string" value="<%=assPassWord %>" />
								</s:param>
</s:service>

<%
	StringBuffer buf = new StringBuffer(80);
	String RETURN_CODE =result.getString("RETURN_CODE");
	String RETURN_MSG =result.getString("RETURN_MSG");
	String CUST_NAME =result.getString("RESPONSE_INFO.CUST_NAME");
	String FLAG =result.getString("RESPONSE_INFO.FLAG");
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
	System.out.println("CUST_NAME============="+CUST_NAME);
    System.out.println("FLAG============="+FLAG);
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("CUST_NAME","<%=CUST_NAME%>");
	response.data.add("FLAG","<%=FLAG%>");
	response.data.add("num","<%=num%>");

	core.ajax.receivePacket(response);
