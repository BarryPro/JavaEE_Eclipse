<%
/**
*	宽带营销案取消前业务限制
*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
String login_no = (String)session.getAttribute("workNo");
String serial_no = request.getParameter("serialNo");
String act_name = request.getParameter("actName");
String act_class = (String)request.getParameter("actClass");
String concelPrifee = (String)request.getParameter("concelPrifee");
String busiId = (String)request.getParameter("busiId");
%>

<s:service name="WsNetCancelLimit">
	<s:param name="ROOT">
			<s:param name="LOGIN_NO" type="string" value="<%=login_no %>" />
			<s:param name="SERIAL_NO" type="string" value="<%=serial_no %>" />
	</s:param>
</s:service>

<%
	StringBuffer buf = new StringBuffer();
	String RETURN_CODE = result.getString("RETURN_CODE");
	String RETURN_MSG = result.getString("RETURN_MSG");
	buf.append(RETURN_CODE).append("~").append(RETURN_MSG).append("~").append(serial_no).append("~").append(act_name)
	.append("~").append(act_class).append("~").append(concelPrifee).append("~").append(busiId);
	out.print(buf.toString());
%>

