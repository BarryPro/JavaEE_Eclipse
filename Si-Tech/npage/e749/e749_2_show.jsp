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
	String sDate =request.getParameter("sDate");
	String inParas[] = new String[3];
	if(sDate.equals("")){
		inParas[0] = "select to_char(d.YEAR_MONTH),trim(to_char(sum(d.EXFAVOUR_FEE),'99999999999990.99')) from DBACCADM.DCUSTOWE_EX d, (select w.begin_date as begin_date,w.end_date as end_date,to_char(w.all_fav_fee),to_char(w.use_fav_fee),to_char(w.all_fav_fee-w.use_fav_fee),t1.id_no as id_no from wcustfavopr w,(select id_no from dcustmsg where phone_no = :phoneNo) t1 where w.id_no = t1.id_no and w.flag != '2' and to_char(sysdate,'yyyymmdd') between w.begin_date and w.end_date and w.use_fav_fee < w.all_fav_fee) w where d.id_no = w.id_no and d.year_month between substr(w.begin_date,1,6) and substr(w.end_date,1,6) group by d.YEAR_MONTH";
		inParas[1] ="phoneNo="+phoneNo;
	}else{
		inParas[0] = "select to_char(d.YEAR_MONTH),trim(to_char(sum(d.EXFAVOUR_FEE),'99999999999990.99')) from DBACCADM.DCUSTOWE_EX d, (select w.begin_date as begin_date,w.end_date as end_date,to_char(w.all_fav_fee),to_char(w.use_fav_fee),to_char(w.all_fav_fee-w.use_fav_fee),t1.id_no as id_no from wcustfavopr w,(select id_no from dcustmsg where phone_no = :phoneNo) t1 where w.id_no = t1.id_no and w.flag != '2' and to_char(sysdate,'yyyymmdd') between w.begin_date and w.end_date and w.use_fav_fee < w.all_fav_fee) w where d.id_no = w.id_no and   d.year_month = :sDate and   d.year_month between substr(w.begin_date,1,6) and substr(w.end_date,1,6) group by d.YEAR_MONTH";
  	inParas[1] ="phoneNo="+phoneNo+",sDate="+sDate;
	}
%> 
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="2">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
if(ret_val==null||ret_val.length==0)
{
	%><HEAD><TITLE>优惠信息明细查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frme749_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">购机入网-让利计划查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
		<th nowrap>账务年月</th>
		<th nowrap>本次优惠</th>
	<tr>
		<tr>
			<td colspan=6 align=center><font color=red border>无查询结果</font></td>
		</tr>


		<td align="center" id="footer" colspan="8">
		   <input class="b_foot" name=back onClick="window.location='e749_2.jsp?opCode=e749&opName=购机入网-让利查询'" type="button" value="返回">
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
<FORM method=post name="frme749_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">购机入网-让利计划查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	  <th nowrap>账务年月</th>
		<th nowrap>本次优惠</th>
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
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='e749_2.jsp'" type="button" value="返回">
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
 


