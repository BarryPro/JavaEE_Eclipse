<%
  /*
   * ����: ȫ��ͨVIP�򳵷���
   * �汾: 2.0
   * ����: 2010/11/17
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%

	System.out.println("================����sb878Cfm in fb878Cfm.jsp=============");
	String iLoginAccept = "";										//��ˮ
	String iChnSource   = "10";										//������ʶ
	String iOpCode      = "4400";									//��������
	String iOpName		= "ȫ��ͨVIP�򳵷���";
	String iLoginNo     = (String)session.getAttribute("workNo");	//��������
	String iLoginPwd    = (String)session.getAttribute("password"); //�������� 
	String iPhoneNo     = request.getParameter("custPhone");		//�ֻ�����
	String iUserPwd  	= request.getParameter("custPwd");			//��������
	System.out.println("=================iLoginPwd=================:"+iLoginPwd);
	System.out.println("=================iUserPwd=================:"+iUserPwd);
	String iOrgCode		= (String)session.getAttribute("orgCode");	//���Ź���
	String regionCode 	= iOrgCode.substring(0,2);
	String iCardType    = request.getParameter("cardType");			//֤������
	String iCardNum     = request.getParameter("cardNo");			//֤������
	String iEnterTime   = request.getParameter("enterTime");        //����ʱ��
	String iLeaveTime   = request.getParameter("leaveTime");        //�뿪ʱ��
	String iSvcLevel = "";

	String iSvcCode		= request.getParameter("oneCodeArr");		//ͳ����Ŀ����
	String iSvcDisc		= request.getParameter("oneNameArr");		//ͳ����Ŀ����
	String iItemID		= request.getParameter("twoCodeArr");		//������Ŀ����
	String iItemValue   = request.getParameter("twoNameArr");  		//������Ŀֵ
	String iPrice      	= request.getParameter("priceArr");			//���
	String iScore     	= request.getParameter("scoreArr");			//�ۺ�Ӧ�ۻ���
	String iAmount 		= request.getParameter("totalPrice");		//�ܽ��
	String iTotalScore 	= request.getParameter("totalScore");		//�ۺ�Ӧ���ܻ���
	String iWeatherFlag = request.getParameter("tqyb");				//�Ƿ��ѯ���û�����ȥĿ�ĵ��������(0����1������)
	String iDestProv 	= request.getParameter("proCode");			//Ŀ�ĵ�ʡ��
	String iDestCity 	= request.getParameter("cityCode");			//Ŀ�ĵس���
	String iDestDate 	= request.getParameter("destDate");			//Ŀ�ĵص�������Ԥ������
	String morrowFlag 	= request.getParameter("morrowFlag");		//�Ƿ�Ԥ���ڶ�������Ԥ����ʶ
	String iMorrowDate 	= "";										//Ŀ�ĵصڶ�������Ԥ������
	String flag 	= request.getParameter("flag");		//inner��ʡ�ڣ�out��ʡ��
	String personNum 	= request.getParameter("personNum");		//��Ա����
	String sheng_flag= request.getParameter("sheng_flag");//huangrong add ʡ��ʡ���ʶ��w��ʡ�⣬n��ʡ��
	
	if("1".equals(morrowFlag)){
		try {
			java.util.Date mDay = new java.text.SimpleDateFormat("yyyyMMdd").parse(iDestDate);
			int day = mDay.getDate();
			mDay.setDate(day+1);
			iMorrowDate = new java.text.SimpleDateFormat("yyyyMMdd").format(mDay);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
	}
	if("n".equals(sheng_flag)){
	 iSvcLevel    = request.getParameter("servLeve");		//���񼶱�
	 iLoginAccept = request.getParameter("login_accept");	
}else
	{
	 iSvcLevel    = request.getParameter("servLevel");		//���񼶱�
	  iLoginAccept = "";
	}
	System.out.println("=================iSvcLevel=================:"+iSvcLevel);		
	System.out.println("=================iLoginAccept=================:"+iLoginAccept);		
%>
<wtc:service name="sb878Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iCardType%>" />
		<wtc:param value="<%=iCardNum%>" />
		<wtc:param value="<%=iEnterTime%>" />
		<wtc:param value="<%=iLeaveTime%>" />
		<wtc:param value="<%=iSvcLevel%>" />
		<wtc:param value="<%=iSvcCode%>" />
		<wtc:param value="<%=iSvcDisc%>" />
		<wtc:param value="<%=iItemID%>" />
		<wtc:param value="<%=iItemValue%>" />
		<wtc:param value="<%=iPrice%>" />
		<wtc:param value="<%=iScore%>" />
		<wtc:param value="<%=iAmount%>" />
		<wtc:param value="<%=iTotalScore%>" />
		<wtc:param value="<%=iWeatherFlag%>" />
		<wtc:param value="<%=iDestProv%>" />
		<wtc:param value="<%=iDestCity%>" />
		<wtc:param value="<%=iDestDate%>" />
		<wtc:param value="<%=iMorrowDate%>" />
<%
		if("inner".equals(morrowFlag))
		{
%>			
		<wtc:param value="<%=personNum%>" />
<%
		}
%>	

<%
		if("n".equals(sheng_flag))
		{
%>			
		<wtc:param value="<%=personNum%>" />
<%
		}
%>				
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sb878Cfm in fb878Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

 	    String statisLoginAccept =  iLoginAccept; /*��ˮ*/
		String statisOpCode="4400";
		String statisPhoneNo= iPhoneNo;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("4400"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}	
%>
	<script language="JavaScript">
		rdShowMessageDialog("����ȫ��ͨVIP�򳵷���ɹ���");
		window.location="/npage/s4400/f4400.jsp?opCode=4400&opName=����VIP��������";
	</script>
<%
	}else{
		System.out.println("���÷�����÷���sb878Cfm in fb878Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location="/npage/s4400/f4400.jsp?opCode=4400&opName=����VIP��������";
	</script>
<%
	}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+ iOpCode +"&retCodeForCntt="+errCode+
			"&opName="+iOpName+"&workNo="+iLoginNo+"&loginAccept="+iLoginAccept+
			"&pageActivePhone="+iPhoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;	
%>
		<jsp:include page="<%=url%>" flush="true" />