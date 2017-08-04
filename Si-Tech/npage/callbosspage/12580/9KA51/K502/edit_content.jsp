<%
	/*
	* 功能: 编辑预定义短信内容
	* 版本: 1.0.0
	* 日期: 2009/01/11      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%                                                     
	String opCode = "K502";                              
	String opName = "编辑预定义短信内容";
	String msg_mod_id = (String) request.getParameter("msg_mod_id");
	String msg_mod_content_id = (String) request.getParameter("msg_mod_content_id");
	String querySql = "select msg_mod_content from DMESSAGEMODELCONTENT where msg_mod_content_id = '"+msg_mod_content_id+"'";
	String[][] dataRows = new String[][] {};	
%>


<wtc:service name="s151Select" outnum="7">
	<wtc:param value="<%=querySql %>" />
	<wtc:param value="dbcall"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="7" scope="end" />
<%
	dataRows = queryList;	
%>
<html>
<head>
<title>编辑预定义短信内容</title>
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
	function doedit(){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA51/K502/editContent_rpc.jsp","正在发送短信，请稍候......");
		mypacket.data.add("msg_mod_content",document.sitechform.msg_mod_content.value);
		mypacket.data.add("msg_mod_content_id",document.sitechform.msg_mod_content_id.value);
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
					<input type="hidden" name="msg_mod_content_id" value="<%=msg_mod_content_id %>" ><input type="hidden" name="msg_mod_id" value="<%=msg_mod_id %>" >
					<textarea name="msg_mod_content" cols="45" rows="15"><%=dataRows[0][0] %></textarea>
				</td>
			</tr>
			<tr align="center">
				<td>
					<input type="button" class="b_foot" value="修改" onClick="doedit();">&nbsp;<input type="reset" class="b_foot" value="重置">&nbsp;<input type="button" class="b_foot" value="关闭" onClick="window.close();">
				</td>
			</tr>
		</table>
		</div>
	</form>
</body>
</html>