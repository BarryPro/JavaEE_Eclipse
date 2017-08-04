<%
   /*
   * 功能: 提醒短信修改
　 * 版本: v2.0
　 * 日期: 2011/3/28
　 * 作者: ningtn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
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
		String opName = "提醒短信修改";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
<%
		/**以下为服务参数**/
		/* 0流水 */
		String iLoginAccept = sLoginAccept;
		/* 1 iOpCode */
		String iOpCode = opCode;
		/* 2 iLoginNo 修改者的loginno */
		String iLoginNo = workNo;
		/* 3 iLoginPasswd */
		String iLoginPasswd = pass;
		/* 4 iSystemNote 系统备注 */
		String iSystemNote = "";
		/* 5 iOpNote 操作备注 */
		String iOpNote = WtcUtil.repNull(request.getParameter("opNote"));
		/* 6 iIpAddr */
		String iIpAddr = WtcUtil.repNull(request.getRemoteAddr());
		/* 7 iMsgCode 短信代码 */
		String iMsgCode = WtcUtil.repNull(request.getParameter("msgCodeHide"));
		iMsgCode = iMsgCode.trim();
		/* 8 iBillType */
		String iBillType = "20";
		/* 9 iPromptType */
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptTypeHide"));
		/* 10 iPromptSeq */
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeqHide"));
		/* 11 iPrompCon 提醒内容 */
		String iPrompCon = WtcUtil.repNull(request.getParameter("sPromptContent"));
		/* 12 iIsPrint */
		String iIsPrint = "4";
		/* 13 iValidFlag */
		String iValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		/* 14 iModifyGroupId 修改者的groupid */
		String iModifyGroupId = groupId;
		/* 15 iIsCreaterStart 是否是创建者标识 */
		String iIsCreaterStart = WtcUtil.repNull(request.getParameter("sIsCreaterStart"));
		/* 16 iAuditLogin 审批者 */
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		/* 17 iChannelsCode */
		String iChannelsCode = "01";
		/**将服务参数压入数组**/
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
			rdShowMessageDialog("提醒短信修改申请已成功提交!",2);
			window.location.href = "fd286.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("提醒短信修改申请未能成功提交!服务代码:<%=retCode1%><br/>服务信息:<%=retMsg1%>");
			window.location.href = "fd286.jsp";
		</script>		
<%			
	}
%>	