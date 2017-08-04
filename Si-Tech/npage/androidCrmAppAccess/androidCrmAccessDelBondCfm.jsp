<%
/********************
 version v2.0
开发商: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String imeiNo     = (String)request.getParameter("imeiNo");  
		String opCode     = (String)request.getParameter("opCode");  
		
		String paraAray[] = new String[8];
		paraAray[0] = "";  																			//流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = "";          															//用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = imeiNo;                                   //imei号码
%>
	<wtc:service name="sm018DelBond" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
	</wtc:service>
		
		
var response = new AJAXPacket();
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);