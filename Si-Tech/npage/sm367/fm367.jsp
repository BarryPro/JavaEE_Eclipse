<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");

%>
  
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
  onload=function()
  {

  
  }
				
 
    
		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
			


 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	
	
		function doquery()
		{
		
		  var querymsg2 = $("#querymsg2").val();
			if(querymsg2.trim()==""){
				rdShowMessageDialog("请输入操作代码进行查询！",1);
				return false;
			}
    
        var myPacket = new AJAXPacket("fm367Qry.jsp","正在查询信息，请稍候......");
        myPacket.data.add("querymsg2",querymsg2.trim());
				core.ajax.sendPacketHtml(myPacket,querinfo,true);
				getdataPacket = null;		
		
		}
		
		
				function schange()
		{
			  $("#showTab").empty();
				$("#querymsg2").val("");
		}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
              
       <table id="add" style="display:block">
					        
       	        <tr>
					        <td class='blue' width=16%>操作代码</td>
					        <td>

								<input type="text" value="" name="querymsg2" id="querymsg2"    maxlength="4" />
								<font class="orange">*</font>
								<input  name="quchoose" id="quchoose" class="b_text" type=button value=查询  onclick="doquery()" >

					        </td>
					      </tr>					          			
   							        	
              </table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input type="button" name="toexcel" class="b_foot" value="导出" onclick="printTable(t1);" />
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		          <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />


    <%@ include file="/npage/include/footer_simple.jsp"%>
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
  sheet.Columns("A").ColumnWidth =8;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =20;//设置列宽 
  sheet.Columns("C").ColumnWidth =15;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =20;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//设置列宽
  sheet.Columns("E").numberformat="@"; 

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
  sheet.Columns("A").ColumnWidth =8;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =20;//设置列宽 
  sheet.Columns("C").ColumnWidth =15;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =20;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//设置列宽
  sheet.Columns("E").numberformat="@"; 

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