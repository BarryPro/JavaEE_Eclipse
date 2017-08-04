<%
/********************
 version v2.0
开发商: si-tech
*
*create:zhangyta@2012-04-05
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "e749";
	String opName = "购机入网-让利查询";
 	String[][] result = new String[][]{}; 
	
	String phoneNo = request.getParameter("phoneNo");
	String inParas[] = new String[2];
	//inParas[0] = "select a.begin_date,a.end_date,to_char(a.all_fav_fee),to_char(a.use_fav_fee),to_char(a.all_fav_fee-a.use_fav_fee) from wcustfavopr a,dcustmsg b where a.id_no=b.id_no and a.phone_no=:phoneNo"; 
	inParas[0] = "select w.begin_date,w.end_date,to_char(w.all_fav_fee),to_char(w.use_fav_fee),to_char(w.all_fav_fee-w.use_fav_fee) from wcustfavopr w,(select id_no from dcustmsg where phone_no = :phoneNo) t1 where w.id_no = t1.id_no and w.flag != '2' and to_char(sysdate,'yyyymmdd') between w.begin_date and w.end_date and w.use_fav_fee < w.all_fav_fee";
 
	inParas[1] ="phoneNo="+phoneNo;
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
		<div id="title_zi">购机入网-让利计划查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
		<th nowrap>营销案办理时间</th>
		<th nowrap>营销案结束时间</th>
		<th nowrap>合约期内总优惠额度</th>
		<th nowrap>截止上月末已优惠的额度</th>
		<th nowrap>优惠额度余额</th>
	 
		
	<tr>
		<tr>
			<td colspan=6 align=center><font color=red border>无查询结果</font></td>
		</tr>


		<td align="center" id="footer" colspan="8">
		   <input class="b_foot" name=back onClick="window.location='e749_1.jsp?opCode=e749&opName=购机入网-让利查询'" type="button" value="返回">
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
	%><HEAD><TITLE>购机入网-让利计划查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">购机入网-让利计划查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	  <th nowrap>营销案办理时间</th>
		<th nowrap>营销案结束时间</th>
		<th nowrap>合约期内总优惠额度</th>
		<th nowrap>截止上月末已优惠的额度</th>
		<th nowrap>优惠额度余额</th>
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
	%>		 
			</tr>
	<%	   }
	%>
	


		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='e749_1.jsp'" type="button" value="返回">
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
 

