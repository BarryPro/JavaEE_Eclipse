<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d289";
 		String opName = "提醒短信审核记录查询";

		/**需要regionCode来做服务的路由**/
		String regionCode  = (String)session.getAttribute("regCode");
		
		
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
											+" login_accept, b.audit_flag_name"
											+" FROM dpromptaudit a,sauditflag b"
											+" WHERE audit_accept = '"+create_accept+"'"
											+" and a.audit_flag = b.audit_flag";
		System.out.println("#######getInfoSql322->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="8"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
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
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>审批流水</th>
				<th nowrap>是否通过</th> 
				<th nowrap>审批人</th>
				<th nowrap>审核时间</th> 
				<th nowrap>审核意见</th>
				<th nowrap>是否已审核</th> 
				<th nowrap>审批人操作流水</th>
				<th nowrap>审核类型</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>">
								<%
								System.out.println("===========sVerifyTypeArr[i][5]"+sVerifyTypeArr[i][5]);
									if (sVerifyTypeArr[i][5].equals("是"))
									{
										if (sVerifyTypeArr[i][1].equals("Y"))
										{
											out.print("审核通过");
										}
									else
										{
											out.print("审核不通过");
										}
									}
								else
									{
											out.print("待审核");
									}
								%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    

