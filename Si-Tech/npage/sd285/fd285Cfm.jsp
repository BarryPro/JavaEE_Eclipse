<%
   /*
   * ����: ���Ѷ�������
�� * �汾: v2.0
�� * ����: 2011/3/28
�� * ����: ningtn
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
	<%@ page contentType= "text/html;charset=gb2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
<%
		/**����Ϊ�������**/
		/* 0������ˮ */
		String loginAccept = sLoginAccept;
		/* 1���ܴ��� */
		String opCode = "d285";
		/* 2�������� */
		String loginNo= workNo;
		/* 3�������ܵĹ������� */
		String loginPassword = pass;
		/* 4ϵͳ��ע */
		String systemNote = "";
		/* 5������ע */
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		/* 6IP��ַ */
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		/* 7���Ŵ��� */
		String sMsgCode = WtcUtil.repNull(request.getParameter("msgCode"));
		sMsgCode = sMsgCode.trim();
		System.out.println("----" + sMsgCode);
		/* 8Ʊ������ */
		String iBillType = "20";
		/* 9��ʾ���� */
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));
		/* 10��ʾ��� */
		String iPromptSeq = "1";
		/* 11������Դ */
		String sReleaseGroup = WtcUtil.repNull(request.getParameter("sReleaseGroup"));
		/* 12������������,1,����,2,�ջ�,3,���� */
		String iReleaseAction = WtcUtil.repNull(request.getParameter("iReleaseAction"));
		/* 13��ʾ���� */
		String sMsgContent = WtcUtil.repNull(request.getParameter("sMsgContent"));
		/* 14�Ƿ��ӡ */
		String sIsPrint = "4";
		/* 15��Ч��־ */
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		/* 16�������� */
		String sCreateLogin = WtcUtil.repNull(request.getParameter("sCreateLogin"));
		/* 17����ʱ�� */
		String sCreateTime = WtcUtil.repNull(request.getParameter("sCreateTime"));
		/* 18�������� */
		String sGroupIds = WtcUtil.repNull(request.getParameter("sGroupId"));
		/* 19��Чʱ�� */
		String sValidTime = WtcUtil.repNull(request.getParameter("sValidTime"));
		/* 20ʧЧʱ�� */
		String sInvalidTime = WtcUtil.repNull(request.getParameter("sInvalidTime"));
		/* 21������ */
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		/* 22������ʶ */
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		System.out.println("========== ningtn ====" + sGroupIds + "|" + sAuditLogins);
		/** �ύ����ǰ����֤ **/
		if(sMsgCode.trim().equals("")){
%>
			<script type="text/javascript">
				<!--
				alert("���Ŵ��벻��Ϊ��!");
				history.go(-1);
				//-->
			</script>
<%
			return;
		}else{
		
		}
%>
<%
		/* ��ʼ�ύ���� */
		/**���ݷָ���������ת��������**/
		String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		/**�����ʾ���**/
		String queryOldPromptSeqSql = "select nvl(max(prompt_seq),0)+1 from sFuncPrompt where 1=1 ";
		if(!"".equals(sMsgCode)){
			queryOldPromptSeqSql += " and function_code = '"+sMsgCode+"'";
		}
		//System.out.println("##################fd285Cfm.jsp->queryOldPromptSeqSql->"+queryOldPromptSeqSql);					
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=queryOldPromptSeqSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
		if(retCode2.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				iPromptSeq = sVerifyTypeArr[0][0];
				System.out.println("##################f9605Cfm.jsp->iPromptSeq->"+iPromptSeq);					
			}
		}
		/**���������ѹ������**/
		String [] inParas = new String[23];
		inParas[0] = loginAccept;
		inParas[1] = opCode;
		inParas[2] = loginNo;
		inParas[3] = loginPassword;
		inParas[4] = systemNote;
		inParas[5] = opNote;
		inParas[6] = ipAddr;
		inParas[7] = sMsgCode;
		inParas[8] = iBillType;
		inParas[9] = iPromptType;
		inParas[10] = "1";
		inParas[11] = sReleaseGroup;
		inParas[12] = iReleaseAction;
		inParas[13] = sMsgContent;
		inParas[14] = sIsPrint;
		inParas[15] = sValidFlag;
		inParas[16] = sCreateLogin;
		inParas[17] = sCreateTime;
		inParas[19] = sValidTime;
		inParas[20] = sInvalidTime;
		inParas[22] = Channels_Code;
%>
	<wtc:service name="sd285Cfm" routerKey="region" routerValue="<%=regionCode%>" 
		 retcode="retCode3" retmsg="retMsg3" outnum="1" >
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
		<wtc:param value="<%=inParas[22]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode3.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ������������ѳɹ��ύ!",2);
			window.location.href = "fd285.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ�����������δ�ܳɹ��ύ!�������:<%=retCode3%><br/>������Ϣ:<%=retMsg3%>");
			window.location.href = "fd285.jsp";
		</script>		
<%			
	}
%>	