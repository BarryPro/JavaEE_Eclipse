<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "e527";
	String opName = "ϵͳ��ֵʧ�����ݲ�ѯ";
	String phoneNo = request.getParameter("phoneNo");	
	String beginYm = request.getParameter("beginYm");	
	String endYm = request.getParameter("endYm");	
	String cityId = request.getParameter("cityId");	
 	String[] inParas2 = new String[2];
	String sql_1="select to_char(count(*)) from pcustpregift_error where 1=1";
	String sql_2="";
	String sql_3="";
	String sql_4="";
	int i_count=Integer.parseInt(request.getParameter("count"));
	int curPage=Integer.parseInt(request.getParameter("curPage"));
    int page_record=10;//ÿҳ��ʾ�ļ�¼��


%>
 

<%
	 
	/*sql_2="SELECT * FROM   ( SELECT u.phone_no,to_char(PREPAY_FEE), ROWNUM RN   FROM (SELECT * FROM PCUSTPREGIFT_ERROR) u   WHERE ROWNUM <= 10  )   WHERE RN >= 0  ";*/
	sql_2=" select * from  (select a.phone_no,b.region_name,'���Ͻ���������', to_char(a.PREPAY_FEE),a.total_date ,rownum rn from PCUSTPREGIFT_ERROR a,sregioncode b,dcustmsg c where a.phone_no=c.phone_no and substr(c.belong_code,1,2)=b.region_code and  rownum  <="+(curPage+1)*page_record ;
	if(phoneNo!="" &&(!phoneNo.equals("")) )
	{
		sql_2+=" and a.phone_no="+phoneNo;
		 
	}
	if((beginYm!="" &&(!beginYm.equals(""))) &&(endYm!="" &&(!endYm.equals(""))) )
	{
		sql_2+=" and substr(total_date,1,6) between "+beginYm+" and "+endYm;
		 
		 
	}
	if(cityId!="0" &&(!cityId.equals("0")) )
	{
		sql_2+="and a.phone_no in (select phone_no from dcustmsg where substr(belong_code,1,2)='"+cityId+"')";
	 
	}
	sql_2+=")where rn > "+curPage*page_record;
	//System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ next test sql is "+sql_2);
%> 
<wtc:pubselect name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:sql><%=sql_2%></wtc:sql>
 
</wtc:pubselect>
<wtc:array id="ret_val2" scope="end" />
<%
	if(ret_val2==null||ret_val2.length==0)
	{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ѯ���Ϊ��!");
			window.location="e527_1.jsp";
		  </script>
		<%
	}
	else
	{
		%>
			<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>ϵͳ��ֵʧ�����ݲ�ѯ</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ϵͳ��ֵʧ�����ݲ�ѯ</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	<!--
	������Ϣ������ �������� ����ƣ����Ͻ��������� Ӧ��ֵ��� ��ֵʧ�����ڣ������գ�
	-->
		<th nowrap>�ֻ�����</th>
		<th nowrap>��������</th>
		<th nowrap>�����</th>
		<th nowrap>Ӧ��ֵ���</th>
		<th nowrap>��ֵʧ������</th>
	 
		 
		 
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
  
<%
	
	if((curPage+1)==i_count)
	{
		%>
		<tr><td colspan=5 align=center>
 
  <a  href="e527_pre.jsp?phoneNo=<%=phoneNo%>&beginYm=<%=beginYm%>&endYm=<%=endYm%>&cityId=<%=cityId%>&curPage=<%=curPage%>&count=<%=i_count%>">��һҳ</a> &nbsp;&nbsp;&nbsp;
 ��һҳ &nbsp;&nbsp;&nbsp;��<%=i_count%>ҳ����ǰ��<%=curPage+1%>ҳ</td></tr>
	<tr>
		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="����" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back onClick="window.location='e527_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
		<%
	}
	else
	{
		%>
			<tr><td colspan=5 align=center>
 
 <a href="e527_pre.jsp?phoneNo=<%=phoneNo%>&beginYm=<%=beginYm%>&endYm=<%=endYm%>&cityId=<%=cityId%>&curPage=<%=curPage%>&count=<%=i_count%>">��һҳ</a>&nbsp;&nbsp;&nbsp;
 <a href="e527_next.jsp?phoneNo=<%=phoneNo%>&beginYm=<%=beginYm%>&endYm=<%=endYm%>&cityId=<%=cityId%>&curPage=<%=curPage+1%>&count=<%=i_count%>">��һҳ</a>&nbsp;&nbsp;&nbsp;��<%=i_count%>ҳ����ǰ��<%=curPage+1%>ҳ</td></tr>
	<tr>
		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="����" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back onClick="window.location='e527_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
		<%
	}	
 %>

 
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
					//alert('����excelʧ��!');
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
				//alert('����excelʧ��!');
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