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
		 *@name						s9645Cfm
		 *@description				ע���������Ϣ����
		 *@author					gonght
		 *@created	2009-5-20 16:44:01
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		��ˮ	�������룬������������ڷ�����ȡ��ˮ
		 *@inparam	opCode			���ܴ���	
		 *@inparam	loginNo			��������  									  
		 *@inparam	loginPasswd		�������ܵĹ�������          
		 *@inparam	loginName			����Ա����
		 *@inparam	systemNote		ϵͳ��ע                    
		 *@inparam	opNote			������ע                      
		 *@inparam	ipAddr			IP��ַ                        
		 *@inparam	sOpTime     ����ʱ��                                
		 *@inparam	sPhoneNo		����Ա�ֻ���
		 *@inparam	sFunctionCode	��������                                  
		 *@inparam	sFunctionName	��������                                         
		 *@inparam	sAdviceContent	��������                 
	 
		 *@output parameter information
		 *@outparam	loginAccept		��ˮ	�����ڷ��������ɵ���ˮ����ԭ�������ˮ
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**����Ϊ�������**/
		String loginAccept = sLoginAccept;
		String opCode = "9645";
		String loginPassword = pass;
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String loginNo = WtcUtil.repNull(request.getParameter("sCreateLogin"));
		String loginName = WtcUtil.repNull(request.getParameter("sCreateName"));		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode"));
		String sFunctionName = WtcUtil.repNull(request.getParameter("sFunctionName"));
		String sPhoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String sOpTime = WtcUtil.repNull(request.getParameter("sCreateTime"));
		String sAdviceContent = WtcUtil.repNull(request.getParameter("sAdviceContent"));
		String sGroupId = WtcUtil.repNull(request.getParameter("sGroupId"));
					
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
		/*String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		*/
		
	  /**���������ѹ������**/
   String [] inParas = new String[13];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = loginName;
   inParas[5]  = opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sOpTime;
   inParas[8]  = sPhoneNo;
   inParas[9] = sFunctionCode;
   inParas[10] = sFunctionName;
   inParas[11] = sGroupId; 
   inParas[12] = sAdviceContent;  
		
%>
	<wtc:service name="s9645Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
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
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode2.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("ע������⽨����Ϣ�ѳɹ��ύ!",2);
			window.location.href = "f9645_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("ע������⽨����Ϣδ�ܳɹ��ύ!�������:<%=retCode2%><br/>������Ϣ:<%=retMsg2%>");
			window.location.href = "f9645_1.jsp";
		</script>		
<%			
	}
%>	
