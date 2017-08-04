<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 注意事项库修改-根据地段代码查询需要修改的信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可修改**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9607";
 		String opName = "注意事项库修改";

		/**需要regionCode来做服务的路由**/
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
		
		/**创建一个空的全局数组**/
		String [][]impResultArr = new String[][]{};	
		String [][] impGroupIdInfo = new String [][]{};	
		
		/**sIsCreaterStartFlag,0表示既不可以是创建人修改,又不可以是修改人修改;1,只能是以修改人修改;2,既可以是创建人修改,又可以是修改人修改**/
		String sIsCreaterStartFlag = "0";
		String createLogin = WtcUtil.repNull(request.getParameter("createLogin"));
		
		String createLoginRotSql = "select msg.root_distance from dchngroupmsg msg,dloginmsg a " 
					+ " where a.login_no='" + createLogin + "' and a.group_id = msg.group_id";
		String createLoginRoot = "";
		System.out.println(" $$$$$$ ningtn $$$$$$ " + createLoginRotSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=createLoginRotSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="result_t"  scope="end"/>
<%
		createLoginRoot = result_t[0][0];
		
		/**1.判断工号的级别,如果root_distance==1,省级,==2,地市,>2,地市或者更小的级别**/
		String loginRootDistanceValue = WtcUtil.repNull(request.getParameter("loginRootDistance"));
		int loginRootDistance = 999999;
		if(!loginRootDistanceValue.equals("")){
			loginRootDistance = Integer.parseInt(loginRootDistanceValue);
		}
		
		/**创建流水**/
		String createAccept = WtcUtil.repNull(request.getParameter("createAccept"));
		
		/**如果工号的级别只是区县的或者比区县更小**/
		if(loginRootDistance>2){
			//String getInfoSql = "select distinct(create_accept),op_code,bill_type,class_seq,class_code,class_value,is_by_value,limit_rule,prompt_type,prompt_seq,prompt_content,is_print,valid_flag,create_login,create_time from sDomainPromptRelease where 1=1 ";
			
			
			String getInfoSql = "SELECT DISTINCT (a.create_accept), b.op_code, b.bill_type, b.class_seq, b.class_code,"
											+"  b.class_value, b.is_by_value, b.limit_rule, b.prompt_type, b.prompt_seq,"
											+"  b.prompt_content, b.is_print, b.valid_flag, b.create_login,"
											+" b.create_time"
											+" FROM sdomainpromptrelease a,sdomainprompt b"
											+" WHERE a.class_code = b.class_code"
											+" and a.op_code = b.op_code"
											+" and a.class_value = b.class_value"
											+" and b.bill_type = a.bill_type"
											+" and b.prompt_type = a.prompt_type"
											+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}		
			getInfoSql += " and a.release_group != '10014'";//区县级工号，不能修改省级工号发布的内容。
			getInfoSql +=" AND a.group_id = (SELECT parent_GROUP_ID FROM dchngroupinfo a, dchngroupmsg b WHERE a.parent_group_id = b.group_id and a.group_id='"+groupId+"' and b.root_distance = 3)";

%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="15"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
		impResultArr = sVerifyTypeArr;	
		//取得发布节点名称
		String getGroupIdNameSql = "select a.group_id,b.group_name from sDomainPromptRelease a,dchngroupmsg b where a.group_id=b.group_id and  create_accept = '"+createAccept.trim()+"' AND a.group_id = (SELECT parent_GROUP_ID FROM dchngroupinfo a, dchngroupmsg b WHERE a.parent_group_id = b.group_id and a.group_id='"+groupId+"' and b.root_distance = 3)";
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="2"> 
		<wtc:sql><%=getGroupIdNameSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="getGroupIdNameArr"  scope="end"/>
<%		
		impGroupIdInfo = getGroupIdNameArr;		
		}



		/**如果工号的级别是地市的**/
		if(loginRootDistance==2){
			String getInfoSql = "SELECT DISTINCT (a.create_accept), b.op_code, b.bill_type, b.class_seq, b.class_code,"
											+"  b.class_value, b.is_by_value, b.limit_rule, b.prompt_type, b.prompt_seq,"
											+"  b.prompt_content, b.is_print, b.valid_flag, b.create_login,"
											+" b.create_time"
											+" FROM sdomainpromptrelease a,sdomainprompt b"
											+" WHERE a.class_code = b.class_code"
											+" and a.op_code = b.op_code"
											+" and a.class_value = b.class_value"
											+" and b.bill_type = a.bill_type"
											+" and b.prompt_type = a.prompt_type"
											+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}		
			getInfoSql +=" AND a.GROUP_ID in (SELECT GROUP_ID FROM dchngroupinfo WHERE parent_GROUP_ID='"+groupId+"')";
			
			System.out.println("#######loginRootDistance->"+loginRootDistance+"&&&&&getInfoSql->222222222"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="15"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		
		impResultArr = sVerifyTypeArr;
		
		/**取得发布节点名称**/
		String getGroupIdNameSql = " SELECT DISTINCT a.release_group, b.group_name"
																+" FROM sDomainPromptRelease a, dchngroupmsg b"
																+" WHERE a.release_group = b.GROUP_ID"
																+" AND create_accept = '"+createAccept.trim()+"'"
																+" AND a.create_login = '"+workNo+"'"
																+" union"
																+" SELECT DISTINCT '"+groupId+"',b.group_name"
																+" FROM sDomainPromptRelease a,dchngroupmsg b"
																+" WHERE create_accept = '"+createAccept.trim()+"'"
																+"   AND a.create_login!='"+workNo+"'"
																+" and b.GROUP_ID='"+groupId+"'";
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="2"> 
		<wtc:sql><%=getGroupIdNameSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="getGroupIdNameArr"  scope="end"/>
<%		
		System.out.println("getGroupIdNameSql->"+getGroupIdNameSql);
		impGroupIdInfo = getGroupIdNameArr;
		
				if(createLogin.equals(workNo)){
					sIsCreaterStartFlag = "2";
				}else{
					sIsCreaterStartFlag = "1";
				}
		}	



		/**如果工号的级别是省级的或者国家级别的,则没有任何限制了**/
		if(loginRootDistance<2){
				String getInfoSql = "SELECT DISTINCT (a.create_accept), b.op_code, b.bill_type, b.class_seq, b.class_code,"
											+"  b.class_value, b.is_by_value, b.limit_rule, b.prompt_type, b.prompt_seq,"
											+"  b.prompt_content, b.is_print, b.valid_flag, b.create_login,"
											+" b.create_time"
											+" FROM sdomainpromptrelease a,sdomainprompt b"
											+" WHERE a.class_code = b.class_code"
											+" and a.op_code = b.op_code"
											+" and a.class_value = b.class_value"
											+" and b.bill_type = a.bill_type"
											+" and b.prompt_type = a.prompt_type"
											+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}			
			System.out.println("#######loginRootDistance->"+loginRootDistance+"&&&&&getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="15"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		
		impResultArr = sVerifyTypeArr;
		//取得发布节点名称
		String getGroupIdNameSql = "select distinct a.release_group,b.group_name from sDomainPromptRelease a,dchngroupmsg b where a.release_group=b.group_id and  create_accept = '"+createAccept.trim()+"'";
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="2"> 
		<wtc:sql><%=getGroupIdNameSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="getGroupIdNameArr"  scope="end"/>
<%		
		System.out.println("getGroupIdNameSql->"+getGroupIdNameSql);
		impGroupIdInfo = getGroupIdNameArr;			
		}	
