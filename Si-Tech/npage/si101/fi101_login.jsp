<%
  /*
   * 功能: 购机赠费
   * 版本: 1.0
   * 日期: 2013/10/10
   * 作者: wanghyd
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
%>
<html>
<head>
<title><%=opName%></title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language=javascript>
	var opFlag;
	
	window.onload = function() {
		opchange();
	}
	
	function opchange() {
		 if (document.getElementsByName("opFlag")[0].checked){
			opFlag = "2";
<%    if ("i101".equals(opCode) || "i102".equals(opCode)){%>
				document.getElementById("opCode").value = "i102";
				document.getElementById("opName").value = "购机赠费冲正";
<%}%>
			document.getElementById("backInput").style.display = "";
		}
	}
	
	function submitt() {
		if (opFlag == "1") {
			buttonSub = document.getElementById("cubmitt");
			buttonSub.disabled = "true";
			
			frm.action = "fi101_main.jsp";
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
				
				frm.action = "fi102_main.jsp";
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
			if ("i101".equals(opCode)) {
%>
		<q vType="setNg35Attr" >
			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>冲正
		</q>
<%
			} else if ("i102".equals(opCode)) {
%>
<q vType="setNg35Attr" >
			
		</q>
		<q vType="setNg35Attr" >
			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>冲正
			<q vType="setNg35Attr" ></q>
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
	         </TR>    
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

