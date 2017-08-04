<%
  /*
   * ����: e571����ʡר�߲�Ʒ����״̬�б��ѯ
   * �汾: 1.0
   * ����: 20120220
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	String opCode = "e571";
	String opName = "��ʡר�߲�Ʒ����״̬�б��ѯ";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String chanceId = request.getParameter("in_ChanceId") == null ? "" : request.getParameter("in_ChanceId");
	String disStr = "";
	if (!"".equals(chanceId)) {
		disStr = " class='InputGrey' readOnly";
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ʡר�߲�Ʒ����״̬�б��ѯ</title>
<script type=text/javascript>
	onload = function() {
		$("#submitBtn").bind("click", function() {
			queryMsg();
		});
		<%
		if (!"".equals(chanceId)) {
			%>
			$("#submitBtn").click();
			<%
		}
		%>
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function queryMsg(){
		controlBtn(true);
		if (!checkElement(document.getElementById("chanceId"))) {
			controlBtn(false);
			return;
		}
		document.frm.action = "fe571_main.jsp";
		document.frm.submit();
	}
</script>

</head>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��Ϣ��ѯ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">���̻����</td>
		<td width="70%">
			<input name="chanceId" id="chanceId" v_type="string" v_must="1" maxlength="21" v_maxlength="21" value="<%=chanceId%>" <%=disStr%>>
			<font class='orange'>*</font>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="��ѯ">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onclick="window.location='fe571.jsp'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onclick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>