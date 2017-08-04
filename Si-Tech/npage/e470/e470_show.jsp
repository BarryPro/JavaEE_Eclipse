<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 营业员操作查询1507
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	request.setCharacterEncoding("GBK");%>

<%
	String opCode="e470";
	String opName="集团客户充值卡手工充值";
	String workNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode"); 
    String[] inParas1 =new String[2];
	String beginDt = request.getParameter("beginDt");
	String endDt = request.getParameter("endDt");
	inParas1[0] = "select b.region_name,a.login_no,to_char(a.op_time,'YYYYMMDD hh24:mi:ss'),a.phone_no1,a.op_note,a.groupid,a.groupname,to_char(a.should_pay_money) from wchargecardmsg a,sregioncode b,dloginmsg c where a.login_no = c.login_no and b.region_code = substr(c.org_code,0,2) and a.op_code='e470' and substr(a.total_date,1,6)>=:beginDt and substr(a.total_date,1,6)<=:endDt  ";
	inParas1[1]="beginDt="+beginDt+",endDt="+endDt;
%>
  <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" outnum="8" retcode="retCodeb" retmsg="retMsgb">
	 <wtc:param value="<%=inParas1[0]%>"/>
	 <wtc:param value="<%=inParas1[1]%>"/>
  </wtc:service>
  <wtc:array id="result" scope="end"/>
<%
  if(result!=null &&result.length>0)
  {
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>集团客户充值卡手工充值</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团客户充值卡手工充值</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr><!--<tr><th>地市</th><th>工号</th><th>充值时间</th><th>充值手机号码</th><th>营销案名称</th><th>归属集团代码</th><th>归属集团名称</th><th>充值金额</th><tr>-->
		<th nowrap>地市</th>
		<th nowrap>工号</th>
		<th nowrap>充值时间</th>
		<th nowrap>充值手机号码</th>
		<th nowrap>营销案名称</th>
		<th nowrap>归属集团代码</th>
		<th nowrap>归属集团名称</th>
		<th nowrap>充值金额</th>
		 
		 
	</tr>
<%	      for(int y=0;y<result.length;y++)
	      {
			String tdClass = ((y%2)==1)?"Grey":"";
%>
	        <tr>
<%    	        for(int j=0;j<result[0].length;j++)
	        {
%>
	              <td height="25" class="<%=tdClass%>" nowrap>&nbsp;<%= result[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>
 
	<tr>
		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
		&nbsp; <input class="b_foot" name=back onClick="goBack()" type="button" value="返回">
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
  else
  {
	  %><script language="javascript">rdShowMessageDialog("报表信息不存在！");
	  window.location="e470_1.jsp?opCode="+"e470"+"&opName="+"集团客户充值卡手工充值";
	  </script><%
	  
  }
%>
 
 
 


<script>
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
 function goBack()
 {
	window.location="e470_1.jsp?opCode="+"e470"+"&opName="+"集团客户充值卡手工充值";
 }
</script>
