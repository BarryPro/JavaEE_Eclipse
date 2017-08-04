<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 审核记录查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: yangrq
　 * 版权: sitech
   * 修改历史
   * 修改日期   20081209   修改人  zhanghonga    修改目的 新页面改造
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="com.sitech.boss.util.page.*"%>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9616";
 		String opName = "审核记录查询";

		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code01"));
		String audit_accept = WtcUtil.repNull(request.getParameter("audit_accept01"));
		String op_time_begin = WtcUtil.repNull(request.getParameter("op_time01_begin"));
		String op_time_end = WtcUtil.repNull(request.getParameter("op_time01_end"));		
		String bill_type = WtcUtil.repNull(request.getParameter("bill_type01"));		
		String prompt_type = WtcUtil.repNull(request.getParameter("prompt_type01"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no01"));	
		String class_code = WtcUtil.repNull(request.getParameter("class_code"));	
		String class_value = WtcUtil.repNull(request.getParameter("class_value"));	

		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
    	
		String	getInfoSql=" SELECT distinct nvl(b.function_name,'ALL'), c.bill_name, d.prompt_name, a.prompt_seq,"
											+" DECODE (a.modify_login, NULL, '发布', '变更'), a.prompt_content,"
											+" DECODE (a.modify_login, NULL, a.create_login, a.modify_login),"
											+" DECODE (a.modify_time, NULL, to_char(a.create_time,'yyyy-MM-dd HH24:MI:ss'), to_char(a.modify_time,'yyyy-MM-dd HH24:MI:ss')),"
											+" DECODE (a.modify_accept, NULL, a.create_accept, a.modify_accept),  to_char(a.valid_time,'yyyy-MM-dd'),"
											+" to_char(a.invalid_time,'yyyy-MM-dd'), f.class_name, a.class_value, 2 release_state,e.group_name,a.class_seq,"
											+" decode(valid_flag,'Y','有效','N','无效',valid_flag),"
											+" decode(is_print,1,'提示',2,'打印',3,'打印并提示'),g.Channels_Name "
											+" FROM sdomainpromptrelease a, sfunccode b, sprintbilltype c, sfuncprompttype d ,dchngroupmsg e,sclass f,sChannelsCode g"
											+" WHERE a.op_code = b.function_code(+)"
											+" and a.op_code = '"+op_code+"'"
											+" and a.bill_type = c.bill_type"
											+" AND a.prompt_type = d.prompt_type"
											+" and e.group_id = a.modify_group"
											+" and a.class_code = f.class_code"
											+" and a.Channels_Code = g.Channels_Code"
											+" AND (release_group in (select group_id"
											+" from dChnGroupInfo"
											+" where  parent_group_id = '"+groupId+"') "
											+" or"
											+" (release_group IN (SELECT parent_group_id"
											+" FROM dchngroupinfo"
											+"  WHERE GROUP_ID = '"+groupId+"')))";
								if(!"".equals(class_code))
								{
									getInfoSql+=" AND a.class_code="+class_code.trim();
								}
								if(!"".equals(class_value))
								{
									getInfoSql+=" AND a.class_value='"+class_value.trim()+"'";
								}
								if(!"".equals(bill_type))
								{
									getInfoSql+=" AND a.bill_type="+bill_type.trim();
								}
								if(!"".equals(prompt_type))
								{
									getInfoSql+=" AND a.prompt_type="+prompt_type.trim();
								}
								if(!"".equals(login_no))
								{
									getInfoSql+="  AND　(a.create_login = '"+login_no+"' OR a.modify_login = '"+login_no+"')";
								}
								if(!"".equals(audit_accept))
								{
									getInfoSql+="  AND　(a.create_accept = "+audit_accept+" OR a.modify_accept = "+audit_accept+")";
								}
								if(!"".equals(op_time_begin))
								{
									getInfoSql+="  AND　(a.create_time BETWEEN TO_DATE ('"+op_time_begin+"', 'yyyymmdd') AND TO_DATE ('"+op_time_end+"', 'yyyymmdd') OR a.modify_time BETWEEN TO_DATE ('"+op_time_begin+"', 'yyyymmdd') AND TO_DATE ('"+op_time_end+"', 'yyyymmdd'))";
								}
								
								/*zhangyan add*/
								String accountType=(String)session.getAttribute("accountType");
								if (accountType.equals("2"))
								{
									getInfoSql+=" and a.channels_code='08' ";
								}			
								

		System.out.println("#######getInfoSql22->"+getInfoSql);
		
		String sqlStr0  = "SELECT count(*) from (" + getInfoSql + ")"; 
		String sqlStr1 = "select * from (select row_.*,rownum id from (" + getInfoSql + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 		
%>
		
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="20"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	

		int totalNum = allNumArr.length>0?Integer.parseInt(allNumArr[0][0]):0;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doChange(){
				
					parent.document.getElementById("op_code01").disabled=true;
					parent.document.getElementById("audit_accept01").disabled=true;
					parent.document.getElementById("op_time01_begin").disabled=true;
					parent.document.getElementById("op_time01_end").disabled=true;
					parent.document.getElementById("bill_type01").disabled=true;
					parent.document.getElementById("prompt_type01").disabled=true;
					parent.document.getElementById("login_no01").disabled=true;
					parent.document.getElementById("class_code").disabled=true;
					parent.document.getElementById("class_value").disabled=true;
					
				var regionRadios = document.getElementsByName("regionRadio");
				for(var i=0;i<regionRadios.length;i++){		
					if(regionRadios[i].checked){
					var radioValue = regionRadios[i].value;
					var radioId=regionRadios[i].title.split("|");
					document.getElementById("control_code").innerHTML=radioId[0];
					document.getElementById("billType").innerHTML=radioId[1];
					document.getElementById("promptType").innerHTML=radioId[2];
					document.getElementById("promptNumber").innerHTML=radioId[3];
					document.getElementById("publishAction").innerHTML=radioId[4];
					document.getElementById("promptContent").innerHTML=radioId[5];
					document.getElementById("createName").innerHTML=radioId[6];
					document.getElementById("createTime").innerHTML=radioId[7];
					document.getElementById("createWork").innerHTML=radioId[8];
					document.getElementById("effectiveTime").innerHTML=radioId[9];
					document.getElementById("extinctTime").innerHTML=radioId[10];
					document.getElementById("wordCode").innerHTML=radioId[11];
					document.getElementById("classCode").innerHTML=radioId[12];
					document.getElementById("id1").innerHTML=radioId[13];
					document.getElementById("id2").innerHTML=radioId[14];
					document.getElementById("id3").innerHTML=radioId[15];
				}
			}
		}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0"  vColorTr="set">
			<tr height=25 align="center">
				<th nowrap>选择</th>
				<th nowrap>界面范围</th>
				<th nowrap>发布区域</th>
				<th nowrap>票据类型</th> 
				<th nowrap>提示类型</th>
				<th nowrap>提示序号</th> 
				<th nowrap>发布动作类型</th>
				<th nowrap>打印类型</th>
				<th nowrap>提示内容</th> 
				<!--
				<td nowrap>创建/修改工号</td>
				<td nowrap>创建/修改时间</td>
				<td nowrap>创建/修改流水</td>
				<td nowrap>生效时间</td>
				<td nowrap>失效时间</td>
				-->
				<th nowrap>代码</th>
				<th nowrap>字段域值</th>	
				<th nowrap>输出顺序</th>
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
						tbclass = (i%2==0)?"":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" id="regionRadio" value="<%=sVerifyTypeArr[i][8]%>" title="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][14]%>|<%=sVerifyTypeArr[i][15]%>|<%=sVerifyTypeArr[i][16]%>" onclick="doChange()">	
							</td class="<%=tbclass%>">
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][14]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="right"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
							<td  style="word-break:break-all;" class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<!--
							<td><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
							-->
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="right"><%=sVerifyTypeArr[i][12]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="right"><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td class="<%=tbclass%>"  align="left"><%=sVerifyTypeArr[i][18]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
	<tr align="right">
			<td colspan="21">
			  <div style="position:relative;font-size:12px;">
						<%	
						   int iQuantity = totalNum;
						   Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						   PageView view = new PageView(request,out,pg); 
						   view.setVisible(true,true,0,0);       
						%>	
				</div>	
			</td>	
		</tr>
  </table>
  </div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">详细信息</div>
	</div>
  <table cellspacing="0" id="detailInfo" style="display:">
				<tr>
					<td width="15%" nowrap>界面范围</td>
					<td width="35%" id="control_code">&nbsp;</td>
					<td width="15%" nowrap>票据类型</td>
					<td id="billType">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>提示类型</td>
					<td width="35%" id="promptType">&nbsp;</td>
					<td width="15%" nowrap>提示序号</td>
					<td id="promptNumber">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>发布动作类型</td>
					<td width="35%" id="publishAction">&nbsp;</td>
					<td width="15%" nowrap>创建/修改流水</td>
					<td width="35%" id="createWork">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>创建/修改工号</td>
					<td width="35%" id="createName">&nbsp;</td>
					<td width="15%" nowrap>创建/修改时间</td>
					<td id="createTime">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>生效时间</td>
					<td id="effectiveTime">&nbsp;</td>
					<td width="15%" nowrap>失效时间</td>
					<td width="35%" id="extinctTime">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>代码</td>
					<td id="wordCode">&nbsp;</td>
					<td width="15%" nowrap>字段域值</td>
					<td width="35%" id="classCode">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>输出顺序</td>
					<td id="id2">&nbsp;</td>
					<td width="15%" nowrap>发布区域</td>
					<td id="id1">&nbsp;</td>
				</tr>
					<tr>
					<td width="15%" nowrap>是否有效</td>
					<td id="id3">&nbsp;</td>
					<td width="15%" nowrap>&nbsp;</td>
					<td >&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" nowrap>提示内容</td>
					<td id="promptContent" colspan=3 style="word-break:break-all;">&nbsp;</td>
				</tr>
	</table>
 	</div>
</body>
</html>    

