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
<title>ԤԼӪ������ѯ</title>

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
  
  
  if(document.frm.phone_no.value.trim() ==""&&document.frm.cust_id.value.trim() == "")
  {
		rdShowMessageDialog("��ע�⣬�ֻ��������û�ID��������һ��!");
		return;
  }
  frm.submit();
  return true;
}
</script>
</head>
<body>
<form name="frm" action="fb824_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
      <tr>
        <td class=blue>�ֻ�����</td>
	 			<td><input type="text" name="phone_no" value="" maxlength="15"></td>
        <td class=blue>�û�ID</td>
	 			<td><input type="text" name="cust_id" value=""  maxlength="14"></td>
      </tr>
      
      <tr>
        <td colspan="6" id="footer">
          <div align="center">
          <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
          <input class="b_foot" type=button name=back value="���" onClick="frm.reset();">
    			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
          </div>
        </td>
      </tr>
    </table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
