
<%
	/*
	* 功能: 预定义短信分类 
	* 版本: 1.0.0
	* 日期: 2009/01/11      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>

<%@page contentType="text/html;charset=GBK"%>            
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%                                                     
	String opCode = "K502";                              
	String opName = "预定义短信分类";                          

	String[][] dataRows = new String[][] {};
	String sql = "select msg_mod_id, msg_mod_name from DMESSAGEMODEL";

%>
<html>
<head>
<title>预定义短信分类</title>
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
<script type="text/javascript">
	function doquery(msg_mod_id){
		window.sitechform.action = "sort_content.jsp?msg_mod_id="+msg_mod_id;
		window.sitechform.target = "mainFrame";
		window.sitechform.method = "post";
		window.sitechform.submit();
	}
</script>
</head>
<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=sql %>" />
	<wtc:param value="dbcall"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="3" scope="end" />
<%
	dataRows = queryList;
%>
<body>
	<form name="sitechform" id="sitechform">
	<div id="Main">
				
				<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg">
							<img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" />
						</td>
						<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
							<div id="Operation_Title">
								<B>预定义短信分类</B>
							</div>
						
							<div id="Operation_Table">
	<table>
				<%
						for (int i = 0; i < dataRows.length; i++) {
						String tdClass = "";
				%>
				<%
							if ((i + 1) % 2 == 1) {
							tdClass = "grey";
				%>
				<tr align="right" style="cursor:pointer" onClick="doquery('<%=dataRows[i][0] %>');">
					<%
					} else {
					%>
				
				<tr align="right" style="cursor:pointer" onClick="doquery('<%=dataRows[i][0] %>');">
					<%
					}
					%>
					<td align="right" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>									
				</tr>
				<%
				}
				%>
	</table>
								</div>
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
							
						</td>
						<td>
							<img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" />
						</td>
					</tr>
				</table>
			</div>
		</form>
</body>
</html>