<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String WorkNo = WtcUtil.repNull(request.getParameter("WorkNo"));
	String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));
	String op_type = WtcUtil.repNull(request.getParameter("op_type"));
	String ccsWorkNo = WtcUtil.repNull(request.getParameter("ccsWorkNo"));
	String kfName = WtcUtil.repNull(request.getParameter("kfName"));
	String classId = WtcUtil.repNull(request.getParameter("classId"));
	String orgCode = WtcUtil.repNull(request.getParameter("orgCode"));
	String duty = WtcUtil.repNull(request.getParameter("duty"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String ipAddr = WtcUtil.repNull(request.getParameter("ipAddr"));
	String opNote = WtcUtil.repNull(request.getParameter("opNote"));
%>
<wtc:service name="sK026Insert" outnum="3">
	<wtc:param value="<%=contactId%>" />
	<wtc:param value="<%=loginNo%>" />
	<wtc:param value="<%=op_type%>" />
	<wtc:param value="<%=ccsWorkNo%>" />
	<wtc:param value="K026" />
	<wtc:param value="<%=WorkNo%>" />
	<wtc:param value="<%=kfName%>" />
	<wtc:param value="<%=classId%>" />
	<wtc:param value="<%=orgCode%>" />
	<wtc:param value="<%=duty%>" />
	<wtc:param value="<%=phoneNo%>" />
	<wtc:param value="<%=ipAddr%>" />
	<wtc:param value="<%=opNote%>" />
	<wtc:param value="" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][1].equals("000000")) {
		retCode = "000000";
		retMsg = "保持日志成功！";
	}
%>
<%
out.println(rows[0][0]);
%>
