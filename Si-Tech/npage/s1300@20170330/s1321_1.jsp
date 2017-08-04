<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
     
		String opCode = "1321";
		String opName = "兑换发票";
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
function docheck() {
   if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("帐户号码不能为空，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("帐户号码不能小于11位，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } 

   if (document.mainForm.login_accept.value.length == 0) {
      rdShowMessageDialog("缴费流水不能为空，请重新输入 !!")
      document.mainForm.login_accept.focus();
      return false;
   }

   if (document.mainForm.year_month.value.length == 0) {
      rdShowMessageDialog("缴费月份不能为空，请重新输入 !!")
      document.mainForm.year_month.focus();
      return false;
   } else if (document.mainForm.year_month.value.length < 6) {
      rdShowMessageDialog("缴费月份不能小于6位，请重新输入 !!")
      document.mainForm.year_month.focus();
      return false;
   }
   //xl add 201407后月结 不可以操作
   if(document.mainForm.year_month.value>="201407") //document.mainForm.year_month.value
   {
	   rdShowMessageDialog("7月份以后的月结发票请在zg17开具!!")
       document.mainForm.year_month.focus();
       return false;
   }
   else
   {
	   document.mainForm.action="s1321_1show.jsp";
   }		
   document.mainForm.submit();
} 

 function sel1()
{
    window.location.href='s1321_1.jsp';
 }

 function sel2() {
    window.location.href='s1321_2.jsp';
 }

 function sel3(){
     window.location.href='s1321_3.jsp';
 }
 
 function doclear(){
 	 mainForm.reset();
 }
-->
 </script> 
 
<title>黑龙江BOSS-兑换发票</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择兑换类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<th width="13%">兑换类型</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1" checked  >
			收据兑换等额发票 
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  >
			收据兑换月消费发票 
			<input name="busyType3" type="radio" onClick="sel3()" value="3"  >
			等额发票兑换月消费发票
		</th>
	</tr>   
                
	<tr> 
		<td class="blue" nowrap>帐户号码</td>
		<td> 
			<input class="button"type="text" value="" name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">缴费流水</td>
		<td> 
			<input type="text" class="button" value="" name="login_accept" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)"> 
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<tr> 
		<td class="blue" nowrap>缴费月份</td>
		<td colspan="3">
			<input class="button"type="text" name="year_month" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
			<font color="orange"> *</font>
		</td>
	</tr>

	<TR> 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="查询" onclick="docheck()" index="9">
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	 <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>