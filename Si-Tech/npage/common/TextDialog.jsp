<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-小键盘</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<link rel="stylesheet" href="/css/jl.css" type="text/css">
<script language="JavaScript">
window.returnValue='';

function successDialog() {
   var inputPassword = document.all.inputpassword.value; 
   
   window.returnValue = inputPassword;     
   window.close();
}

function cancelDialog() {
   window.close();
}
</script>
</head>
<BODY onload="OnInputPwdAgain(document.all.inputpassword);" onBeforeUnload="CloseInputPort();" >
	<DIV id="Operation_Table">
<div id="title_zi">手机号码</div> 
 <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr > 
      <td height="25" class="blue">
         <div align="right">输入号码：</div>
      </td>
	  <td height="25"> 
        <div align="left">
		   <input name="inputpassword" type="text" 
		    onKeyPress="return isKeyNumberdot(0)" filedtype="pwd" functype="0" maxlength="13" />
		</div>
      </td>     
    </tr>
    
	<tr> 
      <td  id="footer" colspan="6"> 
        <div align="center" colspan="2"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="successDialog()">
          &nbsp;&nbsp;&nbsp;
		  <input class="b_foot" type="button" name="return" value="返回" onClick="cancelDialog()">
        </div>
      </td>
    </tr>
  </table>
  <jsp:include page="/npage/common/pwd_comm.jsp"/>
 </div>
</body>
</html>
