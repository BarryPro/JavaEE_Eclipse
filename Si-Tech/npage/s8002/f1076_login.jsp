<%
  /* *********************
   * 功能: 工号业务受理量限制操作
   * 版本: 1.0
   * 日期: 2010/07/12
   * 作者: 
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>工号业务受理量限制操作</title>
	<%
		String opCode = "1076";
		String opName = "工号业务受理量限制操作";
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="javascript" type="text/javascript">
		$(document).ready(function(){
			var confirmObj = $("#confirm");
			var closeObj = $("#close");
			confirmObj.click(function(){
				var opFlag = $("input:checked").val();
				if(opFlag == "one"){
					frm.action = "f1076_1.jsp";
				}else if(opFlag == "two"){
					frm.action = "f1076_2.jsp";
				}
				$("form:first").submit();
			});
			closeObj.click(function(){
				removeCurrentTab();
			});
		});
	</script>
</head>
<body>
<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">工号业务受理量限制操作</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">操作类型</td>
			<td>
				<input type="radio" id="opFlagOne" name="opFlag" value="one" checked="checked" />查询 
				<input type="radio" id="opFlagTwo" name="opFlag" value="two" />录入
			</td>
		</tr>
		<tr>
			<td colspan="2" id="footer">
				<div align="center">
					<input class="b_foot" type=button id="confirm" value="确认" />    
					<input class="b_foot" type=button id="close" value="关闭" />
				</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
