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
		String login_no = (String)session.getAttribute("workNo");

%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
  if(document.frm.delete_number.value=="")  {
     rdShowMessageDialog("������ɾ����Ʊ����!");
     document.frm.delete_number.value = "";
     document.frm.delete_number.focus();
     return false;
  }
  
  if(Number(document.frm.delete_number.value) > Number(document.frm.max_delete_number.value))  {
     rdShowMessageDialog("����ɾ����Ʊ��������ӪҵԱ��Ʊ����������������!");
     document.frm.delete_number.value = "";
     document.frm.delete_number.focus();
     return false;
  }
  
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
 function init()
 {
	//alert("��ṹ~~"+"<%=login_no%>");
	document.getElementById("show1").style.display="none";
	<%
	int max = 0;
	String[][] result = new String[][]{};	
	String sql_init = "select S_INVOICE_NUMBER,E_INVOICE_NUMBER,INVOICE_CODE from WLOGININVOICE where LOGIN_NO = '"+login_no+"'  "; 
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
		max = Integer.parseInt(result[0][1]) - Integer.parseInt(result[0][0]) + 1;
	}
	%>
 }
 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY onload = "init()">
<form action="s9493_6Cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">ӪҵԱ��Ʊɾ��</div>
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
          
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >����ˮ��ѯ 
          <input name="busyType21" type="radio" onClick="sel2()" value="2" > ����Ʊ�����ѯ 
          <input name="busyType22" type="radio" onClick="sel3()" value="3" > ¼�뷢Ʊ����ͷ�Ʊ����
          <input name="busyType23" type="radio" onClick="sel6()" value="4" checked> ӪҵԱ��Ʊɾ��
          
      </td>
      
    </tr>
  </table>
  
  <table cellspacing="0">
	<div id ="show">
	<tr id ="show1">
    	<td align="left" class="blue" width="15%">��ʼ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="s_Invoice_number1" id="s_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��ֹ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="e_Invoice_number1" id="e_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="Invoice_code1" id="Invoice_code1" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>     
    </tr>
	</div>
	<tr>
    	<td align="left" class="blue" width="15%">ɾ����Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="delete_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">���ɾ������:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="max_delete_number" readonly size="10" maxlength="8" value="<%=max%>" onKeyPress="return isKeyNumberdot(0)">
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

