<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String auto_answer_flag = WtcUtil.repNull(request.getParameter("auto_answer_flag"));
%>
<wtc:service name="sK025Insert" outnum="2">
	<wtc:param value="<%=contactId%>" />
	<wtc:param value="<%=called_phone%>" />
	<wtc:param value="" />
	<wtc:param value="<%=WorkNo%>" />
	<wtc:param value="<%=called_phone%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=status_code%>" />
</wtc:service>
<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000") && auot_answer_flag.equals("true")) {
		retCode = "000000";
		retMsg = "设置自动应答成功！";
	}
	if (rows[0][0].equals("000000") && auot_answer_flag.equals("false")) {
		retCode = "000000";
		retMsg = "设置人工应答成功！";
	}
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);