<%
  /*
   * 功能: 更新本机系统配置
　 * 版本: 1.0.0
　 * 日期: 2008/10/16
　 * 作者: mixh
　 * 版权: sitech
	 *update:
　*/
%>
<%
	String opCode = "K081";
	String opName = "更新本机系统配置";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String agent_ip = WtcUtil.repNull(request.getParameter("agent_ip"));
%>

  <wtc:service name="sK120query" outnum="9" retval="configInfo">
	<wtc:param value="<%=agent_ip%>"/>
	</wtc:service>

	<wtc:row id="row" property="configInfo" start="0" length="9">
		var response = new AJAXPacket();
		response.data.add("retType","<%=retType%>");
		response.data.add("retCode","<%=row[0]%>");
		response.data.add("retMsg","<%=row[1]%>");
		response.data.add("agent_ip","<%=row[2]%>");
		response.data.add("mainccsip","<%=row[3]%>");
		response.data.add("ccsid","<%=row[4]%>");
		response.data.add("mainccsip2","<%=row[5]%>");
		response.data.add("create_time","<%=row[6]%>");
		response.data.add("agenttype","<%=row[7]%>");
		response.data.add("callerno","<%=row[8]%>");	  
core.ajax.receivePacket(response);

</wtc:row>





