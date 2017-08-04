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
	String opCode = "e832";
	String opName = "集团产品转账";
 	String[][] result = new String[][]{}; 
	String zjhm = request.getParameter("zjhm");	
	String jtbh = request.getParameter("jtbh");	
	String znwbh = request.getParameter("znwbh");	
	String khid = request.getParameter("khid");
	String inParas[] = new String[2];
	String inParas2[] = new String[2];
	int i_count=1;
	//inParas[0] ="select a.unit_id,a.unit_name,b.cust_id,b.id_iccid from dgrpcustmsg a,dcustdoc b,dgrpcustmsg c,dgrpusermsg d where a.cust_id=b.cust_id and a.cust_id=c.cust_id and a.cust_id = d.cust_id and 1=:i_count";
	//inParas[0] ="select to_char(a.unit_id),a.unit_name,to_char(b.cust_id),to_char(b.id_iccid),to_char(d.account_id) from dgrpcustmsg a,dcustdoc b,dgrpcustmsg c,dgrpusermsg d  where a.cust_id=b.cust_id and a.cust_id=c.cust_id and a.cust_id = d.cust_id   and 1=:i_count";
	// xl add 增加品牌
	inParas[0] ="select to_char(a.unit_id),a.unit_name,to_char(b.cust_id),to_char(b.id_iccid),to_char(d.account_id),to_char(user_no) ,d.user_name,d.sm_code from dgrpcustmsg a,dcustdoc b,dgrpusermsg d  where a.cust_id=b.cust_id  and a.cust_id = d.cust_id and d.run_code!='a'    and 1=:i_count";
	inParas[1] ="i_count="+i_count;
	
	if(zjhm!="" &&(!zjhm.equals("")) )
	{
		inParas[0]+=" and b.id_iccid= :zjhm";
		inParas[1]+=",zjhm="+zjhm;
	}
	if(jtbh!="" &&(!jtbh.equals("")) )
	{
		inParas[0]+=" and a.unit_id=:jtbh";
		inParas[1]+=",jtbh="+jtbh;
	}
	if(znwbh!="" &&(!znwbh.equals("")) )
	{
		inParas[0]+=" and a.boss_vpmn_code=:znwbh";
		inParas[1]+=",znwbh="+znwbh;
	}
	if(khid!="" &&(!khid.equals("")) )
	{
		inParas[0]+=" and b.cust_id=:khid";
		inParas[1]+=",khid="+khid;
	}
	System.out.println("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW test inParas[0] is "+inParas[0]+" and inParas[1] is "+inParas[1]);
%> 
<wtc:service name="TlsPubSelCrm" retcode="sretCode" retmsg="sretMsg" outnum="8">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>  
 
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
if(ret_val==null||ret_val.length==0)
{
	%><HEAD><TITLE>集团产品转账</TITLE>
</HEAD> 
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团产品转账</div>
	</div>
	 无记录
	 <input type="button" value="返回" class="b_foot"  onclick="window.location.href='e832_1.jsp'"> 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else
{
	%><HEAD><TITLE>集团产品转账</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团产品转账</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr rowspan=5>
	    <th nowrap>集团编号</th>
		<th nowrap>集团名称</th>
		<th nowrap>集团ID</th>
		<th nowrap>证件号码</th>
		
	<tr>
	<tr>
		<td height="25" nowrap >
			<%=ret_val[0][0]%>
		</td>
		<td height="25" nowrap>
			<%=ret_val[0][1]%>
		</td>
		<td height="25" nowrap>
			<%=ret_val[0][2]%>
		</td>
		<td height="25" nowrap>
			<%=ret_val[0][3]%>
		</td>
	</tr>
	<tr>
	    <th nowrap   >集团产品账号</th>
		<th nowrap   >集团产品名称</th>
		<th nowrap   >集团当前预存</th>
		<th nowrap   >集团当前欠费</th>
	 
	<tr>
	<%
		  String grp_oweFee="0";
		  for(int y=0;y<ret_val.length;y++)
		  {
			 
	%>
			<%
					//xl add for 查dconmsg的欠费信息 begin
					inParas2[0]="select nvl(to_char(prepay_fee),'0'),nvl(to_char(owe_fee),'0') from dconmsg where contract_no=:contractNo ";
					inParas2[1]="contractNo="+ret_val[y][4];
					//xl add for 查dconmsg的欠费信息 end
			%>
			<wtc:service name="TlsPubSelBoss" retcode="sretCode2" retmsg="sretMsg2" outnum="2">
				<wtc:param value="<%=inParas2[0]%>"/> 
				<wtc:param value="<%=inParas2[1]%>"/>  
			</wtc:service>
			<wtc:array id="ret_val2" scope="end" />
			
			<tr>
	     	    <td height="25" nowrap   >
					<a href="e832_3.jsp?jtbh=<%=ret_val[y][0]%>&accountid=<%=ret_val[y][4]%>&phoneNo1=<%=ret_val[y][5]%>&zjhm=<%=ret_val[y][3]%>&khid=<%=ret_val[y][2]%>&jtmc=<%=ret_val[y][1]%>&jtcpmc=<%=ret_val[y][6]%>&sm_code=<%=ret_val[y][7]%>"><%= ret_val[y][4]%></a>
				</td>
				<td height="25" nowrap   >
					<a href="e832_3.jsp?jtbh=<%=ret_val[y][0]%>&zjhm=<%=ret_val[y][3]%>&khid=<%=ret_val[y][2]%>&accountid=<%=ret_val[y][4]%>&phoneNo1=<%=ret_val[y][5]%>&jtmc=<%=ret_val[y][1]%>&jtcpmc=<%=ret_val[y][6]%>&sm_code=<%=ret_val[y][7]%>"><%= ret_val[y][6]%></a>
				</td>
				<%
				if(ret_val2==null||ret_val2.length==0)
				{
					 %><td height="25" nowrap  >数据不存在</td>
					   <td height="25" nowrap  >数据不存在</td>
					 <%
				}
				else
				{
					%><td height="25" nowrap><%=ret_val2[0][0]%></td>
					  <td height="25" nowrap><%=ret_val2[0][1]%></td>	
					<%
				}	
			%>
				<input type="hidden" id="s_sm_id" value="<%=ret_val[y][7]%>">
				 
	 		</tr>
	<%	   }
	%>
	


		<td align="center" id="footer" colspan="9">
		 
		&nbsp; <input class="b_foot" name=back onClick="window.location='e832_1.jsp'" type="button" value="返回">
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
 	
 

