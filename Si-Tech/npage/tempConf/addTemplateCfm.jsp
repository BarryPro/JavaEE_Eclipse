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
		String workNo = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
		String funccode   = (String)request.getParameter("funccode");  
		String elName   = (String)request.getParameter("elName");  
		String inputId   = (String)request.getParameter("inputId");  
		String tempcont   = (String)request.getParameter("tempcont");  
		String memo   = (String)request.getParameter("memo");  
		
%>
	<wtc:service name="sAddTempConfig" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=funccode%>" />
		<wtc:param value="<%=elName%>" />			
		<wtc:param value="<%=inputId%>" />				
		<wtc:param value="<%=tempcont%>" />					
		<wtc:param value="<%=memo%>" />					
	</wtc:service>
		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);
