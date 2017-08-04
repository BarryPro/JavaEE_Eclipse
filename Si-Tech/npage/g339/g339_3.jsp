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
	String opCode =""; //"d223";
	String opName = "";//"退费统计";
 	
	 
	String req = request.getParameter("req");
	//String kfbm = request.getParameter("kfbm");
	//String pay_value = request.getParameter("pay_value");
	 
	 
 

	String inParas2_now[] = new String[2];
	inParas2_now[0]=" select to_char(a.seq),to_char(a.PRODUCTID),b.productspec_name ,to_char(a.USERLISTSEQ),to_char(a.FEEINFOSEQ) from dbcustadm.dBBOSS_ACCT_EBILL_PRODUCTINFO a,dproductspecinfo@crmquery b where a.seq=:seq and a.productspec_number=b.productspec_number(+)";
	inParas2_now[1]="seq="+req;
	 
	 
		
 
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="5">
		    <wtc:param value="<%=inParas2_now[0]%>"/>
			<wtc:param value="<%=inParas2_now[1]%>"/>
</wtc:service>
<wtc:array id="result_now" scope="end" />   

 
<%
 	if(result_now.length==0 )
	{
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">查询无结果</div>
	</div>
	<table cellspacing="0" id="tabList">
	 
	 
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g339_1.jsp'" type="button" value="返回">
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
		 
	%><HEAD><TITLE>查询结果</TITLE>
</HEAD>

<body>
 
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">跨省集团账单查询-二级结果页</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>全网业务商品级关联流水</th>
		<th nowrap>产品订购关系</th>
		<th nowrap>产品规格名称</th>
	 
	 
	<tr>
	<%
		  for(int i=0;i<result_now.length;i++)
		  { 
	%>
			<tr>
				<td>
					<a href="g339_4.jsp?USERLISTSEQ=<%=result_now[i][3]%>&fee_seq=<%=result_now[i][4]%>"><%=result_now[i][0]%></a>
				</td>
				<td>
					<%=result_now[i][1]%>
				</td>
				<td>
					<%=result_now[i][2]%> 
				</td>
				 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g339_1.jsp'" type="button" value="返回">
		&nbsp;  
		<input class="b_foot" name=print onclick="javascript:window.print();" type="button" value="打印">
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
%>
 
 	
 

