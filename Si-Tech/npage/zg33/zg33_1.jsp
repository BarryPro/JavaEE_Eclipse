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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zg33";
String opName = "��ֵ˰ר�÷�Ʊ��ѯ";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 
String begin_tm = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String end_tm = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var tax_number = document.all.tax_number.value;
	var tax_code = document.all.tax_code.value;
	var s_type_id = document.all.s_type[document.all.s_type.selectedIndex].value;
	var login_no = document.all.login_no.value;
	var begin_tm = document.all.begin_tm.value;
	var end_tm = document.all.end_tm.value;
	/*if(s_type_id=="0")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}		
	
	if(tax_number=="" &&tax_code=="")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}
	
	else if(tax_code=="")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("������ֵ˰רƱ��Ʊ����!");
		return false;
	}*/
	if((begin_tm=="" &&end_tm!="")||(begin_tm!="" &&end_tm==""))
	{
		rdShowMessageDialog("��ֵ˰��ѯ��ʼ������ʱ�����ȫ������!");
		return false;
	}
	else
	{
		document.frm.action="zg33_2.jsp";
		document.frm.submit(); 
	}	
	
	
} 

 

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	
 }

 
  function doExport()
  {
	  
	  document.frm.action="zg12_export.jsp";
	  document.frm.submit();

  }
  function doImport()
  {
	  alert("1");
	  document.frm.action="zg12_import.jsp";
	  document.frm.submit();
  }
  function doTest()
  {
	  alert("1");
	  document.frm.action="zg12_xmltest.jsp";
	  document.frm.submit();
  }
  function do_paynote()
  {
	  alert("?");
	  document.frm.action="zg12_paynote.jsp";
	  document.frm.submit();
  }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
<div class="title">
	<div id="title_zi">�������ѯ����</div>
</div> 	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��ѯ����</td>
      <td> 
        <input class="button"type="text" name="login_no"   size="20"  colspan=2    >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ѯ��ʼʱ��(YYYYMMDD)</td>
      <td> 
        <input class="button"type="text" name="begin_tm" maxlength=8 size="20" value="<%=begin_tm%>"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ѯ����ʱ��(YYYYMMDD)</td>
      <td> 
        <input class="button"type="text" name="end_tm" maxlength=8 size="20" value="<%=end_tm%>" colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��Ʊ״̬</td>
      <td> 
        <select id="s_type_id" name="s_type">
			<option value="">--��ѡ��</option>
			<option value="1">�ѿ���</option>
			<option value="2">���</option>
			<option value="3">�����</option>
			<option value="4">������</option>
			<option value="5">�Ѵ���</option>
			<option value="6">������</option>
			<option value="7">������</option>
			<option value="8">������</option>
		</select>
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ֵ˰רƱ��Ʊ����</td>
      <td> 
        <input class="button"type="text" name="tax_number" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ֵ˰רƱ��Ʊ����</td>
      <td> 
        <input class="button"type="text" name="tax_code" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>

	 
	 
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="����չʾpay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="����" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="����" onclick="doImport()" >	
        -->
      <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
        
	  <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >

	  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
	  </td>
	   
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>