<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
response.setHeader("progma","no-cache");   
response.setHeader("Cache-Control","no-cache");   
response.setDateHeader("Expires",0);

String orgCode = (String)session.getAttribute("orgCode");
String iWorkNo = (String)session.getAttribute("workNo");
String ipAddr= (String) session.getAttribute("ipAddr");
String password = (String)session.getAttribute("password");
String regionCode = orgCode.substring(0,2);
String orgid = (String)session.getAttribute("orgId");    
   

String phone_no =  request.getParameter("phone_no");	
String text1 =  request.getParameter("text1");	

%>

	<wtc:service name="sBlackNumUpd" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=iWorkNo%>"/>
		<wtc:param value="<%=text1%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />


var response = new AJAXPacket();
var retCode ="<%=retCode%>";
var retMsg ="<%=retMsg%>";
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);
core.ajax.receivePacket(response);