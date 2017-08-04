<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<%
   response.setHeader("Pragma","No-cache");
   //response.setHeader("Cache-Control","no-cache");
   response.setHeader("cache-control","public");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
    String  groupId = (String)session.getAttribute("groupId");
		String org_code = (String)session.getAttribute("orgCode");
		%>

		<script language="javascript">

		function quechoosee() {
					
		    var excelquery = document.frm.excelquery.value;
		    		if(excelquery=="0") {
		    			 select_crmtj(document.frm);

	  	      }if(excelquery=="1") {
               select_crmmx(document.frm);
               
	  	      }
		}
	 		 function select_crmtj(statement)
    {
				if(statement)
				{
					with(statement) 
					{

				hTableName.value="rbo006";
				hParams1.value= "prc_e468_tj_upg('<%=workNo%>','<%=groupId%>','0','0'";
				action="<%=request.getContextPath()%>/npage/rpt/print_rpt_crm.jsp";
				frm.submit();  
				  }
				}
		 }
		 
		 		  function select_crmmx(statement)
    {
				if(statement)
				{
					with(statement) 
					{

				hTableName.value="rbo006";
				hParams1.value= "prc_e468_mx_upg('<%=workNo%>','<%=groupId%>','0','0'";
				action="<%=request.getContextPath()%>/npage/rpt/print_rpt_crm.jsp";
				frm.submit();  
				  }
				}
		 }
		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="workNo" value="<%=workNo%>">
		<div class="title">
		<div id="title_zi">报表查询</div>
	</div>
	      <table cellspacing="0" >
						<tr >
			    <td class="blue" width="15%">报表查询类型</td>
		    <td colspan="3">
		 				<select id="excelquery" name="excelquery" style="width:130px;" >
						<option value="0">统计查询</option>
						<option value="1">明细查询</option>
						</select>
						
		 
		</td>		  
	 </tr >
			

</table>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="查询" onclick="quechoosee()" />		
				&nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="返回">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
			       <input type="hidden" name="workNo" value="<%=workNo%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">    
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>