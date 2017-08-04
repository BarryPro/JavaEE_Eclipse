<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String phone_no = request.getParameter("phone_no");              //操作代码
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
	String work_no = (String)session.getAttribute("workNo"); 
	
	
	
%>
<wtc:service name="zg71Qry" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="19" >
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=begin_time%>"/> 
    <wtc:param value="<%=end_time%>"/>
    <wtc:param value="<%=work_no%>"/>
</wtc:service>
<wtc:array id="ret_1" scope="end" start="0"  length="2"/>
<wtc:array id="sVerifyTypeArr" scope="end" start="2"  length="17"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141CfmMsg;
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa sVerifyTypeArr.length is "+sVerifyTypeArr.length+" and s4141CfmCode is "+s4141CfmCode);
	if (sVerifyTypeArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	
%>

<html>
	<head>
	<title></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
			
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
				<th>退费业务</th>
				<th>Sp企业代码</th>
				<th>Sp企业名称</th>
				<th>Sp业务代码</th>
				<th>Sp业务名称</th>
				<th>退费开始时间</th>
				<th>退费结束时间</th>
				<th>计费类型</th>
				<th>单价</th>
				<th>数量</th>
				<th>退费金额</th>
				<th>退费类型</th>
				<th>实际退费工号</th>
			</tr> 
	<%		
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='17'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++)
				{
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr>
							<!--<td class="<%=tbclass%>">
							
								<input type="checkbox" name="regionCheck" id="regionCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][13]%>" onclick="doChange()">	
							</td>-->
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
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
							<td><%=sVerifyTypeArr[i][14]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][15]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>   
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	   
				<input type="button"  class="b_text" onClick="exportExcel('Operation_Table')" value="导出EXCEL">
				<!--
				<input type="button"  class="b_text" onClick="window.location.href='zg69_1.jsp'" value="返回">
				-->
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
<%
	}else{
			out.println("<tr height='25' align='center'><td colspan='11'>");
			out.println("<font class='orange'>没有任何记录！</font>");
			out.println("</td></tr>");
		 }
%>

