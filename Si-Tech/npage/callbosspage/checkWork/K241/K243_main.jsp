<%
  /*
	* ����: ���������ˮ����ִ��
	* �汾: 1.0.0
	* ����: 2011/07/05
	* ����: tangsong
	* ��Ȩ: sitech
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%
	//ȡ�õ�ǰʱ����õĲ��Զ�Ӧ���ʼ���
	String selectSql = "select t.qc_group_name,t.assign_id from dqcdissatisfyassign t"
							+ " where sysdate between t.begin_date and t.end_date";
	List resultList = KFEjbClient.queryForList("selectPublic", selectSql);
%>

<html>
<head>
<title>��ˮ����ִ��</title>
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

//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ
function changeColor(color,obj){
	//�ָ�ԭ��һ�е���ʽ
	if(hisObj != ""){
		for(var i=0;i<hisObj.cells.length;i++){
			var tempTd=hisObj.cells.item(i);
			//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
			tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
		}
	}
	hisObj   = obj;
	hisColor = color;
	//���õ�ǰ�е���ʽ
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; �ı��ֵ���ɫ
		tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
	}
}

//�ʼ�Ⱥ��
function getQcGroupTree(){
	var time = new Date();
	var winParam = 'dialogWidth=300px;dialogHeight=250px';
	window.showModalDialog("K241_select_tree_qcNo.jsp?time="+time+"&returnFlag=0",window,winParam);
}

//����assignIdȡ�ò����µ��ʼ칤�źͲ��������ˮ
function getData() {
	var assignId = document.getElementById("assignId").value;
	if (assignId == "-1") {
		document.getElementById("evternoDiv").innerHTML = "";
		return;
	}
	getEvterno(assignId);
	getCallData(assignId);
}

//����assignIdȡ�ò����µ��ʼ칤��
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

//����assignIdȡ�ò����µı��칤�ŵĲ��������ˮ
function getCallData(assignId) {
	document.getElementById("callDataFrame").src = "K243_get_callData.jsp?assignId=" + assignId;
}

//���ݷ��䷽ʽ�趨��ѡ���Ƿ��ѡ
function setCheckboxStatus() {
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	//�Զ�����ʱ��ѡ�򲻿�ѡ
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
//���ݷ��䷽ʽ�趨��ѡ���Ƿ��ѡ
function setCheckboxStatus1() {
	var assignType = "";
	var objs = document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	//�Զ�����ʱ��ѡ�򲻿�ѡ
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
//�ֶ�����ʱ���ʼ�Աֻ�ܵ�ѡ
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

//ִ�з���
function doAssign() {
	var assignId = document.getElementById("assignId").value;
	if (assignId == "-1") {
		similarMSNPop("��ѡ���ʼ���");
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
		autoAssign(assignId); //�Զ�����
	} else {
		handAssign(assignId); //�ֶ�����
	}
}

//�Զ�����
function autoAssign(assignId) {
	var evterno = new Array(); 
	var objs = document.getElementsByName("qcNo");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			evterno[evterno.length]=objs[i].value;
		
		}
	}
	if (evterno.length == 0) {
		similarMSNPop("��ѡ���ʼ�Ա");
		return;
	}
	
	var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementById("clickdata");
	var contactIdArr = new Array(); //ͨ����ˮ����
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
		similarMSNPop("ͨ����¼��С���ʼ�Ա�����޷���������");
	} else if (result == "success") {
		similarMSNPop("����ɹ���");
		//document.getElementById("flag").value="";
		document.frames["callDataFrame"].sitechform.submit();
	} else {
		similarMSNPop("����ʧ�ܣ�");
	}
}
//�ֶ�����
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
		similarMSNPop("��ѡ���ʼ�Ա");
		return;
	}
	var doc = document.frames["callDataFrame"].document;
	objs = doc.getElementById("qclickcdate");
  <!-- add by jiyk 2012-07-31 ���������ˮ����ˮ��ʧ������-->
	var arrContactid=new Array();
	var callDataBox=doc.getElementsByName("callDataBox");
	var j=0;
	for (var i = 0;i < callDataBox.length; i++) {
		if (callDataBox[i].checked) {
			arrContactid[j++]=callDataBox[i].value;
		}
	}
	if (objs.length == 0) {
		similarMSNPop("��ѡ��ͨ����ˮ");
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
		similarMSNPop("����ɹ���");

		$("#Assignbut").attr("disabled","");
	} else {
		similarMSNPop("����ʧ�ܣ�");
		$("#Assignbut").attr("disabled","");
	}
}

//չʾ������
function showAssignResult() {
	var mainWin = window.top;
	if (mainWin.document.getElementById("K244")) {
		mainWin.removeTab("K244");
	}
	var assignId = document.getElementById("assignId").value;
	var path = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K244_main.jsp?assignId="+assignId;
	mainWin.addTab(true,'K244','��ˮ������',path);
}

//�������� ---zengdj20110928 ���ӵ�������
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
//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
</script>
</head>
<body>
<div id="Operation_Table">
<div >
	<table>
		<div class="title"><div id="title_zi">�ʼ칤��</div></div>
		<tr>
			<td nowrap>�ʼ���</td>
			<td nowrap>
				<select name="assignId" id="assignId" onchange="getData()">
					<option value="-1">--��ѡ��--</option>
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
		<div class="title"><div id="title_zi">���������ˮ(δ����)</div></div>
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
	<input type="radio" name="assignType" value="0" onclick="setCheckboxStatus()" checked="checked" />�Զ�����
	<input type="radio" name="assignType" value="1" onclick="setCheckboxStatus()" />�ֶ�����
	&nbsp;&nbsp;
	<input type="button" class="b_foot" id="Assignbut" name="Assignbut" value="������ˮ" onclick="doAssign()" />
	&nbsp;&nbsp;
	<input type="button" class="b_foot_long" value="�鿴������" onclick="showAssignResult()" />
</div>

</div>
</body>
</html>