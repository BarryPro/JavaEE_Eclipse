<%
  /*
   * ����: �������µ�ȷ�� �µ����� a381
   * �汾: 1.0
   * ����: 2013/10/9
   * ����: diling
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String opCode 	= "a381";
	String loginNo 	= (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	String groupId 	= (String)session.getAttribute("groupId");
	String phone 	= request.getParameter("phone");//�������
	String orderId 	= request.getParameter("orderId");//����ƽ̨����ID
	String orderItemId 	= request.getParameter("orderItemId");//����ƽ̨����ID
	String express 	= request.getParameter("express");//���:��λ���֣�1˳�ᡢ2��ͨ
	String contactOrderNos 	= request.getParameter("contactOrderNos");//��ݱ��:��˳��ʱ����
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 	routerValue="<%=regionCode%>"  id="loginAccept" />
  
<wtc:service name="sA381Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="2" >
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=phone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=orderId%>"/>
	<wtc:param value="<%=orderItemId%>"/>
	<wtc:param value="1"/> <%//0�����ʧ�� 1������ɹ� 2������ 3���ص��ɹ�%>
	<wtc:param value=""/>  <%//���͵�ַ������޸ĵ�ַʱ��ֵ��%>
	<wtc:param value="1"/> <%//�Ƿ�֪ͨ�����µ�0����  1���� %>
	<wtc:param value="<%=express%>"/> 
	<wtc:param value="<%=contactOrderNos%>"/> 
</wtc:service>
<wtc:array id="result11" scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
core.ajax.receivePacket(response);
