<%
  /*
   * 功能: 删除被检对象
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "删除被检对象";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("selectedItemId"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
%>

<%
	String sqlStr = "update dqcobject set bak1='N' where  object_id=:v1 ";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=object_id%>"/>
</wtc:service>
	
var response = new AJAXPacket();
response.data.add("retType", "<%=retType%>");
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
core.ajax.receivePacket(response);

