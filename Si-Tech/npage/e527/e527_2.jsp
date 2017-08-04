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
	String opCode = "e527";
	String opName = "系统充值失败数据查询";
	String phoneNo = request.getParameter("phoneNo");	
	String beginYm = request.getParameter("beginYm");	
	String endYm = request.getParameter("endYm");	
	String cityId = request.getParameter("cityId");	
 	String[] inParas2 = new String[2];
	String sql_1="select to_char(count(*)) from pcustpregift_error where 1=1";
	String sql_2="";
	String sql_3="";
	String sql_4="";
	int i_count2=0;
	int i_count=0;
	inParas2[0]="select to_char(count(*)) from pcustpregift_error where 1=1 ";
	/*
	if(phoneNo!="" &&(!phoneNo.equals("")) )
	{
		sql_2=" and phone_no="+phoneNo;
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA sql_2 is "+sql_2);
	}
	if((beginYm!="" &&(!beginYm.equals(""))) &&(endYm!="" &&(!endYm.equals(""))) )
	{
		sql_3=" and substr(total_date,1,6) between "+beginYm+" and "+endYm;
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB sql_3 is "+sql_3);
	}
	if(cityId!="0" &&(!cityId.equals("0")) )
	{
		sql_4="and phone_no in (select phone_no from dcustmsg where substr(belong_code,1,2)="+cityId+")";
		System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC sql_4 is "+sql_4);
	}*/
	if(phoneNo!="" &&(!phoneNo.equals("")) )
	{
		sql_1+=" and phone_no="+phoneNo;
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA sql_1 is "+sql_1);
		 
	}
	if((beginYm!="" &&(!beginYm.equals(""))) &&(endYm!="" &&(!endYm.equals(""))) )
	{
		sql_1+=" and substr(total_date,1,6) between "+beginYm+" and "+endYm;
		//System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB sql_1 is "+sql_1);
		 
	}
	if(cityId!="0" &&(!cityId.equals("0")) )
	{
		sql_1+="and phone_no in (select phone_no from dcustmsg where substr(belong_code,1,2)="+cityId+")";
		//System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC sql_1 is "+sql_1);
	}

%>
<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sql_1%></wtc:sql>
 
</wtc:pubselect>
<wtc:array id="ret_val" scope="end" />

<%
	if(ret_val!=null&&ret_val.length>0)
	{
		i_count2=(Integer.parseInt(ret_val[0][0]))/10;
		if((Integer.parseInt(ret_val[0][0]))%10==0)
		{
			i_count=i_count2;
		}
		else
		{
			i_count=i_count2+1;
		}
		
	}
	/*sql_2="SELECT * FROM   ( SELECT u.phone_no,to_char(PREPAY_FEE), ROWNUM RN   FROM (SELECT * FROM PCUSTPREGIFT_ERROR) u   WHERE ROWNUM <= 10  )   WHERE RN >= 0  ";*/
	sql_2="select * from (select a.phone_no,b.region_name,'网上交费三重礼', to_char(a.PREPAY_FEE),a.total_date ,rownum rn from PCUSTPREGIFT_ERROR a,sregioncode b,dcustmsg c where a.phone_no=c.phone_no and substr(c.belong_code,1,2)=b.region_code and  rownum <=10";
	if(phoneNo!="" &&(!phoneNo.equals("")) )
	{
		sql_2+=" and a.phone_no="+phoneNo;
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA sql_2 is "+sql_2);
	}
	if((beginYm!="" &&(!beginYm.equals(""))) &&(endYm!="" &&(!endYm.equals(""))) )
	{
		sql_2+=" and substr(total_date,1,6) between "+beginYm+" and "+endYm;
		//System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB sql_2 is "+sql_2);
		 
	}
	if(cityId!="0" &&(!cityId.equals("0")) )
	{
		sql_2+="and a.phone_no in (select phone_no from dcustmsg where substr(belong_code,1,2)='"+cityId+"')";
		//System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC sql_2 is "+sql_2);
	}
	sql_2+=")where rn >= 0";

	//System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ test sql is "+sql_2);
%> 
<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:sql><%=sql_2%></wtc:sql>
 
</wtc:pubselect>
<wtc:array id="ret_val2" scope="end" />
<%
	if(ret_val2==null||ret_val2.length==0)
	{
		%><script language="javascript">
			rdShowMessageDialog("查询结果为空!");
			window.location="e527_1.jsp";
		  </script><%
	}
	else
	{
		%>
			<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>系统充值失败数据查询</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">系统充值失败数据查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	<!--
	返回信息：号码 归属地市 活动名称（网上交费三重礼） 应充值金额 充值失败日期（年月日）
	-->
		<th nowrap>手机号码</th>
		<th nowrap>归属地市</th>
		<th nowrap>活动名称</th>
		<th nowrap>应充值金额</th>
		<th nowrap>充值失败日期</th>
	 
		 
		 
	</tr>
<%	      for(int y=0;y<ret_val2.length;y++)
	      {
			String tdClass = ((y%2)==1)?"Grey":"";
%>
	        <tr>
<%    	        for(int j=0;j<ret_val2[0].length;j++)
	        {
%>
	              <td height="25" nowrap>&nbsp;<%= ret_val2[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>
 <tr><td align=center colspan=5><%if(ret_val!=null&&ret_val.length>0){%>共<%=ret_val[0][0]%>条记录&nbsp;&nbsp;&nbsp;<%}%>  
 <!--
 <a href="e527_pre.jsp?phoneNo=<%=phoneNo%>&beginYm=<%=beginYm%>&endYm=<%=endYm%>&cityId=<%=cityId%>&curPage=1&count=<%=i_count%>" 上一页</a>-->
 上一页&nbsp;&nbsp;&nbsp;<a href="e527_next.jsp?phoneNo=<%=phoneNo%>&beginYm=<%=beginYm%>&endYm=<%=endYm%>&cityId=<%=cityId%>&curPage=1&count=<%=i_count%>">下一页</a>&nbsp;&nbsp;&nbsp;共<%=i_count%>页，当前第1页</td></tr>
	<tr>
		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back onClick="window.location='e527_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
		<%
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