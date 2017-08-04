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
		String groupId = (String)session.getAttribute("groupId");
		String regionCode = (String)session.getAttribute("regCode");
		String simno   = (String)request.getParameter("simno");  
		String loginNo   = (String)request.getParameter("loginNo");  
		String beginDate   = (String)request.getParameter("beginDate");  
		String endDate   = (String)request.getParameter("endDate");  
		String imeiNo   = (String)request.getParameter("imeiNo");  
		String phoneno   = (String)request.getParameter("phoneno");  
		String apnName   = (String)request.getParameter("apnName");  
		String apnCode   = (String)request.getParameter("apnCode");  
		String opCode   = (String)request.getParameter("opCode");
		String workNo   = (String)session.getAttribute("workNo");
		
		
		String status   = "0";  
		
		
%>
	<wtc:service name="sAddPermiCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=simno%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=beginDate%>" />
		<wtc:param value="<%=endDate%>" />	
		<wtc:param value="<%=groupId%>" />	
		<wtc:param value="<%=status%>" />					
		<wtc:param value="<%=imeiNo%>" />
		<wtc:param value="<%=phoneno%>" />	
		<wtc:param value="<%=apnCode%>" />	
		<wtc:param value="<%=apnName%>" />		
		<wtc:param value="<%=opCode%>" />			
		<wtc:param value="<%=workNo%>" />				
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		
		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);
