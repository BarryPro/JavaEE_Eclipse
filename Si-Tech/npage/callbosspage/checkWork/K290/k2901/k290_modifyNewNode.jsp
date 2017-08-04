<%
  /*
   * 功能: 质检权限管理->维护质检员和组->执行组节点修改的逻辑
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType  = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId   = WtcUtil.repNull(request.getParameter("nodeId"));
	String note     = WtcUtil.repNull(request.getParameter("note"));
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
%>
<wtc:service name="sK290Update" outnum="2">
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=note%>" />
	<wtc:param value="<%=login_no%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "修改质检组成功！";
	}
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("nodeName","<%=nodeName%>");
response.data.add("note","<%=note%>");
core.ajax.receivePacket(response);