<%
	/*
	* 功能: 增加预定义短信内容
	* 版本: 1.0.0
	* 日期: 2009/01/13      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%                                                     
	String opCode = "K502";                              
	String opName = "增加预定义短信内容";
	String msg_mod_id = (String) request.getParameter("msg_mod_id");
%>

<html>
<head>
<title>增加预定义短信内容</title>
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

<script language=javascript>
	function doadd(){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA51/K502/insertContent_rpc.jsp","正在增加短信内容，请稍候......");
		mypacket.data.add("msg_mod_content",document.sitechform.msg_mod_content.value);
		mypacket.data.add("msg_mod_id",document.sitechform.msg_mod_id.value);
		core.ajax.sendPacket(mypacket,doProcess,true);
		mypacket=null;
	}
	function doProcess(packet){			
			window.sitechform.action="sort_content.jsp?msg_mod_id=<%=msg_mod_id %>";
			window.sitechform.target="mainFrame";
		  window.sitechform.method='post';
		  window.sitechform.submit();
		  window.close();
		}
</script>
</head>
<body>
	<form name="sitechform" id="sitechform">
		<div id="Operation_Table">
		<div class="title">短信内容</div>
		<table>
			<tr>
				<td>
					<input type="hidden" name="msg_mod_id" value="<%=msg_mod_id %>" >
					<textarea name="msg_mod_content" cols="45" rows="15"></textarea>
				</td>
			</tr>
			<tr align="center">
				<td>
					<input type="button" class="b_foot" value="增加" onClick="doadd();">&nbsp;<input type="button" class="b_foot" value="关闭" onClick="window.close();">
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>