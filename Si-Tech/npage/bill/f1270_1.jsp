<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19,��Ϊ�Ƕ���tab,���Ҳ���Ҫ��������֤����,���Ծ������
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1270";
	String opName = "���ʷѱ��";
%>
<html>
<head>
<title>���ʷѱ��</title>
<script language="javascript">
	<!--
	function pageSubmit(p){
		document.all.pw_favor.value=1 ; //�������Żݸ�ֵ
		form1.action="f1270_2.jsp";
		form1.submit();
	}
	-->
</script>
</head>

<body>
	<form action="" method=post name="form1">
     <%@ include file="/npage/include/header.jsp" %>
       <TABLE>
		 <TR>
			  <TD class="blue">�������</TD>
			  <TD>
			  	<input readonly class="InputGrey" name="i1"  v_type="mobphone" value="<%=activePhone%>">
			  </TD>
		 </TR>
			 
		<TR>
			 <TD id="footer" colspan=3>
				  <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(check(form1))  pageSubmit('1');" >
				  <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>
			 </TD>
		</TR>
        <%@ include file="/npage/include/footer_simple.jsp" %> 	 
	 </TABLE>	
		<input type="hidden" name="pw_favor" value="1">
		<input type="hidden" name="iOpCode" value="1270">
		<input type="hidden" name="iAddStr" value="">
		<input type="hidden" name="activePhone" value="<%=activePhone%>">
 	</form>
</body>
</html>

