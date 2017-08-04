<%
/********************
 version v1.0
开发商: si-tech
update:lijy@20110510
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String phoneNo = request.getParameter("phoneNo");
		String opCode = request.getParameter("opCode");
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String nopass = (String) session.getAttribute("password");/*操作员密码*/
%>
	<wtc:service name="sCheckPhoneRes" routerKey="region" 
		 routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1" >
	  <wtc:param value=""/>
	  <wtc:param value="01"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=nopass%>"/>
	  <wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
	
var response = new AJAXPacket();
var retCode = "";
var retMessage = "";

retCode = "<%=retCode%>";
retMessage = "<%=retMsg%>";
response.data.add("retCode",retCode);
response.data.add("retMsg",retMessage);
core.ajax.receivePacket(response);


