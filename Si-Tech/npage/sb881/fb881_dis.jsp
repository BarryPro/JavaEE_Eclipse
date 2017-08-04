<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String custRegCode=request.getParameter("custRegCode");
String retIfo = "";

String getMsgSql = " SELECT T.DISTRICTID, T.DISTRICTNAME  "
	+"  FROM ONEBOSS.TOBMARKADDRINFO T "
	+"  WHERE T.CITYID = :custRegCode"; 
String[] inParams = new String[2];
inParams[0] = getMsgSql;
inParams[1] = "custRegCode=" + custRegCode;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=custRegCode%>" 
	retmsg="msg0" retcode="code0" outnum="5">
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />

<%
if ( !code0.equals("000000") )
{
%>
<script>
	alert("<%=msg0%>:<%=code0%>");
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
		<div id="title_zi">区县信息列表</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >选择</th>
			<th align="center" >区县代码</th>
			<th align="center" >区县名称</th>
		</tr>						
		<%

		for (int i=0;i<rst.length ; i++)
		{
				retIfo=rst[i][0]  +"@"+ rst[i][1] ;
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_unitIfo" id="r_unitifo" value="<%=retIfo%>" onclick='fn_selIfo("<%=retIfo%>")'></td>
			<td align="center" ><%=rst[i][0]%></td>
			<td align="center" ><%=rst[i][1]%></td>
		</tr>	
		<%
		}
		%>
	</table>	
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="关闭" onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
function fn_selIfo(str)
{
	window.returnValue = str;
	window.close();
}
</script>
</form>
</body>
</html>
