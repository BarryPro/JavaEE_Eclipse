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
 	
	 
	String feeinfoseq = request.getParameter("feeinfoseq");//这个是成员的
	String fee_seq = request.getParameter("fee_seq"); //这个是产品的
	//String pay_value = request.getParameter("pay_value");
	 
	 
 

	String inParas2_now[] = new String[2];
	inParas2_now[0]=" select to_char(nvl(sum(FEEVAL),0)),to_char(PRODUCTCHARGECODE) from dBBOSS_ACCT_FEEINFO where feeinfoseq=:seq group by PRODUCTCHARGECODE ";
	inParas2_now[1]="seq="+fee_seq ;
	 
	 
		
 
%>
 
<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="1">
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
		<div id="title_zi">跨省集团账单查询-四级结果页</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>费用代码</th>
		<th nowrap>费用金额</th>
	 
	 
	<tr>
	<%
		  for(int i=0;i<result_now.length;i++)
		  { 
	%>
			<tr>
				<td>
					 <%=result_now[i][1]%> 
				</td>
				<td>
					<a href="g339_5.jsp "><%=result_now[i][0]%></a>
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
 
 	
 

