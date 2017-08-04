<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟2015-7-27 16:56:29------------------
十一、在营业前台新增中奖查询功能，查询条件为预约年月，展示结果为手机号码，姓名，证件号码，联系人，联系人电话
 -------------------------后台人员：dujl--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  java.util.Calendar j_calendar = java.util.Calendar.getInstance();
  //j_calendar.add(java.util.Calendar.MONTH, -1);// 月份减1  
	String p_month_date = new java.text.SimpleDateFormat("yyyyMM").format(j_calendar.getTime());
	
	
	String current_timestart=new SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
	
	String kaishitimes=current_timestart+"01";
	
	String current_timeend=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>

  onload=function()
  {
		changeType("aaa");
  	$("#toexcel1").hide();
  }
  
  	function changeType(opCode){

	$("#showTab2").empty();
	$("#upgMainTab tr:gt(0)").remove();
	
	if(opCode == "aaa"){
		
	$("#zjxy1").show();
	$("#upgMainTab").hide();	
	$("#zjxy2").hide();
	$("#toexcel").hide();

	}
	if(opCode == "bbb"){
 
	$("#zjxy1").hide();
	$("#upgMainTab").hide();	
	$("#zjxy2").show();
	$("#toexcel1").hide();

	}	
	
}

//重置刷新页面
function reSetThis(){
	  location = location;	
}



