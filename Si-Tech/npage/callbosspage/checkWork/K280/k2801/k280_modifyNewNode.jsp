<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->ִ����ڵ��޸ĵ��߼�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: 
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType  = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId   = WtcUtil.repNull(request.getParameter("nodeId"));
	String note     = WtcUtil.repNull(request.getParameter("note"));
	String objectId = WtcUtil.repNull(request.getParameter("objectid"));
	
	String login_no = (String)session.getAttribute("workNo");	// boss���Ŵ���
	
%>
<wtc:service name="sK280Update" outnum="2">
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=note%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=objectId%>" />
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "�޸ı�����ɹ���";
	}
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("nodeName","<%=nodeName%>");
response.data.add("object_id","<%=objectId%>");
response.data.add("note","<%=note%>");
core.ajax.receivePacket(response);