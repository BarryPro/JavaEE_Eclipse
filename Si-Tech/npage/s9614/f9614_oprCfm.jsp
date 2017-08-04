<%
   /*
   * 功能: 注意事项库审批
　 * 版本: v2.0
　 * 日期: 2008/10/14
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
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		/*@service information
		 *@name						s9614Cfm1
		 *@description				审核的是操作代码 
		 *@author					lugz
		 *@created	2008-10-8 13:01:58
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
		 
		 *@inparam	sAuditAccept	审批流水
		 *@inparam	sIsAuditPass 	Y/N
		 *@inparam	sAuditSuggestion 审批意见
		 *@inparam	sIsAudit	是否已经审核 Y/N
		 
		 *@output parameter information
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**以下为服务参数**/
		String loginAccept = sLoginAccept;
		String opCode = "9614";
		String loginNo= workNo;
		String loginPassword = pass;
		String systemNote = "无";
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String sIsAuditPass = WtcUtil.repNull(request.getParameter("sIsAuditPass"));
		String sAuditSuggestion = WtcUtil.repNull(request.getParameter("sAuditSuggestion"));
		
	 /**将服务参数压入数组**/
   String [] inParas = new String[10];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = "根据界面审批:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sAuditAccept;
   inParas[8] = sIsAuditPass;
   inParas[9] = sAuditSuggestion;
		
	 /**打印服务参数,测试后请可删除这个**/	
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
			rdShowMessageDialog("注意事项库审批成功!",2);
			window.location.href = "f9614_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库审批未能成功!服务代码:<%=retCode1%><br/>服务信息:<%=retMsg1%>");
			window.location.href = "f9614_1.jsp";
		</script>		
<%			
	}
%>
	
