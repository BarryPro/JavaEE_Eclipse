<%
  /*
   * 功能: 关于与浦发银行合作实现手机钱包联名卡产品业务支撑系统改造需求
   * 版本: 1.0
   * 日期: 20110524
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
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
<title>移动营业厅开联名卡</title>
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
			rdShowMessageDialog("输入的身份证长度非18位，请重新输入！", 1);
			document.getElementById("idIccid").focus();
			controlBtn(false);
			return false;
		} else if (document.getElementById("idCardType").value == "02" && !(document.getElementById("idIccid").value.trim().length == 15)) {
			rdShowMessageDialog("输入的身份证长度非15位，请重新输入！", 1);
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
	<div id="title_zi">用户信息</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">手机号码</td>
		<td colspan="3">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">身份证实名验证</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">客户姓名</td>
		<td colspan="3">
			<input type="text" name="custName" id="custName" value="" v_must=1 v_maxlength=60 v_type="string" maxlength="60" size=20/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">证件类型</td>
		<td width="30%">
			<select name="idCardType" id="idCardType">
				<option value="01">18位身份证</option>
				<option value="02">15位身份证</option>
			</select>
		</td>
		<td class="blue" width="20%">证件号码</td>
		<td width="30%">
			<input type="text" name="idIccid" id="idIccid" value="" v_must=1 v_minlength=15 v_maxlength=18 v_type="string" maxlength="18">
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="submitt()">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="重置" onClick="frm.reset()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
