<%
  /*
   * ����: �����߶˿ͻ�����ת��
   * �汾: 1.0
   * ����: 20110617
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
<title>�����߶˿ͻ�����ת��</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>
<script language="javascript">

	window.onload=function() {
		opchange();
	}
	
	function opchange() {
		if(document.getElementsByName("opFlag")[0].checked == true) {
	  	document.getElementById("backAcceptBody").style.display = "none";
		} else if(document.getElementsByName("opFlag")[1].checked == true) {
	  	document.getElementById("backAcceptBody").style.display = "";
		}
	}

	function resetFrm() {
		document.getElementById("backAcceptBody").value = "";
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		//$("#resetBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function submitt() {
		controlBtn(true);
		if(document.getElementsByName("opFlag")[0].checked == true) {
			$("#opCode").val("d925");
			$("#opName").val("�����߶˿ͻ�����ת������");
			document.frm.action = "fd925_main.jsp";
		} else if(document.getElementsByName("opFlag")[1].checked == true) {
			if (document.getElementById("backAccept").value.trim().length == 0) {
				rdShowMessageDialog("�����������ˮ��", 1);
				controlBtn(false);
				return false;
			}
			
			$("#opCode").val("d926");
			$("#opName").val("�����߶˿ͻ�����ת������");
			document.frm.action = "fd926_main.jsp";
		}
		
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
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">�绰����</td>
		<td width="70%"> 
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" id="activePhone" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
			<input type="radio" name="opFlag" onclick="opchange()" checked>����&nbsp;&nbsp;
			<input type="radio" name="opFlag" onclick="opchange()">����
		</td>
	</tr>
	<tbody name="backAcceptBody" id="backAcceptBody" style="display:none">
		<tr>
			<td class="blue" width="30%">������ˮ</td>
			<td width="70%"> 
				<input type="text" name="backAccept" id="backAccept" value="">
			</td>
		</tr>
	</tbody>
	<tr>
		<td colspan="2" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="submitt()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
