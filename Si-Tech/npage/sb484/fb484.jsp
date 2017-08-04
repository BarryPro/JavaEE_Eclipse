<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 TD固话重新购机
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>购多部TD固话预办理</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("===wanghfa===" + opCode + opName);
%>

<script language=javascript>
	var opFlag;
	
	window.onload = function() {
		opchange();
	}
	
	function opchange() {
	 if (document.getElementsByName("opFlag")[0].checked) {
			opFlag = "2";
<%
			if ("b484".equals(opCode) || "b485".equals(opCode)) {
%>
				document.getElementById("opCode").value = "b485";
				document.getElementById("opName").value = "TD固话重新购机冲正";
<%
			} else if ("b486".equals(opCode) || "b487".equals(opCode)) {
%>
				document.getElementById("opCode").value = "b487";
				document.getElementById("opName").value = "TD固话重新购机冲正（铁通）";
<%
			}
%>
			document.getElementById("backInput").style.display = "";
		}
	}
	
	function submitt() {
		if (opFlag == "1") {
			buttonSub = document.getElementById("cubmitt");
			buttonSub.disabled = "true";
			
			frm.action = "fb484_main.jsp";
			frm.submit();
		} else if (opFlag == "2") {
			if (!check(document.getElementById("frm"))) {
				if (document.getElementById("backAccept").value.trim().length == 0) {
					rdShowMessageDialog("流水不能为空，请重新输入。");
					return;
				} else if (!checkElement(document.getElementById("backAccept"))) {
					rdShowMessageDialog("流水格式不正确，请重新输入。");
					return;
				}
			} else {
				buttonSub = document.getElementById("cubmitt");
				buttonSub.disabled = "true";
				
				frm.action = "fb485_main.jsp";
				frm.submit();
			}
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
			操作类型
		</td>
		<td width="70%">
<%
			if ("b484".equals(opCode) || "b486".equals(opCode)) {
%>
			
			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>冲正&nbsp;&nbsp;
<%
			} else if ("b485".equals(opCode) || "b487".equals(opCode)) {
%>
			
			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>冲正&nbsp;&nbsp;
<%
			}
%>
		</td>
	</tr>
	<tr>
		<td class="blue">
			电话号码
		</td>
		<td>
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr name="backInput" id="backInput" style="display:none">
		<td class="blue">
			业务流水
		</td>
		<td>
			<input type="text" name="backAccept" id="backAccept" value="" v_must="1" v_type="0_9" v_name="业务流水" maxlength="30" v_minlength="0" v_maxlength="30" onblur="checkElement(this);">
			<font class="orange">*</font>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
