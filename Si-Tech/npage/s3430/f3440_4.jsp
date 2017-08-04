<%
  /*************************************
  * 功  能: APN代码维护 查询 3474
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: @ 2012-2-28
  **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
    
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");

  String loginName =(String)session.getAttribute("workName");
  String orgCode =(String)session.getAttribute("orgCode");
  String loginNo = (String)session.getAttribute("workNo");
  String ip_Addr = request.getRemoteAddr();
  String regCode = (String)session.getAttribute("regCode");
  String rpt_right = (String)session.getAttribute("rptRight");
  
  String sqlStr ="select region_code,	apn_code,	apn_name,valid_flag,apn_id ,command_code,re_flag,four_flag FROM sapncode  order by region_code,apn_code";
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="8"> 
  <wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
  <wtc:array id="ListName"  scope="end"/>

<%
  if(!"000000".equals(retCode)){
%>
    <script language=javascript>
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="/s3430/s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%
  }else{
    if(ListName[0].length==0){
%>
      <script language='jscript'>
        rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
        window.location.href="/s3430/s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      </script>
<%
    }
%>
<%@ include file="/npage/include/header.jsp"%>
<%
			out.println("<table id=\"tabList\" name=\"tabList\" align=\"center\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#ECF5FB\" width =\"500\">");

			out.print("<th  ><FONT size =2>地区</FONT></th>");
			out.print("<th  ><FONT size =2>apn代码</FONT></th>");
			out.print("<th  ><FONT size =2>apn名称</FONT></th>");
			out.print("<th  ><FONT size =2>使用标志</FONT></th>");
			out.print("<th  ><FONT size =2>重用标志</FONT></th>");
			out.print("<th  ><FONT size =2>4G APN标志</FONT></th>");

			for(int i =0;i<ListName.length;i++)
			{
				out.println("<tr align=\"center\">");
				out.println("<td type = \"text\" name = a"+i+" id = a"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][0]);
				out.println("</FONT></td>");
				out.println("<td type = \"text\" name = b"+i+" id = b"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][1]);
				out.println("</FONT></td>");
				out.println("<td type = \"text\" name = a"+i+" id = a"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][2]);
				out.println("</FONT></td>");
				out.println("<td type = \"text\" name = b"+i+" id = b"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][3]);
				out.println("</FONT></td>");
				out.println("<td type = \"text\" name = a"+i+" id = a"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][6]);
				out.println("</FONT></td>");
				out.println("<td type = \"text\" name = a"+i+" id = a"+i+" nowrap class=lb><FONT size =2>");
				out.println(ListName[i][7]);
				out.println("</FONT></td>");				
				
				out.println("</tr>");
			}

		out.println("</table>");
		out.println("<table align=\"center\" border=\"0\" borderColorDark=\"#FFFFFF\" borderColorLight=\"#000000\" width =\"500\">");
		out.println("<tr><td align = center height=\"40\">使用标志说明: 0:未使用 1:已使用 2:重新启用 <br>重用标志说明: 0:否 1:是 <br>4G APN标志说明：0:2/3G 1:2/3/4G");
		out.println(" ");
		out.println(" <div id=\"mybutton2\" style=\"display:\"><input type='button' value='导出' class=\"b_foot\" onclick='printTable(tabList)' />");
		out.println("<INPUT id=Exit class=\"b_foot\"   type=button size=35 value=返回 name=Exit onclick=\"backHome()\">");
		out.println("</div></td>");
		out.println("</tr>");
		out.println("</table>");
%>
<%@ include file="/npage/include/footer.jsp"%>
<%  }
%>
<script language="javascript">
var excelObj;

function printTable(obj){

	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	total_row = 0;

	if(document.all.tabList.length > 1)	{

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

  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  
  sheet.Columns("F").numberformat="@";

  sheet.Columns("G").ColumnWidth =10;//设置列宽 



		for(a=0;a<document.all.tabList.length;a++)

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

  sheet.Columns("A").ColumnWidth =9;//设置列宽 

  sheet.Columns("A").numberformat="@";

  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("B").numberformat="@";

  sheet.Columns("C").ColumnWidth =21;//设置列宽 

  sheet.Columns("C").numberformat="@";

  sheet.Columns("D").ColumnWidth =14;//设置列宽 

  sheet.Columns("D").numberformat="@";

  sheet.Columns("E").ColumnWidth =16;//设置列宽

  sheet.Columns("E").numberformat="@"; 

  sheet.Columns("F").ColumnWidth =14;//设置列宽 
  
  sheet.Columns("F").numberformat="@";

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

function backHome()
{
	window.location.href="s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}


</script>