<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-22 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>随意行包年</title>
<%
	String opCode = "1201";
	String opName = "随意行包年";
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
 	self.status="";
    document.all.srv_no.focus();
  }
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(check(frm))
  {
    frm.action="f1201Main.jsp";
    frm.submit();	
  }
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户登录</div>
</div>

	<table border="0" cellspacing="0">
		
		<tr> 
			<td nowrap class="blue">手机号码</td>
			<td nowrap> 
				<input type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" maxlength="11" index="0" value="<%=activePhone%>" class="InputGrey" readOnly>
				<font class="orange">*</font>
			</td>
			
		</tr>
		<tr> 
			<td colspan=2 id="footer"> 
				<div align="center"> 
					<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
					<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
				</div>
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>