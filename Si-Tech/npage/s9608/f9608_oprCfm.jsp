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
		 *@name						s9608Cfm1
		 *@description				ע����������
		 *@author					lugz
		 *@created	2008-10-10 14:06:47
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
		String opCode = "9608";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = WtcUtil.repNull(request.getParameter("systemNote"));
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType"));		
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq"));		
		
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		
		System.out.println("sAuditLogins=="+sAuditLogins);
		String [] sAuditLogin = sAuditLogins.split(",");
	 /**���������ѹ������**/
   String [] inParas = new String[12];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = "���ݽ���ɾ��:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iPromptType;
   inParas[10] = iPromptSeq; 
   inParas[11] = "(�μ�sAuditLogin����,δ���˲���)"; 
		
%>
	<wtc:service name="s9608Cfm1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
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
	