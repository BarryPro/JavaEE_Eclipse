<%
   /*
   * ����: ע��������޸�-����"�ֶδ����޸�"���ύҳ��
�� * �汾: v2.0
�� * ����: 2008/10/13
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
		 *@name						s9607Cfm2
		 *@description				ע�������޸�
		 *@author					lugz
		 *@created	2008-10-10 11:12:30
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
		 
		 
		 *@inparam	sFunctionCode	��ʾ��������
		 *@inparam	iBillType	Ʊ������
		 *@inparam	iClassSeq	���˳��
		 *@inparam	iClassCode	����
		 *@inparam	sClassValue	�ֶ���ֵ
		 *@inparam	sIsByValue	�Ƿ��մ�����ʾ
		 *@inparam	sLimitRule	ǰ������
		
		 *@inparam	iPromptType	��ʾ����
		 *@inparam	iPromptSeq	��ʾ���
		 *@inparam	sPromptContent	��ʾ����
		 *@inparam	sIsPrint	�Ƿ��ӡ
		 *@inparam	sValidFlag	��Ч��־
		 *@inparam	sModifyGroupId �޸Ľڵ�
		 *@inparam	sIsCreaterStart Y/N
		 *@inparam	sAuditLogin	������
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */

		/**����Ϊ�������**/
		String loginAccept = "0";
		String opCode = "9607";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = "��";
		String opNote = WtcUtil.repNull(request.getParameter("opNote2"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode2Hidden"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType2Hidden"));
		String iClassSeq = WtcUtil.repNull(request.getParameter("iClassSeq"));	
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCodeHidden"));
		String sClassValue = WtcUtil.repNull(request.getParameter("sClassValueHidden"));
		String sIsByValue = WtcUtil.repNull(request.getParameter("sIsByValue"));
		String sLimitRule = WtcUtil.repNull(request.getParameter("sLimitRule"));
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType2Hidden"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq2Hidden"));
		String sPromptContent = WtcUtil.repNull(request.getParameter("sPromptContent2"));
		String sIsPrint = WtcUtil.repNull(request.getParameter("sIsPrint2"));
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag2"));
		String sModifyGroupId = WtcUtil.repNull(request.getParameter("sModifyGroupId2"));
		String sIsCreaterStart = WtcUtil.repNull(request.getParameter("sIsCreaterStart2"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins2"));
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code2Hidden"));
		
		opNote = "�û�����ҵ���޸�:"+opNote;
		if(opNote.length()>60){
			opNote = opNote.substring(0,60);
		}

		/**���ݷָ���������ת��������**/
		String [] sAuditLogin = sAuditLogins.split(",");
		
		for(int i=0;i<sAuditLogin.length;i++){
			System.out.println("##################f9607_oprCfm.jsp->s9607Cfm1->sAuditLogin["+i+"]->"+sAuditLogin[i]);
		}
		
	 /**���������ѹ������**/
   String [] inParas = new String[22];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iClassSeq; 
   inParas[10]  = iClassCode;
   inParas[11]  = sClassValue;
   inParas[12] = sIsByValue;
   inParas[13] = sLimitRule;
   inParas[14] = iPromptType;
   inParas[15] = iPromptSeq; 
   inParas[16] = sPromptContent;
   inParas[17] = sIsPrint;
   inParas[18] = sValidFlag;
   inParas[19] = sModifyGroupId;
   inParas[20] = sIsCreaterStart;
   inParas[21] = "�μ�����sAuditLogin";
		
	 /**��ӡ�������,���Ժ����ɾ�����**/	
	 for(int i=0;i<inParas.length;i++){
	 		System.out.println("##################f9607_fieldCfm.jsp->s9607Cfm2->inParas["+i+"]->"+inParas[i]);
	 }	
%>
<wtc:service name="s9607Cfm2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
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
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:params value="<%=sAuditLogin%>"/>
	<wtc:param value="<%=Channels_Code%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("ע������������޸������ѳɹ��ύ!",2);
			window.location.href = "f9607_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog(" ע������������޸�����δ�ܳɹ��ύ!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "f9607_1.jsp";
		</script>		
<%			
	}
%>	
	