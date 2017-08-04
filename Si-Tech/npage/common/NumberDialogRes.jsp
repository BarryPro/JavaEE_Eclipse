<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/
//add by luogj 20070618,取消1104中对客户密码“000000”，“111111”，“123456”的限制
%>
<%@ page contenttype="text/html;charset=gb2312" %>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%
   String pwdlength = request.getParameter("pwdlength");
   if (pwdlength == null) {
       pwdlength = "6";
   }
%>
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-密码小键盘</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
window.returnValue='';
function okDialog() {
   var inputPassword = document.all.inputpassword.value; 
   
   if (inputPassword.length == 0) {
       rdShowMessageDialog("密码不能为空，请重新输入！");
	   document.all.inputpassword.focus();
	   return false;
   } else if (inputPassword.length < <%=pwdlength%>){
       rdShowMessageDialog("密码长度至少为<%=pwdlength%>位，请重新输入！");
	     document.all.inputpassword.focus();
       return false;
   }
     /*else if(inputPassword=="000000"||inputPassword=="111111"||inputPassword=="123456")
   	{
   		rdShowMessageDialog("确认有效服务密码是除'000000'、'111111'、'123456'以外的6位阿拉伯数字");
	   document.all.inputpassword.value = "";
	   document.all.inputpassword.focus();
       return false;
   		} */
   //add by wangyh 2007/08/02 begin
   for(i=1;i<6;i++)
   		{
   		  if(inputPassword.charAt(i) != inputPassword.charAt(i-1))
   		  		break;
   				}
   if(i >= 6)
    {
   		rdShowMessageDialog("您设置的服务密码过于简单，建议您重新设置。");
   		}
 	
   for(i=1;i<6;i++)
   		{
   			var a = parseInt(inputPassword.charAt(i));
   			var b = parseInt(inputPassword.charAt(i-1));
   		  if(a != (b+1))
   		  		break;
   				}
   if(i >= 6)
    {
   		rdShowMessageDialog("您设置的服务密码过于简单，建议您重新设置。");
   		}
    for(i=1;i<6;i++)
   		{
   			var a = parseInt(inputPassword.charAt(i));
   			var b = parseInt(inputPassword.charAt(i-1));
   		  if(a != (b-1))
   		  		break;
   				}
   if(i >= 6)
    {
   		rdShowMessageDialog("您设置的服务密码过于简单，建议您重新设置。");
   		}   		
   //wangyh end
   window.returnValue = inputPassword;     
   window.close();
}

function cancelDialog() {
   window.close();
}
</script>
</head>
<BODY onLoad="OnInputPwd(document.all.inputpassword);" onBeforeUnload="CloseInputPort();" leftmargin="0" topmargin="0" background="/images/jl_background_2.gif">
<DIV id="Operation_Table">
  <div class="title">客户密码</div>
  <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr >
      <td height="25" class="blue"><div align="right" >输入密码</div></td>
      <td height="25"><div align="left">
          <input name="inputpassword" type="password" maxlength="<%=pwdlength%>" class="button"  onKeyPress="return isKeyNumberdot(0)" filedtype="pwd" functype="0">
        </div></td>
    </tr>
    <tr>
      <td id="footer" colspan="6"><div align="center" colspan="2">
          <input class="b_foot" type="button" name="Button" value="确定" onClick="okDialog()">
          &nbsp;&nbsp;&nbsp;
          <input class="b_foot" type="button" name="return" value="返回" onClick="cancelDialog()">
        </div></td>
    </tr>
  </table>
  <jsp:include page="/npage/common/pwd_comm.jsp"/>
</div>
</body>
</html>
