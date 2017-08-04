<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 注意事项库修改-根据操作代码查询信息
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
		
		/**sIsCreaterStartFlag,0表示既不可以是创建人修改,又不可以是修改人修改,1,只能是以修改人修改,2,既可以是创建人修改,又可以是修改人修改**/
		String sIsCreaterStartFlag = "0";
		
		/**1.判断工号的级别,如果root_distance==1,省级,==2,地市,>2,地市或者更小的级别**/
		String loginRootDistanceValue = WtcUtil.repNull(request.getParameter("loginRootDistance"));
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
		
		int loginRootDistance = 999999;
		if(!loginRootDistanceValue.equals("")){
			loginRootDistance = Integer.parseInt(loginRootDistanceValue);
		}
		
		/**创建流水**/
		String createAccept = WtcUtil.repNull(request.getParameter("createAccept"));
		
		/**如果工号的级别只是区县的或者比区县更小**/
		if(loginRootDistance>2){
				String getInfoSql = "SELECT a.GROUP_ID, b.function_code, b.bill_type, b.prompt_type, b.prompt_seq,"
												+"  a.release_group, b.prompt_content, b.create_login, b.create_time,"
												+" b.create_accept, b.valid_flag, a.valid_time, a.invalid_time"
												+"  FROM sfuncpromptrelease a,sfuncprompt b"
												+"  WHERE b.function_code = a.function_code"
												+"   and b.bill_type = a.bill_type"
												+"  and b.prompt_type = a.prompt_type"
												+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}
			getInfoSql += " and a.release_group != '10014'";//区县级工号，不能修改省级工号发布的内容。
			getInfoSql +=" AND a.group_id = (SELECT parent_GROUP_ID FROM dchngroupinfo a, dchngroupmsg b WHERE a.parent_group_id = b.group_id and a.group_id='"+groupId+"' and b.root_distance = 3)";
			
			System.out.println("#######loginRootDistance->"+loginRootDistance+"&&&&&getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="13"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
		impResultArr = sVerifyTypeArr;	
		//取得发布节点名称
		String getGroupIdNameSql = "select a.group_id,b.group_name from sfuncpromptrelease a,dchngroupmsg b where a.group_id=b.group_id and  create_accept = '"+createAccept.trim()+"' AND a.group_id = (SELECT parent_GROUP_ID FROM dchngroupinfo a, dchngroupmsg b WHERE a.parent_group_id = b.group_id and a.group_id='"+groupId+"' and b.root_distance = 3)";
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="13"> 
		<wtc:sql><%=getGroupIdNameSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="getGroupIdNameArr"  scope="end"/>
<%		
		System.out.println("getGroupIdNameSql->"+getGroupIdNameSql);
		impGroupIdInfo = getGroupIdNameArr;		
		}



		/**如果工号的级别是地市的**/
		if(loginRootDistance==2){
			String getInfoSql = "SELECT a.GROUP_ID, b.function_code, b.bill_type, b.prompt_type, b.prompt_seq,"
												+"  a.release_group, b.prompt_content, b.create_login, b.create_time,"
												+" b.create_accept, b.valid_flag, a.valid_time, a.invalid_time"
												+"  FROM sfuncpromptrelease a,sfuncprompt b"
												+"  WHERE b.function_code = a.function_code"
												+"   and b.bill_type = a.bill_type"
												+"  and b.prompt_type = a.prompt_type"
												+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}		
			getInfoSql +=" AND a.GROUP_ID in (SELECT GROUP_ID FROM dchngroupinfo WHERE parent_GROUP_ID='"+groupId+"')";
			
			System.out.println("yy#######loginRootDistance22222->"+loginRootDistance+"&&&&&getInfoSql222->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="13"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		
		impResultArr = sVerifyTypeArr;
		
		/**取得发布节点名称**/
		String getGroupIdNameSql = " SELECT DISTINCT a.release_group, b.group_name"
																+" FROM sfuncpromptrelease a, dchngroupmsg b"
																+" WHERE a.release_group = b.GROUP_ID"
																+" AND create_accept = '"+createAccept.trim()+"'"
																+" AND a.create_login = '"+workNo+"'"
																+" union"
																+" SELECT DISTINCT '"+groupId+"',b.group_name"
																+" FROM sfuncpromptrelease a,dchngroupmsg b"
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
				String getInfoSql = "SELECT a.GROUP_ID, b.function_code, b.bill_type, b.prompt_type, b.prompt_seq,"
												+"  a.release_group, b.prompt_content, b.create_login, b.create_time,"
												+" b.create_accept, b.valid_flag, a.valid_time, a.invalid_time"
												+"  FROM sfuncpromptrelease a,sfuncprompt b"
												+"  WHERE b.function_code = a.function_code"
												+"   and b.bill_type = a.bill_type"
												+"  and b.prompt_type = a.prompt_type"
												+" and b.prompt_seq = a.prompt_seq";
			if(!"".equals(createAccept)){
				getInfoSql += " and a.create_accept = '"+createAccept.trim()+"'";
			}			
			System.out.println("#######xxloginRootDistance->"+loginRootDistance+"&&&&&getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="13"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		
		impResultArr = sVerifyTypeArr;
		//取得发布节点名称
		String getGroupIdNameSql = "select distinct a.release_group,b.group_name from sfuncpromptrelease a,dchngroupmsg b where a.release_group=b.group_id and  create_accept = '"+createAccept.trim()+"'";
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
	/**如果impResultArr为空,则表示sFuncPromptRelease中没有记录
		*(或者sFuncPromptRelease表中数据有问题,请注意;
		*因为前一个页面已经选取了表sFuncPrompt中数据,表明表sFuncPrompt中是有此条记录的;)
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
								
							//	System.out.println(impResultArr[i][j].replaceAll("\r\n",""));
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
							document.all.sModifyGroupId.value = giRadios[i].value;
						}
					}	
				if(loginRootDistance>2){
					//这个参数(createLogin),它的值来自于父页面,用于判断:
					//当工号是区县的级别时,用这个创建工号跟修改人本身工号比对,
					//如果相等,则修改发起的途径为:创建人发起的修改
					//如果不相等,则修改发起的途径为:修改者发起的修改
					//alert(parent.document.all.createLogin.value);
					if(parent.document.all.createLogin.value=="<%=workNo%>"){
						document.all.sIsCreaterStart.value = "Y";
						document.all.sIsCreaterStart.disabled = true;
					}else if(loginRootDistance == "<%=createLoginRoot%>"){
						document.all.sIsCreaterStart.value = "Y";
						document.all.sIsCreaterStart.disabled = true;
					}else{
						document.all.sIsCreaterStart.value = "N";
						document.all.sIsCreaterStart.disabled = true;
					}
					document.all.sIsPrint.value = impResultArr[0][2];
					document.all.sPromptContent.value = impResultArr[0][6];
					document.all.sValidFlag.value = impResultArr[0][10];
					
				}
				if(loginRootDistance==2){
					if(<%=sIsCreaterStartFlag%>==2){
						document.all.sIsCreaterStart.value = "Y";
						document.all.sIsCreaterStart.disabled = true;	
					}else if(loginRootDistance == "<%=createLoginRoot%>"){
						document.all.sIsCreaterStart.value = "Y";
						document.all.sIsCreaterStart.disabled = true;
					}else{
						document.all.sIsCreaterStart.value = "N";
						parent.document.all.confirmButton.disabled = false;
					}
					document.all.sIsPrint.value = impResultArr[0][2];
					document.all.sPromptContent.value = impResultArr[0][6];
					document.all.sValidFlag.value = impResultArr[0][10];	
				}
				if(loginRootDistance<2){
					document.all.sIsCreaterStart.value = "Y";
					document.all.sIsCreaterStart.disabled = true;
					document.all.sIsPrint.value = impResultArr[0][2];
					document.all.sPromptContent.value = impResultArr[0][6];
					document.all.sValidFlag.value = impResultArr[0][10];					
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
				<input type="hidden" name="sIsPrint" value=""><!--打印类型,其值由js动态修改-->
				<input type="hidden" name="sModifyGroupId" value=""><!--修改节点,其值由js动态修改;当工号级别为"区县"时触发;其余级别的,此字段无效-->
				<!--应客户要求,不能修改的字段予以隐藏-->
				<input type="hidden" name="sIsCreaterStart" value="Y"><!--选择发起修改的途径,其值由js动态修改-->
				<!--以下为显示的主要内容-->
				<tr>
					<td class="blue">提示内容</td>
					<td colspan="3">
						<textarea name="sPromptContent" rows="8" cols="75"></textarea>&nbsp;<font class="orange">(最多512字)</font>
					</td>
				</tr>	
				<tr>
					<!--
					<td width="15%" nowrap>选择发起修改的途径</td>
					<td width="35%">
						<select name="sIsCreaterStart">
							<option value="Y" selected>创建人发起的修改</option>
							<option value="N">修改者发起的修改</option>
						</select>
					</td>
					-->
					<td width="15%" class="blue" nowrap>有效标志</td>
					<td>
						<select name="sValidFlag">
							<option value="Y">有效</option>
							<option value="N">无效</option>
						</select>
					</td>
				</tr>
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
					<td width="15%" class="blue" nowrap>操作备注</td>
					<td colspan="3"><input type="text" name="opNote" value="" size="90" maxlength="60"></td>
				</tr>		
			</table>
		</div>
	</body>
</html>    

