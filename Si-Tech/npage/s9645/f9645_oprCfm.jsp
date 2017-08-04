<%
   /*
   * 功能: 订购关系查询:注意事项建议信息增加
　 * 版本: v1.0
　 * 日期: 2009-5-20 16:44:39
　 * 作者: gonght
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
	<%@ page contentType= "text/html;charset=GBK" %>
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
		 *@name						s9645Cfm
		 *@description				注意事项建议信息增加
		 *@author					gonght
		 *@created	2009-5-20 16:44:01
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		流水	可以输入，如果不输入则在服务中取流水
		 *@inparam	opCode			功能代码	
		 *@inparam	loginNo			操作工号  									  
		 *@inparam	loginPasswd		经过加密的工号密码          
		 *@inparam	loginName			操作员姓名
		 *@inparam	systemNote		系统备注                    
		 *@inparam	opNote			操作备注                      
		 *@inparam	ipAddr			IP地址                        
		 *@inparam	sOpTime     操作时间                                
		 *@inparam	sPhoneNo		操作员手机号
		 *@inparam	sFunctionCode	操作代码                                  
		 *@inparam	sFunctionName	操作名称                                         
		 *@inparam	sAdviceContent	建议内容                 
	 
		 *@output parameter information
		 *@outparam	loginAccept		流水	返回在服务中生成的流水，或还原传入的流水
		 *@return SVR_ERR_NO 
		 */
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%
		/**以下为服务参数**/
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
		/*String [] sGroupId = sGroupIds.split(",");
		String [] sAuditLogin = sAuditLogins.split(",");
		*/
		
	  /**将服务参数压入数组**/
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
			rdShowMessageDialog("注意事项库建议信息已成功提交!",2);
			window.location.href = "f9645_1.jsp";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库建议信息未能成功提交!服务代码:<%=retCode2%><br/>服务信息:<%=retMsg2%>");
			window.location.href = "f9645_1.jsp";
		</script>		
<%			
	}
%>	
