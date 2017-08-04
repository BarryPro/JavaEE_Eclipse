<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_loginacc=request.getParameter("s_loginacc");
String s_chnSrc=request.getParameter("s_chnSrc");
String s_opCode=request.getParameter("s_opCode");
String s_workNo=request.getParameter("s_workNo");
String s_passwd=request.getParameter("s_passwd");
String s_phone=request.getParameter("s_phone");
String s_userPwd=request.getParameter("s_userPwd");

String s_UnitId=request.getParameter("s_unitId");
String s_customerNumber=request.getParameter("s_customerNumber");
String s_idIccid=request.getParameter("s_idIccid");
String s_opType=request.getParameter("s_opType");
String s_unitOffer=request.getParameter("s_unitOffer");
String s_prodId=request.getParameter("s_prodId");

String s_regCode=(String)session.getAttribute("regCode");
%>
<wtc:service name="sGetAddProduct" outnum="10" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
	<wtc:param value="<%=s_prodId%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=s_unitOffer%>"/>
	<wtc:param value="<%=s_regCode%>"/>
		
	<wtc:param value="PA"/>
	<wtc:param value=""/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
		
	<wtc:param value=""/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_UnitId%>"/>
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

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
</head>
<body>
<form method="POST" action = "" name="frm">

<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">集团信息列表</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >选择</th>
			<th align="center" >原子产品资费编码</th>
			<th align="center" >原子产品资费名称</th>
			<th align="center" >原子产品编码</th>
			<th align="center" >归属产品包编码</th>
			<th align="center" >销售品分类</th>
		</tr>						
		<%
		for (int i=0;i<rst_qryCust.length ; i++)
		{
			String s_bsProd=rst_qryCust[i][2]
				+"@"+rst_qryCust[i][3]
				+"@"+rst_qryCust[i][6]
				+"@"+rst_qryCust[i][7];
		%>
		<tr>
			<td align="center" >
				<input type="radio" name="r_unitIfo1" id="r_unitIfo1" value="<%=s_bsProd%>" onclick='fn_selUnitIfo("<%=s_bsProd%>")'/>
			</td>
			<td align="center" ><%=rst_qryCust[i][2]%></td>
			<td align="center" ><%=rst_qryCust[i][3]%></td>
			<td align="center" ><%=rst_qryCust[i][6]%></td>
			<td align="center" ><%=rst_qryCust[i][7]%></td>
			<td align="center" ><%=rst_qryCust[i][8]%></td>
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
</script>
</form>
</body>
</html>
