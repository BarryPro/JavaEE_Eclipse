<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "9493";
		String opName = "��Ʊ��Ϣ��ѯ";

%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.login_accept.value=="")  {
     rdShowMessageDialog("��������ˮ!");
     document.frm.login_accept.value = "";
     document.frm.login_accept.focus();
     return false;
  }
  /*	
  if(document.frm.phoneNo.value=="")  {
     rdShowMessageDialog("������������!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
  if(document.frm.phoneNo.value.length != 11)  {
     rdShowMessageDialog("������볤�Ȳ���!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  */
  if(document.frm.print_time.value=="")  {
     rdShowMessageDialog("�������ӡ����!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  }  
  
  if(document.frm.print_time.value.length !=6 )  {
     rdShowMessageDialog("��ӡ���³��Ȳ���!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  }  
  /*
  if(document.frm.check_num.value=="")  {
     rdShowMessageDialog("�������α��!");
     document.frm.check_num.value = "";
     document.frm.check_num.focus();
     return false;
  }  
  
  if(document.frm.check_num.value.length !=4 )  {
     rdShowMessageDialog("��α�볤�Ȳ���!");
     document.frm.check_num.value = "";
     document.frm.check_num.focus();
     return false;
  }  
  */
	document.frm.submit();
	            
}

 function sel1() {
 		window.location.href='s9493.jsp';
 }

 function sel2(){
    window.location.href='s9493_3.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
 function sel6(){
    window.location.href='s9493_6.jsp';
 }
 function doclear() {
 		frm.reset();
 }


 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form action="s9493_query.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊ��Ϣ��ѯ��¼��</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType1" type="radio" onClick="sel1()" value="1" checked>����ˮ��ѯ 
          <input name="busyType21" type="radio" onClick="sel2()" value="2"> ����Ʊ�����ѯ
          <input name="busyType22" type="radio" onClick="sel3()" value="3"> ¼�뷢Ʊ����ͷ�Ʊ���� 
          <input name="busyType23" type="radio" onClick="sel6()" value="4"> ӪҵԱ��Ʊɾ��
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="center" class="blue" width="15%">��ˮ:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="login_accept" size="20" maxlength="20" onKeyPress="return isKeyNumberdot(0)">
      </td>
	  <!--
      <td align="center" class="blue" width="15%">�������:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="phoneNo" size="11" maxlength="11" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="center" class="blue" width="15%">��α��:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="check_num" size="4" maxlength="4" onKeyPress="return isKeyNumberdot(0)">
      </td>
	  -->
      <td align="center" class="blue" width="15%">��ӡ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="print_time" size="6" maxlength="6" onKeyPress="return isKeyNumberdot(0)"> &nbsp;(��ʽ:YYYYMM)
      </td>
      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="��ѯ" onclick="commit()" >
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
