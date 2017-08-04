
<%
	/*
	* 功能: 预定义短信内容 
	* 版本: 1.0.0
	* 日期: 2009/03/10      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>
<%@ page contentType="text/html;charset=GBK"%>         
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%                                                     
	String opCode = "K501";                              
	String opName = "预定义短信内容";                          
		
%>
<html>
<head>
<title>预定义短信内容</title>
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
<%
	String loginNo = (String) session.getAttribute("workNo");
	String[][] dataRows = new String[][] {};
	int rowCount = 0;
	int pageSize = 15;
	int pageCount = 0;
	int curPage = 0;
	String strPage = "";	
	String msg_mod_id = (String) request.getParameter("msg_mod_id");
	//查询条件
	String sqlTemp = "select to_char(count(*)) count  from DMESSAGEMODELCONTENT t where msg_mod_id = '"+msg_mod_id+"'";
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
	String dsql = "select CREATE_LOGIN_NO, MSG_MOD_CONTENT, msg_mod_content_id from DMESSAGEMODELCONTENT where msg_mod_id = '"+msg_mod_id+"'";
	String querySql = PageFilterSQL.getOraQuerySQL(dsql,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
	
%>
<body>
	<form name="sitechform" id="sitechform">
		<input type="hidden" name="page"/><input type="hidden" name="myaction" value="">
	<div id="Operation_Table">
		<table cellspacing="0">
				<tr>
					<td class="blue" align="left" width="720">
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
					<th align="center">
						短信内容
					</th>				
				</tr>
				<wtc:service name="s151Select" outnum="7">
					<wtc:param value="<%=querySql %>" />
				</wtc:service>
				<wtc:array id="queryList" start="0" length="7" scope="end" />
				<%
				dataRows = queryList;
				%>
				<%
						for (int i = 0; i < dataRows.length; i++) {
						String tdClass = "";
				%>
				<%
							if ((i + 1) % 2 == 1) {
							tdClass = "grey";
				%>
				<tr title="<%=dataRows[i][2] %>" onClick="parent.parent.document.sitechform.msg_content.value+='<%=dataRows[i][2] %>';parent.parent.onCharsChange(parent.parent.document.getElementsByName('msg_content')[0]);" style="cursor:pointer">
					<%
					} else {
					%>
				
				<tr title="<%=dataRows[i][2] %>" onClick="parent.parent.document.sitechform.msg_content.value+='<%=dataRows[i][2] %>';parent.parent.onCharsChange(parent.parent.document.getElementsByName('msg_content')[0]);" style="cursor:pointer">
					<%
					}
					%>
					
					<td align="center" class="<%=tdClass%>">						
						<%=(dataRows[i][2].length() != 0 && dataRows[i][2].length() >= 10) ? dataRows[i][2].substring(0,10)+"..."
						: "&nbsp;"+dataRows[i][2]==null?"":dataRows[i][2] %>
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
</form>
</body>
</html>
<script language=javascript>
function checkAll(){
	var ck = document.sitechform.chkall;
	var e = document.sitechform.elements;
	for (var i = 0; i < e.length; i++){
  	var f = e[i];
  	if (f.name == 'chk') {
    	if(ck.checked){
      	f.checked=true;
      	document.getElementById("words").innerText ="全不选";
    	}else{
      	f.checked=false;
      	document.getElementById("words").innerText ="全选";
    	} 
   	}
	}	
}

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
   window.sitechform.action="k501_msg_content.jsp?msg_mod_id=<%=msg_mod_id %>";
   window.sitechform.method='post';
   window.sitechform.submit();
}

function doedit(){
	var winParam = 'dialogWidth=400px;dialogHeight=400px;toolbar=no;menubar=no;scrollbars=yes;resizeable=no;location=no;status=no';
	
	var chkvalue = "";
	var j = 0;
	var chks = document.sitechform.chk;
	if(chks != undefined){		
		if(chks.length == undefined){
			if(chks.checked){
				window.showModalDialog("edit_content.jsp?msg_mod_content_id="+chks.value+"&msg_mod_id=<%=msg_mod_id %>",window, winParam);
			}else{
				rdShowMessageDialog("请选择要编辑的短信内容！");
			}
		}else{
			for(var i = 0; i < chks.length; i++){
				if(chks[i].checked){
					j++;
					chkvalue = chks[i].value;
				}
			}
			if(j == 0){
				rdShowMessageDialog("请选择要编辑的短信内容！");
			}else if(j > 1){
				rdShowMessageDialog("只能选择编辑的一个短信内容！");
			}else{		
				window.showModalDialog("edit_content.jsp?msg_mod_content_id="+chkvalue+"&msg_mod_id=<%=msg_mod_id %>",window, winParam);
			}
		}		
	}else{
		rdShowMessageDialog("还没有操作的对象！");
	}
}
function addYjsp(){
	var winParam = 'dialogWidth=400px;dialogHeight=400px;toolbar=no;menubar=no;scrollbars=yes;resizeable=no;location=no;status=no';
	window.showModalDialog("insert_content.jsp?msg_mod_id=<%=msg_mod_id %>",window, winParam);
}
function dodel(){	
	var chkvalue = "";
	var flag = true;
	var chks = document.sitechform.chk;
	if(chks != undefined){
		if(chks.length == undefined){
			if(chks.checked){
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA51/K502/delContent_rpc.jsp","正在处理，请稍候......");
				mypacket.data.add("msg_mod_content_ids",chks.value);
				core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
			}else{
				rdShowMessageDialog("请选择要删除的短信内容！");
			}
		}else{
			for(var i = 0; i < chks.length; i++){
				if(chks[i].checked){
					chkvalue += ","+chks[i].value;
					flag = false;
				}
			}	
			if(flag){
				rdShowMessageDialog("请选择要删除的短信内容！");
			}else{
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/12580/9KA51/K502/delContent_rpc.jsp","正在处理，请稍候......");
				mypacket.data.add("msg_mod_content_ids",chkvalue);
				core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
			}			
		}		
	}else{
		rdShowMessageDialog("还没有操作的对象！");
	}
	
}
function doProcess(packet){
	window.sitechform.action="sort_content.jsp?msg_mod_id=<%=msg_mod_id %>";
	window.sitechform.method='post';
	window.sitechform.submit();
}	
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>