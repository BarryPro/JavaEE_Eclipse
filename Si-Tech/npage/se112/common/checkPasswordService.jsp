<%
/**
*  校验手机号码是否为TD号码 传入密码无意义 不进行密码校验
*/
%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%
String phoneNo = request.getParameter("phoneNo");
String password = request.getParameter("password");
String loginNo = (String)session.getAttribute("login_no");
%>
<s:service name="sPubCustCheck_XML">
		<s:param name="ROOT">
			<s:param name="CUST_TYPE" type="string" value="01" />
			<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" />
			<s:param name="USER_PWD" type="string" value="<%=password %>" />
			<s:param name="ID_TYPE" type="string" value="99" />
			<s:param name="ID_NO" type="string" value="" />
			<s:param name="LOGIN_NO" type="string" value="loginNo" />
		</s:param>
</s:service>
<%
	out.print(retCode + "|" + retMsg);
%>