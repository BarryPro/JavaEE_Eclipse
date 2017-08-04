<%
	/*针对客服类工号，不能操作的功能，进行跳转提示页面*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName = WtcUtil.repNull((String)request.getParameter("opName"));
	String showName = "操作信息";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
			<body>
				<form name="frm" >
					<%@ include file="/npage/include/header.jsp" %>
					<div class="title">
						<div id="title_zi"><%=showName%></div>
					</div>
					<table cellspacing="0">
						<tr>
							<td colspan="4">
								<font color='red'>当前工号为客服类工号，不允许访问此功能！</font>
							</td>
						</tr>
					</table>
				</form>
		<%@ include file="/npage/include/footer.jsp" %>
	</body>
</html>