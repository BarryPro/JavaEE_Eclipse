<%
  /*
   * ����: �·����� 1100
   * �汾: 1.0
   * ����: 2014-11-6
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<% 
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String regCode = (String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
	String opNote = workNo+"������"+opCode+"[�·�����]����";
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sM194Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