//查询动态展示IMEI号码列表
function go_sM290Qry(){

	var packet = new AJAXPacket("fm290_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("y_year_month",$("#y_year_month").val().trim());//
			packet.data.add("region_code","");//
			core.ajax.sendPacket(packet,do_sM290Qry);
			packet = null; 
}
//查询动态展示IMEI号码列表，回调
function do_sM290Qry(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab").show();	
			$("#toexcel1").show();
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				  //如果有一条空记录不展示，服务返回数据为空字符串，服务改进后此逻辑可删除
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
														 "<td>"+retArray[i][2]+"</td>"+ // 
														 "<td>"+retArray[i][3]+"</td>"+// 
														 "<td>"+retArray[i][4]+"</td>"+// 
														 
														 "<td>"+"1800"+"</td>"+// 
														 "<td>"+"50"+"</td>"+// 
														 "<td>"+"36"+"</td>"+// 
														 "<td>"+retArray[i][8]+"</td>"+// 
														 
														 "<td>"+retArray[i][10]+"</td>"+// 
												 "</tr>";
			}
			if(retArray.length==0) {
							trObjdStr += "<tr>"+
														 "<td colspan='10' align='center'>查询信息为空！</td>"+ // 
												 "</tr>";		
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

function to_excel_file(obj){
		var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.upgMainTab.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//设置列宽 
  sheet.Columns("I").ColumnWidth =20;//设置列宽
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//设置列宽 

		for(a=0;a<document.all.upgMainTab.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//设置列宽 
  sheet.Columns("I").ColumnWidth =20;//设置列宽
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//设置列宽 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

function exportTables(tableIds, flag){
  try{   
      rowIndex = 0;
      oXL = new ActiveXObject("Excel.Application");
      oWB = oXL.Workbooks.Add();
      oSheet = oWB.ActiveSheet;
      
      if (tableIds.length <= 0){
          return;
      }
      
      for (var i = 0; i < tableIds.length; i++){
          ExportToExcel(tableIds[i], flag);
      }
      //设置excel可见属性
      oXL.Visible = true;
  }catch(e){
        if((!+'\v1')){ //ie浏览器  
           alert("无法启动Excel，请确保电脑中已经安装了Excel!\n\n如果已经安装了Excel，" + 
               "请调整IE的安全级别。\n\n具体操作：\n\n"+"工具 → Internet选项 → 安全 → 自定义级别 → ActiveX 控件和插件 → 对未标记为可安全执行脚本的ActiveX 控件初始化并执行脚本 → 启用 → 确定"); 
        }else{ 
            alert("请使用IE浏览器进行“导入到EXCEL”操作！");  //方便设置安全等级，限制为ie浏览器  
        } 
    }
}

  function ExportToExcel(targetTable, flag) { 
      //取得表格行数
      $('#'+targetTable+' tr').each(function(i, e){
          var cols = $('td, th', this);
          cols.each(function(j, e){
              var value = $.trim($(this).text().replace(/\n/g, ''));
              if (value == ""){
                  value = $(this).find('input').val();
              }
              
              if (flag && (j + 1) == cols.length){
                  return true;
              }
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  
  
  function changeTGflag() {
	
	
		var starttimess = $("#workRulestarttime").val();
		var endtimess = $("#workRuleendtime").val();
		
 if(starttimess.substring(0,4)!=endtimess.substring(0,4)) {
 		rdShowMessageDialog("开始结束时间不能跨月！");
		return false;

 }		
		
 if(starttimess.substring(4,6)!=endtimess.substring(4,6)) {
 		rdShowMessageDialog("开始结束时间不能跨月！");
		return false;

 }
 
  if(starttimess.substring(6,8)>endtimess.substring(6,8)) {
 		rdShowMessageDialog("开始时间不能大于结束时间！");
		return false;

 }
 			
			
			 	var myPacket = new AJAXPacket("ajax_queryInfo.jsp","正在查询信息，请稍候......");
				myPacket.data.add("starttimess",starttimess);	
				myPacket.data.add("endtimess",endtimess);	
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
			
			
}

	function querinfo2(data){
		//找到添加表格的div
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		markDiv.append(data);
		$("#toexcel").show();		
	}	
  
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>

   <table id=""  cellspacing="0" >  	
        	  <tr>

			        		<td width=15% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="aaa"   onclick="changeType(this.value);" checked/>中奖查询 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="bbb"  onclick="changeType(this.value);"/>预约信息查询 &nbsp;&nbsp;
			        			
			    

			        		</td>

        				</tr>
       </table>
       
       
<table cellSpacing="0" id="zjxy1">
	<tr>
	     <td class="blue" width="15%">预约年月：</td>
		  <td >
			    <input type="text"  name="y_year_month" id="y_year_month" readOnly="readOnly" value="<%=p_month_date%>"  onclick="WdatePicker({dateFmt:'yyyyMM',autoPickDate:true,onpicked:function(){}})" />  
			    	&nbsp;&nbsp;<input type="button" class="b_text" value="查询" onclick="go_sM290Qry()">
		  </td>

	</tr>

</table>


    <table cellspacing="0"  id="zjxy2">
		<tr id="zengjia">
			<td class="blue" width="15%">开始时间</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=kaishitimes%>"   maxlength="17" onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
			</td>
						<td class="blue" width="15%">结束时间</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=current_timeend%>"   maxlength="17" onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='时间格式:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;时间格式:YYYYMMDD</font>	
			 
			 &nbsp;&nbsp;<input type="button" class="b_text" value="查询" onclick="changeTGflag()">
			 
			</td>
		</tr>
		
	</table>

<div class="title"><div id="title_zi">结果列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab"  name="upgMainTab">
    <tr>
        <th>手机号码</th>
        <th>姓名</th>
        <th>证件号码</th>
        <th>联系人</th>
        <th>联系人电话</th>	
        <th>预存</th>	
        <th>月消费额度(底线)</th>	
        <th>消费年限(绑定时长)</th>	
        <th>开户营业厅</th>	
        <th>地市名称</th>	
        
    </tr>
</table>
<div id="showTab2" ></div>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" id="toexcel" name="toexcel" class="b_foot" value="导出" onclick="printTable(t1);" />
	 		<input type="button" id="toexcel1" name="toexcel1" class="b_foot" value="导出" onclick="to_excel_file(upgMainTab)" />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script ="javascript">
var excelObj;

function printTable(obj){
 
	
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;  
   var ExcelSheet =  workB.WorkSheets(1);
	if(document.all.t1.length > 1)	{
		
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//设置列宽 
  sheet.Columns("I").ColumnWidth =20;//设置列宽
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//设置列宽 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
	
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("B").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").ColumnWidth =13;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").ColumnWidth =14;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//设置列宽 
  sheet.Columns("I").ColumnWidth =20;//设置列宽
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//设置列宽 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+"K"+total_row).Borders.LineStyle=1;
	/*合并单元格 第一行*/
	excelObj.Range("A1:K1").MergeCells = true;
	/*合并单元格 第total_row行*/
	excelObj.Range("B"+total_row+":E"+total_row).MergeCells = true;
	excelObj.Range("G"+total_row+":K"+total_row).MergeCells = true;
	
	/*最后三行没有网格*/
	excelObj.Range("A"+(total_row-1)+":O"+(total_row-1)).Borders.LineStyle=0;
	excelObj.Range("A"+(total_row-2)+":O"+(total_row-2)).Borders.LineStyle=0;
	excelObj.Range("A"+(total_row)+":O"+(total_row)).Borders.LineStyle=0;

	/*第一行黑体加粗 垂直水平居中*/
	excelObj.Range("A1:K1").Font.Name="黑体";
	excelObj.Range("A1:K1").Font.Bold=true;
	excelObj.Range("A1:K1").VerticalAlignment = 2;
	excelObj.Range("A1:K1").HorizontalAlignment = 3;
	/*
	ExcelSheet.ActiveSheet.Cells(0,0).Font.Name="黑体";
	ExcelSheet.ActiveSheet.Cells(0,0).Font.Bold=true;
	ExcelSheet.ActiveSheet.Cells(0,0).VerticalAlignment = 2;
	ExcelSheet.ActiveSheet.Cells(0,0).HorizontalAlignment = 3;
	*/
	//excelObj.Columns("A1:K1").Font.Bold=true;
	
	
   
}

</script>