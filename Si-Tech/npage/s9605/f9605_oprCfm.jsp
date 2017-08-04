<%
   /*
   * 功能: 订购关系查询:注意事项库增加
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
		 *@name						s9605Cfm1
		 *@description				注意事项增加
		 *@author					lugz
		 *@created	2008-10-07 17:13:21
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
		 *@inparam	sReleaseGroup 发布来源
		 *@inparam	iReleaseAction 发布动作类型
		 *@inparam	sPromptContent	提示内容
		 *@inparam	sIsPrint	是否打印
		 *@inparam	sValidFlag	有效标志
		 *@inparam	sCreateLogin	创建工号
		 *@inparam	sCreateTime	创建时间
		 *@inparam	sGroupId		发布节点
		 *@inparam	sValidTime 生效时间
		 *@inparam	sInvalidTime 失效时间
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
		String opCode = "9605";
		String loginNo= workNo;
		String loginPassword = pass;
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String ipAddr = WtcUtil.repNull(request.getRemoteAddr());
		
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType"));
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));
		String iPromptSeq = "0";
		String sReleaseGroup = WtcUtil.repNull(request.getParameter("sReleaseGroup"));
		String iReleaseAction = WtcUtil.repNull(request.getParameter("iReleaseAction"));
		String sPromptContent = WtcUtil.repNull(request.getParameter("sPromptContent"));
		String sIsPrint = WtcUtil.repNull(request.getParameter("sIsPrint"));
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag"));
		String sCreateLogin = WtcUtil.repNull(request.getParameter("sCreateLogin"));
		String sCreateTime = WtcUtil.repNull(request.getParameter("sCreateTime"));
		String sGroupIds = WtcUtil.repNull(request.getParameter("sGroupId"));
		String sValidTime = WtcUtil.repNull(request.getParameter("sValidTime"));
		String sInvalidTime = WtcUtil.repNull(request.getParameter("sInvalidTime"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		
		/**检查一下输入的操作模块代码存在否.根据操作模块代码增加的,模块代码不能为"ALL"或者空**/
		if(sFunctionCode.trim().equals("")){
%>
			<script type="text/javascript">
				<!--
				alert("操作模块代码不能为空!");
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
						alert("操作模块代码不存在,请重新输入!");
						history.go(-1);
						//-->
					</script>
<%	
					return;			
				}
			}				
		}
		
		/**根据分隔符将参数转化成数组**/
		String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		
		/**获得提示序号**/
		String queryOldPromptSeqSql = "select nvl(max(prompt_seq),0)+1 from sFuncPrompt where 1=1 ";
		if(!"".equals("sFunctionCode")){
			queryOldPromptSeqSql += " and function_code = '"+sFunctionCode+"'";
		}
		if(!"".equals(iBillType)){
			queryOldPromptSeqSql += " and bill_type = '"+iBillType+"'";
		}
		if(!"".equals(iPromptType)){
			queryOldPromptSeqSql += " and prompt_type = '"+iPromptType+"'";
		}
		//System.out.println("##################f9605_oprCfm.jsp->s9605Cfm1->queryOldPromptSeqSql->"+queryOldPromptSeqSql);					
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=queryOldPromptSeqSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
		if(retCode1.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				iPromptSeq = sVerifyTypeArr[0][0];
				System.out.println("##################f9605_oprCfm.jsp->s9605Cfm1->iPromptSeq->"+iPromptSeq);					
			}
		}		
	 /**将服务参数压入数组**/
   String [] inParas = new String[22];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = "";
   inParas[5]  = "根据界面增加:"+opNote;
   inParas[6]  = ipAddr;
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iPromptType;
   inParas[10] = iPromptSeq; 
   inParas[11] = sReleaseGroup; 
   inParas[12] = iReleaseAction;
   inParas[13] = sPromptContent;
   inParas[14] = sIsPrint;
   inParas[15] = sValidFlag;
   inParas[16] = sCreateLogin; 
   inParas[17] = sCreateTime;
   inParas[18] = "(参见sGroupId数组,未传此参数)";
   inParas[19] = sValidTime;
   inParas[20] = sInvalidTime;
   inParas[21] = "(参见sAuditLogin数组,未传此参数)";
		
%>
	<wtc:service name="s9605Cfm1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
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
	<wtc:param value="<%=Channels_Code%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	if(retCode2.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库内容增加申请已成功提交!",2);
			window.location.href = "f9605_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库内容增加申请未能成功提交!服务代码:<%=retCode2%><br/>服务信息:<%=retMsg2%>");
			window.location.href = "f9605_1.jsp";
		</script>		
<%			
	}
%>	