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
		String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
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

   if (document.mainForm.login_accept.value.length == 0) {
      rdShowMessageDialog("�ɷ���ˮ����Ϊ�գ����������� !!")
      document.mainForm.login_accept.focus();
      return false;
   }

   if (document.mainForm.year_month.value.length == 0) {
      rdShowMessageDialog("�ɷ��·ݲ���Ϊ�գ����������� !!")
      document.mainForm.year_month.focus();
      return false;
   } else if (document.mainForm.year_month.value.length < 6) {
      rdShowMessageDialog("�ɷ��·ݲ���С��6λ������������ !!")
      document.mainForm.year_month.focus();
      return false;
   }
   //xl add 201407���½� �����Բ���
   if(document.mainForm.year_month.value>="201407") //document.mainForm.year_month.value
   {
	   rdShowMessageDialog("7�·��Ժ���½ᷢƱ����zg17����!!")
       document.mainForm.year_month.focus();
       return false;
   }
   else
   {
	   document.mainForm.action="s1321_1show.jsp";
   }		
   document.mainForm.submit();
} 

 function sel1()
{
    window.location.href='s1321_1.jsp';
 }

 function sel2() {
    window.location.href='s1321_2.jsp';
 }

 function sel3(){
     window.location.href='s1321_3.jsp';
 }
 
 function doclear(){
 	 mainForm.reset();
 }
-->
 </script> 
 
<title>������BOSS-�һ���Ʊ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ��һ�����</div>
	</div>
<table cellspacing="0">
	<tr> 
		<th width="13%">�һ�����</th>
		<th width="87%" colspan="3"> 
			<input name="busyType1" type="radio" onClick="sel1()" value="1" checked  >
			�վݶһ��ȶƱ 
			<input name="busyType1" type="radio" onClick="sel2()" value="2"  >
			�վݶһ������ѷ�Ʊ 
			<input name="busyType3" type="radio" onClick="sel3()" value="3"  >
			�ȶƱ�һ������ѷ�Ʊ
		</th>
	</tr>   
                
	<tr> 
		<td class="blue" nowrap>�ʻ�����</td>
		<td> 
			<input class="button"type="text" value="" name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange"> *</font>
		</td>
		<td class="blue">�ɷ���ˮ</td>
		<td> 
			<input type="text" class="button" value="" name="login_accept" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)"> 
			<font color="orange"> *</font>
		</td>
	</tr>
				
	<tr> 
		<td class="blue" nowrap>�ɷ��·�</td>
		<td colspan="3">
			<input class="button"type="text" name="year_month" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
			<font color="orange"> *</font>
		</td>
	</tr>

	<TR> 
		<TD align="center" id="footer" colspan="4"> 
			<input type="button" name="query"  class="b_foot" value="��ѯ" onclick="docheck()" index="9">
			&nbsp;
			<input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" index="10">
			&nbsp;
			<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" index="13">
		</TD>
	</TR>
</table>
	 <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
 </BODY>
</HTML>