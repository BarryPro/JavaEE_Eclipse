<%
  /*
   * ����: ��ȡ���ĸ�����Ϣ 1220
   * �汾: 1.8.2
   * ����: 2011/6/16
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "�������";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<title>�������</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var productCode=document.all.productCode.value;
	if(productCode=="")
	{
			rdShowMessageDialog("���̴��벻��Ϊ�գ������룡");
			return false;		
	}
	var phoneModule=document.all.phoneModule.value;
	if(phoneModule=="")
	{
			rdShowMessageDialog("�ֻ����Ͳ���Ϊ�գ������룡");
			return false;		
	}	
	var errState=document.all.errState.value;	
	if(errState=="")
	{
			rdShowMessageDialog("����������Ϊ�գ������룡");
			return false;		
	}	
	var retvalue=productCode+"~"+phoneModule+"~"+errState;
  window.returnValue = retvalue;
  window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">���ĸ�����Ϣ</div>
	</div>
  <table cellspacing="0">
  	 </tr>
			<td class="blue">���̴���</td>
			<td>
				<input type="text" name="productCode" maxlength="10">
      <td>
    </tr>
  	 </tr>
			<td class="blue">�ֻ�����</td>
			<td>
				<input type="text" name="phoneModule" maxlength="20" size="40">
      <td>
    </tr>    
  	 </tr>
			<td class="blue">��������</td>
			<td>
				<input type="text" name="errState" maxlength="30" size="60">
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
