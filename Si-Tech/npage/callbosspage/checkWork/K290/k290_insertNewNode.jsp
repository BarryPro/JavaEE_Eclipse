<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->新增质检组ajax数据插入
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
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String isleaf = WtcUtil.repNull(request.getParameter("isleaf"));
  String note = WtcUtil.repNull(request.getParameter("note"));
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
  //int maxCount =0;
%>
<wtc:service name="sK290Insert" outnum="5">
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=note%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=isleaf%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
	retCode = "000000";
	retMsg = "增加质检组成功！";
}


%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("login_group_id","<%=rows[0][2]%>");
response.data.add("parent_group_id","<%=rows[0][3]%>");
response.data.add("login_group_name","<%=rows[0][4]%>");
response.data.add("note","<%=note%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);