<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	StringBuffer buf = new StringBuffer(80);
	String saleSeq = (String)request.getParameter("saleSeq");
	String optype = (String)request.getParameter("optype");
	String loginNo = (String)request.getParameter("loginNo");
	//调服务 解析返回值
%>
	<s:service name="WsCheckOrderId">
	<s:param name="ROOT">
		 <s:param name="REQUEST_INFO">
	 		<s:param name="ORDER_ID" type="string" value="<%=saleSeq%>" />
	 		<s:param name="OP_TYPE" type="string" value="<%=optype%>" />
	 		<s:param name="LOGINNO" type="string" value="<%=loginNo%>" />
		</s:param>
	</s:param>
  </s:service>
<%
  String return_code = result.getString("RETURN_CODE");	
	String return_msg = result.getString("RETURN_MSG");		
	String op_type = result.getString("OP_TYPE");
	System.out.println("op_type=============================="+op_type);
	buf.append(return_code).append("~").append("return_msg");
	out.print(buf.toString());
%>


