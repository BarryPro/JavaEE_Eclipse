<%
   /*
   * ����: ������ϵ��ѯ:ע�������ɾ��
�� * �汾: v2.0
�� * ����: 2008/10/09
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**����session�Ĺ̶�����**/
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/*@service information
		 *@name						s9608Cfm2
		 *@description				ע����������
		 *@author					lugz
		 *@created	2008-10-10 14:54:23
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
		 *@inparam	opCode			���ܴ���	
		 *@inparam	loginNo			��������
		 *@inparam	loginPasswd		�������ܵĹ�������
		 *@inparam	systemNote		ϵͳ��ע
		 *@inparam	opNote			������ע
		 *@inparam	ipAddr			IP��ַ
		 
		 *@inparam	iBillType	Ʊ������
		 *@inparam	iClassCode	���˳��
		 *@inparam	sClassValue	�ֶ���ֵ
		 *@inparam	iPromptType	��ʾ����
		 *@inparam	iPromptSeq	��ʾ���
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**����Ϊ�������**/
		String loginAccept = sLoginAccept;
		String opCode = "9608";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = WtcUtil.repNull(request.getParameter("systemNote2"));
		String opNote = WtcUtil.repNull(request.getParameter("opNote2"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode2"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType2"));
		String iClassSeq = WtcUtil.repNull(request.getParameter("iClassSeq"));
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String sClassValue = WtcUtil.repNull(request.getParameter("sClassValue"));
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType2"));
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq2"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		
		System.out.println("sAuditLogins=="+sAuditLogins);
		String [] sAuditLogin = sAuditLogins.split(",");
	 /**���������ѹ������**/
   String [] inParas = new String[14];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = "����ҵ��ɾ��:"+opNote;
   inParas[6]  = ipAddr; 
   inParas[7]  = sFunctionCode; 
   inParas[8] = iBillType;
   inParas[9] = iClassCode;
   inParas[10] = sClassValue;
   inParas[11] = iPromptType;
   inParas[12] = iPromptSeq; 
   inParas[13] = "(�μ�sAuditLogin����,δ���˲���)"; 
		
%>
	<wtc:service name="s9608Cfm2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:params value="<%=sAuditLogin%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("ע�����������ɾ�������ѳɹ��ύ!",2);
			window.location.href = "f9608_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("ע�����������ɾ������δ�ܳɹ��ύ!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "f9608_1.jsp";
		</script>		
<%			
	}
%>
	
