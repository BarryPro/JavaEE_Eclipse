<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
		String opCode = "e746";
		String opName = "������Ʊ¼��";
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
  
  if(document.frm.qdgh.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.qdgh.value = "";
     document.frm.qdgh.focus();
     return false;
  }
	
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
 		 
		window.location.href='e746_1.jsp';
 }

 function sel2(){
 
	window.location.href='e746_3.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
 //ɾ��
function sel4(){
    //alert("4");
	window.location.href='e746_delete.jsp';
 }
 function doclear() {
 		frm.reset();
 }
 function init2()
 {
	if(document.all.qdgh.value=="" || document.all.region_code.value=="" ||document.all.bank_code.value=="")
	{
		rdShowMessageDialog("��ѡ���������ƻ�������ƻ������������Ų�������ѯ!");
		return false;
	}
	else
	{
		var myPacket = new AJAXPacket("getPaper.jsp","���ڲ�ѯ�����Ժ�......");
		myPacket.data.add("loginNo",document.all.qdgh.value);
		myPacket.data.add("region_code",document.all.region_code.value);
		myPacket.data.add("bank_code",document.all.bank_code.value);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
	
 
 }
 function doProcess(packet){
	var return_code = packet.data.findValueByName("return_code");
	var return_msg = packet.data.findValueByName("return_msg");
	//alert("return_code is "+return_code);
	if(return_code=="000000")
	{
		var S_INVOICE_NUMBER=packet.data.findValueByName("S_INVOICE_NUMBER");
		var E_INVOICE_NUMBER=packet.data.findValueByName("E_INVOICE_NUMBER");
		var INVOICE_CODE=packet.data.findValueByName("INVOICE_CODE");
		var return_msg=packet.data.findValueByName("return_msg");
		document.frm.s_Invoice_number1.value=S_INVOICE_NUMBER;
		document.frm.e_Invoice_number1.value=E_INVOICE_NUMBER;
		document.frm.Invoice_code1.value=INVOICE_CODE;
		document.frm.query.disabled=false;
	}
	else
	{
		rdShowMessageDialog("��ѯ����! ����ԭ��"+return_msg);
		return false;
	}
	

 }
 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY  >
<form action="e746_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">������Ʊ��Ϣ��ѯ��¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4">           
          <input name="busyType22" type="radio" onClick="sel1()"  value="3" checked> ����¼�뷢Ʊ����ͷ�Ʊ����
		  <input name="busyType23" type="radio" onClick="sel4()" value="4"> ӪҵԱ��Ʊɾ��
		</td>

      
    </tr>
  </table>

  
  <table cellspacing="0">
  	
  	<tr>
     <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="bank_code" >
          	<%=bank_options%>                   
          </select>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="region_code" >
          	<%=region_options%>                   
          </select>
      </td>
      <td align="left" class="blue" width="15%">
		�������ţ�&nbsp;&nbsp;&nbsp;<input type="text" name="qdgh"><font color="#FF0000">*</font>
	  </td>
    </tr>
    <tr>
    	<td align="left" class="blue" width="15%">��ʼ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="s_Invoice_number" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��ֹ��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="e_Invoice_number" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
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
              <input type="button" name="query1" class="b_foot" value="��ѯ" onclick="init2()" >
          &nbsp;
			  <input type="button" name="query" class="b_foot" disabled value="ȷ��" onclick="commit()" >
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

