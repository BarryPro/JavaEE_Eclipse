<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ͨ��ԭ���������˷�����������ҵ��
   * �汾: 2.0
   * ����: 2011/1/5
   * ����: weigp
   * ��Ȩ: si-tech
   * update: wanglma 20110527
   */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	/*===========��ȡ����============*/
	String loginAccept	    = request.getParameter("loginAccept");		//��ˮ
	String chnSource		= "10";	//������ʶ
	String opCode			= request.getParameter("opCode");	//��������
	String orgCode 			= (String)session.getAttribute("orgCode");
	String opName			= request.getParameter("opName");
	String regionCode 	    = orgCode.substring(0,2);
	String loginNo			= (String)session.getAttribute("workNo");	//��������
	String loginPwd			= (String)session.getAttribute("password");	//��������
	String phoneNo			= request.getParameter("phoneNo");			//�ֻ�����
	String userPwd			= "";	//��������
	String type_flag		= request.getParameter("type_flag");	//�ײ����ͣ�01������	�ײͣ�02�������ײͣ�
	String offer_id			= "";	//���ԣ�10806  �ʷѴ��룺34515 �ʷ����ƣ�����ͨҵ������ײ�   �ʷѴ��룺34517   �ʷ����ƣ�����ͨҵ�������ײ�
	String propCommunity	= "";
	String propDistrict		= "";
	if(!"34517".equals(type_flag)){
	  if("34515".equals(type_flag)) {
		offer_id 			= "34515";	
		}
		if("36724".equals(type_flag)) {
		offer_id 			= "36724";	
		}
		if("36725".equals(type_flag)) {
		offer_id 			= "36725";	
		}
		if("36726".equals(type_flag)) {
		offer_id 			= "36726";	
		}
		if("46865".equals(type_flag)) {
		offer_id 			= "46865";	
		}
		type_flag="01";
		propCommunity	= request.getParameter("propCommunity");	//����
		propDistrict		= request.getParameter("propDistrict");	//������
	}else{
		  offer_id 			= "34517";
		  type_flag="02";
	    propDistrict = 	request.getParameter("propDistrict_select_hidd");	//������
	    propCommunity = request.getParameter("propCommunity_select_hidd");   //����
	}
	String beginTime		= request.getParameter("startTime");	//��ʼʱ��
	String endTime			= request.getParameter("endTime");	//����ʱ��
	String propName			= request.getParameter("custName");	//����������
	String propSex			= request.getParameter("custSex");	//�������Ա�
	String propBirthday		= request.getParameter("propBirthday");	//��������
	String propCardNo		= request.getParameter("idNo");	//���֤��

	String propAddress		= request.getParameter("custAddr");	//��ס��ϸ��ַ
	String propTelephone	= request.getParameter("propTelephone");	//�����˳�ס�̻�
	String feeFlag			= request.getParameter("feeFlay");	//�Ƿ��趨���Ѻ��루N-��Y-�ǣ�
	String feePhone			= request.getParameter("feePhone");	//���Ѻ���
	String feePwd			= request.getParameter("password");	//���Ѻ�������
	String userAccounts		= request.getParameter("userAccounts");	//�û���¼�ʺ�
	
	String propUrgentRoutes	= request.getParameter("propUrgentRoutes");	//�������ȳ������ﳣס�ص�·��
	String propLifeStyle	= request.getParameter("propLifestyle");	//�������������
	String isReportSafe		= request.getParameter("isReportSafe");	//�Ƿ���Ҫ��ƽ������
	String reportCycle		= request.getParameter("reportCycle");	//��ƽ�����ڣ�ÿx�챨һ�Σ�
	String reportName		= request.getParameter("reportName");	//��ƽ�����շ�����
	String reportMobile		= request.getParameter("reportMobile");	//��ƽ�����շ��ƶ��绰
	String reportWay		= request.getParameter("reportWay");	//��ƽ����ʽѡ��01���绰+���ţ�02��ֻ�Ƕ��ţ�
	String famRelaInfoStr	= request.getParameter("famRelaInfoStr");	//��ͨ������Ϣ��(ÿ����������Ϣ֮����'~'�������ӣ���������֮����'|'���зָ�)
	String firstRelaInfoStr	= request.getParameter("firstRelaInfoStr");	//��һ��ϵ����Ϣ
	String friRelaInfoStr	= request.getParameter("friRelaInfoStr");	//������Ϣ��
	String neiRelaInfoStr	= request.getParameter("neiRelaInfoStr");	//�ھ���Ϣ��
//	String affectionNoStr	= request.getParameter("affectionNoStr");	//������봮

%>
<wtc:service name="sD076Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=chnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" /><!--5 -->
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userPwd%>" />
		<wtc:param value="<%=type_flag%>" />
		<wtc:param value="<%=offer_id%>" />
		<wtc:param value="<%=beginTime%>" /><!--10 -->
		<wtc:param value="<%=endTime%>" />
		<wtc:param value="<%=propName%>" />
		<wtc:param value="<%=propSex%>" />
		<wtc:param value="<%=propBirthday%>" />
		<wtc:param value="<%=propCardNo%>" /><!--15 -->
		<wtc:param value="<%=propDistrict%>" />
		<wtc:param value="<%=propAddress%>" />
		<wtc:param value="<%=propTelephone%>" />
		<wtc:param value="<%=feeFlag%>" />
		<wtc:param value="<%=feePhone%>" /><!--20 -->
		<wtc:param value="<%=feePwd%>" />
		<wtc:param value="<%=userAccounts%>" />
		<wtc:param value="<%=propCommunity%>" />
		<wtc:param value="<%=propUrgentRoutes%>" />
		<wtc:param value="<%=propLifeStyle%>" /><!--25 -->
		<wtc:param value="<%=isReportSafe%>" />
		<wtc:param value="<%=reportCycle%>" />
		<wtc:param value="<%=reportName%>" />
		<wtc:param value="<%=reportMobile%>" />
		<wtc:param value="<%=reportWay%>" /><!--30 -->
		<wtc:param value="<%=famRelaInfoStr%>" />
		<wtc:param value="<%=firstRelaInfoStr%>" />
		<wtc:param value="<%=friRelaInfoStr%>" />
		<wtc:param value="<%=neiRelaInfoStr%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sD076Cfm in fd076Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("����ͨҵ������ɹ���",2);
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���sD076Cfm in fd076Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}
System.out.println("%%%%%%%����ԤԼ����ʼ%%%%%%%%"); 	
String iOpCode = 		"d076";
String iLoginNo = 		"";
String iLoginPwd = 		"";
String iPhoneNo = 		phoneNo;
String iUserPwd = 		"";
String inOpNote = 		"";
String iBookingId = 	"";

System.out.println("zhangyan add iOpCode=["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan add inOpNote=["+inOpNote+"]");
System.out.println("zhangyan add iBookingId=["+iBookingId+"]");

String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
	+"&iLoginNo="+iLoginNo
	+"&iLoginPwd="+iLoginPwd
	+"&iPhoneNo="+iPhoneNo
	+"&iUserPwd="+iUserPwd
	+"&inOpNote="+inOpNote
	+"&iLoginAccept="+loginAccept
	+"&iBookingId="+iBookingId;		
System.out.println("booking_url="+booking_url);
%>
<jsp:include page="<%=booking_url%>" flush="true" />
<%
System.out.println("%%%%%%%����ԤԼ�������%%%%%%%%"); 	
	
	
	
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
