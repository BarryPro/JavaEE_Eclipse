<%
  /*
   * ����: 6945�������������ܺ������ۺ�����--������������ ��ȡ����ԭ�� 6945
   * �汾: 1.8.2
   * ����: 2011/6/21
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "�������������ܺ������ۺ�����_��������";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String resonTxt = WtcUtil.repNull(request.getParameter("resonTxt"));
%>
<html>
	<head>
		<title>�������������ܺ������ۺ�����_��������</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var opReson=document.all.opReson.value;	
  window.returnValue = opReson;
  window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">�������������ܺ������ۺ�����_��������</div>
	</div>
  <table cellspacing="0">
  	 </tr>
			<td class="blue">����ԭ��</td>
			<td>
				<input type="text" name="opReson" value="<%=resonTxt%>" maxlength="70" size="140">
      <td>
    </tr>  
    </table>
   
    <table cellspacing="0">
    <tr>
    	<td colspan="2" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="ȷ��" onClick="reValue()" >
					&nbsp;
				<input name="colse" class="b_foot" type="button" value="�ر�" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

