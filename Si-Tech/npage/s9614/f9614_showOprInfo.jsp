<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 注意事项库审批-查询审批信息
　 * 版本: v3.0
　 * 日期: 2008-10-14
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="com.sitech.boss.util.page.*"%>		
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
 		String opCode = "9614";
 		String opName = "注意事项库审批";

		String regionCode  = (String)session.getAttribute("regCode");

		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String release_action = WtcUtil.repNull(request.getParameter("release_action"));
		String IsNotCreateLoginModify = WtcUtil.repNull(request.getParameter("IsNotCreateLoginModify"));
		
		//根据流水,查看工号是否是指定的能审批操作的工号
		String isAuditValidSql = "select audit_login from dPromptAudit where audit_accept = '"+sAuditAccept+"'";
	%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=isAuditValidSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>		
	<%
		
		
		String getRegionSql = "";
		getRegionSql = "SELECT distinct b.function_name, c.bill_name, d.prompt_name, a.prompt_seq,"
							       +" f.group_name,"
							       +" DECODE (a.release_action,"
			               +" 1, '发布',"
			               +" 2, '删除',"
			               +" 3, '更新',"
			               +" a.release_action"
				             +"),"
							       +" a.prompt_content, decode(a.valid_flag,'Y','有效','N','无效',a.valid_flag), a.create_login, a.create_time,"
							       +" a.create_accept, a.valid_time, a.invalid_time, a.modify_login,"
							       +" a.modify_time, a.modify_accept,"
							       +" DECODE (a.is_print,"
							               +" 1, '提示',"
							               +" 2, '打印',"
							               +" 3, '打印并提示',"
							               +" a.is_print"
							               +"),"
							               +" DECODE (a.valid_flag, 'Y', '有效', 'N', '无效', a.valid_flag)	,   "
							               +" g.Channels_Name   "
							  +" FROM sfuncpromptaudit a,"
							       +" sfunccode b,"
							       +" sprintbilltype c,"
							       +" sfuncprompttype d,"
							       +" dchngroupmsg f ,"
							       +" sChannelsCode g"
							 +" WHERE a.function_code = b.function_code"
							   +" AND a.bill_type = c.bill_type"
							   +" AND a.prompt_type = d.prompt_type"
								 +" and f.GROUP_ID = a.modify_group"
								 +" and g.Channels_Code = a.Channels_Code";

		if(release_action.equals("1")){
			getRegionSql += " and a.create_accept = "+sAuditAccept;
		}else
			{
				getRegionSql += " and a.modify_accept = '"+sAuditAccept+"'";
			}
		
		System.out.println(getRegionSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="19"> 
		<wtc:sql><%=getRegionSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			//如果拥有权限,则让审批的功能操作显示出来
			onload=function(){
				parent.document.all.sAuditAccept.value="<%=sAuditAccept%>";
				parent.document.getElementById("oprAuditTable").style.display = "block";
			}
			
			
			//被废弃,暂不删除.
			function doChange(oprInfoCheckBox){
				var oprInfoCheckBoxs = document.getElementsByName("oprInfoCheckBox");	
				var impValue="";
				
				if(oprInfoCheckBox.checked==true){
						impValue = oprInfoCheckBox.value;
						for(var j=0;j<oprInfoCheckBoxs.length;j++){
							if(oprInfoCheckBoxs[j].value==impValue){
								oprInfoCheckBoxs[j].checked=true;	
							}
						}
						
						parent.document.all.sAuditAccept.value=impValue;
						parent.document.getElementById("oprAuditTable").style.display = "block";						
				}
				
				if(oprInfoCheckBox.checked==false){
						impValue = oprInfoCheckBox.value;
						for(var j=0;j<oprInfoCheckBoxs.length;j++){
							if(oprInfoCheckBoxs[j].value==impValue){
								oprInfoCheckBoxs[j].checked=false;	
							}
						}
						
						parent.document.all.sAuditAccept.value="";
						parent.document.getElementById("oprAuditTable").style.display = "none";		
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>操作批次流水</th>
				<th nowrap>发布区域</th>
				<th nowrap>模块名称</th> 
				<th nowrap>票据类型</th>  
				<th nowrap>提示类型</th>
				<th nowrap>提示序号</th>
				<th nowrap>发布类型</th>
				<th nowrap>打印选择</th>
				<th nowrap>有效标志</th>
				<th nowrap>渠道类型</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=sAuditAccept%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][18]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    


