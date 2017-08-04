<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	StringBuffer buf = new StringBuffer();
	String loginNo = (String)request.getParameter("loginNo");
	String phoneNo = (String)request.getParameter("phoneNo");
	String password = (String)request.getParameter("password");
	String offerIdStr = (String)request.getParameter("offferIdStr");
	//调服务 解析返回值
%>
	<s:service name="sMulXqQryWS_XML">
		<s:param name="ROOT">
			<s:param name="LOGIN_ACCEPT" type="string" value="0" />
			<s:param name="CHN_SOURCE" type="string" value="01" />
			<s:param name="OP_CODE" type="string" value="g794" />
			<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
			<s:param name="LOGIN_PWD" type="string" value="<%=password %>" />
			<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" />
			<s:param name="USER_PWD" type="string" value="" />
			<s:param name="OFFERID_STR" type="string" value="<%=offerIdStr %>" />
		</s:param>
	</s:service>
<%
	String return_code = result.getString("RETURN_CODE");	
	String return_msg = result.getString("RETURN_MSG");	

	String offerId = result.getString("OUT_DATA.OFFER_ID");	;
	String xqFlag = result.getString("OUT_DATA.XQ_FLAG");
	String xqCode = result.getString("OUT_DATA.XQ_CODE");
	String xqName = result.getString("OUT_DATA.XQ_NAME");
	
	buf.append(return_code).append("~").append(return_msg).append("~").append(offerId).append("~").append(xqFlag).append("~").append(xqCode).append("~").append(xqName);
	out.print(buf.toString());
%>

