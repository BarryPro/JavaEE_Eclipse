<%
/********************
 * version v2.0
 * ������: si-tech
 * author: huangrong
 * date  : 20101103
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ѯ</title>

<%
	String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(document.frm.b_order_code.value.trim().length == 0)
  {
		rdShowMessageDialog("������󶩵����!");
		return;
  }
  frm.submit();
  return true;
}

function doQryBill(){
  if(document.frm.b_order_code.value.trim().length == 0)
  {
		rdShowMessageDialog("������󶩵����!");
		return;
  }
  frm.action="fb884_3.jsp"
  frm.submit();
  return true;
}
</script>
</head>
<body>
<form name="frm" action="fb884_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
      <tr>
        <td class="blue">�󶩵����</td>
	 			<td><input type="text" name="b_order_code" value="" maxlength="20"><font class="orange">*</font></td>
	 			<td class="blue">�Ӷ������</td>
	 			<td><input type="text" name="s_order_code" value="" maxlength="20"></td>
      </tr>
      
      <tr>
        <td colspan="4" id="footer">
          <div align="center">
          <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
          <input class="b_foot" type=button name="confirm1" value="��Ʊ��ѯ" onClick="doQryBill(this)" index="2">
          <input class="b_foot" type=button name=back value="���" onClick="frm.reset();">
    			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
          </div>
        </td>
      </tr>
    </table>
<!------------------------>
<input type="hidden" name="opName" value="<%=opName%>">  
<input type="hidden" name="opCode" value="<%=opCode%>">     
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
