<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "e569";
	String opName = "投诉退费统计查询";
 	String[][] result = new String[][]{}; 
	String beginYm = request.getParameter("beginYm");	
	String endYm = request.getParameter("endYm");	
	String tjtj = request.getParameter("tjtj");	
	String tjtj1 = request.getParameter("tjtj1");
	String inParas[] = new String[2];
	inParas[0] = "select to_char(nvl(b.spname,'无')),to_char(nvl(a.spid,'无')),to_char(nvl(count(a.third_code),'0')),to_char(nvl(sum(a.system_price),'0')) ,third_code from drefundmsg a,ddsmpspinfo b where a.third_code in (select third_code from srefundthird c where c.third_name =:tjtj  ) and a.spid=b.spid(+) and a.op_time between to_date(:beginYm,'YYYYMMDD hh24:mi:ss') and to_date(:endYm,'YYYYMMDD hh24:mi:ss') group by a.spid,b.spname,third_code order by count(a.spid) desc";
	inParas[1] ="tjtj="+tjtj1+",beginYm="+beginYm+" 00:00:00"+",endYm="+endYm+" 23:59:59";
%> 
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="5">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
if(ret_val==null||ret_val.length==0)
{
	%><HEAD><TITLE>投诉退费统计查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">投诉退费统计查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
		<th nowrap>sp名称</th>
		<th nowrap>spID</th>
		<th nowrap>退费次数</th>
		<th nowrap>退费费用</th>
		<th nowrap>退费三级原因</th>
		<th nowrap>业务名称</th>
		
	<tr>
	<tr>
		<td colspan=6 align=center><font color=red border>无查询结果</font></td>
	</tr>


		<td align="center" id="footer" colspan="8">
		   <input class="b_foot" name=back onClick="window.location='e569_1.jsp?opCode=e569&opName=投诉退费统计查询'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else
{
	%><HEAD><TITLE>投诉退费统计查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">投诉退费统计查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>sp名称</th>
		<th nowrap>spID</th>
		<th nowrap>退费次数</th>
		<th nowrap>退费费用</th>
		<th nowrap>退费三级原因</th>
		<th nowrap>业务名称</th>
	<tr>
	<%
		  for(int y=0;y<ret_val.length;y++)
		  {
			 
	%>
			<tr>
	<%    	    for(int j=0;j<ret_val[0].length;j++)
				{
	%>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][j]%></td>
	<%	        }
	%>			<td height="25" nowrap>&nbsp;<%=tjtj1%></td>
			</tr>
	<%	   }
	%>
	


		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back onClick="window.location='e569_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
%>	 
<script language="javascript">
	var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
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
 excelObj.WorkBooks.Add;
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
}
</script>		
 

