<%
    /*************************************
    * ��  ��: ��ͣ״̬��ѯ g072
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-9-7
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regCode = (String)session.getAttribute("regCode");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	String phoneNoVal = WtcUtil.repStr(request.getParameter("phoneNoVal"), "");/*�������*/
	String uptPromptPhoneNoVal = WtcUtil.repStr(request.getParameter("uptPromptPhoneNoVal"), "");/*�޸ĵ�Ƿ�����Ѻ���*/
	String note = opName;
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sG072Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=phoneNoVal%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=note%>"/> 
		<wtc:param value="<%=uptPromptPhoneNoVal%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    