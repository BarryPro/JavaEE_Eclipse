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

		String opCode = "g165";
		String opName = "����Ʊ¼��";
		String workno = (String)session.getAttribute("workNo");
%>
  


<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	var invoice_id = document.frm.invoice_id.value;
	var invoice_no=document.frm.invoice_no.value;
	var loss_type=document.frm.loss_type.value;
	var loss_reason=document.frm.loss_reason.value;
	
	/*xl add ��Ʊ����*/
	var fplx=document.frm.fplx.value;
	 //alert("test fplx is "+fplx);
	if(document.frm.invoice_id.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.invoice_id.value = "";
     document.frm.invoice_id.focus();
     return false;
  }
  
	
	if(document.frm.invoice_no.value=="")  {
     rdShowMessageDialog("�����뱨��Ʊ����!");
     document.frm.invoice_no.value = "";
     document.frm.invoice_no.focus();
     return false;
  }
  
  
  if(document.frm.loss_reason.value=="")  {
     rdShowMessageDialog("�����뱨��ԭ��!");
     document.frm.loss_reason.value = "";
     document.frm.loss_reason.focus();
     return false;
  }
  document.frm.submit();

	            
}

 
 function doclear() {
 		frm.reset();
 }

 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form  method="post" name="frm" action="g165_2.jsp">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">����Ʊ¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">¼�뷽ʽ</td>
        <td> 
          <input name="busyType2" type="radio"  value="1" checked>ӪҵԱ����Ʊ 
		</td>
      &nbsp;&nbsp;
		<td class="blue" width="15%">��Ʊ����</td>
        <td> 
          <select name="fplx">
				<option value="1">�ƶ���Ʊ</option>
				<option value="2">��ͨ��Ʊ</option>
		  </select> 
		</td>

    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_id"  maxlength="6" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">����Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_no" maxlength="10" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��������:&nbsp;&nbsp;&nbsp;
         <select name="loss_type" >
          	<option value="1">����</option> 
          	<option value="2">����</option>                  
          </select><font color="#FF0000">*</font>
      </td>      
    </tr>
    <tr>
    	<td align="left" class="blue" width="15%">����ԭ��
        <input class="button" type="text" id="loss_reason" name="loss_reason" maxlength="200" ><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="ȷ��" onclick="commit()" >
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

