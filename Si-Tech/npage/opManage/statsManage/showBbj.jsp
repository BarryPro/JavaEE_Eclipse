<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page  contentType="text/html;charset=gb2312" %>
	<head>
  	</head>
<%
System.out.println("-----------showBbj.jsp-------------");
String beDate = request.getParameter("beDate");
String enDate = request.getParameter("enDate");
String statstype = request.getParameter("statstype");
String workNo = (String)session.getAttribute("workNo");

System.out.println("---------statstype----------------"+statstype);
String proName = "";
if(statstype.equals("0")){
	proName = "prc_d602_stat_0('"+workNo+"'";
}else if(statstype.equals("1")){
	proName = "prc_d602_stat_1('"+workNo+"','"+beDate+"','"+enDate+"'";
}else if(statstype.equals("2")){
	proName = "prc_d602_stat_2('"+workNo+"','"+beDate+"','"+enDate+"'";
}
System.out.println("------------beDate----------"+beDate);
System.out.println("------------enDate----------"+enDate);
System.out.println("------------proName----------"+proName);
%>
	<body>
		<form name="form1" action="" method=post>
			<input type="hidden" name="hParams1" value="">
			<input type="hidden" name="hTableName" value="">
			<input type="hidden" name="hDbLogin" value ="dbchange">
    		<input type="hidden" name="rptRight" value="T">
    		<input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
		</form>
	</body>
	
<script>
	 	document.form1.hTableName.value="rbo006";
		document.form1.hParams1.value= "<%=proName%>";
		document.form1.action = "<%=request.getContextPath()%>/npage/rpt/print_rpt_crm_report.jsp";
		document.form1.submit();
</script>
	
</html>
