<%
  /*
   * ����: �����¼
   * �汾: 1.0
   * ����: 2009/04/04
   * ����: yanpx
   * ��Ȩ: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>              
<%
 	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>                 
		<title><%=opName%></title>   
		<script>
			function doCheck(){
				/*
				if(document.form1.all("begin_time").value.length == 8)
					document.form1.begin_time.value=document.form1.begin_time.value+"000000";
				if(document.form1.all("end_time").value.length == 8)
					document.form1.end_time.value=document.form1.end_time.value+"235959";
				var begin_time=document.form1.begin_time.value;
				var end_time=document.form1.end_time.value;
				if(begin_time>end_time){
				  rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���");
				  return false;
				}
				*/
				document.form1.submit();
			}
		</script>
	</head>
	<body>
		<form name="form1" action="f9652_2.jsp">
		<%@ include file="/npage/include/header.jsp" %>

			<div class="title">
				<div id="title_zi">����������������</div>
			</div>
				<table cellspacing="0">
					<TR>
						<TD class="blue">���� </td>
						<td>
							<input type="text" name="owner_name" maxlength="30">
						</TD>
						<TD class="blue">���� </td>
						<td>
							<input type="text" name="table_name" maxlength="30">
						</TD>
					</TR>
					<TR>
						<TD class="blue">������</td>
						<td colspan="3">
							<input type="text" class="button" name="creator" maxlength="150">
						</TD>
					</TR>
					
					<!--TR>
						<TD class="blue">����ʼʱ��</td>
						<td>
						 	<input type="text" v_type="dateTime" class="button" name="begin_time">
						 </TD>
						<TD class="blue">�������ʱ��</td> 
						<td>
							<input type="text" v_type="dateTime" class="button" name="end_time">
						</TD>
					</tr-->
					
					<tr> 
						<td align="center" id="footer" colspan="4">
						&nbsp; <input class="b_foot" name=commit onClick="doCheck()" type=button value=��ѯ>
						&nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=���>
						&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
						&nbsp; 
						</td>
					</tr>
				</table>		
		<%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" value="<%=opName%>"/>
		</form>
	</body>
</html>				