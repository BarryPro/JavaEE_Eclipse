<%
    /*************************************
    * ��  ��: ��Ʒ����������ϵ���� У���޸ĺ��SI����Ӧ�û�������� 2029 
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-5-31
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode = (String)session.getAttribute("regCode");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"), "");
	String password = WtcUtil.repStr(request.getParameter("password"), "");
	String groupId = (String)session.getAttribute("groupId");
	String vSiMMSInfo = WtcUtil.repStr(request.getParameter("vSiMMSInfo"), "");//��֤����
	
	System.out.println("--------------2029---------vSiMMSInfo="+vSiMMSInfo);
	System.out.println("--------------2029---------regCode="+regCode);
	System.out.println("--------------2029---------groupId="+groupId);
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
    
  <wtc:service name="sPubProcCfmNew" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
  	<wtc:param value="<%=printAccept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/> 
  	<wtc:param value="<%=loginNo%>"/>
  	<wtc:param value="<%=password%>"/> 
  	<wtc:param value=""/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=vSiMMSInfo%>"/>
  	<wtc:param value="<%=regCode%>"/>
  	<wtc:param value="G0003"/> <%/* ��Դ����(MAS��̲ʽ�����룺G0001��MAS��wappush��G0002��ADC�� ��ҵ�ֻ�����G0003)*/%>
    <wtc:param value="0"/>     <%/* �������ͣ�0��������1�����Ž��루MAS����1�����Ž��루MAS����*/%>
  </wtc:service>
  <wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---2029----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    