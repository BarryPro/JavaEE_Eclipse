<%
/********************
 version v2.0
开发商: si-tech
*
*update:wanghyd@2013-12-2 
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode  = request.getParameter("opCode");
	String opName  = request.getParameter("opName");			
%>

<script>

function doCheck2()
{	

	if(checkElement(document.frm.srv_no)==false) {
		return false;
	}
			
 
 var srv_no=document.frm.srv_no.value.trim();
 var optypes=$("#banlitype").val()
 
	var myPacket = new AJAXPacket("fm008_qry.jsp","正在查询信息，请稍候......");
	myPacket.data.add("srv_no",srv_no);
	myPacket.data.add("optypes",optypes);
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;
}
  function checkSMZValue(data) {
				//找到添加表格的div
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				//document.frm.toexcel.disabled=false;
}

function returnpages() {
	window.location.href="fm008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}

function changetype() {
				 var optypes=$("#banlitype").val();
				var markDiv=$("#gongdans"); 
				//清空原有表格
				markDiv.empty();
				 if(optypes=="1") {
				$("#zifeizengli1").show();
				$("#zhongduanlei1").hide();
				$("#xinyingxiaohuodongzhixing1").hide();
				}else if(optypes=="0") {
				$("#zifeizengli1").hide();
				$("#zhongduanlei1").show();
				$("#xinyingxiaohuodongzhixing1").hide();
				}else if(optypes=="2") {
				$("#xinyingxiaohuodongzhixing1").show();
				$("#zifeizengli1").hide();
				$("#zhongduanlei1").hide();
				}

}


</script>

<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body onload="changetype()">
<FORM method=post name="frm">
	
  
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="16%">手机号码</td>
          		<td width="84%">
                <input type="text" size="17" value="" maxLength="13" name="srv_no" id="srv_no" v_must="1"  maxlength="11" v_type="mobphone">
      			</td>
      	</TR>		       
        <TR>
          <TD class="blue">查询类型</td>
          <td> 
          			<select id="banlitype" name="banlitype" onChange="changetype()">
								<option value="1">资费赠礼类</option>
								<option value="0">终端类</option>
								<option value="2">新营销活动执行</option>
							  </select>
          	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" name="Button1" value="查询" onclick="doCheck2()">		
          </TD>
        </tr>
        
 		<tr height='25' align='left'   id="zifeizengli1">
		<td colspan='4' >
		<font color="red" style="display:">
		
		  业务范围：统一预存赠礼(2289)；赠送预存款营销案(8379)；四喜号码营销案申请（e462）。

			
			</font> 
		</td>
		</tr>
		
		 	<tr height='25' align='left' id="zhongduanlei1">
		<td colspan='4' style="display:">
		<font color="red">
		

			业务范围：购机赠礼(1145)；合约计划预存购机(d069)；预存购机-合约(g975)；购机赠费(i101)；积分换机(1143)；合约计划购机(e505)；买手机、送话费(8027)；预存话费优惠购机(1141)；购机赠话费（按月返还）(7955)。
			
			</font> 
		</td>
		</tr>
		<tr height='25' align='left' id="xinyingxiaohuodongzhixing1">
		<td colspan='4' style="display:">
		<font color="red">

			1、展示用户办理的所有营销案信息，状态包括：订购、冲正、取消、退机；
			2、若用户办理营销案中包含资费，则按照资费个数多行展示；
			3、列表中展示的时间均为订购时记录的开始、结束时间，若状态为冲正、取消、退机，则请以实际资费时间为准;
			4、营销方式开始、结束时间无内容的为历史数据没有记录；资费代码、名称、主/附加、开始、结束时间无内容的为无资费的营销活动。

			</font> 
		</td>
		</tr>
    
      </TBODY>
	  </TABLE>
   
      
      	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					
					&nbsp; <input class="b_foot" name=back onClick="returnpages()" type=button value=清除>
						&nbsp;<input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
		
			</div>
			</td>
		</tr>
	</table>
			<div id="gongdans">
		</div>	
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
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

