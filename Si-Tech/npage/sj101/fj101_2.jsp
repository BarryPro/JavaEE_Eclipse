<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String op_code =  "J101";
	String op_name =  "亲情圈";
	String opCode = op_code;
	String opName = op_name;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>亲情圈</title>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script language="javascript">
		function doadduser()
		{
			window.opener.getUserInfo();
		}
		</script>
	</head>
	<body>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">亲情圈</div>
	</div>
	<table cellspacing="0">
		<td class=blue>成员手机号码</td>
			<td>
				<input type="text" name="midphone" value="" >
			</td>
		</tr>
		<td class=blue>成员称呼</td>
			<td>
				<input type="text" name="spCode" value="">
			</td>
		</tr>
	</table>
		<div>
			<table cellSpacing=0>
			<tr>
				<td id="footer">
					<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="doadduser()" id="Button1">&nbsp;&nbsp;
					<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="window.close()">
				</td>
			</tr>
			</table>
		</div>
	<%@ include file="/npage/include/footer.jsp" %>
	</body>
</html>