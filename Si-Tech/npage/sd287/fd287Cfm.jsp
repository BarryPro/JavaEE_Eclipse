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
		String opCode = "d287";
		String opName = "���Ѷ���ɾ��";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
<%
		/**����Ϊ�������**/
		/* 0 iLoginAccept ��ˮ */
		String iLoginAccept = sLoginAccept;
		/* 1 iOpCode */
		String iOpCode = opCode;
		/* 2 iLoginNo */
		String iLoginNo = workNo;
		/* 3 iLoginPasswd */
		String iLoginPasswd = pass;
		/* 4 iSystemNote */
		String iSystemNote = "";
		/* 5 iOpNote */
		String iOpNote = WtcUtil.repNull(request.getParameter("opNote"));
		/* 6 iIpAddr */
		String iIpAddr = WtcUtil.repNull(request.getRemoteAddr());
		/* 7 iMsgCode */
		String iMsgCode = WtcUtil.repNull(request.getParameter("msgCodeHide"));
		iMsgCode = iMsgCode.trim();
		/* 8 iBillType */
		String iBillType = "20";
		/* 9 iPromptType */
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptTypeHide"));
		/* 10 iPromptSeq */
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeqHide"));
		/* 11 iAuditLogin */
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		/**���������ѹ������**/
		String [] inParas = new String[12];
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
		String [] sAuditLogin = sAuditLogins.split(",");		
%>
<wtc:service name="sd287Cfm" routerKey="region" routerValue="<%=regionCode%>" 
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
	<wtc:params value="<%=sAuditLogin%>"/>
	</wtc:service>
<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ���ɾ�������ѳɹ��ύ!",2);
			window.location.href = "fd287.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("���Ѷ���ɾ������δ�ܳɹ��ύ!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "fd287.jsp";
		</script>		
<%			
	}
%>	