<%
  /*
   * 功能: 更新本机系统配置
　 * 版本: 1.0.0
　 * 日期: 2008/10/16
　 * 作者: yinzx
　 * 版权: sitech
	 
　*/
%>
<%
	String opCode = "K081";
	String opName = "更新本机系统配置";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
 
	String orgCode = (String)session.getAttribute("orgCode");
	String reginCode = orgCode.substring(0,2);
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String agent_ip = WtcUtil.repNull(request.getParameter("agent_ip"));
	String mainccsip = WtcUtil.repNull(request.getParameter("mainccsip"));
	String ccsid = WtcUtil.repNull(request.getParameter("ccsid"));
	String mainccsip2 = WtcUtil.repNull(request.getParameter("mainccsip2"));
	String agenttype = WtcUtil.repNull(request.getParameter("agenttype"));
	String callerno = WtcUtil.repNull(request.getParameter("callerno"));
  String serv_addr = WtcUtil.repNull(request.getParameter("serv_addr"));
  String sql = WtcUtil.repNull(request.getParameter("sql"));
%>
	
<wtc:service name="sPubModifyKfCfm"  outnum="2" routerKey="region" routerValue="<%=reginCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=mainccsip%>"/>
	<wtc:param value="<%=mainccsip2%>"/>
	<wtc:param value="<%=ccsid%>"/>
	<wtc:param value="<%=agenttype%>"/>
	<wtc:param value="<%=agent_ip%>"/>
	<wtc:param value="<%=serv_addr%>"/>						
</wtc:service>

<wtc:row id="row" start="0" length="2">
	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("agentIp","<%=agent_ip%>");
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
core.ajax.receivePacket(response);

</wtc:row>

