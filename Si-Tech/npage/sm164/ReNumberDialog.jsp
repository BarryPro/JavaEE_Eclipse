<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/********************
 version v2.0
������: si-tech
********************/
%>
<HTML>
<HEAD>
<TITLE>������BOSS-����С����</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<link rel="stylesheet" href="/css/jl.css" type="text/css">
<script language="JavaScript">
window.returnValue='';
function okDialog() {
   var inputPassword = document.all.inputpassword.value; 
   var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
   if (inputPassword.length == 0) {
       rdShowMessageDialog("���벻��Ϊ�գ����������룡");
	   document.all.inputpassword.focus();
	   return false;
   } else if (inputPassword.length != 15){
       rdShowMessageDialog("���볤�ȱ���Ϊ15λ�����������룡");
	   document.all.inputpassword.focus();
       return false;
   }
   if(!reg.test(inputPassword)){
		rdShowMessageDialog("���������ĸ�����֣�");
		document.all.inputpassword.focus();
		return false;
	}

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
<div id="title_zi">�ͻ�����</div> 
 <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr > 
      <td height="25" class="blue">
         <div align="right">�������룺</div>
      </td>
	  <td height="25"> 
        <div align="left">
		   <input name="inputpassword" type="password"   onKeyPress="return isKeyNumberdot(0)" filedtype="pwd" functype="0">
		</div>
      </td>     
    </tr>
    
	<tr> 
      <td  id="footer" colspan="6"> 
        <div align="center" colspan="2"> 
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="okDialog()">
          &nbsp;&nbsp;&nbsp;
		  <input class="b_foot" type="button" name="return" value="����" onClick="cancelDialog()">
        </div>
      </td>
    </tr>
  </table>
  <jsp:include page="/npage/sm164/pwd_comm.jsp"/>
 </div>
</body>
</html>
