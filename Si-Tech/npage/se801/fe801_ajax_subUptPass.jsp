<%
    /*************************************
    * ��  ��: ���ſͻ������� e801
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-4-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginPassword = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String updateType=WtcUtil.repNull((String)request.getParameter("updateType"));
	String identityTypeVal=WtcUtil.repNull((String)request.getParameter("identityTypeVal"));
	String custId=WtcUtil.repNull((String)request.getParameter("custId"));
	String idNo=WtcUtil.repNull((String)request.getParameter("idNo"));
	String oldPassword=WtcUtil.repNull((String)request.getParameter("oldPassword"));
	String newPassword1=WtcUtil.repNull((String)request.getParameter("newPassword1"));
	String slecOperType=WtcUtil.repNull((String)request.getParameter("slecOperType"));
	
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
  String [] inputParam = new String [13] ;
	inputParam[0] = printAccept; //��ˮ
	inputParam[1] = "01";        //����
	inputParam[2] = opCode;      //��������
	inputParam[3] = loginNo;     //����
	inputParam[4] = loginPassword;//��������
	inputParam[5] = "";           //����
	inputParam[6] = "";           //��������
	inputParam[7] = updateType;   //�޸����ͣ�01-�����޸ģ�02-�������ã�
	inputParam[8] = identityTypeVal; //�޸ķ�Χ��01��ֻ�޸ļ��ſͻ����룻02��ֻ�޸ļ����û����룻03���޸ļ��ſͻ����룬���źͼ��������в�Ʒ���붼Ϊ���ſͻ����룩
	inputParam[9] = custId;           //���ſͻ�ID
	inputParam[10] = idNo;           //��Ʒid��iUpdateRangeΪ02ʱ����ֵ)
	inputParam[11] = oldPassword;           //�����루iUpdateTypeΪ01ʱ����ֵ��
	inputParam[12] = newPassword1 ;           //������
%>
	<wtc:service name="se801Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
		<wtc:param value="<%=inputParam[9]%>"/>
		<wtc:param value="<%=inputParam[10]%>"/>
		<wtc:param value="<%=inputParam[11]%>"/>
		<wtc:param value="<%=inputParam[12]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
  System.out.println("-----------e801-----------retcode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("slecOperType","<%=slecOperType%>");
core.ajax.receivePacket(response);
 
	    