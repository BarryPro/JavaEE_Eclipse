<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
	<head>
		<title>座席工号</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/portalet.css"
			rel="stylesheet" type="text/css">
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/csp/vatmpad.js"></script>

<script type="text/javascript">

function butConfirm(){
	var work_no = document.getElementById("work_no").value;
	window.opener.cCcommonTool.BeginListen(work_no);
	window.close();
}

function callCancel(){
	window.close();
}

</script>
	</head>
	<BODY>
		<div class="itemHeader">
			<div id="title">
				座席工号
			</div>
		</div>
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tbody>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						座席工号：
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						<select name="work_no" id="work_no" size="10">
							<option value="102">102</option>
							<option value="104">104</option>
							<option value="105">105</option>
							<option value="106">106</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						<input type="button" name="btnSubmit" value="确认" onClick="butConfirm()" />
						<input type="button" name="btnCancel" value="取消" onClick="callCancel()"/>
					</td>
				</tr>
			</tbody>
		</table>
	</body>
</html>