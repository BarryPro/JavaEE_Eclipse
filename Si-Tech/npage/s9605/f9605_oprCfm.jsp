<%
   /*
   * ����: ������ϵ��ѯ:ע�����������
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
		 *@name						s9605Cfm1
		 *@description				ע����������
		 *@author					lugz
		 *@created	2008-10-07 17:13:21
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
		 *@inparam	sReleaseGroup ������Դ
		 *@inparam	iReleaseAction ������������
		 *@inparam	sPromptContent	��ʾ����
		 *@inparam	sIsPrint	�Ƿ��ӡ
		 *@inparam	sValidFlag	��Ч��־
		 *@inparam	sCreateLogin	��������
		 *@inparam	sCreateTime	����ʱ��
		 *@inparam	sGroupId		�����ڵ�
		 *@inparam	sValidTime ��Чʱ��
		 *@inparam	sInvalidTime ʧЧʱ��
		 *@inparam	sAuditLogin	������
		 
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**����Ϊ�������**/
		String loginAccept = sLoginAccept;
		String opCode = "9605";
		String loginNo= workNo;
		String loginPassword = pass;
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType"));
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));
		String iPromptSeq = "0";
		String sReleaseGroup = WtcUtil.repNull(request.getParameter("sReleaseGroup"));
		String iReleaseAction = WtcUtil.repNull(request.getParameter("iReleaseAction"));
		String sPromptContent = WtcUtil.repNull(request.getParameter("sPromptContent"));
		String sIsPrint = WtcUtil.repNull(request.getParameter("sIsPrint"));
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		String sCreateLogin = WtcUtil.repNull(request.getParameter("sCreateLogin"));
		String sCreateTime = WtcUtil.repNull(request.getParameter("sCreateTime"));
		String sGroupIds = WtcUtil.repNull(request.getParameter("sGroupId"));
		String sValidTime = WtcUtil.repNull(request.getParameter("sValidTime"));
		String sInvalidTime = WtcUtil.repNull(request.getParameter("sInvalidTime"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		
		/**���һ������Ĳ���ģ�������ڷ�.���ݲ���ģ��������ӵ�,ģ����벻��Ϊ"ALL"���߿�**/
		if(sFunctionCode.trim().equals("")){
%>
			<script type="text/javascript">
				<!--
				alert("����ģ����벻��Ϊ��!");
				history.go(-1);
				//-->
			</script>
<%
			return;
		}else{
			String checksFunctionCodeSql="select 1 from sfunccode where function_code = '"+sFunctionCode+"'";
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=checksFunctionCodeSql%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultArr" scope="end" />		
<%
			if(resultArr!=null){
				if(resultArr.length==0){
%>
					<script type="text/javascript">
						<!--
						alert("����ģ����벻����,����������!");
						history.go(-1);
						//-->
					</script>
<%	
					return;			
				}
			}				
		}
		
		/**���ݷָ���������ת��������**/
		String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		
		/**�����ʾ���**/
		String queryOldPromptSeqSql = "select nvl(max(prompt_seq),0)+1 from sFuncPrompt where 1=1 ";
		if(!"".equals("sFunctionCode")){
			queryOldPromptSeqSql += " and function_code = '"+sFunctionCode+"'";
		}
		if(!"".equals(iBillType)){
			queryOldPromptSeqSql += " and bill_type = '"+iBillType+"'";
		}
		if(!"".equals(iPromptType)){
			queryOldPromptSeqSql += " and prompt_type = '"+iPromptType+"'";
		}
		//System.out.println("##################f9605_oprCfm.jsp->s9605Cfm1->queryOldPromptSeqSql->"+queryOldPromptSeqSql);					
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=queryOldPromptSeqSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
		if(retCode1.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				iPromptSeq = sVerifyTypeArr[0][0];
				System.out.println("##################f9605_oprCfm.jsp->s9605Cfm1->iPromptSeq->"+iPromptSeq);					
			}
		}		
	 /**���������ѹ������**/
   String [] inParas = new String[22];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = "";
   inParas[5]  = "���ݽ�������:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iPromptType;
   inParas[10] = iPromptSeq; 
   inParas[11] = sReleaseGroup; 
   inParas[12] = iReleaseAction;
   inParas[13] = sPromptContent;
   inParas[14] = sIsPrint;
   inParas[15] = sValidFlag;
   inParas[16] = sCreateLogin; 
   inParas[17] = sCreateTime;
   inParas[18] = "(�μ�sGroupId����,δ���˲���)";
   inParas[19] = sValidTime;
   inParas[20] = sInvalidTime;
   inParas[21] = "(�μ�sAuditLogin����,δ���˲���)";
		
%>
	<wtc:service name="s9605Cfm1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
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
	<wtc:params value="<%=sGroupId%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:params value="<%=sAuditLogin%>"/>
	<wtc:param value="<%=Channels_Code%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode2.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("ע��������������������ѳɹ��ύ!",2);
			window.location.href = "f9605_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("ע�������������������δ�ܳɹ��ύ!�������:<%=retCode2%><br/>������Ϣ:<%=retMsg2%>");
			window.location.href = "f9605_1.jsp";
		</script>		
<%			
	}
%>	