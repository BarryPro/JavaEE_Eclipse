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
%>

<wtc:service name="sg599QryCust" outnum="6" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
	<wtc:param value="<%=s_accept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	
	<wtc:param value="<%=s_unitId%>"/>
	<wtc:param value="<%=s_customerNumber%>"/>
	<wtc:param value="<%=s_custId%>"/>
	<wtc:param value="<%=s_idIccid%>"/>
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
			<th align="center" >证件号码</th>
			<th align="center" >集团客户ID</th>
			<th align="center" >集团客户名称</th>
			<th align="center" >集团编码</th>
			<th align="center" >集团名称</th>
			<th align="center" >EC集团客户编码</th>
		</tr>						
		<%
		for (int i=0;i<rst_qryCust.length ; i++)
		{
			String s_unitIfo=rst_qryCust[i][0]+"@"+rst_qryCust[i][1]
				+"@"+rst_qryCust[i][2]+"@"+rst_qryCust[i][3]+"@"+rst_qryCust[i][4]+"@"+rst_qryCust[i][5];
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_unitIfo" id="r_unitifo" value="<%=s_unitIfo%>" onclick="fn_selUnitIfo()"></td>
			<td align="center" ><%=rst_qryCust[i][0]%></td>
			<td align="center" ><%=rst_qryCust[i][1]%></td>
			<td align="center" ><%=rst_qryCust[i][2]%></td>
			<td align="center" ><%=rst_qryCust[i][3]%></td>
			<td align="center" ><%=rst_qryCust[i][4]%></td>
			<td align="center" ><%=rst_qryCust[i][5]%></td>
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
function fn_selUnitIfo()
{
	window.returnValue =document.all.r_unitIfo.value;
	window.close();
}
</script>
</form>
</body>
</html>