%>

<%
	/**如果impResultArr为空,则表示sDomainPromptRelease中没有记录
		*(或者sDomainPromptRelease表中数据有问题,请注意;
		*因为前一个页面已经选取了表sFuncPrompt中数据,表明表sDomainPrompt中是有此条记录的;)
	**/
	if(impResultArr==null||impResultArr.length==0){
%>
				<script language="javascript">
					<!--
					parent.document.all.confirmButton.disabled = true;
					//-->
				</script>	
<%	
		return;
	}
%>


<!--如果是营业厅级别,则已经在前面的一个页面给过滤了;如果是区县,只能是修改人;如果是地市,可能是创建人;如果省,创建人-->

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			onload = function(){
				var loginRootDistance = <%=loginRootDistance%>;
				var impResultArr = new Array();	
				<%
					if(impResultArr!=null){
						if(impResultArr.length>0){
							for(int i=0;i<impResultArr.length;i++){
				%>
								var temResultArr = new Array();
				<%
								for(int j=0;j<impResultArr[i].length;j++){
				%>
									temResultArr[<%=j%>] = "<%=impResultArr[i][j].replaceAll("\r\n","")%>";
				<%				
								}
				%>
								impResultArr[<%=i%>]=temResultArr;
				<%
							}	
						}
					}
				%>
				if(impResultArr==null||impResultArr.length==0){
					alert("未能取到任何值,不能进行修改操作!");
					parent.document.all.confirmButton.disabled = true;
					return false;	
				}
				
					var giRadios = document.getElementsByName("giRadio");
					for(var i=0;i<giRadios.length;i++){
						if(giRadios[i].checked){
							document.all.sModifyGroupId2.value = giRadios[i].value;
						}	
					}
					
				if(loginRootDistance>2){
					//这个参数(createLogin),它的值来自于父页面,用于判断:
					//当工号是区县的级别时,用这个创建工号跟修改人本身工号比对,
					//如果相等,则修改发起的途径为:创建人发起的修改
					//如果不相等,则修改发起的途径为:修改者发起的修改
					//alert(parent.document.all.createLogin.value);
					if(parent.document.all.createLogin.value=="<%=workNo%>"){
						document.all.sIsCreaterStart2.value = "Y";
						document.all.sIsCreaterStart2.disabled = true;						
					}else if(loginRootDistance == "<%=createLoginRoot%>"){
						document.all.sIsCreaterStart2.value = "Y";
						document.all.sIsCreaterStart2.disabled = true;
					}else{
						document.all.sIsCreaterStart2.value = "N";
						document.all.sIsCreaterStart2.disabled = true;						
					}
					document.all.sIsPrint2.value = impResultArr[0][11];
					document.all.sPromptContent2.value = impResultArr[0][10];
					document.all.sValidFlag2.value = impResultArr[0][12];
					document.all.iClassSeq.value = impResultArr[0][3];
					document.all.sLimitRule.value = impResultArr[0][7];
					//document.all.sIsByValue.value = impResultArr[0][6];
				
				}
				if(loginRootDistance==2){
					if(<%=sIsCreaterStartFlag%>==2){
						document.all.sIsCreaterStart2.value = "Y";
						document.all.sIsCreaterStart2.disabled = true;	
					}else if(loginRootDistance == "<%=createLoginRoot%>"){
						document.all.sIsCreaterStart2.value = "Y";
						document.all.sIsCreaterStart2.disabled = true;
					}else{
						document.all.sIsCreaterStart2.value = "N";
						parent.document.all.confirmButton.disabled = false;
					}
					document.all.sIsPrint2.value = impResultArr[0][11];
					document.all.sPromptContent2.value = impResultArr[0][10];
					document.all.sValidFlag2.value = impResultArr[0][12];
					document.all.iClassSeq.value = impResultArr[0][3];
					document.all.sLimitRule.value = impResultArr[0][7];
				}
				if(loginRootDistance<2){
					document.all.sIsCreaterStart2.value = "Y";
					document.all.sIsCreaterStart2.disabled = true;
					document.all.sIsPrint2.value = impResultArr[0][11];
					document.all.sPromptContent2.value = impResultArr[0][10];
					document.all.sValidFlag2.value = impResultArr[0][12];	
					document.all.iClassSeq.value = impResultArr[0][3];
					document.all.sLimitRule.value = impResultArr[0][7];
				}
				
				var createLoginNo = parent.document.all.createLogin.value;
				document.sAuditLoginInfoFrame.location.href = "../s9605/f9605_getAuditLoginInfo.jsp?createLoginNo="+createLoginNo;
			}
		//-->
	</script>
