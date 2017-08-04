<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	StringBuffer buf = new StringBuffer(80);
	String login_no = (String)request.getParameter("loginNo");
	String phone_no = (String)request.getParameter("iPhoneNo");
	String fee_code = (String)request.getParameter("fee_code");
	String means_id = (String)request.getParameter("meansId");
	String act_id = (String)request.getParameter("act_id");
	String fee_name = (String)request.getParameter("fee_name");
	//调服务 解析返回值
%>
	<s:service name="WsCheckUpDownMeans">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="LOGIN_NO" type="string" value="<%=login_no%>" />
	 		<s:param name="PHONE_NO" type="string" value="<%=phone_no%>" />
	 		<s:param name="MEANS_ID" type="string" value="<%=means_id%>" />
	 		<s:param name="ACT_ID" type="string" value="<%=act_id%>" />
	 		<s:param name="ADD_FEE_CODE" type="string" value="<%=fee_code%>" />
	 		<s:param name="ADD_FEE_NAME" type="string" value="<%=fee_name%>" />
		</s:param>
	</s:param>
  </s:service>
<%
  	String return_code = result.getString("RETURN_CODE");	
	String return_msg = result.getString("RETURN_MSG");	
	String actId = result.getString("ACT_ID");	;
	buf.append(return_code).append("~").append(return_msg).append("~").append(actId).append("~");
	out.print(buf.toString());
%>

