<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_loginacc=request.getParameter("hd_loginacc");
String s_chnSrc=request.getParameter("hd_chnSrc");
String s_opCode=request.getParameter("hd_opCode");
String s_workNo=request.getParameter("hd_workNo");
String s_passwd=request.getParameter("hd_passwd");
String s_phone=request.getParameter("hd_phone");
String s_userPwd=request.getParameter("hd_userPwd");
String s_unitOffer=request.getParameter("s_unitOffer");

String s_UnitId=request.getParameter("t_UnitId");
String s_customerNumber=request.getParameter("t_customerNumber");
String s_idIccid=request.getParameter("t_idIccid");
String s_opType=request.getParameter("hd_opType");
String s_rOpType=request.getParameter("r_opType");
String s_classCode=request.getParameter("s_classCode");
String t_ECSubsID=request.getParameter("t_ECSubsID");
String hd_bizType=request.getParameter("hd_bizType");

String s_regCode=(String)session.getAttribute("regCode");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");
String s_powerRight=(String)session.getAttribute("powerRight");
%>
<wtc:service name="sPubMProdSelE" outnum="30" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
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
	<wtc:param value="m01"/>
	<wtc:param value="<%=s_unitOffer%>"/>
	<wtc:param value="<%=t_ECSubsID%>"/>
		
	<wtc:param value="<%=hd_bizType%>"/>		
	<wtc:param value=""/>		
	<wtc:param value=""/>		
</wtc:service>
<wtc:array id="rst_qryCust" scope="end" />
<%
if ( !rc_qryCust.equals("000000") )
{
%>
<script>
	rdShowMessageDialog("<%=rc_qryCust%>:<%=rm_qryCust%>");
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
			<th align="center" >附加产品编号</th>
			<th align="center" >附加产品名称</th>
			<th align="center" >成员产品编码</th>
		</tr>						
		<%
		for (int i=0;i<rst_qryCust.length ; i++)
		{
			String s_unitIfo=rst_qryCust[i][0]
				+"@"+rst_qryCust[i][1]
				+"@"+rst_qryCust[i][2];
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_unitIfo" id="r_unitifo" value="<%=s_unitIfo%>" onclick="fn_selUnitIfo()"></td>
			<td align="center" ><%=rst_qryCust[i][0]%></td>
			<td align="center" ><%=rst_qryCust[i][1]%></td>
			<td align="center" ><%=rst_qryCust[i][2]%></td>
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
