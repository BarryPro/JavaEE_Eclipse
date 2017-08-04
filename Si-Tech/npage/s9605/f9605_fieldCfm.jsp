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
		 *@name						s9605Cfm2
		 *@description				注意事项增加
		 *@author					lugz
		 *@created	2008-10-8 13:01:58
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
		 *@inparam	opCode			功能代码	
		 *@inparam	loginNo			操作工号
		 *@inparam	loginPasswd		经过加密的工号密码
		 *@inparam	opNote			操作备注
		 *@inparam	ipAddr			IP地址
		 
		 
		 *@inparam	sFunctionCode	提示操作功能
		 *@inparam	iBillType	票据类型
		 *@inparam	iClassSeq	输出顺序
		 *@inparam	iClassCode	代码
		 *@inparam	sClassValue	字段域值
		 *@inparam	sIsByValue	是否按照代码提示
		 *@inparam	sLimitRule	前项限制
		
		 *@inparam	iPromptType	提示类型
		 *@inparam	iPromptSeq	提示序号
		 *@inparam	sReleaseGroup 发布来源
		 *@inparam	iReleaseAction 发布动作类型
		 *@inparam	sGroupId		发布节点
		 *@inparam	sPromptContent	提示内容
		 *@inparam	sIsPrint	是否打印
		 *@inparam	sValidFlag	有效标志
		 *@inparam	sCreateLogin	创建工号
		 *@inparam	sCreateTime	创建时间
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
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode2"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType2"));
		String iClassSeq = WtcUtil.repNull(request.getParameter("iClassSeq"));
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String sClassValue = WtcUtil.repNull(request.getParameter("sClassValue"));
		String sIsByValue = WtcUtil.repNull(request.getParameter("sIsByValue"));
		String sLimitRule = WtcUtil.repNull(request.getParameter("sLimitRule"))==""?"1":WtcUtil.repNull(request.getParameter("sLimitRule"));//@ 081015 还没有这个的准确定义,先不管
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType2"));
		String iPromptSeq = "";
		String sReleaseGroup = WtcUtil.repNull(request.getParameter("sReleaseGroup2"));
		String iReleaseAction = WtcUtil.repNull(request.getParameter("iReleaseAction2"))==""?"1":WtcUtil.repNull(request.getParameter("iReleaseAction2"));  //1发布,2收回,3更新
		String sGroupIds = WtcUtil.repNull(request.getParameter("sGroupId"));
		String sPromptContent = WtcUtil.repNull(request.getParameter("sPromptContent2"));
		String sIsPrint = WtcUtil.repNull(request.getParameter("sIsPrint2"));
		String sValidFlag = WtcUtil.repNull(request.getParameter("sValidFlag2"));
		String sCreateLogin = WtcUtil.repNull(request.getParameter("sCreateLogin2"));
		String sCreateTime = WtcUtil.repNull(request.getParameter("sCreateTime2"));
		String sValidTime = WtcUtil.repNull(request.getParameter("sValidTime2"));
		String sInvalidTime = WtcUtil.repNull(request.getParameter("sInvalidTime2"));
		String sAuditLogins = WtcUtil.repNull(request.getParameter("sAuditLogins"));
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code2"));
		
		/**检查一下输入的操作模块代码是否存在.根据业务增加的,模块代码可以为"ALL",但不能为空**/
		if(sFunctionCode.trim().equals("")){
%>
			<script type="text/javascript">
				<!--
				alert("操作模块代码不能为空!");
				window.location.href = "f9605_1.jsp?confirmFlag=fieldPromptConfirm";
				//-->
			</script>
<%
			return;
		}else{
			/**根据业务增加的,模块代码可以为"ALL"**/
			if(sFunctionCode.equalsIgnoreCase("all")){
				/**服务要求是大写的"ALL",防止页面传入的不是大写**/
				sFunctionCode = sFunctionCode.toUpperCase();
			}else{
				String checksFunctionCodeSql="select 1 from sfunccode where function_code = '"+sFunctionCode+"' and rownum=1";
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
						window.location.href = "f9605_1.jsp?confirmFlag=fieldPromptConfirm";
						//-->
					</script>
<%	
					return;			
					}
				}
			}				
		}		
		
		/**根据分隔符将参数转化成数组**/
		String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		
		/**获得提示序号**/
		String queryOldPromptSeqSql = "select nvl(max(prompt_seq),0)+1 from sDomainPrompt where 1=1 ";
		if(!"".equals("sFunctionCode")){
			queryOldPromptSeqSql += " and op_code = '"+sFunctionCode+"'";
		}
		if(!"".equals(iBillType)){
			queryOldPromptSeqSql += " and bill_type = '"+iBillType+"'";
		}
		if(!"".equals(iPromptType)){
			queryOldPromptSeqSql += " and prompt_type = '"+iPromptType+"'";
		}	
		if(!"".equals(iClassCode)){
			queryOldPromptSeqSql += " and class_code = '"+iClassCode+"'";
		}
		if(!"".equals(sClassValue)){
			queryOldPromptSeqSql += " and class_value = '"+sClassValue+"'";
		}					
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=queryOldPromptSeqSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
		if(retCode1.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				iPromptSeq = sVerifyTypeArr[0][0];
				System.out.println("##################f9605_fieldCfm.jsp->s9605Cfm2->iPromptSeq->"+iPromptSeq);					
			}
		}
				
	 /**将服务参数压入数组**/
   String [] inParas = new String[27];
   inParas[0]  = loginAccept;
   inParas[1]  = opCode;
   inParas[2]  = loginNo;
   inParas[3]  = loginPassword;
   inParas[4]  = "";
   inParas[5]  = "根据业务增加:"+opNote;
   inParas[6]  = ipAddr;  
   inParas[7] = sFunctionCode;
   inParas[8] = iBillType;
   inParas[9] = iClassSeq;
   inParas[10] = iClassCode;
   inParas[11] = sClassValue;
   inParas[12] = sIsByValue;
   inParas[13] = sLimitRule;
   inParas[14] = iPromptType;
   inParas[15] = iPromptSeq; 
   inParas[16] = sReleaseGroup; 
   inParas[17] = iReleaseAction;
   inParas[18] = "(参见sGroupId数组,未传此参数)";
   inParas[19] = sPromptContent;
   inParas[20] = sIsPrint;
   inParas[21] = sValidFlag;
   inParas[22] = sCreateLogin; 
   inParas[23] = sCreateTime;
   inParas[24] = sValidTime;
   inParas[25] = sInvalidTime;
   inParas[26] = "(参见sAuditLogin数组,未传此参数)";
		
%>
	<wtc:service name="s9605Cfm2" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
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
	<wtc:param value="<%=inParas[21]%>"/>
	<wtc:param value="<%=inParas[22]%>"/>
	<wtc:param value="<%=inParas[23]%>"/>
	<wtc:param value="<%=inParas[24]%>"/>
	<wtc:param value="<%=inParas[25]%>"/>
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
	
