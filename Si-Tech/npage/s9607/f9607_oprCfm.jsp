<%
   /*
   * ����: ע��������޸�-����"�������ܴ����޸�"���ύҳ��
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
		 *@name						s9607Cfm1
		 *@description				ע���������޸�
		 *@author					lugz
		 *@created	2008-10-10 9:05:18
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
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCodeHidden"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillTypeHidden"));		
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptTypeHidden"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeqHidden"));
		
		String sPromptContent = WtcUtil.repNull(request.getParameter("sPromptContent"));
		String sIsPrint = WtcUtil.repNull(request.getParameter("sIsPrint"));
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		String sModifyGroupId = WtcUtil.repNull(request.getParameter("sModifyGroupId"));
		String sIsCreaterStart = WtcUtil.repNull(request.getParameter("sIsCreaterStart"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_CodeHidden"));
		System.out.println(")))))))))))))))))))))))))))))))))))))))))==="+Channels_Code);
		
		System.out.println("sAuditLogins="+sAuditLogins);
		opNote = "�û����ݽ����޸�:"+opNote;
		if(opNote.length()>60){
			opNote = opNote.substring(0,60);
		}
		
		/**���ݷָ���������ת��������**/
		String [] sAuditLogin = sAuditLogins.split(",");
		
		for(int i=0;i<sAuditLogin.length;i++){
			System.out.println("##################f9607_oprCfm.jsp->s9607Cfm1->sAuditLogin["+i+"]->"+sAuditLogin[i]);
		}
		
	 /**���������ѹ������**/
   String [] inParas = new String[17];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iPromptType;
   inParas[10] = iPromptSeq; 
   inParas[11] = sPromptContent;
   inParas[12] = sIsPrint;
   inParas[13] = sValidFlag;
   inParas[14] = sModifyGroupId;
   inParas[15] = sIsCreaterStart;
   inParas[16] = "�μ�����sAuditLogin";
		
	 /**��ӡ�������,���Ժ����ɾ�����**/	
	 for(int i=0;i<inParas.length;i++){
	 		System.out.println("##################f9607_oprCfm.jsp->s9607Cfm1->inParas["+i+"]->"+inParas[i]);
	 }	
%>
<wtc:service name="s9607Cfm1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
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
			rdShowMessageDialog("ע������������޸�����δ�ܳɹ��ύ!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "f9607_1.jsp";
		</script>		
<%			
	}
%>	
	