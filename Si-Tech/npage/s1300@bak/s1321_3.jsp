<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�һ���Ʊ1321
   * �汾: 1.0
   * ����: 2009/2/16
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%  
	String opCode = "1321";
	String opName = "�һ���Ʊ";
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
 function DoCheck(){
    if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("�ʻ����벻��Ϊ�գ����������� !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("�ʻ����벻��С��11λ������������ !!")
      document.mainForm.contract_no.focus();
      return false;
   } 

   if (document.mainForm.cust_name.value.length == 0) {
      rdShowMessageDialog("�ͻ����Ʋ���Ϊ�գ����������� !!")
      document.mainForm.cust_name.focus();
      return false;
   } 

   if (document.mainForm.phone_no.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!")
      document.mainForm.phone_no.focus();
      return false;
   } else if (document.mainForm.phone_no.value.length < 11) {
      rdShowMessageDialog("�ֻ����벻��С��11λ������������ !!")
      document.mainForm.phone_no.focus();
      return false;
   }

   if (document.mainForm.bill_no.value.length != 0) {
       if (document.mainForm.bill_money.value.length == 0) {
	      rdShowMessageDialog("���Ѿ�����֧Ʊ���룬֧Ʊ����Ϊ�գ����������� !!")
          document.mainForm.bill_money.focus();
          return false;
	   }

       if (document.mainForm.money_total.value.length != 0) {
	      rdShowMessageDialog("���Ѿ�����֧Ʊ���룬�ֽ������գ����������� !!")
          document.mainForm.money_total.focus();
          return false;
	   }
   } else {
       if (document.mainForm.bill_money.value.length != 0) {
	      rdShowMessageDialog("��û������֧Ʊ���룬֧Ʊ������Ϊ�գ����������� !!")
          document.mainForm.bill_money.focus();
          return false;
	   }

       if (document.mainForm.money_total.value.length == 0) {
	      rdShowMessageDialog("��û������֧Ʊ���룬�ֽ����Ϊ�գ����������� !!")
          document.mainForm.money_total.focus();
          return false;
	   }
   }   
   
   if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("��ʼ���²���Ϊ�գ����������� !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("��ʼ���²���С��6λ������������ !!")
      document.mainForm.begin_ym.focus();
      return false;
   }

   if (document.mainForm.end_ym.value.length == 0) {
      rdShowMessageDialog("�������²���Ϊ�գ����������� !!")
      document.mainForm.end_ym.focus();
      return false;
   } else if (document.mainForm.end_ym.value.length < 6) {
      rdShowMessageDialog("�������²���С��6λ������������ !!")
      document.mainForm.end_ym.focus();
      return false;
   }
	//xl add 201407���½� �����Բ���
	if(document.mainForm.begin_ym.value>="201407" ||document.mainForm.end_ym.value>="201407")
	{
		rdShowMessageDialog("7�·��Ժ���½ᷢƱ����zg17����!!")
		return false;
	}
	else
	{
		document.mainForm.action="s1321_3show.jsp";   
		document.mainForm.submit();
	}
	
 }

 function sel1() {
    window.location.href='s1321_1.jsp';
 }
 
 function sel2(){
     window.location.href='s1321_2.jsp';
 }
 
 function sel3(){
     window.location.href='s1321_3.jsp';
 }
 
function doclear() {
 	mainForm.reset();
}
//-->
</SCRIPT>
 
<title>������BOSS-�һ���Ʊ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<FORM action="" method="post" name="mainForm">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ��һ�����</div>
	</div>
<table cellspacing="0">
	<tr bgcolor="649ECC"> 
		<th width="13%">�һ�����</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1"  >
			�վݶһ��ȶƱ 
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  >
			�վݶһ������ѷ�Ʊ 
			<input name="busyType1" type="radio" onClick="sel3()" value="3"  checked>
			�ȶƱ�һ������ѷ�Ʊ
		</th>
	</tr>  
	 
	<tr> 
		<td class="blue" nowrap>�ʻ�����</td>
		<td> 
			<input type="text" name="contract_no" value="" maxlength="14" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">�ͻ�����</td>
		<td> 
			<input type="text" name="cust_name" value="" maxlength="20" class="button">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>�ֻ�����</td>
		<td> 
			<input type="text" name="phone_no" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">֧Ʊ����</td>
		<td> 
			<input type="text" name="bill_no" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>֧Ʊ���</td>
		<td> 
			<input type="text" name="bill_money" value="" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(1)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">�ֽ���</td>
		<td width="39%">
			<input type="text" class="button" value="" name="money_total" size="20" maxlength="11" onKeyPress="return isKeyNumberdot(1)">
			<font color="orange"> *</font>
		</td>                  
	</tr>

	<tr> 
		<td class="blue" nowrap>��ʼ�·�</td>
		<td> 
			<input type="text" name="begin_ym" value="<%=dateStr%>" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">�����·�</td>
		<td> 
			<input type="text" name="end_ym" value="<%=dateStr%>" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>				
            
	<TR > 
		<TD align="center" colspan="4" id="footer"> 
			<input type="button" name="Submit1"  class="b_foot" value="��ѯ" onclick="DoCheck()" index="9">
			&nbsp;
			<input type="button" name="return" class="b_foot" value="���" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return" class="b_foot" value="�ر�" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>