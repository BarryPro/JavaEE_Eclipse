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
		<%@ page contentType="text/html;charset=GBK"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9646";
 		String opName = "注意事项建议信息查询";
		
		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
					
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222 checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr1"  scope="end"/>
<%
		/**根据loginRootDistance来判断工号权限问题**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr1 !=null && sVerifyTypeArr1.length>0){
				loginRootDistance = sVerifyTypeArr1[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr1[0][0]);
				System.out.println("33333 loginRootDistance->"+loginRootDistance);
			}
		}					
		/** 
		 	*@inparam			audit_accept 审批流水
			*@inparam			op_time_begin      操作时间（创建时间、或修改时间）
			*@inparam			op_time_end      操作时间（创建时间、或修改时间）
			*@inparam			op_code      界面范围
			*@inparam			bill_type    票据类型
			*@inparam			prompt_type  提示类型
			*@inparam			login_no     发起人工号：（创建人、修改人、删除人）
		 **/
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));	
		StringBuffer  getInfoSql = new StringBuffer();
		//String getInfoSql = "";	
			if(op_code.equals("ALL") )
			{
				if(loginRootDistance == 2)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and a.login_no = b.login_no and a.group_id=c.group_id and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" ");			
					System.out.println("getInfoSql====="+getInfoSql);				
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);
					}
					if(!begin_time.equals("") && !end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time between to_date('"+begin_time+"','yyyymmdd') and to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					} 
				}
				else if(loginRootDistance == 3)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and a.login_no = b.login_no and a.group_id=c.group_id and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" and a.group_id='"+groupId+"' ");			
					System.out.println("getInfoSql====="+getInfoSql);				
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);
					}
					if(!begin_time.equals("") && !end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time between to_date('"+begin_time+"','yyyymmdd') and to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					} 				
				}
				else if(loginRootDistance == 4)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and a.login_no = b.login_no and a.group_id=c.group_id and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" and a.group_id='"+groupId+"' ");			
					System.out.println("getInfoSql====="+getInfoSql);				
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);
					}
					if(!begin_time.equals("") && !end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time between to_date('"+begin_time+"','yyyymmdd') and to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					} 				
				}	 		 	
			}
			else
			{
				if(loginRootDistance == 2)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and function_code = '"+op_code+"' and a.login_no = b.login_no and a.group_id=c.group_id and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" ");
					System.out.println("getInfoSql====="+getInfoSql);	
					if(!begin_time.equals(""))
					{
						getInfoSql.append(" and a.op_time > to_date('"+begin_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					}
					if(!end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time < to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);								
					}
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);	
					}
				}
				else if(loginRootDistance == 3)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and function_code = '"+op_code+"' and a.login_no = b.login_no and a.group_id=c.group_id and a.group_id='"+groupId+"' and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" ");
					System.out.println("getInfoSql====="+getInfoSql);	
					if(!begin_time.equals(""))
					{
						getInfoSql.append(" and a.op_time > to_date('"+begin_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					}
					if(!end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time < to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);								
					}
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);	
					}
				}	 					
				else if(loginRootDistance == 4)
				{
					getInfoSql.append("SELECT a.login_no,to_char(a.op_time,'yyyymmdd'),function_code,trim(function_name),trim(a.login_name),trim(phone_no),advice_content,login_accept FROM sAdviceInfoQry a,dLoginMsg b,dChnGroupMsg c WHERE a.op_flag = '0' and function_code = '"+op_code+"' and a.login_no = b.login_no and a.group_id=c.group_id and a.group_id='"+groupId+"' and substr(b.org_code,1,2)='"+regionCode+"' and c.root_distance >= "+loginRootDistance+" ");
					System.out.println("getInfoSql====="+getInfoSql);	
					if(!begin_time.equals(""))
					{
						getInfoSql.append(" and a.op_time > to_date('"+begin_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);				
					}
					if(!end_time.equals(""))
					{
						getInfoSql.append(" and a.op_time < to_date('"+end_time+"','yyyymmdd') ");
						System.out.println("getInfoSql====="+getInfoSql);								
					}
					if(!login_no.equals(""))
					{
						getInfoSql.append(" and a.login_no = '"+login_no+"' ");
						System.out.println("getInfoSql====="+getInfoSql);	
					}
				}	 		
			}								
		System.out.println("#######getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="9"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%			
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
				/**复选框全部选中**/
			function doSelectAllNodes(){
				document.all.sure.disabled=false;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=true;
				}
				doChange();	
			}
			
			/**取消复选框全部选中**/
			function doCancelChooseAll(){
				document.all.sure.disabled=true;
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=false;
				}
				doChange();				
			}
							
				function doChange(){
					document.all.sure.disabled=false;					
					parent.document.all.begin_time.disabled=true;
					parent.document.all.op_code.disabled=true;
					parent.document.all.end_time.disabled=true;
					parent.document.all.login_no.disabled=true;					
				var regionChecks = document.getElementsByName("regionCheck");
				var impCodeStr = "";
				var regionLength=0;
				for(var i=0;i<regionChecks.length;i++){		
					if(regionChecks[i].checked){
					var impValue = regionChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							impCodeStr = impArr[7];
						}else{
							impCodeStr += (","+impArr[7]);								
						}
						regionLength++;
				}				
			}
			document.all.loginAccept.value = impCodeStr;
			if(document.all.loginAccept.value.length==0)
			{
				document.all.sure.disabled=true;
			}		
		}
		function doConfirm(){
				var radioValue = document.all.loginAccept.value;
				var opNote = document.all.opNote.value;
				var op_code = document.all.op_code.value;
				//alert(radioValue+"|"+op_code+"|"+opNote);
				window.location.href = "f9646Cfm.jsp?loginAccept="+radioValue+"&opNote="+opNote+"&op_code="+op_code;
				}	
				
var excelObj;
function printTable(obj){
	var regionChecks = document.getElementsByName("regionCheck");
	doConfirm();
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
 	excelObj.WorkBooks.Add; 
	for(j=1;j< 9;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	var xy=0;
	for(var a=0;a <regionChecks.length;a++)
	{
		if(regionChecks[a].checked)
		{
			var impValue = regionChecks[a].value;
			var impArr = impValue.split("|");
			
				try
				{	
					for(var j = 0; j < 8; j++)
					{											
						excelObj.Cells(xy+2,j+2).value = impArr[j];						
					}		
					xy++;						
				}
				catch(e)
				{
					alert('生成excel失败!');
				}	
		}		
	}
}					
		//-->
	</script>
	
</head>
<body>	
	<div id="Operation_Table">
     <table cellspacing="0" id='t1'>
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>操作工号</th>
				<th nowrap>操作时间</th>
				<th nowrap>功能代码</th> 
				<th nowrap>功能名称</th>
				<th nowrap>操作者姓名</th>
				<th nowrap>操作员手机号</th>
				<th nowrap>建议信息</th>
				<th nowrap>创建流水</th>				
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
							<td class="<%=tbclass%>">
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="allchoose"  class="b_text" value="全部选择" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="取消全选" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;				
				<input class="b_text" name="sure" type="button" value="导出EXCEL" style="cursor:hand;" onClick="printTable(t1);" disabled>
				<input class="blue" name="loginAccept" type="hidden" >					
				<input class="blue" name="opNote" type="hidden" value="操作员：<%=workNo%> 完成了导出注意事项建议信息操作" >									
				<input class="blue" name="op_code" type="hidden" value="<%=op_code%>">									
			</td>
	  </tr>
 </table>  
 	</div>
</body>
</html>  

