<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �����ֻ������Ű�BOSS����7191
   * �汾: 1.0
   * ����: 2008/01/13
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
<title>�����ֻ������Ű�BOSS����</title>
<%
    String opCode="7191";
	String opName="�����ֻ������Ű�BOSS����";
	String phoneNo = (String)request.getParameter("activePhone");			//�û��ֻ���
    String workNo=(String)session.getAttribute("workNo");					//����
%>
</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    document.all.srv_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	frm.action="f7191_1.jsp";
	document.all.opcode.value="7191";
	frm.submit();	
	return true;
}
function opchange(){

	 if(document.all.opFlag[0].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opcode" >
	<div class="title">
		<div id="title_zi">�����ֻ������Ű�BOSS����</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="25%">�ֻ�����</td> 
		<td> 
			<input class="InputGrey" readOnly type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
			<font color="orange">*</font>
		</td>
	</tr>
	<TR style="display:none" id="backaccept_id"> 
		<TD class="blue">ҵ����ˮ</TD>
		<TD>
			<input class="button" type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR>    

	<tr> 
		<td colspan="2" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>