<%
   /*
   * ����: ע�����������
�� * �汾: v2.0
�� * ����: 2008/10/14
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
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/*@service information
		 *@name						s9614Cfm1
		 *@description				��˵��ǲ������� 
		 *@author					lugz
		 *@created	2008-10-8 13:01:58
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
		 
		 *@inparam	sAuditAccept	������ˮ
		 *@inparam	sIsAuditPass 	Y/N
		 *@inparam	sAuditSuggestion �������
		 *@inparam	sIsAudit	�Ƿ��Ѿ���� Y/N
		 
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**����Ϊ�������**/
		String loginAccept = sLoginAccept;
		String opCode = "9614";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = "��";
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String sIsAuditPass = WtcUtil.repNull(request.getParameter("sIsAuditPass"));
		String sAuditSuggestion = WtcUtil.repNull(request.getParameter("sAuditSuggestion"));
		
	 /**���������ѹ������**/
   String [] inParas = new String[10];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = "���ݽ�������:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sAuditAccept;
   inParas[8] = sIsAuditPass;
   inParas[9] = sAuditSuggestion;
		
	 /**��ӡ�������,���Ժ����ɾ�����**/	
	 for(int i=0;i<inParas.length;i++){
	 		System.out.println("##################f9614_oprCfm.jsp->s9614Cfm1->inParas["+i+"]->"+inParas[i]);
	 }	
%>
	<wtc:service name="s9614Cfm1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
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
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("ע������������ɹ�!",2);
			window.location.href = "f9614_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("ע�����������δ�ܳɹ�!�������:<%=retCode1%><br/>������Ϣ:<%=retMsg1%>");
			window.location.href = "f9614_1.jsp";
		</script>		
<%			
	}
%>
	
