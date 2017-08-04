<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String msgId = request.getParameter("msgId");
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
%>
var response = new AJAXPacket();
response.data.add("msgId", "<%=msgId%>");
response.data.add("acceptName", "se555<%=seq%>");
core.ajax.receivePacket(response);
