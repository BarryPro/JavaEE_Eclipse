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
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());//月份
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<script language="JavaScript">
<!--	
 function sel1() {
    window.location.href='s1321_1.jsp';
 }

 function sel2(){
     window.location.href='s1321_2.jsp';
 }
 
 function sel3() {
     window.location.href='s1321_3.jsp';
 }

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

 
   if (document.mainForm.year_month.value.length == 0) {
      rdShowMessageDialog("收据月份不能为空，请重新输入 !!")
      document.mainForm.year_month.focus();
      return false;
   } else if (document.mainForm.year_month.value.length < 6) {
      rdShowMessageDialog("收据开始月份不能小于6位，请重新输入 !!")
      document.mainForm.year_month.focus();
      return false;
   }

   if (document.mainForm.year_month_end.value.length == 0) {
      rdShowMessageDialog("收据结束年月不能为空，请重新输入 !!")
      document.mainForm.year_month_end.focus();
      return false;
   } else if (document.mainForm.year_month_end.value.length < 6) {
      rdShowMessageDialog("收据结束年月不能小于6位，请重新输入 !!")
      document.mainForm.year_month_end.focus();
      return false;
   }
if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("发票开始月份不能为空，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("发票开始月份不能小于6位，请重新输入 !!")
      document.mainForm.begin_ym.focus();
      return false;
   }

   if (document.mainForm.begin_ym_end.value.length == 0) {
      rdShowMessageDialog("发票结束年月不能为空，请重新输入 !!")
      document.mainForm.begin_ym_end.focus();
      return false;
   } else if (document.mainForm.begin_ym_end.value.length < 6) {
      rdShowMessageDialog("发票结束年月不能小于6位，请重新输入 !!")
      document.mainForm.begin_ym_end.focus();
      return false;
   }
    //xl add 201407后月结 不可以操作
	if(document.mainForm.begin_ym.value>="201407" ||document.mainForm.begin_ym_end.value>="201407" ||document.mainForm.year_month.value>="201407" ||document.mainForm.year_month_end.value>="201407")
	{
		rdShowMessageDialog("7月份以后的月结发票请在zg17开具!!")
		return false;
	}
	else
	{
		document.mainForm.action="s1321_2show.jsp";   
		document.mainForm.submit();
	}	
	
 }
-->
 </script> 
 
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
	<tr> 
		<th>兑换类型</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1"  >
			收据兑换等额发票
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
			收据兑换月消费发票
			<input name="busyType1" type="radio" onClick="sel3()" value="3"  >
			等额发票兑换月消费发票
		</th>
	</tr>   
	<tr> 
		<td class="blue">帐户号码</td>
		<td colspan="3"> 
			<input type="text" class="button" value="" name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<tr> 
		<td class="blue">收据开始月份</td>
		<td> 
			<input type="text" class="button" value="<%=dateStr%>" name="year_month" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue" nowrap>收据结束月份</td>
		<td>
			<input type="text" class="button" value="<%=dateStr%>" name="year_month_end" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
                
	<tr> 
		<td class="blue">发票开始月份</td>
		<td> 
			<input type="text" class="button" value="<%=dateStr%>" name="begin_ym" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue" nowrap>发票结束月份</td>
		<td>
			<input type="text" class="button" value="<%=dateStr%>" name="begin_ym_end" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<TR > 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="查询" onclick="docheck()"  >
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()"  >
		</td>
	</tr>
</table>
	  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>
