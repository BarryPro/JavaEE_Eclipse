<%
/**
*	营销案取消前调用的业务限制
*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
String login_no = (String)session.getAttribute("workNo");
String group_id = (String)session.getAttribute("groupId");
String phone_no = request.getParameter("phoneNo");
String serial_no = request.getParameter("serialNo");
String act_id = (String)request.getParameter("actId");
String act_name = request.getParameter("actName");
String act_class = (String)request.getParameter("actClass");
String concelPrifee = (String)request.getParameter("concelPrifee");
String busiId = (String)request.getParameter("busiId");
String opCode = (String)request.getParameter("opCode");
System.out.println("++++++++++++++++++++++g798 opCode="+opCode);

%>

<s:service name="sMarketOrderWS_XML">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="PHONE_NO" type="string" value="<%=phone_no %>" />
			<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
			<s:param name="ACTIVE_NO" type="string" value="<%=act_id %>" />
			<s:param name="OPR_CODE" type="string" value="3" />
	 		<s:param name="PLAYER_CODE " type="string" value="0" />
			<s:param name="FLAG" type="string" value="0" />
			<s:param name="BUSI_ID" type="string" value="<%=busiId %>" />
		</s:param>
	</s:param>
</s:service>

<%
	StringBuffer buf = new StringBuffer();
	String RETURN_CODE = result.getString("RETURN_CODE");
	String RETURN_MSG = result.getString("RETURN_MSG");
	buf.append(RETURN_CODE).append("~").append(RETURN_MSG).append("~").append(serial_no).append("~").append(act_name)
	.append("~").append(act_class).append("~").append(concelPrifee).append("~").append(busiId).append("~");
%>
<s:service name="WsMktCheckChnCancel">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="GROUP_ID" type="string" value="<%=group_id %>" />
			<s:param name="ORDER_ID" type="string" value="<%=busiId %>" />
			<s:param name="OP_CODE" type="string" value="<%=opCode %>" />
		</s:param>
	</s:param>
</s:service>	
<%
 	String RE_CODE = result.getString("RETURN_CODE");	
	String RE_MSG = result.getString("RETURN_MSG");	
	System.out.println("++++++++++++++++++++++g798 RE_CODE="+RE_CODE);
	System.out.println("++++++++++++++++++++++g798 RE_MSG="+RE_MSG);
 	buf.append(RE_CODE).append("~").append(RE_MSG);	
	System.out.println("++++++++++++++++++++++buf="+buf.toString());
	out.print(buf.toString());
%>

