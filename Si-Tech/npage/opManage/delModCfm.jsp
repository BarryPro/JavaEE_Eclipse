<%
/********************
 version v2.0
开发商: si-tech
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var resultArray = new Array();
<%
		String regionCode = (String)session.getAttribute("regCode");
		String layoutId    = (String)request.getParameter("layoutId");
		String delType    = (String)request.getParameter("delType");
		String retCode = "";
		String retMsg = "";
	 	 
		try{
%>		
 		<wtc:service name="sMRoleDelCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
 			<wtc:param value="<%=layoutId%>" />
 			<wtc:param value="<%=delType%>" />	
		</wtc:service>
			
<%
 
	retCode = code;
	retMsg = msg;
	 
	}catch(Exception e){
		retCode = "000409";
		retMsg = "调用服务sMRoleDelCfm系统错误";
	}
	
	System.out.println("--------- ---------retCode------------"+retCode);
	System.out.println("--------  ---------retMsg-------------"+retMsg);
%>
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
