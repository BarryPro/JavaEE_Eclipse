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

String s_UnitId=request.getParameter("t_UnitId");
String s_customerNumber=request.getParameter("t_customerNumber");
String s_idIccid=request.getParameter("t_idIccid");
String s_opType=request.getParameter("hd_opType");

String s_regCode=(String)session.getAttribute("regCode");
%>
<wtc:service name="sPbossProdQry" outnum="50" routerKey="region" routerValue="<%=s_regCode%>" 
	retcode="rc_qryCust" retmsg="rm_qryCust" >
	<wtc:param value="<%=s_loginacc%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_userPwd%>"/>
		
	<wtc:param value="<%=s_UnitId%>"/>
	<wtc:param value="<%=s_customerNumber%>"/>
	<wtc:param value="<%=s_idIccid%>"/>
	<wtc:param value="<%=s_opType%>"/>
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
		<div id="title_zi">������Ϣ�б�</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<th align="center" >ѡ��</th>
			<th align="center" >֤������</th>
			<th align="center" >��������</th>
			<th align="center" >���ű���</th>
			<th align="center" >EC���ſͻ�����</th>
			<th align="center" >���Ų�Ʒ���ʷ�</th>
			<th align="center" >���Ų�Ʒ����</th>
			<th align="center" >���Ų�ƷID</th>
			<th align="center" >��ҵ��Ʒ����ʵ��Ψһ��ʶ</th>
			<th align="center" >��ҵ�û���ʶ</th>
		</tr>						
		<%
		String s_unitIfo="";
		for (int i=0;i<rst_qryCust.length ; i++)
		{
				s_unitIfo=rst_qryCust[i][0]  +"@"+ rst_qryCust[i][2]  +"@"+ rst_qryCust[i][1]  
					+"@"+ rst_qryCust[i][3]  +"@"+ rst_qryCust[i][4] 
					+"@"+ rst_qryCust[i][5]  +"@"+ rst_qryCust[i][6]  +"@"+ rst_qryCust[i][7]  
					+"@"+ rst_qryCust[i][8]  +"@"+ rst_qryCust[i][9] 
					+"@"+ rst_qryCust[i][10]  +"@"+ rst_qryCust[i][11]  +"@"+ rst_qryCust[i][12] 
					+"@"+ rst_qryCust[i][13]  +"@"+ rst_qryCust[i][14] +"@"+ rst_qryCust[i][16]; 
		%>
		<tr>
			<td align="center" ><input type="radio" name="r_unitIfo" id="r_unitifo" value="<%=s_unitIfo%>" onclick='fn_selUnitIfo("<%=s_unitIfo%>")'></td>
			<td align="center" ><%=rst_qryCust[i][0]%></td>
			<td align="center" ><%=rst_qryCust[i][2]%></td>
			<td align="center" ><%=rst_qryCust[i][1]%></td>
			<td align="center" ><%=rst_qryCust[i][3]%></td>
			<td align="center" ><%=rst_qryCust[i][4]%></td>
			<td align="center" ><%=rst_qryCust[i][5]%></td>
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
				<input class="b_foot" type="button" name="b_cls" value="�ر�"
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
