<%
  /* *********************
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

  //ǰһ��ҳ�洫��Ĳ���
  String iOpType=request.getParameter("opType");//��������   a���� u�޸� dɾ��
  String iScopeType=request.getParameter("scopeType");// ������Χ	0����	1����
  String iGoodType=request.getParameter("choPhoneType"); //������������ 
    System.out.println("!!!!!"+iGoodType+"-----------------------------------------------------------------!!!!______________________________-");
  if( iGoodType==null || iGoodType.equals("0") ) {
  iGoodType="";
  }

  String iDistrictCode=request.getParameter("disCode");//���ش���
  String iInterestRate=request.getParameter("interestRate");//��������
  String iInsuranceFee=request.getParameter("insuranceFee");//���շ�
  String iTestFee=request.getParameter("testFee");//�����
  String iContractHand=request.getParameter("contractHand");//����������
  String iLockMonth=request.getParameter("lockMonth");//�䶳����
  String iOwnPsw=request.getParameter("ownPsw");//�����־
  String iIdNum=request.getParameter("idNum");//������
  String iAssureNum=request.getParameter("assureNum");//������
  String iDeadDelayRate=request.getParameter("deadDelayRate");//���ɽ���
  String iDeadDelayBegin=request.getParameter("deadDelayBegin");//���ɽ�������
  String iCheckFlag=request.getParameter("checkFlag");//֧Ʊ��־
  String iNoUserDay=request.getParameter("noUserDay");//����ͣ������
  String iNoUserMoney=request.getParameter("noUserMoney");//����ͣ�����
  String iPreDelMonth=request.getParameter("predelMonth");//Ԥ������
  String iPreDelDeposit=request.getParameter("predelDeposit");//Ԥ��Ѻ��
  String iInnetPredelMonths=request.getParameter("innetPredelMonths");//Ԥ����������
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<wtc:service name="s5008Cfm" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=ip_Addr%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=iOpType%>"/>
				<wtc:param value="<%=iScopeType%>"/>
				<wtc:param value="<%=iGoodType%>"/>
				<wtc:param value="<%=regionCode%>"/>
				<wtc:param value="<%=iDistrictCode%>"/>
				<wtc:param value="<%=iInterestRate%>"/>
				<wtc:param value="<%=iInsuranceFee%>"/>
				<wtc:param value="<%=iTestFee%>"/>
				<wtc:param value="<%=iContractHand%>"/>
				<wtc:param value="<%=iLockMonth%>"/>
				<wtc:param value="<%=iOwnPsw%>"/>
				<wtc:param value="<%=iIdNum%>"/>
				<wtc:param value="<%=iAssureNum%>"/>
				<wtc:param value="<%=iDeadDelayRate%>"/>
				<wtc:param value="<%=iDeadDelayBegin%>"/>
				<wtc:param value="<%=iCheckFlag%>"/>
				<wtc:param value="<%=iNoUserDay%>"/>
				<wtc:param value="<%=iNoUserMoney%>"/>
				<wtc:param value="<%=iPreDelMonth%>"/>
				<wtc:param value="<%=iPreDelDeposit%>"/>
				<wtc:param value="<%=iInnetPredelMonths%>"/>
									
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		if (retCode1.equals("0")||retCode1.equals("000000")){
%>
			<script language="JavaScript">
				rdShowMessageDialog("�����ɹ��� ");
				window.location="f5008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("����ʧ�ܣ�" + "<%=retCode1%>" + "<%=retMsg1%>");
				window.location="f5008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
	}
%>