<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String isleaf = WtcUtil.repNull(request.getParameter("isleaf"));
	
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
  //int maxCount =0;
%>
<wtc:service name="sK280Insert" outnum="5">
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=isleaf%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
	retCode = "000000";
	retMsg = "增加新被检组成功！";
	
System.out.println("retCode_________"+retCode);
System.out.println("retMsg_________"+retMsg);
}


%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("login_group_id","<%=rows[0][2]%>");
response.data.add("parent_group_id","<%=rows[0][3]%>");
response.data.add("login_group_name","<%=rows[0][4]%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);