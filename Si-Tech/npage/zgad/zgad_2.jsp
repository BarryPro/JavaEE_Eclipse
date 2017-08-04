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
	String opCode = "zgad";
	String opName = "集团产品转账冲正";
 	String[][] result = new String[][]{}; 
	String jtcpzh = request.getParameter("jtcpzh");
	String jtkhid = request.getParameter("jtkhid");
%> 
<wtc:service name="bs_zgadInit" retcode="sretCode" retmsg="sretMsg" outnum="6">
    <wtc:param value="<%=jtcpzh%>"/> 
    <wtc:param value="<%=jtkhid%>"/>  
</wtc:service>
<wtc:array id="ret_val"  scope="end" start="0"  length="2" />
<wtc:array id="zgad_return"  scope="end" start="2"  length="4" />
<%
if(ret_val==null||ret_val.length==0)
{
	%><HEAD><TITLE>集团产品转账冲正</TITLE>
</HEAD> 
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团产品转账冲正</div>
	</div>
	 无记录
	 <input type="button" value="返回" class="b_foot"  onclick="window.location.href='zgad_1.jsp'"> 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
else
{
	%><HEAD><TITLE>集团产品转账冲正</TITLE>
</HEAD>
<body>
<FORM method=post name="frm1507_2">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团产品转账冲正</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>转账流水</th>
		<th nowrap>转账金额</th>
		<th nowrap>接转账户号码</th>
		<th nowrap>转账操作时间</th>
		<th nowrap>操作</th>
	<tr>
	<tr>
		<%
			for(int i=0;i<zgad_return.length;i++)
			{
				%>
					<tr>
						<td>
							<%=zgad_return[i][0]%>
						</td>
						<td>
							<%=zgad_return[i][1]%>
						</td>
						<td>
							<%=zgad_return[i][2]%>
						</td>
						<td>
							<%=zgad_return[i][3]%>
						</td>
						<td>
							<a href="zgad_3.jsp?jtcpzh=<%=jtcpzh%>&jtkhid=<%=jtkhid%>&zrzh=<%=zgad_return[i][2]%>&zzls=<%=zgad_return[i][0]%>&je=<%=zgad_return[i][1]%>">确认操作</a>
						</td>
					</tr>
				<%
			}
		%> 
	</tr>
	 
	


		<td align="center" id="footer" colspan="6">
		 
		&nbsp; <input class="b_foot" name=back onClick="window.location='zgad_1.jsp'" type="button" value="返回">
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
	function docfm()
	{
		alert("1");
	}
</script> 	
 

