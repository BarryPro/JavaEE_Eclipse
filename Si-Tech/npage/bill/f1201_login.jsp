<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-22 ҳ�����,�޸���ʽ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����а���</title>
<%
	String opCode = "1201";
	String opName = "�����а���";
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
 	self.status="";
    document.all.srv_no.focus();
  }
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(check(frm))
  {
    frm.action="f1201Main.jsp";
    frm.submit();	
  }
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���¼</div>
</div>

	<table border="0" cellspacing="0">
		
		<tr> 
			<td nowrap class="blue">�ֻ�����</td>
			<td nowrap> 
				<input type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" maxlength="11" index="0" value="<%=activePhone%>" class="InputGrey" readOnly>
				<font class="orange">*</font>
			</td>
			
		</tr>
		<tr> 
			<td colspan=2 id="footer"> 
				<div align="center"> 
					<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
					<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
				</div>
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>