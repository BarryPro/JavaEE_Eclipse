<%
   /*
   * 功能: 审核记录查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: yangrq
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9616";
 		String opName = "审核记录查询";

		/**需要regionCode来做服务的路由**/
		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arrSession.get(0);
		String orgCode = baseInfo[0][16];
		String regionCode = orgCode.substring(0,2);
		String groupId = baseInfo[0][21];
		String workNo = baseInfo[0][2];
		/** 
		 	*@inparam			audit_accept 审批流水
			*@inparam			op_time_begin      操作时间（创建时间、或修改时间）
			*@inparam			op_time_end      操作时间（创建时间、或修改时间）
			*@inparam			op_code      操作代码
			*@inparam			bill_type    票据类型
			*@inparam			prompt_type  提示类型
			*@inparam			login_no     发起人工号：（创建人、修改人、删除人）
		 **/
		String create_accept = WtcUtil.repNull(request.getParameter("create_accept"));
		String getInfoSql = "SELECT audit_accept, is_pass, "
											+"  audit_login, change_audit_date,"
											+"  decode(audit_suggestion,'NULL','空',audit_suggestion), "
											+" decode(is_audit,'Y','是','N','否',is_audit), "
											+" login_accept, b.audit_flag_name,login_name"
											+" FROM dpromptaudit a,sauditflag b,dloginmsg c"
											+" WHERE audit_accept = '"+create_accept+"'"
											+" and a.audit_flag = b.audit_flag"
											+" and a.audit_login = c.login_no";
		System.out.println("#######getInfoSql322->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="8"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
System.out.println("#######getInfoSql322->"+getInfoSql);
System.out.println("11sVerifyTypeArr.length=" + sVerifyTypeArr.length);	
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			/*function doChange(){
				var regionRadios = document.getElementById("regionRadio");	
				if(regionRadios.checked){
					alert(regionRadios.checked)
					var radioValue = regionRadios.value;
					parent.document.getElementById("qryFieldAuditInfoFrame").style.display = "block";
					parent.document.qryFieldAuditInfoFrame.location = "f9616_getPromptAuditByClassCode.jsp?create_accept="+radioValue;
				}
			}*/
		//-->
	</script>
	<!--调用css-->
	<link href="/css/jl.css" rel="stylesheet" type="text/css">
</head>
<body bgColor=#FFFFFF leftmargin="0" topmargin="0px" background="/images/jl_background_2.gif">
	<div id="Operation_Table">
     <table  bgcolor="#FFFFFF" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
			<tr bgcolor='649ECC' height=25 align="center">
				<td nowrap>选择</td>
				<td nowrap>审批流水</td>
				<td nowrap>是否通过</td> 
				<th nowrap>审批工号</th>
				<th nowrap>审批人</th>
				<td nowrap>审核时间</td> 
				<td nowrap>审核意见</td>
				<td nowrap>是否已审核</td> 
				<td nowrap>审批人操作流水</td>
				<td nowrap>audit_flag</td>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr bgcolor='#EEEEEE' height='25' align='center'><td colspan='11'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				for(int i=0;i<sVerifyTypeArr.length;i++){
	%>
						<tr bgcolor="E8E8E8" align="center">
							<td>
								<input type="radio" name="regionRadio" id="regionRadio" value="<%=sVerifyTypeArr[i][3]%>" onclick="doChange()">	
							</td>
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td>
								<%
								System.out.println("===========sVerifyTypeArr[i][5]"+sVerifyTypeArr[i][5]);
									if (sVerifyTypeArr[i][5].equals("是"))
									{
											if (sVerifyTypeArr[i][1].equals("Y"))
											{
												out.println("审核通过");
											}
										else
											{
												out.println("审核不通过");
											}
									}
								else
									{
											out.println("待审核11");
									}
								%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    

