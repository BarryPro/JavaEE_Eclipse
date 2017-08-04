<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
  request.setCharacterEncoding("GBK");
  String opCode = request.getParameter("opCode");
  String opName = "四喜号码营销方案配置审批";
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
		
	}
	
	function changeOpFlag() {
		//var opFlag = $("input[@name=opFlag]:checked").val();
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		var opFlag = $("input[@name=opFlag]:checked").val();
		
		controlBtn(true);
		if (opFlag == "add") {
			document.frm.action = "fe457_main.jsp";
		} else if (opFlag == "query") {
			document.frm.action = "fe458_query.jsp";
		} else if (opFlag == "approve") {
			document.frm.action = "fe461_queryApr.jsp";
		}
		
		document.frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode" value="<%=opCode%>">

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
  <table cellspacing="0">
		<tr>
			<td class="blue" width="30%">操作类型</td>
			<td width="70%">
				<!--input type="radio" name="opFlag" value="add" checked>新增&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="query">查询/修改/删除&nbsp;&nbsp;-->
				<input type="radio" name="opFlag" value="approve" checked>审批
			</td>
		</tr>
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