<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �̲�ͨ�ʷ�
   * �汾: 1.0
   * ����: 2011-8-2 14:09:25
   * ����: ningtn
   * ��Ȩ: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>�̲�ͨ�ʷ�</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String phoneNo = (String)request.getParameter("activePhone");
	%>
	<script language="JavaScript">
		function frmCfm(subButton){
			/* ��ť�ӳ� */
			controlButt(subButton);
			/* �º����� */
			getAfterPrompt();
			/* ���ñ�ע */
			var opNoteObj = $("#opNote");
			if(opNoteObj.val() == ""){
				opNoteObj.val("����Ա<%=workNo%>Ϊ<%=phoneNo%>��<%=opName%>����");
			}
			/* ��ע����У�� */
			var opNoteVal =  opNoteObj.val();
			var opNoteLen = getByteLen(opNoteVal);
			if(opNoteLen > 60){
				rdShowMessageDialog("���ֻ��������30������");
				return false;
			}
			/* �ύҳ�� */
			var confirmFlag = rdShowConfirmDialog("ȷ��Ҫ�ύ������?");
			if(confirmFlag!=1){
				return false;
			}
			frm.submit();
		}
		$(document).ready(function(){
			/* ҳ���ʼ�� */
			if("e147" == "<%=opCode%>"){
				$("#productTr").show();
			}else{
				$("#productTr").hide();
			}
		});
	</script>
<body>
<form name="frm" method="POST" action="fe147Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">�û�����</td>
			<td colspan="3">
				<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" 
				 class="InputGrey" readOnly />
			</td>
		</tr>
		<tr id="productTr">
			<td class="blue">�ʷ�ѡ��</td>
			<td colspan="3">
				<select id="productType" name="productType" onmouseover=FixWidth(this) >
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
							select offer_id,offer_name from product_offer where offer_attr_type='YnYc' and sysdate between eff_date and exp_date
						</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">������ע</td>
			<td colspan="3">
				<input type="text" id="opNote" name="opNote" value="" size="60" maxlength="60" />
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="ȷ��" onclick="frmCfm(this)" />
				&nbsp;
				<input type="reset" name="query" class="b_foot" value="ȡ��"  />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>