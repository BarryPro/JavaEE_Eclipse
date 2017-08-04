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
String s_retIfo="";


String s_workNo=(String)session.getAttribute("workNo");
String s_passwd=(String)session.getAttribute("password");
String s_opCode=request.getParameter("hd_opCode");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");
String s_classCode=request.getParameter("classCode");
String s_servCode=request.getParameter("hd_bizType");
String oldProdId=request.getParameter("oldProdId");
String unitUsrId=request.getParameter("unitUsrId");
String s_powerRight = ((String)session.getAttribute("powerRight")).trim();
String s_regCode = ((String)session.getAttribute("regCode")).trim();

%>	
	
<form method="POST" action = "" name="frm">

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
	<wtc:param value="u03"/>
	<wtc:param value="<%=oldProdId%>"/>
	<wtc:param value="<%=unitUsrId%>"/>
		
	<wtc:param value="<%=s_servCode%>"/>		
	<wtc:param value=""/>		
	<wtc:param value=""/>		
</wtc:service>
<wtc:array id="rst_qryProd" scope="end" />
	
<%
System.out.println("zhangyan~~~rst_qryProd~"+rst_qryProd);
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

<DIV id="Operation_Table" style="display:none">
	<div class="title">
		<div id="title_zi">集团产品选择</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >选择</th>
			<th align="center" >产品代码</th>
			<th align="center" >产品名称</th>
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
				value="<%=s_prodIfo%>" onclick='fn_selProdIfo("<%=s_prodIfo%>" )'></td>
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
function fn_selIfo(str)
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
