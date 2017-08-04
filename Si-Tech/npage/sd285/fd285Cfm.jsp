<%
   /*
   * 功能: 提醒短信增加
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
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
<%
		/**以下为服务参数**/
		/* 0操作流水 */
		String loginAccept = sLoginAccept;
		/* 1功能代码 */
		String opCode = "d285";
		/* 2操作工号 */
		String loginNo= workNo;
		/* 3经过加密的工号密码 */
		String loginPassword = pass;
		/* 4系统备注 */
		String systemNote = "";
		/* 5操作备注 */
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		/* 6IP地址 */
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		/* 7短信代码 */
		String sMsgCode = WtcUtil.repNull(request.getParameter("msgCode"));
		sMsgCode = sMsgCode.trim();
		System.out.println("----" + sMsgCode);
		/* 8票据类型 */
		String iBillType = "20";
		/* 9提示类型 */
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));
		/* 10提示序号 */
		String iPromptSeq = "1";
		/* 11发布来源 */
		String sReleaseGroup = WtcUtil.repNull(request.getParameter("sReleaseGroup"));
		/* 12发布动作类型,1,发布,2,收回,3,更新 */
		String iReleaseAction = WtcUtil.repNull(request.getParameter("iReleaseAction"));
		/* 13提示内容 */
		String sMsgContent = WtcUtil.repNull(request.getParameter("sMsgContent"));
		/* 14是否打印 */
		String sIsPrint = "4";
		/* 15有效标志 */
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		/* 16创建工号 */
		String sCreateLogin = WtcUtil.repNull(request.getParameter("sCreateLogin"));
		/* 17创建时间 */
		String sCreateTime = WtcUtil.repNull(request.getParameter("sCreateTime"));
		/* 18发布区域 */
		String sGroupIds = WtcUtil.repNull(request.getParameter("sGroupId"));
		/* 19生效时间 */
		String sValidTime = WtcUtil.repNull(request.getParameter("sValidTime"));
		/* 20失效时间 */
		String sInvalidTime = WtcUtil.repNull(request.getParameter("sInvalidTime"));
		/* 21审批人 */
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		/* 22渠道标识 */
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		System.out.println("========== ningtn ====" + sGroupIds + "|" + sAuditLogins);
		/** 提交服务前的验证 **/
		if(sMsgCode.trim().equals("")){
%>
			<script type="text/javascript">
				<!--
				alert("短信代码不能为空!");
				history.go(-1);
				//-->
			</script>
<%
			return;
		}else{
		
		}
%>
<%
		/* 开始提交服务 */
		/**根据分隔符将参数转化成数组**/
		String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		/**获得提示序号**/
		String queryOldPromptSeqSql = "select nvl(max(prompt_seq),0)+1 from sFuncPrompt where 1=1 ";
		if(!"".equals(sMsgCode)){
			queryOldPromptSeqSql += " and function_code = '"+sMsgCode+"'";
		}
		//System.out.println("##################fd285Cfm.jsp->queryOldPromptSeqSql->"+queryOldPromptSeqSql);					
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=queryOldPromptSeqSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
		if(retCode2.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				iPromptSeq = sVerifyTypeArr[0][0];
				System.out.println("##################f9605Cfm.jsp->iPromptSeq->"+iPromptSeq);					
			}
		}
		/**将服务参数压入数组**/
		String [] inParas = new String[23];
		inParas[0] = loginAccept;
		inParas[1] = opCode;
		inParas[2] = loginNo;
		inParas[3] = loginPassword;
		inParas[4] = systemNote;
		inParas[5] = opNote;
		inParas[6] = ipAddr;
		inParas[7] = sMsgCode;
		inParas[8] = iBillType;
		inParas[9] = iPromptType;
		inParas[10] = "1";
		inParas[11] = sReleaseGroup;
		inParas[12] = iReleaseAction;
		inParas[13] = sMsgContent;
		inParas[14] = sIsPrint;
		inParas[15] = sValidFlag;
		inParas[16] = sCreateLogin;
		inParas[17] = sCreateTime;
		inParas[19] = sValidTime;
		inParas[20] = sInvalidTime;
		inParas[22] = Channels_Code;
%>
	<wtc:service name="sd285Cfm" routerKey="region" routerValue="<%=regionCode%>" 
		 retcode="retCode3" retmsg="retMsg3" outnum="1" >
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
		<wtc:param value="<%=inParas[16]%>"/>
		<wtc:param value="<%=inParas[17]%>"/>
		<wtc:params value="<%=sGroupId%>"/>
		<wtc:param value="<%=inParas[19]%>"/>
		<wtc:param value="<%=inParas[20]%>"/>
		<wtc:params value="<%=sAuditLogin%>"/>
		<wtc:param value="<%=inParas[22]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode3.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("提醒短信增加申请已成功提交!",2);
			window.location.href = "fd285.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("提醒短信增加申请未能成功提交!服务代码:<%=retCode3%><br/>服务信息:<%=retMsg3%>");
			window.location.href = "fd285.jsp";
		</script>		
<%			
	}
%>	