<%
   /*
   * 功能: 注意事项库修改-按照"操作功能代码修改"的提交页面
　 * 版本: v2.0
　 * 日期: 2008/10/13
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
	<%@ page contentType= "text/html;charset=gb2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>	
<%
		/**来自session的固定数据**/
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/*@service information
		 *@name						s9607Cfm1
		 *@description				注意事项库的修改
		 *@author					lugz
		 *@created	2008-10-10 9:05:18
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
		 *@inparam	opCode			功能代码	
		 *@inparam	loginNo			操作工号
		 *@inparam	loginPasswd		经过加密的工号密码
		 *@inparam	systemNote		系统备注
		 *@inparam	opNote			操作备注
		 *@inparam	ipAddr			IP地址
		 
		 *@inparam	sFunctionCode	提示操作功能
		 *@inparam	iBillType	票据类型
		 *@inparam	iPromptType	提示类型
		 *@inparam	iPromptSeq	提示序号
		 *@inparam	sPromptContent	提示内容
		 *@inparam	sIsPrint	是否打印
		 *@inparam	sValidFlag	有效标志
		 *@inparam	sModifyGroupId 修改节点
		 *@inparam	sIsCreaterStart Y/N
		 *@inparam	sAuditLogin	审批人
		 
		 *@output parameter information		
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO 
		 */
		 
		/**以下为服务参数**/
		String loginAccept = "0";
		String opCode = "9607";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = "无";
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
		opNote = "用户根据界面修改:"+opNote;
		if(opNote.length()>60){
			opNote = opNote.substring(0,60);
		}
		
		/**根据分隔符将参数转化成数组**/
		String [] sAuditLogin = sAuditLogins.split(",");
		
		for(int i=0;i<sAuditLogin.length;i++){
			System.out.println("##################f9607_oprCfm.jsp->s9607Cfm1->sAuditLogin["+i+"]->"+sAuditLogin[i]);
		}
		
	 /**将服务参数压入数组**/
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
   inParas[16] = "参见数组sAuditLogin";
		
	 /**打印服务参数,测试后请可删除这个**/	
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
			rdShowMessageDialog("注意事项库内容修改申请已成功提交!",2);
			window.location.href = "f9607_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库内容修改申请未能成功提交!服务代码:<%=retCode1%><br/>服务信息:<%=retMsg1%>");
			window.location.href = "f9607_1.jsp";
		</script>		
<%			
	}
%>	
	