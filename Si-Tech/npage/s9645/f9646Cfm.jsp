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
		 *@name						s9646Cfm
		 *@description				注意事项建议信息增加
		 *@author					gonght
		 *@created	2009-5-22 14:31:59
		 *@version %I%, %G%
		 *@since 1.00
		 *@input parameter information
		 *@inparam	loginAccept		流水	创建建议信息时生成的流水
		 *@inparam	opCode			功能代码	
		 *@inparam	workNo			操作工号  									  
		 *@inparam	loginPasswd		经过加密的工号密码                           
		 *@inparam	opNote			操作备注                      
		 *@inparam	ipAddr			IP地址                        
		 *@inparam	sFunctionCode   功能代码                                	                
	 
		 *@output parameter information
		 *@return SVR_ERR_NO 
		 */
		 
		/**以下为服务参数**/
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
	 /**将服务参数压入数组**/
   String [] inParas = new String[6];
   inParas[0]  = "(参见loginAccept数组,未传此参数)";
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
			//rdShowMessageDialog("注意事项库建议信息查询操作完成!",2);
			window.location.href = "f9646_getAuditByFunctionCode.jsp?op_code=<%=op_code%>";
		</script>
<%	
	}else{
%>
		<script language="javascript">
			rdShowMessageDialog("注意事项库建议信息查询操作未完成!服务代码:<%=retCode2%><br/>服务信息:<%=retMsg2%>");
			window.location.href = "f9646_getAuditByFunctionCode.jsp?op_code=<%=op_code%>";
		</script>		
<%			
	}
%>	
