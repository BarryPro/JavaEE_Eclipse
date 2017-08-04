<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-13
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");
  String opCode = request.getParameter("opCode");
  String opName = "四喜号码营销案办理";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language=javascript>
	onload = function() {
		var opCode = "<%=opCode%>";
		
		if (opCode == "e462") {
			$("#opName").val("四喜号码营销案申请");
			$("input[name=opFlag][value=apply]").attr("checked", true);
		} else if (opCode == "e463") {
			$("#opName").val("四喜号码营销案冲正");
			$("input[name=opFlag][value=back]").attr("checked", true);
		} else if (opCode == "e464") {
			$("#opName").val("四喜号码营销案取消");
			$("input[name=opFlag][value=cancel]").attr("checked", true);
		}
		
		changeOpFlag();
	}
	
	function changeOpFlag() {
		var opFlag = $("input[@name=opFlag]:checked").val();
		
		if (opFlag == "apply" || opFlag == "cancel") {
			$("#backAcceptBody").hide();
		} else if (opFlag == "back") {
			$("#backAcceptBody").show();
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		var opFlag = $("input[@name=opFlag]:checked").val();
		
		controlBtn(true);
		if (opFlag == "apply") {
			$("#opCode").val("e462");
			$("#opName").val("四喜号码营销案申请");
			document.frm.action = "fe462_main.jsp";
		} else if (opFlag == "back") {
			if (!checkElement(document.getElementById("backAccept"))) {
				controlBtn(false);
				return false;
			}
			$("#opCode").val("e463");
			$("#opName").val("四喜号码营销案冲正");
			document.frm.action = "fe463_main.jsp";
		} else if (opFlag == "cancel") {
			$("#opCode").val("e464");
			$("#opName").val("四喜号码营销案取消");
			document.frm.action = "fe464_main.jsp";
		}
		
		document.frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
  <table cellspacing="0">
		<tr>
			<td class="blue" width="30%">电话号码</td>
			<td width="70%">
				<input type="text" name="activePhone" value="<%=activePhone%>" class="InputGrey" readOnly>
			</td>
		</tr>
		<tr>
			<td class="blue" width="30%">操作类型</td>
			<td width="70%">
				<input type="radio" name="opFlag" value="apply" onclick="changeOpFlag();" checked>申请&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="back" onclick="changeOpFlag();">冲正&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="cancel" onclick="changeOpFlag();">取消
			</td>
		</tr>
		<tbody id="backAcceptBody" style="display:none">
			<tr>
				<td class="blue">冲正流水</td>
				<td>
					<input type="text" name="backAccept" id="backAccept" v_type="0_9" v_maxlength="15" maxlength="15" v_must="1">
				</td>
			</tr>
		</tbody>
		<tr>
			<td colspan="4" align="center">
				<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="doCfm();">
				<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab();">
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>