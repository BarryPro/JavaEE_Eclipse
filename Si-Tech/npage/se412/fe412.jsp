<%
  /*
   * ����: ǩԼ�Żݹ���d069
   * �汾: 1.0
   * ����: 2011-1-11 
   * ����: 
   * ��Ȩ: si-tech
   * update:huangrong
 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
%>

<script language=javascript>
	var opFlag;
	
	window.onload = function() {
		opchange();
	}
	
	function opchange() {
		if (document.getElementsByName("opFlag")[0].checked) {
			opFlag = "1";
<%
			if ("e412".equals(opCode) || "e413".equals(opCode)) {
%>
				document.getElementById("opCode").value = "e412";
				document.getElementById("opName").value = "�����������";
				
<%
			}
%>
			
		} else if (document.getElementsByName("opFlag")[1].checked) {
			opFlag = "2";
<%
			if ("e412".equals(opCode) || "e413".equals(opCode)) {
%>
				document.getElementById("opCode").value = "e413";
				document.getElementById("opName").value = "�������������ѯ";
			
<%
			}
%>
		
		}
	}
	
	function submitt() {
		if (opFlag == "1") {
			
			frm.action = "fe412_1.jsp";
			frm.submit();
		} else if (opFlag == "2") {
		

				
				frm.action = "fe413_1.jsp";
				frm.submit();
		
		}
	}
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">
			��������
		</td>
		<td width="70%">
<%
			if ("e412".equals(opCode)) {
%>
			<input type="radio" name="opFlag" value="1" onclick="opchange()" checked>�����������&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="2" onclick="opchange()" >�������������ѯ&nbsp;&nbsp;
<%
			} else if ("e413".equals(opCode)) {
%>
			<input type="radio" name="opFlag" value="1" onclick="opchange()" >�����������&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>�������������ѯ&nbsp;&nbsp;
<%
			}
%>
		</td>
	</tr>


</table>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="ȷ��" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>

