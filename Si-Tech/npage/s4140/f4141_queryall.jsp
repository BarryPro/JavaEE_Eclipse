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
 		String opName = "投诉退费--批量查询";
		 
		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
	 
		String value_new = "";
		//多个字符串 需要split
		String  tar = ""; 
		String lgNameArrays = "";
		 
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("22222aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa checkSql->"+checkSql);
		//xl add
		String qry_value = request.getParameter("qry_value");
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
		 
		//xl add 
		String s_region_code = WtcUtil.repNull(request.getParameter("qry_region"));
		String[][] result1  = null ;
%>
		<wtc:service name="s4141Qry"  routerKey="region"  routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="20"> 
			<wtc:param value="<%=lgNameArrays%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value="<%=begin_time%>"/>
			<wtc:param value="<%=end_time%>"/>
			<wtc:param value="<%=qry_value%>"/>
			<wtc:param value="<%=s_region_code%>"/>
			
		</wtc:service> 
		<wtc:array id="sVerifyTypeArr1" start="0" length="2" scope="end"/>
		<wtc:array  id="sVerifyTypeArr" start="2" length="18" scope="end"/>
 
<%	
result1 = sVerifyTypeArr;
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSS result1.length=" + result1.length);
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
	for(j=1;j< 15;j++)
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
					for(var j = 0; j < 814; j++)
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
     <table cellspacing="0" id='t1' width="200px" >
			<tr>
				<!--
				<th nowrap>选择</th>
				-->
				<th>地市</th>
				<th>工单流水</th>
				<th>投诉电话号</th>
				<th>操作时间</th> 
				<th>退费三级原因</th>
				<th>Sp企业代码</th>
				<th>Sp企业简称</th>
				<th>Sp业务代码</th>
				<th>Sp业务名称</th>
				<th>业务使用时间</th>	
				<th>计费类型</th>
				<th>单价</th>
				<th>数量</th>
				<th>退费金额</th>
				<th>退费类型</th>
				<th>操作工号</th>
				<th>号码归属地</th>
				<th>品牌</th>
			</tr> 
	<%		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+sVerifyTypeArr.length);
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='14'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				System.out.println("AAAAAAAAAAAAAAAAAAAAAAA sVerifyTypeArr.length is "+sVerifyTypeArr.length);
				for(int i=0;i<result1.length;i++)
				{
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr>
							<!--<td class="<%=tbclass%>">
							
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][13]%>" onclick="doChange()">	
							</td>-->
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][14]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][12]%></td>
							<td><%=sVerifyTypeArr[i][13]%>&nbsp;</td> 
							<td><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>   
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	      <!--
		   <input type="button" name="allchoose"  class="b_text" value="全部选择" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="取消全选" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;				
				<input class="b_text" name="sure" type="button" value="导出EXCEL" style="cursor:hand;" onClick="printTable(t1);" disabled>
				<input class="blue" name="loginAccept" type="hidden" >					
				<input class="blue" name="opNote" type="hidden" value="操作员：<%=workNo%> 完成了导出注意事项建议信息操作" >									
				<input class="blue" name="op_code" type="hidden" value="<%=op_code%>">
				&nbsp;&nbsp;
				-->
				<input type="button"  class="b_text" onClick="exportExcel('Operation_Table')" value="导出EXCEL">
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
 
 //获取当前活动的工作薄(即第一个)
 myWorksheet = myWorkbook.ActiveSheet; 
 
 //设置工作薄名称
 myWorksheet.name="NP统计";
 
 //获取BODY文本范围
 var sel = document.body.createTextRange();
 
 //将文本范围移动至DIV处
 sel.moveToElementText(curTb);
 
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