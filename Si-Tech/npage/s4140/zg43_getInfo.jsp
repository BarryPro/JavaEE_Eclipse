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
		String tftj = request.getParameter("tftj");
		
		String op_code = WtcUtil.repNull(request.getParameter("op_code"));
		String begin_time = WtcUtil.repNull(request.getParameter("begin_time"));
		String end_time = WtcUtil.repNull(request.getParameter("end_time"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no"));	
		String opNote = WtcUtil.repNull(request.getParameter("opNote"));
		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));			
	 
		//String getInfoSql = "";	
 
		String[] inParas2 = new String[2];
			
 
%>


<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	
	
</head>
<body>	
	<div id="Operation_Table">
	<%
		if(tftj=="1" ||tftj.equals("1"))
		{
			//gprs 投诉手机号码、退费流水、退费起止时间(gprs为时间段，自有业务为时间点)，操作时间、操作流水、退费类型、退费种类、退费业务、退费工号、退费金额
			inParas2[0]="select phone_no,   refund_accept,   refund_begin_dt,  refund_end_dt, to_char(a.op_time, 'yyyymmdd hh24:mi:ss'),   to_char(login_accept),  b.third_name,  a.tf_login_no,  to_char(a.system_price), '单倍',   'GPRS退费'  from drefundmsg a, srefundthird b where a.phone_no = :phone_no   and substr(a.op_time,1,8) between to_date(:date1,'yyyymmdd hh24:mi:ss') and to_date(:date2, 'yyyymmdd hh24:mi:ss') and a.third_code = b.third_code and b.valid_flag = '4'   and a.flag = '4'  and a.first_code = '1' order by a.op_time desc";
			inParas2[1]="phone_no="+phone_no+",date1="+begin_time+",date2="+end_time;
			%>
			<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="11">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="sVerifyTypeArr" scope="end" />
			<table id="t1">
				<tr align="center"> 
					<th>投诉手机号码</th>
					<th>退费流水</th>
					<th>退费开始时间</th> 
					<th>退费结束时间</th>
					<th>操作时间</th>
					<th>操作流水</th>
					<th>退费类型</th>
					<th>退费种类</th>
					<th>退费业务</th>
					<th>退费工号</th>
					<th>退费金额</th>
				</tr>
			 
			<%
					if(sVerifyTypeArr.length==0){
						out.println("<tr height='25' align='center'><td colspan='11'>");
						out.println("<font class='orange'>没有任何记录！</font>");
						out.println("</td></tr>");
					}else if(sVerifyTypeArr.length>0){
						for(int i=0;i<sVerifyTypeArr.length;i++){
								 
			%>
								<tr>
									<td><%=sVerifyTypeArr[i][0]%></td>
									<td><%=sVerifyTypeArr[i][1]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][3]%></td>
									<td><%=sVerifyTypeArr[i][4]%></td>
									<td><%=sVerifyTypeArr[i][5]%></td>
									<td><%=sVerifyTypeArr[i][9]%></td>
									<td><%=sVerifyTypeArr[i][10]%></td>
									<td><%=sVerifyTypeArr[i][6]%></td>
									<td><%=sVerifyTypeArr[i][7]%></td>
									<td><%=sVerifyTypeArr[i][8]%></td>
								</tr>
			<%				
						}
					}
			%>
		  </table>
			<%
		}
		else
		{
			//自有业务
			//投诉手机号码、退费流水、退费起止时间(gprs为时间段，自有业务为时间点)，操作时间、操作流水、退费类型、退费种类、退费业务、退费工号、退费金额
			inParas2[0]="select phone_no,refund_accept,to_char(a.op_time,'YYYYMMDD hh24:mi:ss'),to_char(login_accept),decode(REFUND_TYPE,1,'单倍',2,'双倍'),decode(REFUND_kind,1,'梦网/自有业务',2,'GPRS退费'),b.third_name,a.tf_login_no,to_char(a.system_price) from drefundmsg a,srefundthird b where a.phone_no=:s_no and substr(a.op_time,1,8) between to_date(:date1,'yyyymmdd hh24:mi:ss') and to_date(:date2, 'yyyymmdd hh24:mi:ss') and a.third_code=b.third_code and b.valid_flag='4' and a.flag='4' and a.first_code='0' order by a.op_time desc";
			inParas2[1]="s_no="+phone_no+",date1="+begin_time+",date2="+end_time;
			%>
			<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="9">
				<wtc:param value="<%=inParas2[0]%>"/>
				<wtc:param value="<%=inParas2[1]%>"/>
			</wtc:service>
			<wtc:array id="sVerifyTypeArr" scope="end" />
			<table id="t1">
				<tr align="center"> 
					<th>投诉手机号码</th>
					<th>退费流水</th>
					<th>退费时间</th> 
					<th>操作时间</th>
					<th>操作流水</th>
					<th>退费类型</th>
					<th>退费种类</th>
					<th>退费业务</th>
					<th>退费工号</th>
					<th>退费金额</th>
				</tr>
			 
			<%
					if(sVerifyTypeArr.length==0){
						out.println("<tr height='25' align='center'><td colspan='10'>");
						out.println("<font class='orange'>没有任何记录！</font>");
						out.println("</td></tr>");
					}else if(sVerifyTypeArr.length>0){
						for(int i=0;i<sVerifyTypeArr.length;i++){
								 
			%>
								<tr>
									<td><%=sVerifyTypeArr[i][0]%></td>
									<td><%=sVerifyTypeArr[i][1]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][2]%></td>
									<td><%=sVerifyTypeArr[i][3]%></td>
									<td><%=sVerifyTypeArr[i][4]%></td>
									<td><%=sVerifyTypeArr[i][5]%></td>
									<td><%=sVerifyTypeArr[i][6]%></td>
									<td><%=sVerifyTypeArr[i][7]%></td>
									<td><%=sVerifyTypeArr[i][8]%></td>
								</tr>
			<%				
						}
					}
			%>
		  </table>
			<%
		}
	%>
     
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       		<input class="b_text" name="sure" type="button" value="导出EXCEL" style="cursor:hand;" onClick="exportExcel('Operation_Table');" >
				<input class="blue" name="loginAccept" type="hidden" >					
				<input class="blue" name="opNote" type="hidden" value="操作员：<%=workNo%> 完成了导出注意事项建议信息操作" >									
				<input class="blue" name="op_code" type="hidden" value="<%=op_code%>">									
			</td>
	  </tr>
 </table>  
 	</div>
