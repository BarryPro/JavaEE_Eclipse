<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���Źܿ� d344
   * �汾: 1.0
   * ����: 2011/3/25
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//����
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode="d344";
	String opName="���Źܿ�";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>���Źܿ�</title>
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>

	<table cellspacing="0">
	<tr>
		<td class="blue">��������</td>
		<td  class="blue">
			<input type="radio" name="opFlag" value="K" checked>ǿ��
			<input type="radio" name="opFlag" value="N"> ǿ��
		</td>
	</tr>

	<tr>
		<td class="blue">�������</td>
		<td>
			<input name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td align=center colspan="2">
			<input class="b_foot" name=sure  type=button value=ȷ�� onClick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=reset onClick="" type="reset" value=���>
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<script language="javascript">
	function pageSubmit(){
		form1.action="fd344_2.jsp";
		form1.submit();
	}
</script>



