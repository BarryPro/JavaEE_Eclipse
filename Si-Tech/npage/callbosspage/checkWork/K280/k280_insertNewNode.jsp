<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->�������ʼ���ajax���ݲ���
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: guozw
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String objectid= WtcUtil.repNull(request.getParameter("objectid"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String isleaf = WtcUtil.repNull(request.getParameter("isleaf"));
	
	String login_no = (String)session.getAttribute("workNo");	// boss���Ŵ���	
%>
<wtc:service name="sK280Insert" outnum="5">
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=note%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=isleaf%>" />
	<wtc:param value="<%=objectid%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
             retCode = "000000";
             retMsg = "�����±�����ɹ���";
}


%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("login_group_id","<%=rows[0][2]%>");
response.data.add("parent_group_id","<%=rows[0][3]%>");
response.data.add("login_group_name","<%=rows[0][4]%>");
response.data.add("object_id","<%=objectid%>");
response.data.add("note","<%=note%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);
