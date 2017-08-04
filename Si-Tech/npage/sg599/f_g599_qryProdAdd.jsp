<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_accept=request.getParameter("s_accept");
String s_opCode=request.getParameter("s_opCode");
String s_iextCode=request.getParameter("s_iextCode");
String s_custId=request.getParameter("s_custId");
String s_offerId=request.getParameter("s_offerId");
String s_opName=request.getParameter("s_opName");

String s_regCode=(String)session.getAttribute("regCode");
String s_workNo=(String)session.getAttribute("workNo");
String s_passwd=(String)session.getAttribute("password");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");
String s_powerRight = ((String)session.getAttribute("powerRight"));

String s_classCode=request.getParameter("classCode");
String s_servCode=request.getParameter("s_servCode");
%>
<wtc:service name="sPubMProdSelE" outnum="30" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryProdAdd" retmsg="rm_qryProdAdd" >
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>	
	<wtc:param value="PA"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_orgId%>"/>
		
	<wtc:param value="<%=s_groupId%>"/>
	<wtc:param value="JT"/>
	<wtc:param value="<%=s_classCode%>"/>
	<wtc:param value="E"/>
	<wtc:param value="<%=s_powerRight%>"/>
		
	<wtc:param value="40"/>
	<wtc:param value=""/>
	<wtc:param value="u01"/>
	<wtc:param value="<%=s_offerId%>"/>
	<wtc:param value=""/>
		
	<wtc:param value="<%=s_servCode%>"/>		
	<wtc:param value=""/>		
	<wtc:param value=""/>		
</wtc:service>
<wtc:array id="rst_qryProdAdd" scope="end" />
<%
if ( !rc_qryProdAdd.equals("000000") )
{
%>
<script>
	alert("<%=rc_qryProdAdd%>:<%=rm_qryProdAdd%>");
	window.close();
</script>
<%
}
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=s_opName%></title>
</head>
<body>
<form method="POST" action = "" name="frm">
<div id="Operation_Title">
	<div class="icon"></div>
		<B><%=s_opName%></B>
</div>

<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">集团信息列表</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >选择</th>
			<th align="center" >附加产品编号</th>
			<th align="center" >附加产品名称</th>
			<th align="center" >产品编码</th>
			<th align="center" >归属产品包编码</th>
		</tr>						
		<%
		for (int i=0;i<rst_qryProdAdd.length ; i++)
		{
			String s_retIfo=rst_qryProdAdd[i][3]+"@"+rst_qryProdAdd[i][4]
				+"@"+rst_qryProdAdd[i][21]+"@"+rst_qryProdAdd[i][22];
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_retifo" id="r_retifo" value="<%=s_retIfo%>" onclick='fn_selUnitIfo("<%=s_retIfo%>")'></td>
			<td align="center" ><%=rst_qryProdAdd[i][3]%></td>
			<td align="center" ><%=rst_qryProdAdd[i][4]%></td>
			<td align="center" ><%=rst_qryProdAdd[i][21]%></td>
			<td align="center" ><%=rst_qryProdAdd[i][22]%></td>
		</tr>	
		<%
		}
		%>
	</table>	
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="关闭"
					onClick="window.close()">								
			</td>
		</tr>
	</table>		
</div>
<script>
function fn_selUnitIfo(retVal)
{
	window.returnValue =retVal;
	window.close();
}
</script>
</form>
</body>
</html>
