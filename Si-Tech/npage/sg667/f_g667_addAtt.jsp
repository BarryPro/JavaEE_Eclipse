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
String s_classCode=request.getParameter("s_classCode");
String s_servCode=request.getParameter("hd_bizType");
String oldProdId=request.getParameter("oldProdId");
String unitUsrId=request.getParameter("unitUsrId");
String s_powerRight = ((String)session.getAttribute("powerRight")).trim();
String s_regCode = ((String)session.getAttribute("regCode")).trim();
%>	
	
<wtc:service name="sPubMProdSelE" outnum="23" routerKey="region" routerValue="<%=s_regCode%>" 
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
		
	<wtc:param value="40"/>
	<wtc:param value=""/>
	<wtc:param value="u01"/>
	<wtc:param value="<%=oldProdId%>"/>
	<wtc:param value="<%=unitUsrId%>"/>
		
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
	
<form method="POST" action = "" name="frm">

<DIV id="Operation_Table" style="display:none">
	<div class="title">
		<div id="title_zi">���Ÿ��Ӳ�Ʒ</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >ѡ��</th>
			<th align="center" >���Ӳ�Ʒ���</th>
			<th align="center" >���Ӳ�Ʒ����</th>
			<th align="center" >��Ʒ����</th>
			<th align="center" >������Ʒ������</th>
		</tr>						
		<%
		System.out.println("111~~~~"+rst_qryProd.length);
		for (int i=0;i<rst_qryProd.length ; i++)
		{
			s_retIfo=rst_qryProd[i][3]+"@"+rst_qryProd[i][4]
				+"@"+rst_qryProd[i][21]+"@"+rst_qryProd[i][22];
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_prodIfo" id="r_prodIfo" 
				value="<%=s_retIfo%>" onclick='fn_selIfo("<%=s_retIfo%>" )'></td>
			<td align="center" ><%=rst_qryProd[i][3]%></td>
			<td align="center" ><%=rst_qryProd[i][4]%></td>
			<td align="center" ><%=rst_qryProd[i][21]%></td>
			<td align="center" ><%=rst_qryProd[i][22]%></td>
		</tr>	
		<%
		}
		%>			
	</table>	
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="�ر�"
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
