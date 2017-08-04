<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
 
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String agent_ips = WtcUtil.repNull(request.getParameter("agent_ips"));
   String sqlStr = "select mainccsip, ccsid, mainccsip2, agenttype, callerno from dcrmcallcfg where agent_ip in(" + agent_ips + ")";
   String orgCode = (String)session.getAttribute("orgCode");
	 String regionCode = orgCode.substring(0,2);
   
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="dbchange"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6" scope="end"/>
 

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

