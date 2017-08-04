<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
</head>
<body>
<%
String s_loginacc=request.getParameter("hd_loginacc");
String s_chnSrc=request.getParameter("hd_chnSrc");
String s_opCode=request.getParameter("hd_opCode");
String s_workNo=request.getParameter("hd_workNo");
String s_passwd=request.getParameter("hd_passwd");
String s_phone=request.getParameter("hd_phone");
String s_userPwd=request.getParameter("hd_userPwd");

String unitid=request.getParameter("t_UnitId");
String ecid=request.getParameter("t_customerNumber");
String idiccid=request.getParameter("t_idIccid");
String opType=request.getParameter("opType");

String s_regCode=(String)session.getAttribute("regCode");
String s_ret="";
%>	
	
	
<form method="POST" action = "" name="frm">
<wtc:service name="sPbossProdQry" outnum="50" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
	<wtc:param value="<%=s_loginacc%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_userPwd%>"/>
		
	<wtc:param value="<%=unitid%>"/>
	<wtc:param value="<%=ecid%>"/>
	<wtc:param value="<%=idiccid%>"/>
	<wtc:param value="<%=opType%>"/>
</wtc:service>
<wtc:array id="rst_qryCust" scope="end" />
	
<%
if ( !rc_qryCust.equals("000000") )
{
%>
<script>
	alert("<%=rc_qryCust%>:<%=rm_qryCust%>");
	window.close();
</script>
<%
}
%>
	
<DIV id="Operation_Table" style="display:none">
	<div class="title">
		<div id="title_zi">集团信息列表</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >选择</th>
			
			<th align="center" >证件号码</th>
			<th align="center" >集团编码</th>
			<th align="center" >集团客户名称</th>
			<th align="center" >EC集团客户编码</th>
			<th align="center" >集团产品ID</th>
			
			<th align="center" >用户编号</th>
			<th align="center" >用户名称</th>
			<th align="center" >付费账户</th>
			<th align="center" >用户唯一标识</th>
			
			<th align="center" >产品订购唯一标识</th>
		</tr>						
		
			<%
			for ( int i=0;i<rst_qryCust.length;i++ )
			{
				s_ret=rst_qryCust[i][0]  +"@"+ rst_qryCust[i][1]  +"@"+ rst_qryCust[i][2]  
					+"@"+ rst_qryCust[i][3]  +"@"+ rst_qryCust[i][4] 
					+"@"+ rst_qryCust[i][5]  +"@"+ rst_qryCust[i][6]  +"@"+ rst_qryCust[i][7]  
					+"@"+ rst_qryCust[i][8]  +"@"+ rst_qryCust[i][9] 
					+"@"+ rst_qryCust[i][10]  +"@"+ rst_qryCust[i][11]  +"@"+ rst_qryCust[i][12] 
					+"@"+ rst_qryCust[i][13]  +"@"+ rst_qryCust[i][14] ; 
			%>
				<tr>
					<td align="center" >
						<input type="radio" name="r_unitIfo" id="r_unitifo" value="" 
							onclick='fn_selUnitIfo("<%=s_ret%>")'>
					</td>
					
					<td align="center" ><%=rst_qryCust[i][0]%></td>
					<td align="center" ><%=rst_qryCust[i][1]%></td>
					<td align="center" ><%=rst_qryCust[i][2]%></td>
					<td align="center" ><%=rst_qryCust[i][3]%></td>
					<td align="center" ><%=rst_qryCust[i][6]%></td>
					
					<td align="center" ><%=rst_qryCust[i][9]%></td>
					<td align="center" ><%=rst_qryCust[i][10]%></td>
					<td align="center" ><%=rst_qryCust[i][11]%></td>
					<td align="center" ><%=rst_qryCust[i][8]%></td>
					<td align="center" ><%=rst_qryCust[i][7]%></td>		
				</tr>		
			<%
			}
			%>
				
	</table>	
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="关闭"
					onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
function fn_selUnitIfo(str)
{
	window.returnValue =str;
	window.close();
}

$(document).ready(
	function ()
	{
		$("#Operation_Table").show("slow");
	}
);
</script>
</form>
</body>
</html>
