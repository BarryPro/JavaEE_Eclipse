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
<%@ page import="java.util.*"%>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
     
		String opCode = "zg75";
		String opName = "���⹤���½ᷢƱ��ӡ";
		//String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String[] mon = new String[]{"","","","","",""};

		Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.set(Integer.parseInt(dateStr.substring(0,4)),
						  (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
		for(int i=0;i<=5;i++)
		  {
				  if(i!=5)
				  {
					mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
					cal.add(Calendar.MONTH,-1);
				  }
				  else
					mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
		  }
		activePhone = request.getParameter("activePhone");
		 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
function docheck() {
   if (document.mainForm.contract_no.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!")
      document.mainForm.contract_no.focus();
      return false;
   } else if (document.mainForm.contract_no.value.length < 11) {
      rdShowMessageDialog("�ֻ����벻��С��11λ������������ !!")
      document.mainForm.contract_no.focus();
      return false;
   } 
 
   if (document.mainForm.begin_ym.value.length == 0) {
      rdShowMessageDialog("�ɷ��·ݲ���Ϊ�գ����������� !!")
      document.mainForm.begin_ym.focus();
      return false;
   } else if (document.mainForm.begin_ym.value.length < 6) {
      rdShowMessageDialog("�ɷ��·ݲ���С��6λ������������ !!")
      document.mainForm.begin_ym.focus();
      return false;
   }
   
   // 20140701��ſ��Զһ� if(document.mainForm.begin_ym.value<"201407") if(document.mainForm.begin_ym.value<"201307")
   
   if(document.mainForm.begin_ym.value<"201406")
   {
	   rdShowMessageDialog("�°��½ᷢƱ����201407��ſɰ���!")
       return false;
   }
   else
   {
	   document.mainForm.action="zg75_2.jsp";
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
		<div id="title_zi">�½ᷢƱ��ӡ</div>
	</div>
<table cellspacing="0">
  
                
	<tr> 
		<td class="blue" nowrap>�ֻ�����</td>
		<td  >
			<input class="button"type="text" value="<%=activePhone%>" readonly name="contract_no" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			<font color="orange">*</font>
		</td>
	</tr>

	<tr> 
		<td class="blue" nowrap>��ӡ����</td>
		<td> 
			<input class="button"type="text" name="begin_ym" size="20" maxlength="6"  onKeyPress="return isKeyNumberdot(0)"  value="<%=mon[1]%>">(YYYYMM)
			<font color="orange">*</font>
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