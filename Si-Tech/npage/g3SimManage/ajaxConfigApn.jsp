<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create hejwa 2012-11-29 9:52:20
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String apnName   = (String)request.getParameter("apnName");  
		String apnCode   = (String)request.getParameter("apnCode");  
		String opflag   = (String)request.getParameter("opflag");  
		
		System.out.println("-----------g3op--apnName---------"+apnName);
		System.out.println("-----------g3op--apnCode---------"+apnCode);
		System.out.println("-----------g3op--opflag----------"+opflag);
%>
	<wtc:service name="sApnNameConfig" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=apnName%>" />
		<wtc:param value="<%=apnCode%>" />	
		<wtc:param value="<%=opflag%>" />	
	</wtc:service>
		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);