</head>
	<body>
		<div id="Operation_Table">
     	<table cellspacing="0">
				<!--以下隐藏字段在js中动态赋值-->
				<input type="hidden" name="sModifyGroupId2" value="">
				<!--
						//这个参数(createLogin),它的值来自于f9607_getFieldInfoByFunctionCode.jsp,用于判断:
						//当工号是区县的级别时,用这个创建工号跟修改人本身工号比对,
						//如果相等,则修改发起的途径为:创建人发起的修改
						//如果不相等,则修改发起的途径为:修改者发起的修改
				-->
				<input type="hidden" name="createLogin" value="">
				
				<!--应客户要求,不能修改的字段予以隐藏-->
				<input type="hidden" name="sIsCreaterStart2" value="Y"><!--选择发起修改的途径,其值由js动态修改-->
				<input type="hidden" name="sIsByValue" value="Y"><!--sIsByValue:是否按值提示,应客户,固定值为'Y',不可更改-->
				<input type="hidden" name="sIsPrint2" value=""><!--打印类型,其值由js动态修改-->
				<input type="hidden" name="sLimitRule" value=""><!--前项限制,其值由js动态修改-->
				
				<!--以下为显示的主要内容-->				
				<tr>
					<td width="15%" class="blue" nowrap>提示内容</td>
					<td colspan="3">
						<textarea name="sPromptContent2" rows="8" cols="75"></textarea>&nbsp;<font class="orange">(最多512字)</font>
					</td>
				</tr>
				<!--	
				<tr>
					<td width="15%" nowrap>选择发起修改的途径</td>
					<td width="35%">
						<select name="sIsCreaterStart2">
							<option value="Y" selected>创建人发起的修改</option>
							<option value="N">修改者发起的修改</option>
						</select>
					</td>
					<td>是否按照代码提示</td>
					<td>
						<select name="sIsByValueInfo" disabled>
							<option value="Y" selected>是</option>
							<option value="N">否</option>
						</select>
					</td>
				</tr>
				-->
				<tr>
					<td width="15%" class="blue" nowrap>有效标志</td>
					<td colspan="3">
						<select name="sValidFlag2">
							<option value="none" selected>请选择</option>
							<option value="Y">有效</option>
							<option value="N">无效</option>
						</select>
					</td>
					<!--
					<td width="15%" nowrap></td>
					<td width="35%">
					-->
						<input type="hidden" name="iClassSeq" value="" onkeypress="if (event.keyCode<45 || event.keyCode>57) event.returnValue=false;">
					<!--
					</td>
					-->	
				</tr>
				<!--
				<tr>
					<td>打印选择</td>
					<td>
						<select name="sIsPrintInfo" disabled>
							<option value="1">提示</option>
							<option value="2">打印</option>
							<option value="3">打印并提示</option>
						</select>
						
					</td>	
					<td>前项限制</td>
					<td>
						<input type="text" name="sLimitRuleInfo" value="" disabled>
					</td>						
				</tr>
				-->
				
				<tr id="queryGroupIdTr">
					<td class="blue">发布区域</td>
					<td colspan="3">
							<table cellspacing="0">
									<tr align="center">
										<th width="15%" nowrap>选择</th>
										<th width="35%" nowrap>节点代码</th>
										<th nowrap>节点名称</th>
									</tr> 
							<%
									if(impGroupIdInfo.length==0){
										out.println("<tr height='25' align='center'><td colspan='3'>");
										out.println("没有任何记录！");
										out.println("</td></tr>");
									}else if(impGroupIdInfo.length>0){
										String tbclass = "";
										for(int i=0;i<impGroupIdInfo.length;i++){
												tbclass = (i%2==0)?"Grey":"";
							%>
												<tr align="center">
													<td class="<%=tbclass%>">
														<input type="checkbox" checked name="giRadio" value="<%=impGroupIdInfo[i][0]%>" disabled>	
													</td>
													<td class="<%=tbclass%>"><%=impGroupIdInfo[i][0]%>&nbsp;</td>
													<td class="<%=tbclass%>"><%=impGroupIdInfo[i][1]%>&nbsp;</td>
												</tr>
							<%				
										}
									}
							%>
						  </table>
					</td>
				</tr>			
				<tr>
					<td width="15%" class="blue" nowrap>请选择审批人</td>
					<td colspan="3">
						<!--显示审批人信息-->
						<iframe frameBorder="0" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" scrolling="no" style="height:180px; visibility:inherit; width:100%; z-index:1;"></iframe>
						<!--接受选择的审批人的工号串-->
						<input type="hidden" name="sAuditLogins" value="">
					</td>
				</tr>
				<tr>
					<td class="blue" nowrap>操作备注</td>
					<td colspan="3"><input type="text" name="opNote2" value="" size="90" maxlength="60"></td>
				</tr>			
			</table>
		</div>
	</body>
</html>    

