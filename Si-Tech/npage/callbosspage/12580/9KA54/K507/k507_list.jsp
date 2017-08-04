
<%
  /*
   * 功能: 短信日志
　 * 版本: 1.0.0
　 * 日期: 2009/01/09
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,javax.servlet.http.HttpServletRequest,com.sitech.boss.util.excel.*"%>
<%@ include file="../../headTotal.jsp" %>

	           

<%
	String dsql1 = "";
	String dsql2 = "";
	String dsql3 = "";
	String loginNo = (String) session.getAttribute("workNo");

	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 15;
	int pageCount = 0;
	int curPage = 0;
	String strPage = "";
	String beginTime = "";
	String endTime = "";
	String caller_phone = "";//增加的主叫号码查询条件
	String user_phone = "";
	String send_login_no = "";
	String timeSql = "";//时间查询条件
	
	String phSql = "";//主叫号码查询条件
	
	if(request.getParameter("beginTime") != null && request.getParameter("beginTime").length() > 0){
		beginTime = (String) request.getParameter("beginTime");
		
		timeSql = " and to_char(t.INSERT_TIME,'yyyy-MM-dd HH24:MI') >= '"+beginTime+"'";
	}
	if(request.getParameter("endTime") != null && request.getParameter("endTime").length() > 0){
		endTime = (String) request.getParameter("endTime");
		timeSql += " and to_char(t.INSERT_TIME,'yyyy-MM-dd HH24:MI') <= '"+endTime+" 23:59:59'";
	}
	
	if(request.getParameter("caller_phone") != null && request.getParameter("caller_phone").length() > 0 ){
		caller_phone = (String) request.getParameter("caller_phone");
		phSql = " and t.caller_phone like '%"+caller_phone+"%'";
	}
	
	if(request.getParameter("user_phone") != null && request.getParameter("user_phone").length() > 0 ){
		
		user_phone = (String) request.getParameter("user_phone");
		phSql += " and t.user_phone like '%"+user_phone+"%'";
	}
	if(request.getParameter("send_login_no") != null && request.getParameter("send_login_no").length() > 0 ){
		send_login_no = (String) request.getParameter("send_login_no");
		phSql += " and t.send_login_no like '%"+send_login_no+"%'";
	}
	
	//查询条件
	String sqlTemp = "select to_char(count(*)) count from SMS_PUSH_REC_LOG_12580 t where 1=1 " + phSql + timeSql;
	
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp %>" />
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<%
	dsql1 = "select ";
	dsql2 = "t.contact_id, t.send_login_no, t.user_phone, t.long_serv_no, t.Success_FLAG, t.SEND_CONTENT, to_char(t.VALID_TIME, 'yyyy-MM-dd hh24:mi:ss'), to_char(t.INSERT_TIME, 'yyyy-MM-dd hh24:mi:ss'), t.caller_phone  ";
	dsql3 = "from SMS_PUSH_REC_LOG_12580 t where 1=1 " + phSql + timeSql+" order by t.insert_time desc,t.user_phone";
	String dsql = dsql1+dsql2+dsql3;
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
	
	String querySql = PageFilterSQL.getOraQuerySQL(dsql,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>

<html>
	<head>
		<title>短信日志信息</title>
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
		<script language="javascript">
			//查看短信日志内容
			function seeContent(vo){				
				parent.mainFrame.document.forms[0].content.value=vo;
			}
			function reSendMsg(aph, callph, msg){
				window.open('k507_reSendMsg.jsp?aphone='+aph+'&callphone='+callph+'&content='+msg,'','toolbar=no,menubar=no,width=700px,height=200px');				
			}
		</script>
	</head>

	<body>
		
		<wtc:service name="s151Select" outnum="12">
			<wtc:param value="<%=querySql %>" />
		</wtc:service>
		<wtc:array id="queryList" start="0" length="12" scope="end" />
		<%
		dataRows = queryList;
		%>
		<div id="Main">
				<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
		<div id="Operation_Table">
			<div class="title">短信日志列表</div>
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
						<input type="button" class="b_foot" value="导出" onClick="jsExcel();">
					</td>
				</tr>
			</table>
			<table cellSpacing="0" width="100%">
				<tr>
					<th>
						接触流水号
					</th>
					<th>
						工号
					</th>
					<th>
						目的地址
					</th>
					<th>
						主叫号码
					</th>
					<th>
						源地址
					</th>
										
					<th>
						短信状态
					</th>
					<th>
						短信内容
					</th>
					<th>
						发送时间
					</th>
					<th>
						受理时间
					</th>
					<th>
						短信长度
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
				<tr onDblClick="reSendMsg('<%=dataRows[i][3]%>','<%=dataRows[i][9]%>','<%=dataRows[i][6]%>');" onClick="seeContent('<%=dataRows[i][6]==null?"":dataRows[i][6] %>');" style="cursor:pointer">
					<%
					} else {
					%>
				
				<tr onDblClick="reSendMsg('<%=dataRows[i][3]%>','<%=dataRows[i][9]%>','<%=dataRows[i][6]%>');" onClick="seeContent('<%=dataRows[i][6]==null?"":dataRows[i][6] %>');" style="cursor:pointer">
					<%
					}
					%>
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
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][9].length() != 0) ? dataRows[i][9]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][4].length() != 0) ? dataRows[i][4]
						: "&nbsp;"%>
					</td>
					
					<td align="center" class="<%=tdClass%>">
						<%
						 String rsf = "成功";
						 if(dataRows[i][5].length() != 0 && "N".equals(dataRows[i][5])){
						 		rsf = "失败";
						 }
						 out.println(rsf);
						%>						
					</td>
					<td align="left" class="<%=tdClass%>">
						<%=(dataRows[i][6].length() != 0 && dataRows[i][6].length() >= 10) ? dataRows[i][6].substring(0,10)+"..."
						: "&nbsp;"+dataRows[i][6]==null?"":dataRows[i][6] %>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][7].length() != 0) ? dataRows[i][7]
						: "&nbsp;"%>
					</td>
					
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][8].length() != 0) ? dataRows[i][8]
						: "&nbsp;"%>
					</td>
					
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][6].length() != 0) ? String.valueOf(dataRows[i][6].length()) : "&nbsp;"%>
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
		<form action="" name="sitechform" method="post">
			<input type="hidden" name="page"/>
			<input type="hidden" name="myaction" value="">
			<input type="hidden" name="beginTime" type="text" value="<%=request.getParameter("beginTime")==null?"":request.getParameter("beginTime") %>"/>
			<input type="hidden" name="endTime" type="text" value="<%=request.getParameter("endTime")==null?"":request.getParameter("endTime") %>"/>
			<input type="hidden" name="send_login_no" type="text" value="<%=request.getParameter("send_login_no")==null?"":request.getParameter("send_login_no") %>"/>
			<input type="hidden" name="caller_phone" type="text" value="<%=request.getParameter("caller_phone")==null?"":request.getParameter("caller_phone") %>"/>
			<input type="hidden" name="user_phone" type="text" value="<%=request.getParameter("user_phone")==null?"":request.getParameter("user_phone") %>"/>
		</form>
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
   window.sitechform.action="k507_list.jsp";
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

function jsExcel(tt){
	var hi = (window.screen.Height-300)/2;
	var wi = (window.screen.width-300)/2;
	window.open('k507_sel_cloumn.jsp?begintime=<%=beginTime %>&endtime=<%=endTime %>&caller_phone=<%=caller_phone %>&user_phone=<%=user_phone %>&send_login_no=<%=send_login_no %>&curPage=<%=curPage %>&pageSize=<%=pageSize %>&rowCount=<%=rowCount %>','','height=300, width=300, top='+hi+', left='+wi+', toolbar=no, menubar=no, scrollbars=no, resizable=no');
	//document.sitechform.action="k507_list.jsp?exce="+typ;
	//document.sitechform.submit();
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
