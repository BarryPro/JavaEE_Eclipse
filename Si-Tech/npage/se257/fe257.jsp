<%
  /*
   * 功能: 充值卡营销案转赠
   * 版本: 1.0
   * 日期: 20110908
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>充值卡营销案转赠</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
%>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	onload=function() {
		if ("<%=opCode%>" == "e257") {
			document.getElementsByName("opFlag")[0].checked = true;
		} else if ("<%=opCode%>" == "e258") {
			document.getElementsByName("opFlag")[1].checked = true;
		}
		opChange();
	}
	
	function opChange() {
		if (document.getElementsByName("opFlag")[0].checked) {
			document.getElementById("opCode").value = "e257";
			document.getElementById("opName").value = "充值卡营销案转赠录入";
		} else if (document.getElementsByName("opFlag")[1].checked) {
			document.getElementById("opCode").value = "e258";
			document.getElementById("opName").value = "充值卡营销案转赠修改";
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		if (document.getElementsByName("opFlag")[0].checked) {
			document.frm.action = "fe257_main.jsp";
		} else if (document.getElementsByName("opFlag")[1].checked) {
			document.frm.action = "fe258_main.jsp";
		}
		document.frm.submit();
	}
	
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="">
 	<input type="hidden" name="opName" id="opName" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">电话号码</td>
		<td colspan="3"> 
			<input type="text" size="12" name="activePhone" value="<%=activePhone%>" id="activePhone" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3" >
			<input type="radio" name="opFlag" value="1" onclick="opChange()">充值卡营销案转赠录入&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="2" onclick="opChange()">充值卡营销案转赠修改&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="doCfm(this)">    
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
