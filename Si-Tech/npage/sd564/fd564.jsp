<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d564";
 		String opName = "网上预约选号信息查询";
 		/* 获取系统当前时间 */
 		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 		/* 当月第一天 */
 		String firstDay = dateStr.substring(0,6) + "01";
 		System.out.println("=======fd564.jsp===" + dateStr + "|" + firstDay);
 		String regionCode= (String)session.getAttribute("regCode");
 		String groupId= (String)session.getAttribute("groupId");
 	
%>
<html>
<head>
	<title>网上预约选号信息查询</title>
	<script language="javascript">
	  $(document).ready(function(){
      $("input[name='opFlag']").click(function(){
        //找到添加表格的div
				var markDiv=$("#intablediv"); 
				//清空原有表格
				markDiv.empty();
				//document.form1.toexcel.disabled=true;
      });
    });
		function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			var phoneNoVal 	= $("#phoneNo").val().trim();
			var orderNoVal 	= $("#orderNo").val().trim();
			var idCardNoVal = $("#idCardNo").val().trim();
			var startTimeVal = $("#startTime").val().trim();
			var endTimeVal 	= $("#endTime").val().trim();
			if(phoneNoVal.length==0 && orderNoVal.length==0 && idCardNoVal.length==0)
			{
					rdShowMessageDialog("请至少输入手机号码、订单号、身份证号中的一个！",0);
  			  return false;
			}
			if(startTimeVal.length == 0 || endTimeVal.length == 0){
			    rdShowMessageDialog("请输入开始时间和结束时间！",0);
  			  return false;
			  }
			  if(startTimeVal.substring(0,4)==endTimeVal.substring(0,4)) {
          if(startTimeVal.substring(4,6)==endTimeVal.substring(4,6)) {
          	 if(startTimeVal.substring(6,8)>endTimeVal.substring(6,8)) {
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
			/* 如果开始四样都没输入，则时间必须输入 */
			if(phoneNoVal.length == 0 && orderNoVal.length == 0 
			  && idCardNoVal.length == 0 && (startTimeVal.length == 0 || endTimeVal.length == 0)){
			  	
			  	rdShowMessageDialog("其他信息不输入时，时间必须输入",0);
			  	return false;
			}
			var getdataPacket = new AJAXPacket("fd564_qry.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("phoneNo",phoneNoVal);
			getdataPacket.data.add("orderNo",orderNoVal);
			getdataPacket.data.add("idCardNo",idCardNoVal);
			getdataPacket.data.add("startTime",startTimeVal);
			getdataPacket.data.add("endTime",endTimeVal);
			getdataPacket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacketHtml(getdataPacket);
			getdataPacket = null;
			
		}
		function doProcess(data){
				//找到添加表格的div
				var markDiv=$("#intablediv"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				//document.form1.toexcel.disabled=false;
		}
		function doReset(){
			window.location.href = "/npage/sd564/fd564.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		

	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">网上预约选号信息查询</div>
	</div>
	<table cellspacing="0">
		<tr>
	    <td class="blue">手机号码</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" maxlength="15" 
				 v_type="mobphone" onblur="checkElement(this)" />
			</td>
			<td class="blue">订单号</td>
			<td>
				<input type="text" name="orderNo" id="orderNo" value="" 
				 maxlength="30"  onblur="checkElement(this)" />
			</td>
	  </tr>
	  <tr>
			<td class="blue">身份证号</td>
			<td colspan="3">
				<input type="text" name="idCardNo" id="idCardNo" value="" 
				 maxlength="20" v_type="idcard" onblur="checkElement(this)" />
			</td>
		</tr>
		<tr>
			<td class="blue">开始时间</td>
			<td>
				<input type="text" name="startTime" id="startTime" value="<%=firstDay%>" 
				 maxlength="8" v_type="date" onblur="checkElement(this)" />
			</td>
			<td class="blue">结束时间</td>
			<td>
				<input type="text" name="endTime" id="endTime" value="<%=dateStr%>" 
				 maxlength="8" v_type="date" onblur="checkElement(this)" />
			</td>
		</tr>
		<tr>
			<td colspan="4"><font class="red">注：手机号码、订单号、身份证号选择一个输入即可。</font></td>
		</tr>
	</table>
	<div id="intablediv">
	</div>
	<table cellspacing="0">
		<tr>
			<td>
				<div align="center">
				<input type="button" name="query" class="b_foot" value="查询" onclick="doQuery()" />
				&nbsp;
				<!--<input type="button" name="toexcel" class="b_foot" value="导出" onclick="printTable(t1);" disabled/>-->
				&nbsp;
				<input type="reset" name="reset" class="b_foot" value="清除" onclick="doReset()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
				</div>
			</td>
		</tr>
	</table>
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