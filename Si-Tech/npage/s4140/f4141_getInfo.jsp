<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 投诉退费查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2009-08-10
　 * 作者: zhangshuaia
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
    
 		String opCode = "4141";
 		String opName = "投诉退费--查询";
		
		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
					
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222 checkSql->"+checkSql);

		//xl add
		String qry_flag = request.getParameter("qry_flag");
		String login_nos = WtcUtil.repNull(request.getParameter("login_nos"));
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
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
		StringBuffer  getInfoSql = new StringBuffer();
		//String getInfoSql = "";	
		System.out.println("op_code====="+opCode);
			if(opCode.equals("4141") )
			{
				if(qry_flag=="1" ||qry_flag.equals("1"))
				{
					getInfoSql.append("  select a.phone_no,substr(a.op_time,0,8),a.login_accept,decode(a.refund_type,'1','单倍','2','双倍'),decode(a.refund_kind,'1','退现金','2','退预存'),a.system_price,b.first_name,c.second_name,d.third_name ,a.login_no");	
					getInfoSql.append("  from drefundMsg a,SrefundFirst b,SrefundSecond c,SrefundThird d,dloginmsg f");	
					getInfoSql.append("  where a.first_code=b.first_code");	
					getInfoSql.append("  and a.phone_no='"+phone_no+"'");	
					getInfoSql.append("  and a.second_code=c.second_code");	
					getInfoSql.append("  and a.third_code=d.third_code");	
					getInfoSql.append("  and b.first_code=c.first_code");	
					getInfoSql.append("  and c.second_code=d.second_code");	
					getInfoSql.append("  and a.refund_type in ('1','2')");	
					getInfoSql.append("  and a.login_no=f.login_no");	
					getInfoSql.append("  and substr(a.op_time,1,8) between to_date('"+begin_time+"','yyyymmdd hh24:mi:ss') and to_date('"+end_time+"', 'yyyymmdd hh24:mi:ss')");	
					getInfoSql.append("  order by a.op_time asc");	
					System.out.println("号码查询11111111111 getInfoSql====="+getInfoSql);	
				}
				else
				{
					getInfoSql.append("  select a.phone_no,substr(a.op_time,0,8),a.login_accept,decode(a.refund_type,'1','单倍','2','双倍'),decode(a.refund_kind,'1','退现金','2','退预存'),a.system_price,b.first_name,c.second_name,d.third_name ,a.login_no");	
					getInfoSql.append("  from drefundMsg a,SrefundFirst b,SrefundSecond c,SrefundThird d,dloginmsg f");	
					getInfoSql.append("  where a.first_code=b.first_code");	
				 	
					getInfoSql.append("  and a.second_code=c.second_code");	
					getInfoSql.append("  and a.third_code=d.third_code");	
					getInfoSql.append("  and b.first_code=c.first_code");	
					getInfoSql.append("  and c.second_code=d.second_code");	
					getInfoSql.append("  and a.refund_type in ('1','2')");	
					getInfoSql.append("  and a.login_no=f.login_no");	
					getInfoSql.append("  and a.login_no='"+login_nos+"'");
					getInfoSql.append("  and substr(a.op_time,1,8) between to_date('"+begin_time+"','yyyymmdd hh24:mi:ss') and to_date('"+end_time+"', 'yyyymmdd hh24:mi:ss')");	
					getInfoSql.append("  order by a.op_time asc");
					System.out.println("号码查询222222222222222222 getInfoSql====="+getInfoSql);
				}
							 		 	
			}
							
		System.out.println("#######getInfoSql->"+getInfoSql);
%>
		<wtc:pubselect  name="TlsPubSelBoss"  routerKey="region"  routerValue="<%=regionCode%>" outnum="31"> 
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
				
var excelObj;
function printTable(obj){
	var regionChecks = document.getElementsByName("regionCheck");
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
	parent.window.location.href = "f4141.jsp?op_code=<%=op_code%>";
}					
		//-->
	</script>
	
</head>
<body>	
	<div id="Operation_Table">
     <table cellspacing="0" id='t1'>
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>投诉电话号</th>
				<th nowrap>操作时间</th>
				<th nowrap>操作流水</th> 
				<th nowrap>退费类型</th>
				<th nowrap>退费种类</th>
				<th nowrap>退费金额</th>
				<th nowrap>退费一级原因</th>
				<th nowrap>退费二级原因</th>
				<th nowrap>退费三级原因</th>
				<th nowrap>实际操作工号</th>
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
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>" align="center"><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
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

