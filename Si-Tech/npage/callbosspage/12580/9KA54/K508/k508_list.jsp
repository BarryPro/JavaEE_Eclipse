
<%
  /*
   * 功能: 留言日志
　 * 版本: 1.0.0
　 * 日期: 2009/01/09
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%@ include file="../../headTotal.jsp" %>
<%
	String loginNo = (String) session.getAttribute("workNo");

	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 15;
	int pageCount = 0;
	int curPage = 0;
	String strPage = "";
	String beginTime = "";
	String endTime = "";
	String user_phone = "";
	String long_serv_no = "";
	String timeSql = "";
	
	if(request.getParameter("beginTime") != null && request.getParameter("beginTime").length() > 0){
		beginTime = (String) request.getParameter("beginTime");
		
		timeSql = " and to_char(t.create_time,'yyyy-MM-dd HH24:MI') >= '"+beginTime+"'";
	}
	if(request.getParameter("endTime") != null && request.getParameter("endTime").length() > 0){
		endTime = (String) request.getParameter("endTime");
		timeSql += " and to_char(t.create_time,'yyyy-MM-dd HH24:MI') <= '"+endTime+" 23:59:59'";
	}

	if(request.getParameter("user_phone") != null){
		user_phone = (String) request.getParameter("user_phone");
		
	}
	if(request.getParameter("long_serv_no") != null){
		long_serv_no = (String) request.getParameter("long_serv_no");
	}
	
	//查询条件
	String sqlTemp = "select to_char(count(*)) count from DTAKEMSG t where t.ACCEPT_NO like '%"+user_phone+"%' and t.CREATE_LOGIN_NO like '%"+long_serv_no+"%'" + timeSql;
	
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp %>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<%
	
	if (rowsC4.length != 0) {
		rowCount = Integer.parseInt(rowsC4[0][0]);
	}
	strPage = request.getParameter("page");
	if (strPage == null || strPage.equals("") || strPage.trim().length() == 0) {
		curPage = 1;
	} else {
		curPage = Integer.parseInt(strPage);
		if (curPage < 1)
			curPage = 1;
	}
	pageCount = (rowCount + pageSize - 1) / pageSize;
	if (curPage > pageCount)
		curPage = pageCount;
	int beginPos = (curPage - 1) * pageSize;
	String dsql = "select t.CALLER_NO, t.ACCEPT_NO, t.CREATE_LOGIN_NO, t.MSG_CONTENT, to_char(t.CREATE_TIME,'yyyy-MM-dd hh24:mi:ss'), t.MSG_DESCR from DTAKEMSG t where t.ACCEPT_NO like '%"+user_phone+"%' and t.CREATE_LOGIN_NO like '%"+long_serv_no+"%'" + timeSql+" order by t.CREATE_TIME desc,t.ACCEPT_NO";
	String querySql = PageFilterSQL.getOraQuerySQL(dsql,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
	
%>
<html>
	<head>
		<title>留言日志</title>
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
		<script language="javascript">
			//查看短信日志内容
			function seeContent(vo){				
				parent.mainFrame.document.forms[0].content.value=vo;
			}
		</script>
	</head>

	<body>
		<wtc:service name="s151Select" outnum="9">
			<wtc:param value="<%=querySql %>" />
		</wtc:service>
		<wtc:array id="queryList" start="0" length="9" scope="end" />
		<%
		dataRows = queryList;
		%>
		<div id="Main">
				<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
		<div id="Operation_Table">
			<div class="title">留言日志列表</div>
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" width="100%">
						<%
						if (pageCount != 0) {
						%>
						第
						<%=curPage%>
						页 共
						<%=pageCount%>
						页 共
						<%=rowCount%>
						条
						<%
						} else {
						%>
						<font color="orange">当前记录为空！</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">首页</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">上一页</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">下一页</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">尾页</a>
						<%
						}
						%>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" width="100%">
				<tr>
					<th>
						序号
					</th>
					<th>
						主叫号码
					</th>
					<th>
						留言主机号码
					</th>					
					<th>
						创建人
					</th>
					<th>
						留言内容
					</th>
					<th>
						创建时间
					</th>
					<th>
						备注
					</th>
				</tr>
				<%
						
						for (int i = 0; i < dataRows.length; i++) {
						String tdClass = "";
				%>
				<%
							if ((i + 1) % 2 == 1) {
							tdClass = "grey";
				%>
				<tr onClick="seeContent('<%=dataRows[i][4] %>');" style="cursor:pointer">
					<%
					} else {
					%>
				
				<tr onClick="seeContent('<%=dataRows[i][4] %>');" style="cursor:pointer">
					<%
					}
					%>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>
					<td align="left" class="<%=tdClass%>">
						<%=(dataRows[i][4].length() != 0 && dataRows[i][4].length() >= 10) ? dataRows[i][4].substring(0,10)+"..."
						: "&nbsp;"+dataRows[i][4]==null?"":dataRows[i][4] %>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][5].length() != 0) ? dataRows[i][5]
						: "&nbsp;"%>
					</td>
					
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][6].length() != 0) ? dataRows[i][6]
						: "&nbsp;"%>
					</td>
					
				</tr>
				<%
				}
				%>
			</table>
			<table cellspacing="0">
				<tr>
					<td class="blue" align="right" width="720">
						<%
						if (pageCount != 0) {
						%>
						第
						<%=curPage%>
						页 共
						<%=pageCount%>
						页 共
						<%=rowCount%>
						条
						<%
						} else {
						%>
						<font color="orange">当前记录为空！</font>
						<%
						}
						%>
						<%
						if (pageCount != 1 && pageCount != 0) {
						%>
						<a href="#" onClick="doLoad('first');return false;">首页</a>
						<%
						}
						%>
						<%
						if (curPage > 1) {
						%>
						<a href="#" onClick="doLoad('pre');return false;">上一页</a>
						<%
						}
						%>
						<%
						if (curPage < pageCount) {
						%>
						<a href="#" onClick="doLoad('next');return false;">下一页</a>
						<%
						}
						%>
						<%
						if (pageCount > 1) {
						%>
						<a href="#" onClick="doLoad('last');return false;">尾页</a>
						<%
						}
						%>
					</td>
				</tr>
			</table>
		</div>
	</td>
</tr>
</table>
</div>
		<form action="" name="sitechform"><input type="hidden" name="page"/><input type="hidden" name="myaction" value=""></form>
	</body>
</html>
<script language=javascript>
function doLoad(operateCode){
   var str='1';
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   	str='0';
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1) %>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1) %>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
   window.sitechform.myaction.value="doLoad";									
   window.sitechform.action="k508_list.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}
function changeColor(obj){
	var objs = document.getElementsByTagName("tr");
	for(var i = 0; i < objs.length; i++){
		objs.bgColor = "";
	}
	
	obj.bgColor = "#33FFCC";
	
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
