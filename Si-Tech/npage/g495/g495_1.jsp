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
		String opCode = "g495";
		String opName = "�°���ͨӪҵԱ��Ʊ¼��";
		String login_no = (String)session.getAttribute("workNo");

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
  
	document.frm.submit();
	            
}

 function sel1() {
 		 
		window.location.href='g495_1.jsp';
 }

 function sel2(){
 
	window.location.href='e902.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
function sel4(){
    window.location.href='s9493_5.jsp';
 }
 function doclear() {
 		frm.reset();
 }
 function init()
 {
	//alert("��ṹ~~"+"<%=login_no%>");
	document.getElementById("show1").style.display="none";
	<%
	String[][] result = new String[][]{};	
	String sql_init = "select S_INVOICE_NUMBER,E_INVOICE_NUMBER,INVOICE_CODE from TT_WLOGININVOICE where LOGIN_NO = '"+login_no+"' and flag='N'  "; 
	%>
	<wtc:pubselect name="sPubSelect" outnum="3">
			<wtc:sql><%=sql_init%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retList" scope="end" />
	<%
	result = retList;
    if(retList.length != 0)
	{
		%>//alert("�ǿ� "+"<%=result[0][0]%>"+"<%=result[0][1]%>"+"<%=result[0][2]%>");
		document.getElementById("show1").style.display="block";
		document.getElementById("s_Invoice_number1").value="<%=result[0][0]%>";
		document.getElementById("e_Invoice_number1").value="<%=result[0][1]%>";
		document.getElementById("Invoice_code1").value="<%=result[0][2]%>";
		<%
	}
	%>
 }

 function sel1() {
 	window.location.href='g495_1.jsp';
 }

 function sel2(){
    window.location.href='e902.jsp';
 }
 function sel3(){
    window.location.href='e903.jsp';
 }
 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY onload = "init()">
<form action="g495_cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�°���ͨӪҵԱ��Ʊ¼��</div>
		</div> 
	<!--
  <table cellspacing="0">
  
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
        	
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >����ˮ��ѯ 
          <input name="busyType21" type="radio" onClick="sel2()" value="2" > ����Ʊ�����ѯ 
          <input name="busyType22" type="radio" onClick="sel3()" value="3" checked> ¼�뷢Ʊ����ͷ�Ʊ����
      </td>
      
    </tr>
    
  </table>-->

 <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <!--
			<input name="busyType1" type="radio" onClick="sel2()" value="2" >����ˮ��ѯ 
          <input name="busyType1" type="radio" onClick="sel3()" value="3" >ӪҵԱ��Ʊɾ�� 
		  -->
          <input name="busyType1" type="radio" onClick="sel1()" value="1" checked> ¼�뷢Ʊ����ͷ�Ʊ���� 
          
      </td>
      
    </tr>
  </table>
  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��ʼ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="s_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��ֹ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="e_Invoice_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="12" onKeyPress="return isKeyNumberdot(0)">
      </td>
      
    </tr>
	<div id ="show">
	<tr id ="show1">
    	<td align="left" class="blue" width="15%">��ʼ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly id="s_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��ֹ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly id="e_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly id="Invoice_code1" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>
      
    </tr>
	</div>
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

