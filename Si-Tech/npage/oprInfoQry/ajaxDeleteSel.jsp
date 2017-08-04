<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String idArrays   = (String)request.getParameter("idArrays");  
%>
	<wtc:service name="sOprInfoDelSel" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=idArrays%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);
