<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String par_Id= WtcUtil.repNull(request.getParameter("par_Id"));
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
%>
<wtc:service name="sK280Delete" outnum="3">
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=par_Id%>" />	
</wtc:service>
<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "删除被检组成功！";
	}
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("flag","<%=rows[0][2]%>");
response.data.add("par_Id","<%=par_Id%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);