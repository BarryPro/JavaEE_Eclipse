<%
   /*
   * ����: ������ϵ��ѯ:ע���������Ϣ����
�� * �汾: v1.0
�� * ����: 2009-5-20 16:44:39
�� * ����: gonght
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
	<%@ page contentType= "text/html;charset=GBK" %>
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
		 *@name						s9646Cfm
		 *@description				ע���������Ϣ����
		 *@author					gonght
		 *@created	2009-5-22 14:31:59
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		��ˮ	����������Ϣʱ���ɵ���ˮ
		 *@inparam	opCode			���ܴ���	
		 *@inparam	workNo			��������  									  
		 *@inparam	loginPasswd		�������ܵĹ�������                           
		 *@inparam	opNote			������ע                      
		 *@inparam	ipAddr			IP��ַ                        
		 *@inparam	sFunctionCode   ���ܴ���                                	                
	 
		 *@output parameter information
		 *@return SVR_ERR_NO 
		 */
		 
		/**����Ϊ�������**/
		String vLoginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String opCode = "9646";
		String loginPassword = pass;
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		
		String [] loginAccept = vLoginAccept.split(",");
		for(int i=0;i< loginAccept.length;i++)
		{
			System.out.println(loginAccept[i]); 
		}			
	System.out.println("++++++++s9646Cfm begin+++++++");
	 /**���������ѹ������**/
   String [] inParas = new String[6];
   inParas[0]  = "(�μ�loginAccept����,δ���˲���)";
   inParas[1]  = opCode;
   inParas[2]  = workNo;
   inParas[3]  = loginPassword;
   inParas[4]  = opNote;
   inParas[5]  = ipAddr;	
%>
	<wtc:service name="s9646Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
	<wtc:params value="<%=loginAccept%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode2.equals("000000")){
%>
		<script language="javascript">
			//rdShowMessageDialog("ע������⽨����Ϣ��ѯ�������!",2);
			window.location.href = "f9646_getAuditByFunctionCode.jsp?op_code=<%=op_code%>";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("ע������⽨����Ϣ��ѯ����δ���!�������:<%=retCode2%><br/>������Ϣ:<%=retMsg2%>");
			window.location.href = "f9646_getAuditByFunctionCode.jsp?op_code=<%=op_code%>";
		</script>		
<%			
	}
%>	
