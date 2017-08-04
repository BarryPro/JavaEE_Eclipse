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
		String status   = (String)request.getParameter("status");  
		
		System.out.println("----------------groupId-------------"+groupId);
		System.out.println("----------------simno---------------"+simno);
		System.out.println("----------------loginNo-------------"+loginNo);
		System.out.println("----------------beginDate-----------"+beginDate);
		System.out.println("----------------endDate-------------"+endDate);
		System.out.println("----------------status--------------"+status);
		
		
%>
	<wtc:service name="sUpdPermiCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=simno%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=beginDate%>" />
		<wtc:param value="<%=endDate%>" />	
		<wtc:param value="<%=groupId%>" />	
		<wtc:param value="<%=status%>" />					
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
		
		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);