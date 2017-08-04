<%
  /*
   * 功能: 更新本机系统配置
　 * 版本: 1.0.0
　 * 日期: 2008/10/16
　 * 作者: mixh
　 * 版权: sitech
	 *update:  yinzx 0715 屏蔽System.out.println()
　*/
%>
<%
	String opCode = "K081";
	String opName = "更新本机系统配置";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
//	System.out.println("############################################");
	
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String agent_ip = WtcUtil.repNull(request.getParameter("agent_ip"));
	String mainccsip = WtcUtil.repNull(request.getParameter("mainccsip"));
	String ccsid = WtcUtil.repNull(request.getParameter("ccsid"));
	String mainccsip2 = WtcUtil.repNull(request.getParameter("mainccsip2"));
	String agenttype = WtcUtil.repNull(request.getParameter("agenttype"));
	String callerno = WtcUtil.repNull(request.getParameter("callerno"));
	
/*	System.out.println(agent_ip);
	System.out.println(mainccsip);
	System.out.println(ccsid);
	System.out.println(mainccsip2);
	System.out.println(agenttype);
	System.out.println(callerno);  

   System.out.println("############################################"); */
   
%>

<wtc:service name="sK120modify" outnum="2">
	<wtc:param value="<%=agent_ip%>"/>
	<wtc:param value="<%=mainccsip%>"/>
	<wtc:param value="<%=ccsid%>"/>
	<wtc:param value="<%=mainccsip2%>"/>
	<wtc:param value="<%=agenttype%>"/>
	<wtc:param value="<%=callerno%>"/>
</wtc:service>

<wtc:row id="row" start="0" length="2">
<%
/*System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
System.out.println(row[0]);
System.out.println(row[1]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");*/
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("agentIp","<%=agent_ip%>");
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
core.ajax.receivePacket(response);

</wtc:row>




