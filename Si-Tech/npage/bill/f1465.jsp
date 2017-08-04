<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 彩铃信息费业务受理1465
   * 版本: 1.0
   * 日期: 2008/12/22
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
<title>彩铃业务受理</title>
<%
	String opCode="1465";
	String opName="彩铃信息费业务受理";
	String phoneNo=(String)request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
	self.status="";
    document.all.phoneNo.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	if (0 == document.all.func_type.value){
  	rdShowMessageDialog("请选择彩铃功能类型!");	
  	return false;
  }
  
  controlButt(subButton);//延时控制按钮的可用性
  if(!check(frm)) return false;
  
  frm.action="f1465Main.jsp";
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择功能类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">服务号码</td> 
		<td> 
			<input class="InputGrey" readOnly type="text" size="12" name="phoneNo" value="<%=phoneNo%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>功能类型</td>
		<td class=Input nowrap>
			<select name="func_type" class="button" index="15">
				<option value="00" selected >--请选择功能类型--</option>
				<option value="02">2元彩铃信息费包月</option>
				<option value="03">12元彩铃信息费包年</option>
				<!--   <option value="04">0元彩铃包月</option>  新需求改造动感地带0元月租，封掉此处产品移至个人彩铃申请模块，20071220--> 
				<option value="05">0元彩铃信息费</option>
			</select>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td colspan="2" id="footer" align="center"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
   
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>