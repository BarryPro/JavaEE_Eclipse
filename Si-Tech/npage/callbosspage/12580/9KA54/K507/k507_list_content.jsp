<%
  /*
   * 功能: 短信内容
　 * 版本: 1.0.0
　 * 日期: 2009/01/09
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<html>
<head>
<title>短信日志查询条件</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg">
			<img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" />
		</td>
		<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">			
			<div id="Operation_Table">
			<div class="title">短信内容</div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<textarea name="content" cols="30" rows="10" readonly="true"></textarea>
					</td>
				</tr>
			</table>

		</td>
		<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg">
			<img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" />
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" />
		</td>
		<td valign="bottom">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
				<tr>
					<td height="1"></td>
				</tr>
			</table>
		</td>
		<td>
			<img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" />
		</td>
	</tr>
</table>
</form>
</body>
</html>
