<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 奥运手机报短信版BOSS订购7191
   * 版本: 1.0
   * 日期: 2008/01/13
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>奥运手机报短信版BOSS订购</title>
<%
    String opCode="7191";
	String opName="奥运手机报短信版BOSS订购";
	String phoneNo = (String)request.getParameter("activePhone");			//用户手机号
    String workNo=(String)session.getAttribute("workNo");					//工号
%>
</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
	frm.action="f7191_1.jsp";
	document.all.opcode.value="7191";
	frm.submit();	
	return true;
}
function opchange(){

	 if(document.all.opFlag[0].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opcode" >
	<div class="title">
		<div id="title_zi">奥运手机报短信版BOSS订购</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="25%">手机号码</td> 
		<td> 
			<input class="InputGrey" readOnly type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
			<font color="orange">*</font>
		</td>
	</tr>
	<TR style="display:none" id="backaccept_id"> 
		<TD class="blue">业务流水</TD>
		<TD>
			<input class="button" type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR>    

	<tr> 
		<td colspan="2" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>