 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

String productId = request.getParameter("productId");
String phoneNo = request.getParameter("phoneNo");
String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
String ret = "";
String sql = "select count(*)"
	 + "  from dproductorderdet a, dgrpnomebmsg b, dcustmsg c"
	 + " where a.id_no = b.id_no"
	 + "   and b.member_id = c.id_no"
	 + "   and a.product_id = '" + productId + "'"
	 + "   and c.phone_no = '" + phoneNo + "'";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />	
<%
System.out.println("====wanghfa==== result = " + result.length);
if ("000000".equals(retCode1) && result.length > 0) {
	ret = result[0][0];
}
%>

var response = new AJAXPacket();
response.data.add("ret", "<%=ret%>");
core.ajax.receivePacket(response);
