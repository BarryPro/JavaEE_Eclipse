<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ͷ���˷�ͳ�Ʋ�ѯ</title>
<%
    String opCode="e630";
	String opName="�����������ʲ�ѯ";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
 
%>
<SCRIPT type="text/javascript">
function docfm() {
   var contract_no = document.form.contract_no.value;
   var year_month = document.form.year_month.value;

   if (contract_no.length == 0) {
       rdShowMessageDialog("��ͬ���벻��Ϊ�գ����������룡");
       document.form.contract_no.focus();
       return false;   
   } else if (year_month.length == 0){
       rdShowMessageDialog("�������²���Ϊ�գ����������룡");
       document.form.year_month.focus();
       return false;
   } else if (year_month.length < 6){
       rdShowMessageDialog("�������¸�ʽ����ȷ�����������룡");
       document.form.year_month.focus();
       return false;
   } else {
      form.submit();
   }
}
</script> 
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body>
<form action="e630_2.jsp" name="form" method="POST">
 	<input type="hidden" name="opcode" value = "e630" >
	<input type="hidden" name="opname" value = "�����������ʲ�ѯ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">�����������ʲ�ѯ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >
				��ͬ�ţ�<input type="text" name="contract_no" maxlength="14" class="button" onKeyPress="return isKeyNumberdot(0)"> 
			</td>
			<td class="blue" >
				�������£�<input type="text" name="year_month" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">(YYYYMM)
       
			</td>
		</tr>
	 
		 
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="��ѯ" id="cz" onclick="docfm()" >
			 
			
			<input type=reset class="b_foot" value="����" >
			<!--
				<input type=test class="b_foot" value="����" onclick="test()" >
			-->
			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
  function test()
  {
	  alert("1");
	  form.action="e630_test.jsp";
	  form.submit();

  }
</script>
 
 