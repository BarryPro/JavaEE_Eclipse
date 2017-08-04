<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String called_phone = WtcUtil.repNull(request.getParameter("called_phone"));
	String region_code = WtcUtil.repNull(request.getParameter("region_code"));
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String WorkNo = WtcUtil.repNull(request.getParameter("WorkNo"));
	String status_code = WtcUtil.repNull(request.getParameter("status_code"));
	String caller_phone = WtcUtil.repNull(request.getParameter("caller_phone"));
	String contact_ip = WtcUtil.repNull(request.getParameter("contact_ip"));
	String notes = WtcUtil.repNull(request.getParameter("notes"));
	String kfName = WtcUtil.repNull(request.getParameter("kfName"));
	String classId = WtcUtil.repNull(request.getParameter("classId"));
	String org_code = WtcUtil.repNull(request.getParameter("org_code"));
	String duty = WtcUtil.repNull(request.getParameter("duty"));
	String opNote = WtcUtil.repNull(request.getParameter("opNote"));
%>
<wtc:service name="sK025Insert" outnum="2">
	<wtc:param value="<%=contactId%>" />
	<wtc:param value="<%=called_phone%>" />
	<wtc:param value="<%=region_code%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=called_phone%>" />
	<wtc:param value="" />
	<wtc:param value="1" />
	<wtc:param value="1" />
	<wtc:param value="1" />
	<wtc:param value="3" />
	<wtc:param value="<%=status_code%>" />
	<wtc:param value="<%=caller_phone%>" />
	<wtc:param value="<%=called_phone%>" />
	<wtc:param value="" />
	<wtc:param value="1" />
	<wtc:param value="6" />
	<wtc:param value="1" />
	<wtc:param value="1" />
	<wtc:param value="<%=contact_ip%>" />
	<wtc:param value="<%=notes%>" />
	<wtc:param value="" />
	<wtc:param value="K025" />
	<wtc:param value="<%=WorkNo%>" />
	<wtc:param value="<%=kfName%>" />
	<wtc:param value="<%=classId%>" />
	<wtc:param value="<%=org_code%>" />
	<wtc:param value="<%=duty%>" />
	<wtc:param value="<%=opNote%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "保存呼出日志成功！";
	}
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);