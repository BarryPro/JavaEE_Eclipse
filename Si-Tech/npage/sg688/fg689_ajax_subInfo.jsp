<%
  /*
   * ����: ���������֤��ѯ¼�� g689
   * �汾: 1.0
   * ����: 2012/5/20
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), ""); 
	String idIccid_input = WtcUtil.repStr(request.getParameter("idIccid_input"), ""); //���֤����
  String regCode = (String)session.getAttribute("regCode");
  String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
  String password=WtcUtil.repNull((String)session.getAttribute("password"));	
  String notes = workNo+"������"+opName;
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
  String [] inputParam = new String [9] ;
	inputParam[0] = printAccept; //��ˮ
	inputParam[1] = "01";        //����
	inputParam[2] = opCode;      //��������
	inputParam[3] = workNo;     //����
	inputParam[4] = password;//��������
	inputParam[5] = "";           //����
	inputParam[6] = "";           //��������
	inputParam[7] = notes;   //��ע
	inputParam[8] = idIccid_input; //���֤��
%>
	<wtc:service name="sG689Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    