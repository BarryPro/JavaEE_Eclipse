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
		String opCode = "g053";
		String opName = "������Ʊ��Ϣ";
		String login_no = (String)session.getAttribute("workNo");
		String sqlStr = "select BANK_CODE,BANK_NAME from QD_BANKCODE order by BANK_CODE";
	    String sqlStr1 = "select region_code,region_name from sregioncode where region_code<=13 order by region_code";
		
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String bank_options = "<option value=>--��ѡ��--</option>";
   String region_options ="<option value=>--��ѡ��--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     bank_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     region_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.s_Invoice_number.value=="")  {
     rdShowMessageDialog("��������ʼ��Ʊ����!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.s_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("��ʼ��Ʊ���볤�Ȳ���!");
     document.frm.s_Invoice_number.value = "";
     document.frm.s_Invoice_number.focus();
     return false;
  }
	
	if(document.frm.e_Invoice_number.value=="")  {
     rdShowMessageDialog("��������ֹ��Ʊ����!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.e_Invoice_number.value.length < 8)  {
     rdShowMessageDialog("��ֹ��Ʊ���볤�Ȳ���!");
     document.frm.e_Invoice_number.value = "";
     document.frm.e_Invoice_number.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value=="")  {
     rdShowMessageDialog("�����뷢Ʊ����!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value.length < 12)  {
     rdShowMessageDialog("��Ʊ���볤�Ȳ���!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  if(document.frm.bank_code.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.bank_code.value = "";
     document.frm.bank_code.focus();
     return false;
  }
  if(document.frm.region_code.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.region_code.value = "";
     document.frm.region_code.focus();
     return false;
  }
  
	document.frm.submit();
	            
}

 function sel1() { 		 
	window.location.href='g053.jsp';
 }
 function sel2(){ 
	window.location.href='g053_2.jsp';
 } 
 function sel3(){
    window.location.href='g053_3.jsp';
 }
function sel4(){
    window.location.href='g053_4.jsp';
 }
function sel5(){
    window.location.href='g053_5.jsp';
 }
function sel6(){
    window.location.href='g053_6.jsp';
} 
function sel7(){
    window.location.href='g053_7.jsp';
}
function doclear() {
 	frm.reset();
}

 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY>
<form action="g053Cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊͳ����Ϣ��¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" checked>������Ʊ 
          <input name="busyType2" type="radio" onClick="sel5()" value="1">Ӫҵ����Ʊ
<!--           
          <input name="busyType2" type="radio" onClick="sel2()" value="1">��Ʊʹ�������ѯ 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">���ô������ 
          <input name="busyType2" type="radio" onClick="sel4()" value="1">�������ô������   
 -->                 
          <input name="busyType2" type="radio" onClick="sel6()" value="1">��ѯ��ɾ��
		  <input name="busyType2" type="radio" onClick="sel7()" value="1">��ѯ
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��ʼ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="s_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��ֹ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="e_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="12" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>      
    </tr>
    
    <tr>
    	<td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="bank_code" >
          	<%=bank_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
          	<%=region_options%>                   
          </select><font color="#FF0000">*</font>
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

