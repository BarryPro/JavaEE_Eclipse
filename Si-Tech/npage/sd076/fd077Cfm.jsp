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
	/*String loginAccept	    = "";	//��ˮ*/
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
	String offerId		= request.getParameter("offerId");	//�ײ����ͣ�01������	�ײͣ�02�������ײͣ�
	System.out.println("wanghyd----type_flag--1--"+type_flag);  
	System.out.println("wanghyd----offerId----"+offerId);                                   
	String propDistrict		= "";
	String propCommunity	= "";
	String ofrId=request.getParameter("ofrId");
	System.out.println("d077~~~~ofrId="+ofrId);
	

	if("34515".equals(offerId)) {
		type_flag ="01";	
	}
	if("34517".equals(offerId)) {
		type_flag ="02";	
	}
	if("36724".equals(offerId)) {
		type_flag ="01";	
	}
	if("36725".equals(offerId)) {
		type_flag ="01";	
	}
	if("36726".equals(offerId)) {
		type_flag ="01";	
	}
	if("46865".equals(offerId)) {
		type_flag ="01";	
	}
	System.out.println("wanghyd----type_flag--2--"+type_flag); 
	if("02".equals(type_flag)){ 
	    propDistrict = 	request.getParameter("propDistrict_select_hidd");	//������
	    propCommunity = request.getParameter("propCommunity_select_hidd");   //����
	}else if("01".equals(type_flag)){
	    propDistrict = request.getParameter("propDistrict");	//������
	    propCommunity = request.getParameter("propCommunity");	//����
	}       
	
	String propAddress		= request.getParameter("custAddr");	//��ס��ϸ��ַ      													                                                        
	String propTelephone	= request.getParameter("propTelephone");	//�����˳�ס�̻�    													                                                        
	String feeFlag			= request.getParameter("feeFlay");	//�Ƿ��趨���Ѻ��루N-��Y-�ǣ�                                            
	String feePhone			= request.getParameter("feePhone");	//���Ѻ���          													                                                        
	String feePwd			= request.getParameter("feePwdEnd");	//���Ѻ�������      													                                                        
	String userAccounts		= request.getParameter("userAccounts");	//�û���¼�ʺ�      													                                                        
	String propUrgentRoutes	= request.getParameter("propUrgentRoutes");	//�������ȳ������ﳣס�ص�·��                                              
	String propLifestyle	= request.getParameter("propLifestyle");	//�������������    													                                                        
	String isReportSafe		= request.getParameter("isReportSafe");	//�Ƿ���Ҫ��ƽ������													                                                        
	String reportCycle		= request.getParameter("reportCycle");	//��ƽ�����ڣ�ÿx�챨һ�Σ�
	String reportName		= request.getParameter("reportName");	//��ƽ�����շ�����  													                                                        
	String reportMobile		= request.getParameter("reportMobile");	//��ƽ�����շ��ƶ��绰                                                      
	String reportWay		= request.getParameter("reportWay");	//��ƽ����ʽѡ��01���绰+���ţ�02��ֻ�Ƕ��ţ�                             
	String famRelaInfoStr	= request.getParameter("famRelaInfoStr");	//��ͨ������Ϣ��(ÿ����������Ϣ֮����'~'�������ӣ���������֮����'|'���зָ�)
	String firstRelaInfoStr	= request.getParameter("firstRelaInfoStr");	//��һ��ϵ����Ϣ    													                                                        
	String friRelaInfoStr	= request.getParameter("friRelaInfoStr");	//������Ϣ��        													                                                        
	String neiRelaInfoStr	= request.getParameter("neiRelaInfoStr");	//�ھ���Ϣ�� 
	String propSex	= request.getParameter("custSex");	//�ھ���Ϣ�� 	
	String propBirthday		= request.getParameter("propBirthday");	//��������
	String phoneList	= request.getParameter("phoneList");	//ɾ���ĵ绰����ƴ��
	String opFlag	= request.getParameter("opFlag");	//�ʷѱ��������Ϣ���
	      													                                                        
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<wtc:service name="sD077Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=chnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=loginPwd%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=userPwd%>" />
		<wtc:param value="<%=type_flag%>" />
		<wtc:param value="<%=propDistrict%>" />
		<wtc:param value="<%=propAddress%>" />
		<wtc:param value="<%=propTelephone%>" />
		<wtc:param value="<%=feeFlag%>" />
		<wtc:param value="<%=feePhone%>" />
		<wtc:param value="<%=feePwd%>" />
		<wtc:param value="<%=userAccounts%>" />
		<wtc:param value="<%=propCommunity%>" />
		<wtc:param value="<%=propUrgentRoutes%>" />
		<wtc:param value="<%=propLifestyle%>" />
		<wtc:param value="<%=isReportSafe%>" />
		<wtc:param value="<%=reportCycle%>" />
		<wtc:param value="<%=reportName%>" />
		<wtc:param value="<%=reportMobile%>" />
		<wtc:param value="<%=reportWay%>" />
		<wtc:param value="<%=famRelaInfoStr%>" />
		<wtc:param value="<%=firstRelaInfoStr%>" />
		<wtc:param value="<%=friRelaInfoStr%>" />
		<wtc:param value="<%=neiRelaInfoStr%>" />
		<wtc:param value="<%=propSex%>" />
		<wtc:param value="<%=propBirthday%>" />		
		<wtc:param value="<%=phoneList%>" />					
		<wtc:param value="<%=ofrId%>" />					
		<wtc:param value="<%=opFlag%>" />					
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sD077Cfm in fd077Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("����ͨҵ�����ɹ���");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���sD077Cfm in fd077Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fd076_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
	</script>
<%
	}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
