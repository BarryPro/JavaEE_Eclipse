<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:wanglma@2011-05-18 
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
String regionCode = (String)session.getAttribute("regCode");
String functionId = request.getParameter("functionId");
String functionName = "";

String sql = "select function_name from sfunccodenew where function_code = '" + functionId + "'";
System.out.println("====wanghfa====ajaxGetFuncName.jsp==== sql = " + sql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
	<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result"  scope="end"/>
<%
System.out.println("====wanghfa====ajaxGetFuncName.jsp==== sPubSelect " + retCode + ", " + retMsg);
if(retCode.equals("000000") && result.length > 0) {
	functionName = result[0][0];
}
%>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("functionId", "<%=functionId%>");
response.data.add("functionName", "<%=functionName%>");
core.ajax.receivePacket(response);
