<%
  /*
   * ����: ɾ���������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	//String opCode = "K230";
	//String opName = "ɾ���������";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("selectedItemId"));
%>

<%
	String sqlStr = "update dqcobject set bak1='N' where  object_id="+object_id;
%>

<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	
var response = new AJAXPacket();
response.data.add("retType", "<%=retType%>");
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
core.ajax.receivePacket(response);

