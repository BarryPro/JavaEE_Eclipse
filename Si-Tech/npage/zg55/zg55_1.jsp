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
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg55";
		String opName = "�ϰ漯�ŷ�Ʊ��ӡ";
 	
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneno.value=="")
  {
     rdShowMessageDialog("������������!");
     document.frm.phoneno.focus();
     return false;
  }
  

  if( document.frm.phoneno.value!="" && document.frm.phoneno.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneno.value = "";
     document.frm.phoneno.focus();
     return false;
  }
	            
	
}

 function docheck()
 {
	 if (document.mainForm.tem1.value.length == 0) {
      rdShowMessageDialog("�������Ʋ���Ϊ�գ����������� !!")
      document.mainForm.tem1.focus();
      return false;
	   }
	   
	 else  if (document.mainForm.tem8.value.length == 0) {
		  rdShowMessageDialog("�ϼƽ���Ϊ�գ����������� !!")
		  document.mainForm.tem8.focus();
		  return false;
	   }
	   //xl add
	  else  if (document.mainForm.seq_num.value.length == 0) {
		  rdShowMessageDialog("��Ʊ���кŲ���Ϊ�գ����������� !!")
		  document.mainForm.seq_num.focus();
		  return false;
	   }
	   else
	  {
		   //document.mainForm.action="../zg44/zg44_2.jsp";
		   document.mainForm.action="zg55_2.jsp";
		   document.mainForm.submit(); 
	   }	
	   
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }

 
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�����뼯�ŷ�Ʊ��ӡ��Ϣ</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��������</td>
      <td> 
       <input class="button" value="" type="text" name="tem1" maxlength="40">
      </td>
      <td class="blue">�ƶ�̨��</td>
      <td> 
        <input class="button" type="text" value="" name="tem2" onKeyPress="return isKeyNumberdot(0)">
      </td>
     </tr>
	 
	 <tr> 
      <td class="blue" width="15%">Э�����</td>
      <td> 
       <input class="button" type="text" value="" name="tem3" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td class="blue">֧Ʊ����</td>
      <td> 
       <input class="button" type="text" value="" name="tem4" onKeyPress="return isKeyNumberdot(0)">
      </td>
     </tr> 
	 
	 <tr> 
      <td class="blue" width="15%">��Ʊ���к�</td>
      <td> 
       <input class="button" type="text" value="" name="seq_num" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td class="blue">�ϼƽ��</td>
      <td> 
       <input class="button" type="text" value="" name="tem8" onKeyPress="return isKeyNumberdot(2)">
      </td>
     </tr> 
	 
	  <tr> 
		  <td class="blue" width="15%">��Ŀ1</td>
		  <td colspan=4> 
		  <input class="button" type="text" value="" size="83" name="tem5">
		  </td>
	  </tr> 
	  <tr>
		  <td class="blue" width="15%">��Ŀ2</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem6">
		  </td>
	  </tr>
	  <tr>
		  <td class="blue" width="15%">��Ŀ3</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem7">
		  </td>
	  </tr>
	  <tr>
		  <td class="blue" width="15%">��ע</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem9">
		  </td>
	  </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ӡ" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%> 
</form>
 </BODY>
</HTML>