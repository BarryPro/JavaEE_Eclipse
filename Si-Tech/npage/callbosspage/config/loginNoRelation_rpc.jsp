<%
  /*
   * ����: ���Ź�ϵ������-��̨�߼�����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: donglei
�� * ��Ȩ: sitech
   * update:yinzx 2009/09/23 ������滻�ɷ���RK096
�� */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String boss_login_no = WtcUtil.repNull(request.getParameter("boss_login_no"));
	String kf_login_no= WtcUtil.repNull(request.getParameter("kf_login_no"));
  String login_status= WtcUtil.repNull(request.getParameter("login_status"));
	String login_no = (String)session.getAttribute("workNo");	// ��½���Ŵ���
 
	 
	
	 
	 
	
%>
<wtc:service name="sK096Insert" outnum="2">
	<wtc:param value="<%=retType%>"/>
	<wtc:param value="<%=boss_login_no%>"/>
	<wtc:param value="<%=kf_login_no%>"/>
	<wtc:param value="<%=login_status%>"/>
	<wtc:param value="<%=login_no%>"/>				
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);