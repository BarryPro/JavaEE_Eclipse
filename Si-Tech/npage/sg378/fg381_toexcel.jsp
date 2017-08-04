<%
/*************************************
* 功  能: g381·虚拟V网用户查询结果
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: shengzd @ 2010-03-22
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("phoneNo");
    String groupNo = request.getParameter("groupNo");
    String pageNum = request.getParameter("pageNum");//跳转的页数
    String rowNum = request.getParameter("rowNum");//每页显示的数量
    String pageCount = "";//总页数
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	String groupName = "";
	String groupNo_new = "";
	
	
	/**************** 分页设置 ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		String[][] allNumStr = new String[][]{};
		String num = "0";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<wtc:service name="sg381Qry"  routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
		<wtc:param value="<%=Integer.toString(iPageNumber)%>"/>
		<wtc:param value="<%=Integer.toString(iPageSize)%>"/>	
	</wtc:service>
	<wtc:array id="qryArr" start="0" length="9" scope="end"/>
	<wtc:array id="qryArr2" start="9" length="1" scope="end"/>
	

<%

	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		num = qryArr2[0][0];
	}
%>		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
	  onload=function()
  {
printTable(t1);
   }
  
</script>

<body>
<form name="frm2" action="" method="post" >

		
		<div id="groupTable">
			<div id="Operation_Table" style="padding:0px">
					<table id="t1" cellspacing="0"  vColorTr="set" style="display:none">
							<tr>	
								<th>集团号</th>			
								<th>集团名称</th>
								<th>用户手机号码</th>			
								<th>用户名称</th>
								<th>当月资费</th>			
								<th>下月资费</th>
								<th>成员账号</th>
								<th>运行状态</th>
								<th>加入集团时间</th>
							</tr>
							<%
								if(qryFlag) {
									for(int i=0;i<qryArr.length;i++) {
										out.println("<tr><td>" + qryArr[i][0] + "</td>" +
											        "<td>" + qryArr[i][1] + "</td>" +
											        "<td>" + qryArr[i][2] + "</td>" +
											        "<td>" + qryArr[i][3] + "</td>" +
											        "<td>" + qryArr[i][4] + "</td>" +
											        "<td>" + qryArr[i][5] + "</td>" +
											        "<td>" + qryArr[i][6] + "</td>" +
											        "<td>" + qryArr[i][7] + "</td>" +
											        "<td>" + qryArr[i][8] + "</td>" +
											        "</tr>"
											    );
									}
								}
							%>

					</table>
			</div>
		</div>
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
  sheet.Columns("E").ColumnWidth =25;//设置列宽
  sheet.Columns("F").ColumnWidth =25;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
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
window.close();
}

</script>