<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
%>
<wtc:service name="sK280Update" outnum="2">
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="" />
	<wtc:param value="<%=login_no%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "修改被检组成功！";
	}
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("nodeName","<%=nodeName%>");
core.ajax.receivePacket(response);