</body>
</html>  
<script language="javascript">
	function exportExcel(DivID){
 //先声明Excel插件、Excel工作簿等对像
 var jXls, myWorkbook, myWorksheet;
 
 try {
  //插件初始化失败时作出提示
  jXls = new ActiveXObject('Excel.Application');
 }catch (e) {
	return false;
 }
 
 //不显示警告 
 jXls.DisplayAlerts = false;
 
 //创建AX对象excel
 myWorkbook = jXls.Workbooks.Add();
 //myWorkbook.Worksheets(3).Delete();//删除第3个标签页(可不做)
 //myWorkbook.Worksheets(2).Delete();//删除第2个标签页(可不做)
 
 //获取DOM对像
 var curTb = document.getElementById(DivID);
 //alert("1");
 //获取当前活动的工作薄(即第一个)
 myWorksheet = myWorkbook.ActiveSheet; 
 //alert("2");
 //设置工作薄名称
 myWorksheet.name="NP统计";
 
 //获取BODY文本范围
 var sel = document.body.createTextRange();
 //alert("3 curTb is "+curTb);
 //将文本范围移动至DIV处
 sel.moveToElementText(curTb);
 //alert("4");
 //选中Range
 sel.select();
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 
 //将文本范围的内容拷贝至剪贴板
 sel.execCommand("Copy");
 
 //将内容粘贴至工作簿
 myWorksheet.Paste();
 
 //打开工作簿
 jXls.Visible = true;
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 jXls = null;//释放对像
 myWorkbook = null;//释放对像
 myWorksheet = null;//释放对像
}
</script>