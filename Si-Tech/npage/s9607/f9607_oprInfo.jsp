<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ע��������޸�-���ݲ��������ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,���޸�**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9607";
 		String opName = "ע��������޸�";

		/**��ҪregionCode���������·��**/
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
			
		/**����һ���յ�ȫ������**/
		String [][]impResultArr = new String[][]{};	
		String [][] impGroupIdInfo = new String [][]{};	
		
		/**sIsCreaterStartFlag,0��ʾ�Ȳ������Ǵ������޸�,�ֲ��������޸����޸�,1,ֻ�������޸����޸�,2,�ȿ����Ǵ������޸�,�ֿ������޸����޸�**/
		String sIsCreaterStartFlag = "0";
		
		/**1.�жϹ��ŵļ���,���root_distance==1,ʡ��,==2,����,>2,���л��߸�С�ļ���**/
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
		
		/**������ˮ**/
		String createAccept = WtcUtil.repNull(request.getParameter("createAccept"));
		
		/**������ŵļ���ֻ�����صĻ��߱����ظ�С**/
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
			getInfoSql += " and a.release_group != '10014'";//���ؼ����ţ������޸�ʡ�����ŷ��������ݡ�
			getInfoSql +=" AND a.group_id = (SELECT parent_GROUP_ID FROM dchngroupinfo a, dchngroupmsg b WHERE a.parent_group_id = b.group_id and a.group_id='"+groupId+"' and b.root_distance = 3)";
			
			System.out.println("#######loginRootDistance->"+loginRootDistance+"&&&&&getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="13"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
		impResultArr = sVerifyTypeArr;	
		//ȡ�÷����ڵ�����
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



		/**������ŵļ����ǵ��е�**/
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
		
		/**ȡ�÷����ڵ�����**/
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



		/**������ŵļ�����ʡ���Ļ��߹��Ҽ����,��û���κ�������**/
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
		//ȡ�÷����ڵ�����
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
	/**���impResultArrΪ��,���ʾsFuncPromptRelease��û�м�¼
		*(����sFuncPromptRelease��������������,��ע��;
		*��Ϊǰһ��ҳ���Ѿ�ѡȡ�˱�sFuncPrompt������,������sFuncPrompt�����д�����¼��;)
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


<!--�����Ӫҵ������,���Ѿ���ǰ���һ��ҳ���������;���������,ֻ�����޸���;����ǵ���,�����Ǵ�����;���ʡ,������-->
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
					alert("δ��ȡ���κ�ֵ,���ܽ����޸Ĳ���!");
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
					//�������(createLogin),����ֵ�����ڸ�ҳ��,�����ж�:
					//�����������صļ���ʱ,������������Ÿ��޸��˱����űȶ�,
					//������,���޸ķ����;��Ϊ:�����˷�����޸�
					//��������,���޸ķ����;��Ϊ:�޸��߷�����޸�
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
				<!--���������ֶ���js�ж�̬��ֵ-->
				<input type="hidden" name="sIsPrint" value=""><!--��ӡ����,��ֵ��js��̬�޸�-->
				<input type="hidden" name="sModifyGroupId" value=""><!--�޸Ľڵ�,��ֵ��js��̬�޸�;�����ż���Ϊ"����"ʱ����;���༶���,���ֶ���Ч-->
				<!--Ӧ�ͻ�Ҫ��,�����޸ĵ��ֶ���������-->
				<input type="hidden" name="sIsCreaterStart" value="Y"><!--ѡ�����޸ĵ�;��,��ֵ��js��̬�޸�-->
				<!--����Ϊ��ʾ����Ҫ����-->
				<tr>
					<td class="blue">��ʾ����</td>
					<td colspan="3">
						<textarea name="sPromptContent" rows="8" cols="75"></textarea>&nbsp;<font class="orange">(���512��)</font>
					</td>
				</tr>	
				<tr>
					<!--
					<td width="15%" nowrap>ѡ�����޸ĵ�;��</td>
					<td width="35%">
						<select name="sIsCreaterStart">
							<option value="Y" selected>�����˷�����޸�</option>
							<option value="N">�޸��߷�����޸�</option>
						</select>
					</td>
					-->
					<td width="15%" class="blue" nowrap>��Ч��־</td>
					<td>
						<select name="sValidFlag">
							<option value="Y">��Ч</option>
							<option value="N">��Ч</option>
						</select>
					</td>
				</tr>
				<tr id="queryGroupIdTr">
					<td class="blue">��������</td>
					<td colspan="3">
							<table cellspacing="0">
									<tr align="center">
										<th width="15%" nowrap>ѡ��</th>
										<th width="35%" nowrap>�ڵ����</th>
										<th nowrap>�ڵ�����</th>
									</tr> 
							<%
									if(impGroupIdInfo.length==0){
										out.println("<tr height='25' align='center'><td colspan='3'>");
										out.println("û���κμ�¼��");
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
					<td width="15%" class="blue" nowrap>��ѡ��������</td>
					<td colspan="3">
						<!--��ʾ��������Ϣ-->
						<iframe frameBorder="0" id="sAuditLoginInfoFrame" align="center" name="sAuditLoginInfoFrame" scrolling="no" style="height:180px; visibility:inherit; width:100%; z-index:1;"></iframe>
						<!--����ѡ��������˵Ĺ��Ŵ�-->
						<input type="hidden" name="sAuditLogins" value="">
					</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>������ע</td>
					<td colspan="3"><input type="text" name="opNote" value="" size="90" maxlength="60"></td>
				</tr>		
			</table>
		</div>
	</body>
</html>    

