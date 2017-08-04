<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>投诉退费统计查询</title>
<%
    String opCode="e630";
	String opName="集团托收销帐查询";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
 
%>
<SCRIPT type="text/javascript">
function docfm() {
   var contract_no = document.form.contract_no.value;
   var year_month = document.form.year_month.value;

   if (contract_no.length == 0) {
       rdShowMessageDialog("合同号码不许为空，请重新输入！");
       document.form.contract_no.focus();
       return false;   
   } else if (year_month.length == 0){
       rdShowMessageDialog("出帐年月不许为空，请重新输入！");
       document.form.year_month.focus();
       return false;
   } else if (year_month.length < 6){
       rdShowMessageDialog("出帐年月格式不正确，请重新输入！");
       document.form.year_month.focus();
       return false;
   } else {
      form.submit();
   }
}
</script> 
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body>
<form action="e630_2.jsp" name="form" method="POST">
 	<input type="hidden" name="opcode" value = "e630" >
	<input type="hidden" name="opname" value = "集团托收销帐查询" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">集团托收销帐查询</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >
				合同号：<input type="text" name="contract_no" maxlength="14" class="button" onKeyPress="return isKeyNumberdot(0)"> 
			</td>
			<td class="blue" >
				出账年月：<input type="text" name="year_month" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">(YYYYMM)
       
			</td>
		</tr>
	 
		 
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="查询" id="cz" onclick="docfm()" >
			 
			
			<input type=reset class="b_foot" value="重置" >
			<!--
				<input type=test class="b_foot" value="测试" onclick="test()" >
			-->
			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
  function test()
  {
	  alert("1");
	  form.action="e630_test.jsp";
	  form.submit();

  }
</script>
 
 