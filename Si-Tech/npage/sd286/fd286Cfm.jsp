<%
   /*
   * ����: ���Ѷ����޸�
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
		String opCode = "d286";
		String opName = "���Ѷ����޸�";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
<%
		/**����Ϊ�������**/
		/* 0��ˮ */
		String iLoginAccept = sLoginAccept;
		/* 1 iOpCode */
		String iOpCode = opCode;
		/* 2 iLoginNo �޸��ߵ�loginno */
		String iLoginNo = workNo;
		/* 3 iLoginPasswd */
		String iLoginPasswd = pass;
		/* 4 iSystemNote ϵͳ��ע */
		String iSystemNote = "";
		/* 5 iOpNote ������ע */
		String iOpNote = WtcUtil.repNull(request.getParameter("opNote"));
		/* 6 iIpAddr */
		String iIpAddr = WtcUtil.repNull(request.getRemoteAddr());
		/* 7 iMsgCode ���Ŵ��� */
		String iMsgCode = WtcUtil.repNull(request.getParameter("msgCodeHide"));
		iMsgCode = iMsgCode.trim();
		/* 8 iBillType */
		String iBillType = "20";
		/* 9 iPromptType */
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptTypeHide"));
		/* 10 iPromptSeq */
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeqHide"));
		/* 11 iPrompCon �������� */
		String iPrompCon = WtcUtil.repNull(request.getParameter("sPromptContent"));
		/* 12 iIsPrint */
		String iIsPrint = "4";
		/* 13 iValidFlag */
		String iValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		/* 14 iModifyGroupId �޸��ߵ�groupid */
		String iModifyGroupId = groupId;
		/* 15 iIsCreaterStart �Ƿ��Ǵ����߱�ʶ */
		String iIsCreaterStart = WtcUtil.repNull(request.getParameter("sIsCreaterStart"));
		/* 16 iAuditLogin ������ */
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		/* 17 iChannelsCode */
		String iChannelsCode = "01";
		/**���������ѹ������**/
		String [] inParas = new String[23];
		inParas[0] = iLoginAccept;
		inParas[1] = iOpCode;
		inParas[2] = iLoginNo;
		inParas[3] = iLoginPasswd;
		inParas[4] = iSystemNote;
		inParas[5] = iOpNote;
		inParas[6] = iIpAddr;
		inParas[7] = iMsgCode;
		inParas[8] = iBillType;
		inParas[9] = iPromptType;
		inParas[10] = iPromptSeq;
		inParas[11] = iPrompCon;
		inParas[12] = iIsPrint;
		inParas[13] = iValidFlag;
		inParas[14] = iModifyGroupId;
		inParas[15] = iIsCreaterStart;
		inParas[17] = iChannelsCode;
		
		String [] sAuditLogin = sAuditLogins.split(",");

%>
<wtc:service name="sd286Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="retCode1" retmsg="retMsg1" outnum="1" >
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
	<wtc:param value="<%=inParas[17]%>"/>
	</wtc:service>
<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ����޸������ѳɹ��ύ!",2);
			window.location.href = "fd286.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ����޸�����δ�ܳɹ��ύ!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "fd286.jsp";
		</script>		
<%			
	}
%>	