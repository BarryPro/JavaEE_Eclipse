<%
   /*
   * 功能: 注意事项库修改-查询审批人信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *
   * 使用此页面前,请先查看业务逻辑是否正确
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 		String opCode = "9607";
 		String opName = "注意事项库修改";

		String groupId = (String)session.getAttribute("groupId");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		
		
		String getAuditLoginSql = "";
		
		/**如果是省级工号,就让其自己审批自己**/
		if(groupId.equals("10014")){
			getAuditLoginSql = "select login_no,login_name from dLoginMsg where group_id = '10014'";
		}else{
		
	 		getAuditLoginSql = "select login_no, login_name "
															 +" from dLoginMsg"
															 +" where login_no in"
															+" ("
															+" select a.login_no"
															            +" from sLoginPdomRelation a, sPopedomCode b"
															            +" where a.POPEDOM_CODE = b.POPEDOM_CODE"
															            +" and   b.PDT_CODE in ('03','05')"
															            +" and   a.end_date  >  sysdate"
															            +" and   b.REFLECT_CODE = '9614'"
															/*
															            +" union"
															+" select b.login_no"
																+" from sRolePdomRelation a, sLoginRoalRelation b,  sPopedomCode c"
																+" where  a.role_code = b.role_code" 
																+" and    a.POPEDOM_CODE = c.POPEDOM_CODE"
																+" and    c.REFLECT_CODE = '9614'"
																+" and    b.end_date > sysdate"
																*/
															+" )"
															+" and substr(login_no,1,1) between  'a' and  'm'"
															+" and group_id = ("
															+" select group_id from dChnGroupMsg where group_id" 
															 +" in (select parent_group_id from dChnGroupInfo  where group_id = '"+groupId+"' )"
															 +" and ROOT_DISTANCE = 2)";
															 
		}
	System.out.println("1111="+getAuditLoginSql);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getAuditLoginSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%		
		int totalNum = sVerifyTypeArr.length;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			//**解决iframe自适应大小的问题**/
			onload = function(){
				parent.document.getElementById('sAuditLoginInfoFrame').style.height=parent.document.sAuditLoginInfoFrame.document.body.scrollHeight+'px';	
			}
		
			//**复选框选中或者取消的主要事件**/
			function doChange(thisRadio){
				var auditLoginChecks = document.getElementsByName("auditLoginCheck");	
				var impCodeStr = "";
				var impNameStr = "";
				var regionLength = 0;
				for(var i=0;i<auditLoginChecks.length;i++){
					if(auditLoginChecks[i].checked){
						var impValue = auditLoginChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							impCodeStr = impArr[0];
							impNameStr = impArr[0]+" "+impArr[1];
						}
						regionLength++;
						if(regionLength>5){
							rdShowMessageDialog("最多只能选择5个审批人!");
							thisRadio.checked = false;
							break;
						}else{
							if(regionLength>1){
								impCodeStr += (","+impArr[0]);
								impNameStr += (","+impArr[0]+" "+impArr[1]);
							}	
						}
					}
				}
				
				//向父页面传值
				parent.document.all.sAuditLogins.value = impCodeStr;
				
				//让父窗口的父窗口的"提交修改"按钮可用
				parent.parent.document.all.confirmButton.disabled = false;
				//alert(impCodeStr);
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th width="15%" nowrap>选择</th>
				<th width="35%" nowrap>审批人工号</th>
				<th nowrap>审批人姓名</th> 
			</tr> 
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i=0;i<totalNum;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="checkbox" name="auditLoginCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>" onclick="doChange(this)">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
			<tr bgcolor="gray" height="20" align="center">
				<td colspan="3" nowrap>(注:最多能选择5个审核人,至少需要选择1个审核人)</td>
			</tr> 
  </table>
</div>
</body>
</html>    
