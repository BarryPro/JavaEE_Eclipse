<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_opCode=request.getParameter("hd_opCode");
String s_opName=request.getParameter("hd_opName");

String s_idIccid=request.getParameter("t_idIccid");
String s_custId=request.getParameter("t_custId");
String s_unitId=request.getParameter("t_unitId");
String s_customerNumber=request.getParameter("t_customerNumber");
String s_accept=request.getParameter("hd_accept");
String s_regCode	=(String)session.getAttribute("regCode");
String s_workNo=(String)session.getAttribute("workNo");
String s_passwd=(String)session.getAttribute("password");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");
String s_classCode=request.getParameter("classCode");
String s_powerRight = ((String)session.getAttribute("powerRight")).trim();
String s_servCode=request.getParameter("s_servCode");

%>
<wtc:service name="sPubMProdSelE" outnum="22" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryProd" retmsg="rm_qryProd" >
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
		
	<wtc:param value="10"/>
	<wtc:param value=""/>
	<wtc:param value="u01"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
		
	<wtc:param value="<%=s_servCode%>"/>		
	<wtc:param value=""/>		
	<wtc:param value=""/>		
</wtc:service>
<wtc:array id="rst_qryProd" scope="end" />
<%
if ( !rc_qryProd.equals("000000") )
{
%>
<script>
	alert("<%=rc_qryProd%>:<%=rm_qryProd%>" );
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
			<th align="center" >资费代码</th>
			<th align="center" >资费名称</th>
			<th align="center" >企业产品编码</th>
		</tr>							
		<%
		for (int i=0;i<rst_qryProd.length ; i++)
		{
			String s_prodIfo=rst_qryProd[i][3]+"@"+rst_qryProd[i][4]
				+"@"+rst_qryProd[i][21]+"@"+rst_qryProd[i][3];
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_prodIfo" id="r_prodIfo" 
				value="<%=s_prodIfo%>" onclick="fn_selProdIfo()"></td>
			<td align="center" ><%=rst_qryProd[i][3]%></td>
			<td align="center" ><%=rst_qryProd[i][4]%></td>
			<td align="center" ><%=rst_qryProd[i][21]%></td>
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
function fn_selProdIfo()
{
	window.returnValue =document.all.r_prodIfo.value;
	window.close();
}
</script>
</form>
</body>
</html>
