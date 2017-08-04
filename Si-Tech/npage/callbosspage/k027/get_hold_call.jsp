<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String hold_call_id = WtcUtil.repNull(request.getParameter("hold_call_id"));
	String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));
	String WorkNo = WtcUtil.repNull(request.getParameter("WorkNo"));
	String ccsWorkNo = WtcUtil.repNull(request.getParameter("ccsWorkNo"));
	String kfName = WtcUtil.repNull(request.getParameter("kfName"));
	String classId = WtcUtil.repNull(request.getParameter("classId"));
	String duty = WtcUtil.repNull(request.getParameter("duty"));
	String orgCode = WtcUtil.repNull(request.getParameter("orgCode"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String ipAddr = WtcUtil.repNull(request.getParameter("ipAddr"));
		
%>
<wtc:service name="sK026Update" outnum="2">
	<wtc:param value="<%=hold_call_id%>" />
	<wtc:param value="<%=loginNo%>" />
	<wtc:param value="<%=ccsWorkNo%>" />
	<wtc:param value="K027" />
	<wtc:param value="<%=WorkNo%>" />
	<wtc:param value="<%=kfName%>" />
	<wtc:param value="<%=classId%>" />
	<wtc:param value="<%=duty%>" />
	<wtc:param value="<%=orgCode%>" />
	<wtc:param value="<%=phoneNo%>" />
	<wtc:param value="<%=ipAddr%>" />
	<wtc:param value="" />
	<wtc:param value="" />
</wtc:service>
<wtc:array id="rows" scope="end" />

<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "取保持成功！";
	}
%>

<%
out.println("000000");
%>