<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/2/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
	String opCode = "1321";
	String opName = "兑换发票";
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
 function DoCheck(){
    if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("帐户号码不能为空，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("帐户号码不能小于11位，请重新输入 !!")
      document.mainForm.contract_no.focus();
      return false;
   } 

   if (document.mainForm.cust_name.value.length == 0) {
      rdShowMessageDialog("客户名称不能为空，请重新输入 !!")
      document.mainForm.cust_name.focus();
      return false;
   } 

   if (document.mainForm.phone_no.value.length == 0) {
      rdShowMessageDialog("手机号码不能为空，请重新输入 !!")
      document.mainForm.phone_no.focus();
      return false;
   } else if (document.mainForm.phone_no.value.length < 11) {
      rdShowMessageDialog("手机号码不能小于11位，请重新输入 !!")
      document.mainForm.phone_no.focus();
      return false;
   }

   if (document.mainForm.bill_no.value.length != 0) {
       if (document.mainForm.bill_money.value.length == 0) {
	      rdShowMessageDialog("您已经输入支票号码，支票金额不能为空，请重新输入 !!")
          document.mainForm.bill_money.focus();
          return false;
	   }

       if (document.mainForm.money_total.value.length != 0) {
	      rdShowMessageDialog("您已经输入支票号码，现金金额必须空，请重新输入 !!")
          document.mainForm.money_total.focus();
          return false;
	   }
   } else {
       if (document.mainForm.bill_money.value.length != 0) {
	      rdShowMessageDialog("您没有输入支票号码，支票金额必须为空，请重新输入 !!")
          document.mainForm.bill_money.focus();
          return false;
	   }

       if (document.mainForm.money_total.value.length == 0) {
	      rdShowMessageDialog("您没有输入支票号码，现金金额不能为空，请重新输入 !!")
          document.mainForm.money_total.focus();
          return false;
	   }
   }   
   
   if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("开始年月不能为空，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("开始年月不能小于6位，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   }

   if (document.mainForm.end_ym.value.length == 0) {
      rdShowMessageDialog("结束年月不能为空，请重新输入 !!")
      document.mainForm.end_ym.focus();
      return false;
   } else if (document.mainForm.end_ym.value.length < 6) {
      rdShowMessageDialog("结束年月不能小于6位，请重新输入 !!")
      document.mainForm.end_ym.focus();
      return false;
   }
	//xl add 201407后月结 不可以操作
	if(document.mainForm.begin_ym.value>="201407" ||document.mainForm.end_ym.value>="201407")
	{
		rdShowMessageDialog("7月份以后的月结发票请在zg17开具!!")
		return false;
	}
	else
	{
		document.mainForm.action="s1321_3show.jsp";   
		document.mainForm.submit();
	}
	
 }

 function sel1() {
    window.location.href='s1321_1.jsp';
 }
 
 function sel2(){
     window.location.href='s1321_2.jsp';
 }
 
 function sel3(){
     window.location.href='s1321_3.jsp';
 }
 
function doclear() {
 	mainForm.reset();
}
//-->
</SCRIPT>
 
<title>黑龙江BOSS-兑换发票</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<FORM action="" method="post" name="mainForm">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择兑换类型</div>
	</div>
<table cellspacing="0">
	<tr bgcolor="649ECC"> 
		<th width="13%">兑换类型</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1"  >
			收据兑换等额发票 
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  >
			收据兑换月消费发票 
			<input name="busyType1" type="radio" onClick="sel3()" value="3"  checked>
			等额发票兑换月消费发票
		</th>
	</tr>  
	 
	<tr> 
		<td class="blue" nowrap>帐户号码</td>
		<td> 
			<input type="text" name="contract_no" value="" maxlength="14" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">客户名称</td>
		<td> 
			<input type="text" name="cust_name" value="" maxlength="20" class="button">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>手机号码</td>
		<td> 
			<input type="text" name="phone_no" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">支票号码</td>
		<td> 
			<input type="text" name="bill_no" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>支票金额</td>
		<td> 
			<input type="text" name="bill_money" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(1)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">现金金额</td>
		<td width="39%">
			<input type="text" class="button" value="" name="money_total" size="20" maxlength="11" onKeyPress="return isKeyNumberdot(1)">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>开始月份</td>
		<td> 
			<input type="text" name="begin_ym" value="<%=dateStr%>" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">结束月份</td>
		<td> 
			<input type="text" name="end_ym" value="<%=dateStr%>" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>				
            
	<TR > 
		<TD align="center" colspan="4" id="footer"> 
			<input type="button" name="Submit1"  class="b_foot" value="查询" onclick="DoCheck()" index="9">
			&nbsp;
			<input type="button" name="return" class="b_foot" value="清除" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return" class="b_foot" value="关闭" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>