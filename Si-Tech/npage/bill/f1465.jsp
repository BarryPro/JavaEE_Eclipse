<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ��ҵ������1465
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����ҵ������</title>
<%
	String opCode="1465";
	String opName="������Ϣ��ҵ������";
	String phoneNo=(String)request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
	self.status="";
    document.all.phoneNo.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	if (0 == document.all.func_type.value){
  	rdShowMessageDialog("��ѡ����幦������!");	
  	return false;
  }
  
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(frm)) return false;
  
  frm.action="f1465Main.jsp";
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ��������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">�������</td> 
		<td> 
			<input class="InputGrey" readOnly type="text" size="12" name="phoneNo" value="<%=phoneNo%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
		</td>
	</tr>
	<tr>
		<td class="blue" nowrap>��������</td>
		<td class=Input nowrap>
			<select name="func_type" class="button" index="15">
				<option value="00" selected >--��ѡ��������--</option>
				<option value="02">2Ԫ������Ϣ�Ѱ���</option>
				<option value="03">12Ԫ������Ϣ�Ѱ���</option>
				<!--   <option value="04">0Ԫ�������</option>  ��������춯�еش�0Ԫ���⣬����˴���Ʒ�������˲�������ģ�飬20071220--> 
				<option value="05">0Ԫ������Ϣ��</option>
			</select>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td colspan="2" id="footer" align="center"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
   
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>