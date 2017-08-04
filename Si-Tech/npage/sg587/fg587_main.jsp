<%
    /*************************************
    * 功  能: 网上终端营销案订单管理 g587
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2013-4-15
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
%>
<%   
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
 		/* 获取系统当前时间 */
 		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 		/* 当月第一天 */
 		String firstDay = dateStr.substring(0,6) + "01";
 		String regionCode= (String)session.getAttribute("regCode");
 		String groupId= (String)session.getAttribute("groupId");
%>

<html>
<head>
	<title>网上终端营销案订单管理</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	
	<script language="javascript">
		function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			var startTimeVal = $("#startTime").val().trim();
			var endTimeVal 	= $("#endTime").val().trim();

		  if(startTimeVal.length == 0 || endTimeVal.length == 0){
		    rdShowMessageDialog("请输入开始时间和结束时间！",0);
			  return false;
		  }
		  if(startTimeVal.substring(0,4)==endTimeVal.substring(0,4)) {
        if(startTimeVal.substring(4,6)==endTimeVal.substring(4,6)) {
          if(parseInt(startTimeVal.substring(6,8),10)>parseInt(endTimeVal.substring(6,8),10)) {
            rdShowMessageDialog("结束日期天数应该大于开始日期天数！",0);
            return false;
          }
        }else {
          rdShowMessageDialog("不允许跨月份查询！",0);
          return false;
        }
			}else{
				rdShowMessageDialog("不允许跨年份查询！",0);
				return false;
			}
			var getdataPacket = new AJAXPacket("fg587_ajax_query.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("startTime",startTimeVal);
			getdataPacket.data.add("endTime",endTimeVal);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			getdataPacket.data.add("qry_no",$("#qry_no").val());
			getdataPacket.data.add("qry_pho",$("#qry_pho").val());
			getdataPacket.data.add("odr_id",$("#odr_id").val());
			core.ajax.sendPacketHtml(getdataPacket);
			getdataPacket = null;
		}
		function doProcess(data){
			//找到添加表格的div
			var markDiv=$("#intablediv"); 
			//清空原有表格
			markDiv.empty();
			markDiv.append(data);
			document.form1.toexcel.disabled=false;
		} 
		function doReset(){
			window.location.href="fg587_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">终端销售订单查询</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">开始时间</td>
			<td>
				<input type="text" name="startTime" id="startTime" value="<%=firstDay%>" 
				 maxlength="8" v_type="date" onblur="checkElement(this)" readOnly />
				<img onclick="WdatePicker({el:startTime,dateFmt:'yyyyMMdd',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
			</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" name="endTime" id="endTime" value="<%=dateStr%>" 
				 maxlength="8" v_type="date" onblur="checkElement(this)" readOnly />
				<img onclick="WdatePicker({el:endTime,dateFmt:'yyyyMMdd',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">				 
			</td>
		</tr>
		<tr>
			<td class="blue">查询工号</td>
			<td>
				<input type="text" name="qry_no" id="qry_no" value="" 
					maxlength="6" size='11' />
			</td>
			<td class="blue">查询手机号</td>
			<td>
				<input type="text" name="qry_pho" id="qry_pho" value="" 
					maxlength="15" size='23' />
			</td>			
		</tr>
		<tr>
			<td class="blue">订单号</td>
			<td colspan='3'>
				<input type="text" name="odr_id" id="odr_id" value="" 
					maxlength="16" size='21' v_type="int" onblur="checkElement(this)"/>
			</td>		
		</tr>		
		
	</table>
	<table cellspacing="0">
		<tr>
			<td>
				<div align="center">
				<input type="button" name="query" class="b_foot" value="查询" onclick="doQuery()" />
				&nbsp;
				<input type="button" name="toexcel" class="b_foot" value="导出" onclick="printTable(t1);" disabled/>
				&nbsp;
				<input type="reset" name="reset" class="b_foot" value="重置" onclick="doReset()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
				</div>
			</td>
		</tr>
	</table>
	<div id="intablediv">
	</div>

	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 

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
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 
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

</script>