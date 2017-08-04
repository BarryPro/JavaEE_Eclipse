<%
/********************
version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<head>
	<title>扣费主动提醒短信处理明细报表</title>
<%
	String opCode = "zg91";
	String opName = "扣费主动提醒短信处理明细报表";
	String regionCode= (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("phoneNo");
	String beginTime = (String)request.getParameter("beginTime");
	String endTime   = (String)request.getParameter("endTime");
	String yyyymmdd=beginTime.substring(0,6);
	String sysdate="";
	int allPage=0;
	int everyPage=20;
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
  String[] inParam1 = new String[2];
	inParam1[0]="select to_char(sysdate,'yyyymmdd') from dual";
	
  String[] inParam = new String[2];	
  	inParam[0]="select to_char(a.msisdn),to_char(c.region_name),to_char(decode(a.order_flag,'1','包月','0','点播')),to_char(decode(a.zy_flag,'1','梦网','0','自有')),substr(serv_name,0,200),to_char(a.oper_code),to_char(a.fee),to_char(a.reply_time),to_char(a.reply_time),to_char(decode(a.flag1,'Z','是','否')) from dbbillprg.tellcode_inc_del_bak_"+yyyymmdd+"  a,dcustmsg b ,sregioncode c where   a.reply_time between :startTime and :s_emdtime and a.msisdn=b.phone_no and substr(b.belong_code,1,2)=c.region_code and a.reply_time is not null";
	//inParam[0]="select to_char(a.msisdn),to_char(c.region_name),to_char(decode(a.order_flag,'1','包月','0','点播')),to_char(decode(a.zy_flag,'1','梦网','0','自有')),nvl(trim(serv_name),''),to_char(a.oper_code),to_char(a.fee),to_char(a.reply_time),to_char(a.reply_time),to_char(decode(a.flag1,'Z','是','否')) from dbbillprg.tellcode_inc_del_bak_"+yyyymmdd+"  a,dcustmsg b ,sregioncode c where  a.reply_time between :startTime and :s_emdtime and a.msisdn=b.phone_no and substr(b.belong_code,1,2)=c.region_code and a.reply_time is not null";
	inParam[1] = "startTime="+beginTime+",s_emdtime="+endTime;

		
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam1[0]%>"/> 
	</wtc:service>
	<wtc:array id="newDateArr" scope="end" />
<%	

	if(newDateArr!=null&&newDateArr.length>0){
    sysdate = newDateArr[0][0];        
  }
	if(sysdate!=null&&!"".equals(sysdate)&&(sysdate.substring(0,6)==beginTime.substring(0,6)||sysdate.substring(0,6).equals(beginTime.substring(0,6)))){
		inParam[0]="select to_char(a.msisdn),c.region_name,decode(a.order_flag,'1','包月','0','点播'),decode(a.zy_flag,'1','梦网','0','自有'),substr(serv_name,0,200),to_char(a.oper_code), to_char(a.fee),to_char(a.reply_time),to_char(a.reply_time),decode(a.flag1,'Z','是','否') from dbbillprg.tellcode_inc_del_bak a,dcustmsg b ,sregioncode c where a.reply_time between :startTime and :s_emdtime  and a.msisdn=b.phone_no and substr(b.belong_code,1,2)=c.region_code and a.reply_time is not null";
		//inParam[0]="select to_char(a.msisdn),c.region_name,decode(a.order_flag,'1','包月','0','点播'),decode(a.zy_flag,'1','梦网','0','自有'),1,to_char(a.oper_code), to_char(a.fee),to_char(a.reply_time),to_char(a.reply_time),decode(a.flag1,'Z','是','否') from dbbillprg.tellcode_inc_del_bak a,dcustmsg b ,sregioncode c where a.reply_time between :startTime and :s_emdtime   and a.msisdn=b.phone_no and substr(b.belong_code,1,2)=c.region_code and a.reply_time is not null";
	}
	
%>


			<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="10">
				<wtc:param value="<%=inParam[0]%>"/>
				<wtc:param value="<%=inParam[1]%>"/>
			</wtc:service>
			<wtc:array id="resultArr" scope="end" />
<%

	if(resultArr!=null&&resultArr.length>0){
		String[][] result = resultArr;
%>
<script language="javascript">
//alert("result "+"<%=result[0][0]%>");
</script>
</head>
<script language="javascript">
	function gotos(page)
	{
		//var page_now = document.all.toPage[document.all.toPage.selectedIndex].value;
		window.location.href="zg91_getMore.jsp?pageNumber="+page+"&beginTime=<%=beginTime%>&endTime=<%=endTime%>";
	}


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
	for(j=1;j< 10;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	var xy=0;
	for(var a=0;a <regionChecks.length;a++)
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
	//parent.window.location.href = "zg91.jsp";
}	

	function updateMsg(rowId){
		var msgArr = new Array();

		$("#msgDiv").children("span").text(msgArr[rowId]);
	}
	$(document).ready(function(){
		 
		var msgNode = $("#msgDiv").css("border","1px solid #999").width("360px")
            .css("position","absolute").css("z-index","99")
            .css("background-color","#dff6b3").css("padding","8");
        msgNode.hide();
		
		var as = $("a[@space='bindBag']");
        as.css("cursor","hand").css("font-weight","600");
        as.mouseover(function(event){
    		//获取当前准备显示的行数
            var aNode = $(this);
            aNode.css("color","#3366CC");
            var divNode = aNode.parent();
            sid = divNode.attr("rowId");
            updateMsg(sid);
            var myEvent = event || windows.event;
			var divY = 0;
			divY = myEvent.clientY + msgNode.height();
			if(divY > 430){
				//alert("gaole");
				divY = 345 - msgNode.height();
			}else{
				divY = myEvent.clientY - 70;
			}
        	msgNode.css("left",myEvent.clientX - 390 + "px").css("top",divY + "px");
        	//浮动框显示
        	msgNode.show();
    	});
    	as.mouseout(function(){
    		var aNode = $(this);
            aNode.css("font-weight","600").css("color","#333333");
        	msgNode.hide();
    	});
	});
	
</script>
<body>
	<div id="Operation_Table">
	<table cellspacing="0" id="queryMsgTab">
		<tr>
			<th>手机号码</th>
			<th>归属地</th>
			<th>计费类型</th>
			<th>业务分类</th>
			<th>业务名称</th>
			<th>业务代码</th>
			<th>资费标准</th>
			<th>客户回复信息时间</th>
			<th>系统回复客户时间</th>
			<th>是否减免费用</th>
			 
		</tr>
		<%
		// 总页数
			allPage = (Integer.parseInt(String.valueOf(result.length))- 1) / everyPage + 1 ;
			//每页到达条数
			int lastNo=everyPage*iPageNumber;
			//如果是最后一页并且不是整页
			if(result.length%everyPage!=0&&result.length%everyPage<everyPage&&iPageNumber==allPage){
				lastNo=result.length%everyPage*1+(iPageNumber-1)*everyPage*1;

			}
			//for(int i =0; i < result.length; i++){
			for(int i = (iPageNumber-1)*everyPage; i < lastNo; i++){
		%>
		<tr>
			<td><%=result[i][0]%></td>
			<td><%=result[i][1]%></td>
			<td><%=result[i][2]%></td>
			<td><%=result[i][3]%></td> 
			<td><%=result[i][4]%></td>
			<td><%=result[i][5]%></td>
			<td><%=result[i][6]%></td>
			<td><%=result[i][7]%></td> 		
			<td><%=result[i][8]%></td>
			<td><%=result[i][9]%></td>
			</td>
		</tr>
	<%
		}
	%>
	</table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
				<input type="button"  class="b_text" onClick="exportExcel('Operation_Table')" value="导出当页EXCEL">
				<input type="button"  class="b_text" onClick="exportExcel('Operation_TableAll')" value="全量导出EXCEL">

			</td>
	  </tr>
 </table> 
  	
</div>
					<!--分页-->
					<div align="center">
						<table align="center">
						<tr>
							<td align="center">
								总记录数：<font name="totalPertain" id="totalPertain"><%=result.length%></font>&nbsp;&nbsp;
								总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
								当前页：<font name="currentPage" id="currentPage"><%=iPageNumber%></font>&nbsp;&nbsp;
								每页行数：<%=everyPage%>
								&nbsp;&nbsp;跳转到
								<select name="toPage" id="toPage" style="width:80px" onchange="gotos(this.value);">
									<%
									for (int i = 0; i <= allPage; i ++) {
										if(i==0)
										{
											%>
												<option value="<%=i%>">--请选择</option>
											<%
										}
										else
										{
											%>
												<option value="<%=i%>">第<%=i%>页</option>
											<%
										}
									
									}
									%>
								</select>
								页
								<input type="button" class="b_foot" value="关闭" onclick="window.close()">
							</td>
						</tr>
						</table>
					</div>
					<!--end 分页-->	
							
				<input type="hidden" id="nowPage" />
				<input type="hidden" id="allPage" value="<%= allPage %>" />		
<!--全量-->	
 	<div  id="Operation_TableAll">
	<table style="display: none" cellspacing="0" id="queryMsgTabAll">
		<tr>
			<th>手机号码</th>
			<th>归属地</th>
			<th>计费类型</th>
			<th>业务分类</th>
			<th>业务名称</th>
			<th>业务代码</th>
			<th>资费标准</th>
			<th>客户回复信息时间</th>
			<th>系统回复客户时间</th>
			<th>是否减免费用</th>
			 
		</tr>
		<%
			for(int i =0; i < result.length; i++){
		%>
		<tr>
			<td><%=result[i][0]%></td>
			<td><%=result[i][1]%></td>
			<td><%=result[i][2]%></td>
			<td><%=result[i][3]%></td> 
			<td><%=result[i][4]%></td>
			<td><%=result[i][5]%></td>
			<td><%=result[i][6]%></td>
			<td><%=result[i][7]%></td> 		
			<td><%=result[i][8]%></td>
			<td><%=result[i][9]%></td>
			</td>
		</tr>
	<%
		}
	%>
	</table>  	
</div>
 <!--全量end-->	

 
</body>
</html>


<%
	}else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("查询结果为空!",0);
		//parent.window.location.href = "zg91.jsp";
		Window.close();

	</script>
<%
	}
%>


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
 myWorksheet.name="扣费主动提醒短信处理明细";
 
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