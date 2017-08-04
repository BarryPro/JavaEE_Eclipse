<%
   /*
   * 功能: 订购关系查询:注意事项库删除
　 * 版本: v2.0
　 * 日期: 2008/10/09
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
		 *@name						s9608Cfm1
		 *@description				注意事项增加
		 *@author					lugz
		 *@created	2008-10-10 14:06:47
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
		 *@inparam	sAuditLogin	审批人
		 *@output parameter information
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**以下为服务参数**/
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
	 /**将服务参数压入数组**/
   String [] inParas = new String[12];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = systemNote;
   inParas[5]  = "根据界面删除:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iPromptType;
   inParas[10] = iPromptSeq; 
   inParas[11] = "(参见sAuditLogin数组,未传此参数)"; 
		
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
			rdShowMessageDialog("注意事项库内容删除申请已成功提交!",2);
			window.location.href = "f9608_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库内容删除申请未能成功提交!服务代码:<%=retCode1%><br/>服务信息:<%=retMsg1%>");
			window.location.href = "f9608_1.jsp";
		</script>		
<%			
	}
%>
	