<%
  /*
	* 功能: 不满意度流水分配执行
	* 版本: 1.0.0
	* 日期: 2011/07/05
	* 作者: tangsong
	* 版权: sitech
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%
	//取得当前时间可用的策略对应的质检组
	String selectSql = "select t.qc_group_name,t.assign_id from dqcdissatisfyassign t"
							+ " where sysdate between t.begin_date and t.end_date";
	List resultList = KFEjbClient.queryForList("selectPublic", selectSql);
%>

<html>
<head>
<title>流水分配执行</title>
<style type="text/css">
	.mydiv {
		border:1px solid #99CCFF;
	}
	.mydiv th, .mydiv td {
		text-align:center;	
	}
	#Operation_Table td {
		text-indent:0;
	}
</style>
<script type="text/javascript">
	
$(document).ready(
	function()
	{
    	$("td").not("[input]").addClass("Blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");

		$("a").hover(function() {
			$(this).css("color", "orange");
		}, function() {
			$(this).css("color", "blue");
		});
		setCheckboxStatus();
	}
);

//选中行高亮显示
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色
function changeColor(color,obj){
	//恢复原来一行的样式
	if(hisObj != ""){
		for(var i=0;i<hisObj.cells.length;i++){
			var tempTd=hisObj.cells.item(i);
			//tempTd.className=hisColor; 还原字的颜色
			tempTd.style.backgroundColor = '#F7F7F7';		//还原行背景颜色
		}
	}
	hisObj   = obj;
	hisColor = color;
	//设置当前行的样式
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; 改变字的颜色
		tempTd.style.backgroundColor='#00BFFF';	//改变行背景颜色
	}
}

//质检群组
function getQcGroupTree(){
	var time = new Date();
	var winParam = 'dialogWidth=300px;dialogHeight=250px';
	window.showModalDialog("K241_select_tree_qcNo.jsp?time="+time+"&returnFlag=0",window,winParam);
}

//根据assignId取得策略下的质检工号和不满意度流水
function getData() {
	var assignId = document.getElementById("assignId").value;
	if (assignId == "-1") {
		document.getElementById("evternoDiv").innerHTML = "";
		return;
	}
	getEvterno(assignId);
	getCallData(assignId);
}

//根据assignId取得策略下的质检工号
function getEvterno(assignId) {
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K243_get_evterno.jsp","");
	packet.data.add("assignId", assignId);
	core.ajax.sendPacket(packet,doProcessGetEvterno,false);
	packet=null;
}

function doProcessGetEvterno(packet) {
	var evternoHtml = packet.data.findValueByName("evternoHtml");
	document.getElementById("evternoDiv").innerHTML = evternoHtml;
	setCheckboxStatus();
}

//根据assignId取得策略下的被检工号的不满意度流水
function getCallData(assignId) {
	document.getElementById("callDataFrame").src = "K243_get_callData.jsp?assignId=" + assignId;
}

//根据分配方式设定复选框是否可选
function setCheckboxStatus() {
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	//自动分配时复选框不可选
	var doc = document.frames["callDataFrame"].document;
	if (assignType == "0") {
		//$("input[type='checkbox']").attr("disabled","disabled");
		$("input[type='checkbox']").attr("checked","checked");
		//$(doc).find("input[type='checkbox']").attr("disabled","disabled");
		$(doc).find("input[type='checkbox']").attr("checked","checked");
		
  var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementsByName("callDataBox");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
	var clikcdate = doc.getElementById("clickdata").value;
					if(clikcdate.indexOf(objs[i].value)!=-1)
					{
					objs[i].checked=false;
				  }  
		}
	}
	
		
	} else {
		$("input[type='checkbox']").attr("disabled","");
		$("input[type='checkbox']").attr("checked","");
		//$(doc).find("input[type='checkbox']").attr("disabled","");
		$(doc).find("input[type='checkbox']").attr("checked","");
	}
}
//根据分配方式设定复选框是否可选
function setCheckboxStatus1() {
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	//自动分配时复选框不可选
	var doc = document.frames["callDataFrame"].document;
	if (assignType == "0") {
		//$("input[type='checkbox']").attr("disabled","disabled");
		//$("input[type='checkbox']").attr("checked","checked");
		//$(doc).find("input[type='checkbox']").attr("disabled","disabled");
		$(doc).find("input[type='checkbox']").attr("checked","checked");
		
  var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementsByName("callDataBox");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
	var clikcdate = doc.getElementById("clickdata").value;
					if(clikcdate.indexOf(objs[i].value)!=-1)
					{
					objs[i].checked=false;
				  }  
		}
	}
	
		
	} //else {
		//$("input[type='checkbox']").attr("disabled","");
	//	$("input[type='checkbox']").attr("checked","");
		//$(doc).find("input[type='checkbox']").attr("disabled","");
	//	$(doc).find("input[type='checkbox']").attr("checked","");
	//}
}
//手动分配时，质检员只能单选
function qcNoClick(obj) {
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	if (assignType == "1") {
		if (obj.checked) {
			$("input[name='qcNo']").attr("checked","");
			obj.checked = true;
		}
	}
	else{
			
	}
}

//执行分配
function doAssign() {
	var assignId = document.getElementById("assignId").value;
	if (assignId == "-1") {
		similarMSNPop("请选择质检组");
		return;
	}
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	if (assignType == "0") {
		autoAssign(assignId); //自动分配
	} else {
		handAssign(assignId); //手动分配
	}
}

//自动分配
function autoAssign(assignId) {
	var evterno = new Array(); 
	var objs = document.getElementsByName("qcNo");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			evterno[evterno.length]=objs[i].value;
		
		}
	}
	if (evterno.length == 0) {
		similarMSNPop("请选择质检员");
		return;
	}
	
	var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementById("clickdata");
	var contactIdArr = new Array(); //通话流水数组
	var trmval=objs.value;
   contactIdArr=trmval.split(",");
  var flag=document.getElementById("flag").value; 
  var caller="";
  var accept_login_no = "";
 	var Contact_id = "";
 	var accept_long_begin = "";
 	var accept_long_end = "";
  var beginTime = ""; 
  var endTime = "";
   caller=doc.getElementById("caller_phone").value;
   accept_login_no = doc.getElementById("accept_login_no").value;
 	 Contact_id = doc.getElementById("Contact_id").value;
 	 accept_long_begin = doc.getElementById("accept_long_begin").value;
 	 accept_long_end = doc.getElementById("accept_long_end").value;
   beginTime = doc.getElementById("beginTime").value; 
   endTime = doc.getElementById("endTime").value;
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K243_do_assign_auto.jsp","");
	packet.data.add("caller_phone", caller);
	packet.data.add("accept_login_no", accept_login_no);
	packet.data.add("Contact_id", Contact_id);
	packet.data.add("accept_long_begin", accept_long_begin);
	packet.data.add("accept_long_end", accept_long_end);
	packet.data.add("beginTime", beginTime);
	packet.data.add("endTime", endTime);
	packet.data.add("assignId", assignId);
	packet.data.add("evterno", evterno);
	packet.data.add("contactIdArr", contactIdArr);
	core.ajax.sendPacket(packet,doProcessAutoAssign,false);
	packet=null;
	
}

function doProcessAutoAssign(packet) {
	var result = packet.data.findValueByName("result");
	if (result == "nodata") {
		similarMSNPop("通话记录数小于质检员数，无法继续分配");
	} else if (result == "success") {
		similarMSNPop("分配成功！");
		//document.getElementById("flag").value="";
		document.frames["callDataFrame"].sitechform.submit();
	} else {
		similarMSNPop("分配失败！");
	}
}
//手动分配
function handAssign(assignId) {
	var evterno = "";
	var objs = document.getElementsByName("qcNo");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			evterno = objs[i].value;
			break;
		}
	}
	if (evterno == "") {
		similarMSNPop("请选择质检员");
		return;
	}
	var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementById("qclickcdate");
  <!-- add by jiyk 2012-07-31 不满意度流水，流水丢失问题解决-->
	var arrContactid=new Array();
	var callDataBox=doc.getElementsByName("callDataBox");
	var j=0;
	for (var i = 0;i < callDataBox.length; i++) {
		if (callDataBox[i].checked) {
			arrContactid[j++]=callDataBox[i].value;
		}
	}
	if (objs.length == 0) {
		similarMSNPop("请选择通话流水");
		return;
	}
	$("#Assignbut").attr("disabled","disabled");
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K243_do_assign_hand.jsp","");
  packet.data.add("assignId", assignId);
	packet.data.add("evterno", evterno);
	packet.data.add("contactIdArr", arrContactid);
	core.ajax.sendPacket(packet,doProcessHandAssign,false);
	packet=null;
	doc.getElementById("qclickcdate").value="";
}

function doProcessHandAssign(packet) {
	var result = packet.data.findValueByName("result");
	if (result == "success") {
		document.frames["callDataFrame"].document.getElementById("qclickcdate").value="";
		document.frames["callDataFrame"].sitechform.submit();
		similarMSNPop("分配成功！");

		$("#Assignbut").attr("disabled","");
	} else {
		similarMSNPop("分配失败！");
		$("#Assignbut").attr("disabled","");
	}
}

//展示分配结果
function showAssignResult() {
	var mainWin = window.top;
	if (mainWin.document.getElementById("K244")) {
		mainWin.removeTab("K244");
	}
	var assignId = document.getElementById("assignId").value;
	var path = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K244_main.jsp?assignId="+assignId;
	mainWin.addTab(true,'K244','流水分配结果',path);
}

//导出窗口 ---zengdj20110928 增加导出功能
function showExpWin(flag){
	 //var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 //var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 //var month_interval = getMonths(startDate,endDate);
	 //document.sitechform.month_interval.value = month_interval;
	var assignId = document.getElementById("assignId").value;
	if (assignId == "-1") {
		assignId="";
	}
  openWinMid('K243_expSelect.jsp?flag='+flag+'&assignId='+assignId,'expSelect',340,320);
}
//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //转向网页的地址;
  //var name; //网页名称，可为;
  //var iWidth; //弹出窗口的宽度;
  //var iHeight; //弹出窗口的高度;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>
<body>
<div id="Operation_Table">
<div >
	<table>
		<div class="title"><div id="title_zi">质检工号</div></div>
		<tr>
			<td nowrap>质检组</td>
			<td nowrap>
				<select name="assignId" id="assignId" onchange="getData()">
					<option value="-1">--请选择--</option>
<%
	if (resultList != null && resultList.size() > 0) {
		for (int i = 0; i < resultList.size(); i++) {
			Map map = (Map)resultList.get(i);
			String assignId = (String)map.get("ASSIGN_ID");
			String qcGroupName = (String)map.get("QC_GROUP_NAME");
%>
					<option value="<%=assignId%>"><%=qcGroupName%></option>
<%
		}
	}
%>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="evternoDiv" style="height:90px;overflow:scroll"></div>
			</td>
		</tr>
	</table>
</div>

<div >
	<table>
		<div class="title"><div id="title_zi">不满意度流水(未分配)</div></div>
		  <input type="hidden" name="flag" id="flag" value="" />
		<tr>
			<td>
				<div style="height:557px">
				<iframe src="K243_get_callData.jsp" name="callDataFrame" id="callDataFrame" frameborder="0" style="width:100%;height:100%"></iframe>
				</div>
			</td>
		</tr>
	</table>
</div>

<div id="myfooter" class="mydiv" style="clear:both;margin-top:5px;text-align:center;padding:2px;">
	<input type="radio" name="assignType" value="0" onclick="setCheckboxStatus()" checked="checked" />自动分配
	<input type="radio" name="assignType" value="1" onclick="setCheckboxStatus()" />手动分配
	&nbsp;&nbsp;
	<input type="button" class="b_foot" id="Assignbut" name="Assignbut" value="分配流水" onclick="doAssign()" />
	&nbsp;&nbsp;
	<input type="button" class="b_foot_long" value="查看分配结果" onclick="showAssignResult()" />
</div>

</div>
</body>
</html>