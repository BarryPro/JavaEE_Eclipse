<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/
//add by luogj 20070618,ȡ��1104�жԿͻ����롰000000������111111������123456��������
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
<TITLE>������BOSS-����С����</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
window.returnValue='';
function okDialog() {
   var inputPassword = document.all.inputpassword.value; 
   
   if (inputPassword.length == 0) {
       rdShowMessageDialog("���벻��Ϊ�գ����������룡");
	   document.all.inputpassword.focus();
	   return false;
   } else if (inputPassword.length < <%=pwdlength%>){
       rdShowMessageDialog("���볤������Ϊ<%=pwdlength%>λ�����������룡");
	     document.all.inputpassword.focus();
       return false;
   }
     /*else if(inputPassword=="000000"||inputPassword=="111111"||inputPassword=="123456")
   	{
   		rdShowMessageDialog("ȷ����Ч���������ǳ�'000000'��'111111'��'123456'�����6λ����������");
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
   		rdShowMessageDialog("�����õķ���������ڼ򵥣��������������á�");
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
   		rdShowMessageDialog("�����õķ���������ڼ򵥣��������������á�");
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
   		rdShowMessageDialog("�����õķ���������ڼ򵥣��������������á�");
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
  <div class="title">�ͻ�����</div>
  <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr >
      <td height="25" class="blue"><div align="right" >��������</div></td>
      <td height="25"><div align="left">
          <input name="inputpassword" type="password" maxlength="<%=pwdlength%>" class="button"  onKeyPress="return isKeyNumberdot(0)" filedtype="pwd" functype="0">
        </div></td>
    </tr>
    <tr>
      <td id="footer" colspan="6"><div align="center" colspan="2">
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="okDialog()">
          &nbsp;&nbsp;&nbsp;
          <input class="b_foot" type="button" name="return" value="����" onClick="cancelDialog()">
        </div></td>
    </tr>
  </table>
  <jsp:include page="/npage/common/pwd_comm.jsp"/>
</div>
</body>
</html>
