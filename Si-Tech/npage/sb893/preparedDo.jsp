<%
  /*
   * ����: ��վ����
   * �汾: 2.0
   * ����: 2010/11/26
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%

	String opCode 	= "b893";
	String loginNo 	= (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	String groupId 	= (String)session.getAttribute("groupId");
	String phoneNo 	= request.getParameter("phoneNo");
	//���봦��״̬ 0-���Ͽ���,1-ӪҵԱԤռ,2-�ͻ������ɹ�,3-��ͨ�����ɹ�
	String phoneStatus= "1";//request.getParameter("phoneStatus");
	String retCode = "";
	String retMsg = "";
%>
<wtc:service name="sb893Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="2" >
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=phoneStatus%>"/>
</wtc:service>
<wtc:array id="result11" scope="end"/>
<%
	System.out.println("=============preparedDo.jsp==============="+retCode1+"-----------"+result11.length);
	if("000000".equals(retCode1)){
		System.out.println("=============sb893Cfmִ�гɹ���===============");
		retCode = "000000";
		retMsg  = retMsg1;
	}else{
		System.out.println("sb893Cfmִ��ʧ�� ["+retCode1+"],"+retMsg1+"");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
