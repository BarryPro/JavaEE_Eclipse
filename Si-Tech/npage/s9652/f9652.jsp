<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
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
				  rdShowMessageDialog("开始时间比结束时间大");
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
				<div id="title_zi">数据清理任务审批</div>
			</div>
				<table cellspacing="0">
					<TR>
						<TD class="blue">属主 </td>
						<td>
							<input type="text" name="owner_name" maxlength="30">
						</TD>
						<TD class="blue">表名 </td>
						<td>
							<input type="text" name="table_name" maxlength="30">
						</TD>
					</TR>
					<TR>
						<TD class="blue">创建人</td>
						<td colspan="3">
							<input type="text" class="button" name="creator" maxlength="150">
						</TD>
					</TR>
					
					<!--TR>
						<TD class="blue">任务开始时间</td>
						<td>
						 	<input type="text" v_type="dateTime" class="button" name="begin_time">
						 </TD>
						<TD class="blue">任务结束时间</td> 
						<td>
							<input type="text" v_type="dateTime" class="button" name="end_time">
						</TD>
					</tr-->
					
					<tr> 
						<td align="center" id="footer" colspan="4">
						&nbsp; <input class="b_foot" name=commit onClick="doCheck()" type=button value=查询>
						&nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=清除>
						&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
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