<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String selectId= WtcUtil.repNull(request.getParameter("selectId"));
	String superId = WtcUtil.repNull(request.getParameter("superId"));
	String login_no = (String)session.getAttribute("workNo");	// boss���Ŵ���
	String orgCode  = (String)session.getAttribute("orgCode");	// ��֯����
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	System.out.println("selectId="+selectId);
  //int maxCount =0;
%>
<wtc:service name="sK410Delete" outnum="3">
	<wtc:param value="<%=selectId%>" />	
	<wtc:param value="<%=superId%>"/>
	<wtc:param value="<%=login_no%>" />	
	<wtc:param value="<%=orgCode%>"/>
	<wtc:param value="<%=ip_Addr%>"/>
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
	retCode = "000000";
	retMsg = "�����½ڵ�ɹ���";
	
System.out.println("retCode_________"+retCode);
System.out.println("retMsg_________"+retMsg);
}


%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("flag","<%=rows[0][2]%>");
response.data.add("superId","<%=superId%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);