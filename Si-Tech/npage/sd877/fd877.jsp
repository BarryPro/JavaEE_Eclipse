<%
  /*
   * ����: �������ַ����к���ʵ���ֻ�Ǯ����������Ʒҵ��֧��ϵͳ��������
   * �汾: 1.0
   * ����: 20110524
   * ����: ������wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ƶ�Ӫҵ����������</title>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String workNo=(String)session.getAttribute("workNo");
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

	window.onload=function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function submitt() {
		controlBtn(true);
		if (!check(frm)) {//idIccid
			controlBtn(false);
			return false;
		}
		if (document.getElementById("idCardType").value == "01" && !(document.getElementById("idIccid").value.trim().length == 18)) {
			rdShowMessageDialog("��������֤���ȷ�18λ�����������룡", 1);
			document.getElementById("idIccid").focus();
			controlBtn(false);
			return false;
		} else if (document.getElementById("idCardType").value == "02" && !(document.getElementById("idIccid").value.trim().length == 15)) {
			rdShowMessageDialog("��������֤���ȷ�15λ�����������룡", 1);
			document.getElementById("idIccid").focus();
			controlBtn(false);
			return false;
		}
		document.frm.action = "fd877_main.jsp";
		document.frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">�ֻ�����</td>
		<td colspan="3">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">���֤ʵ����֤</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">�ͻ�����</td>
		<td colspan="3">
			<input type="text" name="custName" id="custName" value="" v_must=1 v_maxlength=60 v_type="string" maxlength="60" size=20/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">֤������</td>
		<td width="30%">
			<select name="idCardType" id="idCardType">
				<option value="01">18λ���֤</option>
				<option value="02">15λ���֤</option>
			</select>
		</td>
		<td class="blue" width="20%">֤������</td>
		<td width="30%">
			<input type="text" name="idIccid" id="idIccid" value="" v_must=1 v_minlength=15 v_maxlength=18 v_type="string" maxlength="18">
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="submitt()">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onClick="frm.reset()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
