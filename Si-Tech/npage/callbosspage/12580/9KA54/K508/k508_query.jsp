<%
  /*
   * 功能: 留言日志查询条件
　 * 版本: 1.0.0
　 * 日期: 2009/01/18
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
	String opCode = "K508";
	String opName = "留言日志查询条件";
	//chengh 设置查询时间
	SimpleDateFormat esdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
	String bnowdate = esdf.format(new Date());
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String nowdate = sdf.format(new Date());
	String loginNo = (String) session.getAttribute("workNo");
%>

<html>
<head>
<title>留言日志查询条件</title>
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
		function queryData(){
		  window.sitechform.action="k508_list.jsp";
		  window.sitechform.target="rightFrame";
   		window.sitechform.method="post";
   		window.sitechform.submit();
		}
		
	</script>
</head>

<body>
<form name="sitechform" id="sitechform">
			<div id="Operation_Table">
			
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th align="center">条件</th>
					<th align="center">值</th>
				</tr>
				<tr>
					<td>开始时间</td>
					<td>
						<input id="begintime" readonly="true" name="beginTime" type="text" value="<%=bnowdate %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endtime);"/>
						<img onclick="WdatePicker({el:$dp.$('begintime'),dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td>结束时间</td>
					<td>
						<input id="endtime" readonly="true" name="endTime" type="text" value="<%=nowdate %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endtime);" />
						<img onclick="WdatePicker({el:$dp.$('endtime'),dateFmt:'yyyy-MM-dd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
					</td>
				</tr>
				<tr>
					<td>话务员工号</td>
					<td><input name="long_serv_no" value="<%=loginNo%>" /></td>
				</tr>
				<tr>
					<td>受理号码</td>
					<td><input name="user_phone" value="" /></td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td id="footer" align=center>
						<input class="b_foot" name="submit1" type="button" value="查询" onclick="queryData();">
						<input class="b_foot" name="reset1" type="reset" value="重置">
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						留言内容
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="content" cols="37" rows="10" readonly="true"></textarea>
					</td>
				</tr>
			</table> 
		</div>
</form>
</body>
</html>
