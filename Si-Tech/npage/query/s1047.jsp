<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "1047";
		String opName = "ͳ����ʷ��ѯ";
		
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("������������!");
     document.frm.phoneNo.focus();
     return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	            
	
}

 function docheck()
{
	
  if(document.frm.contractno.value=="")
  {
      rdShowMessageDialog("������֧���ʺ�!");
     	document.frm.contractno.focus();
     	return false;
  }
  if(document.frm.yearmonth.value=="")
  {
      rdShowMessageDialog("������ͳ������!");
     	document.frm.yearmonth.focus();
     	return false;
  }
 
  
   document.frm.action="s1047_2.jsp?phoneNo="+document.frm.phoneNo.value+"&contractno="+document.frm.contractno.value+"&yearmonth="+document.frm.yearmonth.value;
   document.frm.query.disabled=true;
   document.frm.submit();
} 


  function doclear() {
 		frm.reset();
 }






-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      <td class="blue">*֧���ʺ�</td>
      <td> 
        <input type="text" name="contractno" size="20" maxlength="20"  >
      </td>
       <td class="blue">*ͳ������</td>
      <td> 
        <input type="text" name="yearmonth" size="20" maxlength="20"  >
      </td>
      
    </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>