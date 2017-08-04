<%
/**
*  校验手机号码是否为TD号码 传入密码无意义 不进行密码校验
*/
%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
String phoneNo = request.getParameter("phoneNo");
String loginNo = (String)session.getAttribute("login_no");
String loginPwd = (String)session.getAttribute("login_password");
%>
<s:service name="s5584LimitWS_XML">
		<s:param name="ROOT">
			<s:param name="OP_CODE" type="string" value="d570a" />
			<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
			<s:param name="LOGIN_PWD" type="string" value="<%=loginPwd %>" />
			<s:param name="PHONE_NO" type="string" value="<%=phoneNo%>" />
			<s:param name="USER_PWD" type="string" value="" />
			<s:param name="LIMIT_CODE" type="string" value="64" />
		</s:param>
</s:service>
<%
	out.print(retCode);
%>