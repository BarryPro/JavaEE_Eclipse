<%
/********************
 version v1.0
������: si-tech
update: sunaj@2010-03-01
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%
	String opCode="8375";
	String opName="����Ԥ��������";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 

	String paraAray[] = new String[41];  //update by diling@2012/2/3 15:46:57
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("audit_phone");
	paraAray[6] = "";
	paraAray[7] = request.getParameter("file_name");
	paraAray[8] = request.getParameter("file_no");
	paraAray[9] = request.getParameter("audit_name");
	paraAray[10] = request.getParameter("base_fee");
	paraAray[11] = request.getParameter("base_term");
	paraAray[12] = request.getParameter("free_fee");
	paraAray[13] = request.getParameter("free_term");
	paraAray[14] = request.getParameter("return_fee");
	paraAray[15] = request.getParameter("begin_time");
	paraAray[16] = request.getParameter("stop_time");
	paraAray[17] = request.getParameter("project_name");  //�С������
	paraAray[18] = request.getParameter("project_code");  //�����
	paraAray[19] = request.getParameter("month_basefee");
	paraAray[20] = request.getParameter("month_consume");
	paraAray[21] = request.getParameter("return_date"); 
	paraAray[22] = request.getParameter("cash_fee");
	paraAray[23] = request.getParameter("projectTypeAdd");  //����
	paraAray[24] = request.getParameter("projectNameAdd");  //����
	paraAray[25] = request.getParameter("projectTypeSel");  //���л�����
	paraAray[26] = request.getParameter("projectType");     //����    
	paraAray[27] = request.getParameter("return_paytype");; 
	paraAray[28] = request.getParameter("consume_mark"); 
	paraAray[29] = request.getParameter("return_term");   
	paraAray[30] = request.getParameter("gift_code");      //��Ʒ����
	paraAray[31] = request.getParameter("gift_grade");     //��Ʒ�ȼ�
	paraAray[32] = request.getParameter("OpFlag");         //������ѡ��
	paraAray[33] = request.getParameter("work_men");        //������Ա
	paraAray[34] = request.getParameter("action_code");     //���ֻ���� huangrong ��� �Ӿ��ֻ�����ֵ
	paraAray[35] = request.getParameter("do_note");        //��ע��Ϣ huangrong ��� ��ע��Ϣ��ֵ 2010-10-21 13:29
	paraAray[36] = request.getParameter("channelChecked");        //�������� huangrong ��� �������� 2011-8-24
	paraAray[37] = "";
	String hasOfferId = request.getParameter("hasOfferId");        //�Զ��ŷָ����ʷ��ַ���
	String[] offerIds = request.getParameterValues("offerId");        //�Զ��ŷָ����ʷ��ַ���
	System.out.println("====wanghfa====f8375_2.jsp==== hasOfferId = " + hasOfferId + ", offerIds = " + offerIds);
	if ("1".equals(hasOfferId) && offerIds != null) {
		for (int i = 0; i < offerIds.length; i ++) {
			if (i == 0) {
				paraAray[37] = offerIds[i];
			} else {
				paraAray[37] += "," + offerIds[i];
			}
		}
	}
	paraAray[38] = request.getParameter("innetTime");        //���õ�����ʱ��Ҫ��
	/*begin add ���ӵ���Ԥ�����ͣ��Ԥ������ by diling@2012/2/3 16:09:27*/
	paraAray[39] = request.getParameter("typeOfBaseFeeValue"); 
	paraAray[40] = request.getParameter("typeOfFreeFeeValue"); 
	System.out.println("========f8375_2.jsp==== paraAray[39] = "+paraAray[39]);
	System.out.println("========f8375_2.jsp==== paraAray[40] = "+paraAray[40]);
	/*end add by diling */

%>
	<wtc:service name="s8375Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
		<wtc:param value="<%=paraAray[25]%>"/>
		<wtc:param value="<%=paraAray[26]%>"/>
		<wtc:param value="<%=paraAray[27]%>"/>
		<wtc:param value="<%=paraAray[28]%>"/>
		<wtc:param value="<%=paraAray[29]%>"/>
		<wtc:param value="<%=paraAray[30]%>"/>
		<wtc:param value="<%=paraAray[31]%>"/>
		<wtc:param value="<%=paraAray[32]%>"/>
		<wtc:param value="<%=paraAray[33]%>"/>
		<wtc:param value="<%=paraAray[34]%>"/>    <!--huangrong ���� ���ݾ��ֻ�����ֵ-->
		<wtc:param value="<%=paraAray[35]%>"/>    <!--huangrong ���� ���ݱ�ע��Ϣ��ֵ 2010-10-21 13:29-->
		<wtc:param value="<%=paraAray[36]%>"/>    <!--huangrong ���� ������������ 2011-8-30 14:22-->
		<wtc:param value="<%=paraAray[37]%>"/>
		<wtc:param value="<%=paraAray[38]%>"/>
		<wtc:param value="<%=paraAray[39]%>"/>		<!--diling ���� ����Ԥ������ 2012/2/3 16:14:42-->
		<wtc:param value="<%=paraAray[40]%>"/>		<!--diling ���� �Ԥ������ 2012/2/3 16:14:46-->
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg  = retMsg;
	if (errCode.equals("000000") )
	{
		String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	
%>
	<jsp:include page="<%=url%>" flush="true" />
<script language="JavaScript">	
	rdShowMessageDialog("ȷ�ϳɹ�! ",2);
	window.location="/npage/s1141/f8375_login.jsp?opCode=8375&opName=����Ԥ��������";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����Ԥ��������ʧ��!(<%=errMsg%>",0);
	window.location="/npage/s1141/f8375_login.jsp?opCode=8375&opName=����Ԥ��������";
</script>
<%}%>
