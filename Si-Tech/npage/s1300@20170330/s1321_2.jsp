<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�һ���Ʊ1321
   * �汾: 1.0
   * ����: 2009/1/16
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = "1321";
		String opName = "�һ���Ʊ";
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());//�·�
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<script language="JavaScript">
<!--	
 function sel1() {
    window.location.href='s1321_1.jsp';
 }

 function sel2(){
     window.location.href='s1321_2.jsp';
 }
 
 function sel3() {
     window.location.href='s1321_3.jsp';
 }

 function docheck() {
    
	if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("�ʻ����벻��Ϊ�գ����������� !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("�ʻ����벻��С��11λ������������ !!")
      document.mainForm.contract_no.focus();
      return false;
   } 

 
   if (document.mainForm.year_month.value.length == 0) {
      rdShowMessageDialog("�վ��·ݲ���Ϊ�գ����������� !!")
      document.mainForm.year_month.focus();
      return false;
   } else if (document.mainForm.year_month.value.length < 6) {
      rdShowMessageDialog("�վݿ�ʼ�·ݲ���С��6λ������������ !!")
      document.mainForm.year_month.focus();
      return false;
   }

   if (document.mainForm.year_month_end.value.length == 0) {
      rdShowMessageDialog("�վݽ������²���Ϊ�գ����������� !!")
      document.mainForm.year_month_end.focus();
      return false;
   } else if (document.mainForm.year_month_end.value.length < 6) {
      rdShowMessageDialog("�վݽ������²���С��6λ������������ !!")
      document.mainForm.year_month_end.focus();
      return false;
   }
if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("��Ʊ��ʼ�·ݲ���Ϊ�գ����������� !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("��Ʊ��ʼ�·ݲ���С��6λ������������ !!")
      document.mainForm.begin_ym.focus();
      return false;
   }

   if (document.mainForm.begin_ym_end.value.length == 0) {
      rdShowMessageDialog("��Ʊ�������²���Ϊ�գ����������� !!")
      document.mainForm.begin_ym_end.focus();
      return false;
   } else if (document.mainForm.begin_ym_end.value.length < 6) {
      rdShowMessageDialog("��Ʊ�������²���С��6λ������������ !!")
      document.mainForm.begin_ym_end.focus();
      return false;
   }
    //xl add 201407���½� �����Բ���
	if(document.mainForm.begin_ym.value>="201407" ||document.mainForm.begin_ym_end.value>="201407" ||document.mainForm.year_month.value>="201407" ||document.mainForm.year_month_end.value>="201407")
	{
		rdShowMessageDialog("7�·��Ժ���½ᷢƱ����zg17����!!")
		return false;
	}
	else
	{
		document.mainForm.action="s1321_2show.jsp";   
		document.mainForm.submit();
	}	
	
 }
-->
 </script> 
 
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
	<tr> 
		<th>�һ�����</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1"  >
			�վݶһ��ȶƱ
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  checked>
			�վݶһ������ѷ�Ʊ
			<input name="busyType1" type="radio" onClick="sel3()" value="3"  >
			�ȶƱ�һ������ѷ�Ʊ
		</th>
	</tr>   
	<tr> 
		<td class="blue">�ʻ�����</td>
		<td colspan="3"> 
			<input type="text" class="button" value="" name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<tr> 
		<td class="blue">�վݿ�ʼ�·�</td>
		<td> 
			<input type="text" class="button" value="<%=dateStr%>" name="year_month" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue" nowrap>�վݽ����·�</td>
		<td>
			<input type="text" class="button" value="<%=dateStr%>" name="year_month_end" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
                
	<tr> 
		<td class="blue">��Ʊ��ʼ�·�</td>
		<td> 
			<input type="text" class="button" value="<%=dateStr%>" name="begin_ym" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue" nowrap>��Ʊ�����·�</td>
		<td>
			<input type="text" class="button" value="<%=dateStr%>" name="begin_ym_end" size="20" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<TR > 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="��ѯ" onclick="docheck()"  >
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()"  >
		</td>
	</tr>
</table>
	  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>
