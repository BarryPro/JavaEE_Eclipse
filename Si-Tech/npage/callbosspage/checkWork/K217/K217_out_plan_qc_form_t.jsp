<%
  /*
   * 功能: 计划外质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%!
	public  String getCurrDateStr(String str) {
		  if(str.equals("")){
		    	return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		  }else{
				 	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
							"yyyyMMdd");
				 	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		  }
	}
%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	if(opCode == null || "".equals(opCode)){
			opCode = "K217";
	}
	if(opName == null || "".equals(opName)){
			opName = "对工单进行质检";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
/***************获得考评对象流水、考评内容流水开始******************/
	String contact_id     = request.getParameter("serialnum");//被检流水
	String isOutPlanflag  = request.getParameter("isOutPlanflag");
	String staffno        = (String)request.getParameter("staffno");//被检工号
	String evterno        = (String)session.getAttribute("kfWorkNo");//质检工号
	String tabId          = WtcUtil.repNull(request.getParameter("tabId"));//tab页面的id值
/***************获得考评对象流水、考评内容流水结束******************/
%>

 
<html>
<head>
<script>

/**
  *质检完毕返回处理函数
  */
function doProcessSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");

		if(retCode=="000000"){
					rdShowConfirmDialog("成功记录考评结果！",2);
				}else{
					rdShowConfirmDialog("记录考评结果失败！",2);
				}
		
	  //保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *质检完毕，保存质检结果
  *
  */
function saveQcInfo(a) {
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc_t.jsp","请稍后...");

		//获得考评项得分
    var scoreValues    = new Array();
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    
    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for 中测 start 培训建议
    var tranSugg = document.getElementById("tranSugg").value;
    var testWeight = document.getElementById("testWeight").value;
    //add for 中测 end
    
    
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    
    
		chkPacket.data.add("retType", a);
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		//add for 中测 start
		chkPacket.data.add("tranSugg", tranSugg);
		chkPacket.data.add("testWeight", testWeight);
		//add for 中测 end
		
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");

		chkPacket.data.add("staffno","<%=staffno%>");
		
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,true);
		chkPacket =null;
}


/**
  *临时保存返回处理函数
  */
function doProcessTempSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="tempSaveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("临时保存质检结果成功！",2);
				}else{
					rdShowConfirmDialog("临时保存质检结果失败！",1);
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}


/**
  *
  *临时保存质检结果
  *
  */
function tempSaveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","请稍后...");
		//获得考评项得分
    var scoreValues    = new Array();
    
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for 中测 start 培训建议
    var tranSugg = document.getElementById("tranSugg").value;
    //add for 中测 end
    
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_text = document.getElementById("error_level_text").value;
    //差错类别id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //差错类别
    var error_class_texts = document.getElementById("error_class_texts").value;
    //来电原因id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //来电原因
    var service_class_texts = document.getElementById("service_class_texts").value;
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    //质检时长
    var handleTime = document.getElementById("handleTime").innerHTML;
    //听取录音时长
    var listenTime = document.getElementById("listenTime").innerHTML;
    //整理时长
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //总时长
    var totalTime = document.getElementById("totalTime").innerHTML;    

		chkPacket.data.add("retType", "tempSaveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
	
		//add for 中测 start 培训建议
		chkPacket.data.add("tranSugg", tranSugg);
		//add for 中测 end


		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "0");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("staffno","<%=staffno%>");
		<!--参数false表示同步执行-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
		chkPacket =null;
}

/**
  *放弃返回处理函数
  */
function doProcessGiveUpQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("成功放弃质检！",2);
				}else{
					rdShowConfirmDialog("放弃质检失败！",1);
				}
		}
		//保存结果后将isSaved的值设为true
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *放弃质检
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","请稍后...");
	//获得考评项得分
    var scoreValues    = new Array();
    
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //获得考评项id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//获得流水号
		var serialnum = document.getElementById("serialnum").value;
		//内容概况
    var contentinsum = document.getElementById("contentinsum").value;
    //处理情况
    var handleinfo = document.getElementById("handleinfo").value;
    //改进建议
    var improveadvice = document.getElementById("improveadvice").value;
    //综合评价
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for 中测 start
    var tranSugg = document.getElementById("tranSugg").value;
    //add for 中测 end
    
    //差错等级id
    var error_level_id = document.getElementById("error_level_id").value;
    //差错等级
    var error_level_text = document.getElementById("error_level_text").value;
    //差错类别id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //差错类别
    var error_class_texts = document.getElementById("error_class_texts").value;
    //来电原因id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //来电原因
    var service_class_texts = document.getElementById("service_class_texts").value;
    //放弃原因id
    var give_up_reason_ids = document.getElementById("give_up_reason_ids").value;    
    //放弃原因
    var give_up_reason_texts = document.getElementById("give_up_reason_texts").value;
    //总得分
    var totalScore = document.getElementById("totalScore").value;
    //质检时长
    var handleTime = document.getElementById("handleTime").innerHTML;
    //听取录音时长
    var listenTime = document.getElementById("listenTime").innerHTML;
    //整理时长
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //总时长
    var totalTime = document.getElementById("totalTime").innerHTML; 

		chkPacket.data.add("retType", "giveUpQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		
		//add for 中测 start
		chkPacket.data.add("tranSugg", tranSugg);
		//add for 中测 end
		
		chkPacket.data.add("error_level_id", error_level_id);
		chkPacket.data.add("error_level_text", error_level_text);
		chkPacket.data.add("error_class_ids", error_class_ids);
		chkPacket.data.add("error_class_texts", error_class_texts);
		chkPacket.data.add("service_class_ids", service_class_ids);
		chkPacket.data.add("service_class_texts", service_class_texts);
		chkPacket.data.add("give_up_reason_ids", give_up_reason_ids);
		chkPacket.data.add("give_up_reason_texts", give_up_reason_texts);	
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "4");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");
		chkPacket.data.add("handleTime", handleTime);
		chkPacket.data.add("listenTime", listenTime);
		chkPacket.data.add("adjustTime", adjustTime);		
		chkPacket.data.add("totalTime", totalTime);
		chkPacket.data.add("staffno","<%=staffno%>");
		core.ajax.sendPacket(chkPacket, doProcessGiveUpQcInfo, true);
		chkPacket =null;
}


//选择考评等级后改变分数和总分
function changeScore(i){
		var scorei = document.getElementById("score"+i);
		var itemleveli = document.getElementById("itemlevel"+i);
		scorei.value=itemleveli.options[itemleveli.selectedIndex].value;
		sumScore();
}

function checkIsSendTip(a){
		
			saveQcInfo(a);
		
}

/**
 *功能：记录质检结果通知
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;	
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","正在发送请求，请稍候......");
		mypacket.data.add("belongno","");
		mypacket.data.add("type",0);
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=evterno%>");
		mypacket.data.add("apptitle","流水号：<%=contact_id%> 考评得分："+totalScore);                   	
		mypacket.data.add("content","");  
		mypacket.data.add("flag",flag);  	
		core.ajax.sendPacket(mypacket,doQcCfmdoProcess,true);
		mypacket=null;     
}

//发送通知回调函数
function doQcCfmdoProcess(packet){	
		var flag = packet.data.findValueByName("flag");
		toSendMsg(flag);
}

//add by hanjc for 中测 begin
//发送电子邮件提醒
function doMailCfm(){
	 var path='<%=request.getContextPath()%>/npage/callbosspage/K083/K083_mailSend.jsp?mailcontent=请查看流水号：<%=contact_id%>的评分结果';
	 var obj = openWinMid(path,'邮件提醒',650,850);
}
//add by hanjc for 中测 end

//发送质检结果通知提醒
function toSendMsg(flag){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","正在发送通知，请稍候......");
		mypacket.data.add("description","质检结果");//不能超过10位
		mypacket.data.add("send_login_no","<%=evterno%>");
		mypacket.data.add("receive_login_no","<%=staffno%>");
		mypacket.data.add("cityid","");
		mypacket.data.add("content","请查看流水号：<%=contact_id%>的评分结果");
		mypacket.data.add("msg_type",0);
		mypacket.data.add("title","质检结果通知");
	  mypacket.data.add("bak",flag);
	  core.ajax.sendPacket(mypacket,toSendMsgdoProcess,true);
		mypacket=null;
}

//发送质检结果通知提醒回调函数
function toSendMsgdoProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		saveQcInfo();
}

/*-------------听取录音功能开始-----------------*/
function doLisenRecord(filepath,contact_id,idname){
		window.parent.top.document.getElementById("recordfile").value     = filepath;
		window.parent.top.document.getElementById("lisenContactId").value = contact_id;
		window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
		window.parent.top.document.getElementById(idname).click();
}
function ListenPause(idname){
}

/**
	*初始化时获取录音地址
	*/
function initCheckCallListen(id,idname){
		if(id==''){
				return;
		}
		
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetInitPath,false);
		packet=null;
}	
	
function doProcessGetInitPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname");
   window.parent.top.document.getElementById("recordfile").value     = file_path;
	 window.parent.top.document.getElementById("lisenContactId").value = contact_id;
	 window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
}

/**
  *录音听取调用
  *
  *id:     流水ID
  *idname: opcode
  */
function checkCallListen(id,idname){
		if(id==''){
		return;
		}
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","");
		packet.data.add("contact_id",id);
		packet.data.add("idname",idname);
		core.ajax.sendPacket(packet,doProcessGetPath,false);
		packet=null;
}

function doProcessGetPath(packet){
   var file_path   = packet.data.findValueByName("file_path");
   var flag        = packet.data.findValueByName("flag");
   var contact_id  = packet.data.findValueByName("contact_id"); 
   var idname      = packet.data.findValueByName("idname"); 
 
   if(flag=='Y'){
   		doLisenRecord(file_path,contact_id,idname);
   }else{
   		getCallListen(contact_id,idname);
   }
}

function getCallListen(id,idname){
		if(id==''){
				return;
		}	
		var path = "<%=request.getContextPath()%>"+"/npage/callbosspage/checkWork/K217/K217_getCallListen.jsp?flag_id="+id;
		openWinMid(path,'录音听取',650,850);
}

/*--------------听取录音功能结束----------------*/

/*----------------放音计时开始--------------*/

var ListenTimer = null;
function ListenTimeStart(){ 
		var listenTime=document.getElementById("listenTime").innerHTML;
		listenTime=parseInt(listenTime)+1; 
	  document.getElementById("listenTime").innerHTML =listenTime;
	  window.ListenTimer = window.setTimeout("ListenTimeStart()",1000);
}

function ListenTimePause(){
		clearTimeout(window.ListenTimer);
}

function ListenTimeStop(){
		ListenTimePause();
}

function ListenTimeEnd(){
		ListenTimeStop();
}
/*----------------放音计时结束--------------*/

/*--------------计时器开始----------------*/
window.onload=function(){
		setTimer();
		
}
var scan = "";
function setTimer(){
		scan = setInterval("timer()",1000);
}

//结束质检时长
function finishedTimer(){
		clearInterval(scan);
}

function timer(){
		var handleTime = document.getElementById("handleTime").innerHTML; 
		handleTime=parseInt(handleTime)+1;
		var totalTime = handleTime;
		document.getElementById("handleTime").innerHTML=handleTime;
		document.getElementById("totalTime").innerHTML=totalTime;
}

/*----------------计时器结束--------------*/

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//关闭当前窗口
function closeWin(){
		var tabId='<%=tabId%>';
		var isClosed = document.getElementById("isClosed").value;
		if(tabId!=''&& isClosed=='false'){
	    parent.parent.removeTab(tabId);
	  }
}
</script>

<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
}
#tabtit ul
{
	height:23px;
	position:absolute;
}
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}

/*---------------听取录音按钮style开始-------*/
#callSearch
{
	height:1.2%;
	width:100%;
	padding:4px 2px;
	font-size:12px;
	z-index:1000000000000;
}

#callSearch img
{
	width:16px;
	height:16px;
	cursor:pointer;
}

/*---------------听取录音按钮style结束------------*/

#subScore{
border:1px solid #FFF;
}
</style>

</head>
<body>
<form name="form1">
<input type="hidden" name="serialnum" id="serialnum" value=""/>
	


<div id="Operation_Table">
  <div class="title">
    评分项目 &nbsp;子项得分合计 &nbsp;
  	<input type="text" disabled id="subScore" size="6" value=""/> &nbsp;
  </div>
  <table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="2px" cellspacing="0">
	  <tr>
	    <td>序号</td>
	    <td>名称</td>
	    <td>最低分</td>
	    <td>最高分 </td>
	    <td>得分</td>
	    <td>考评等级</td>    
	  </tr>

<tr>
<td class='Blue' width='30px'>0</td>
<td class='Blue'>
使用标准欢迎语(2分)
<input type='hidden' name='itemId' value='0101'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score0' id='score0' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel0' id='itemlevel0' onchange='changeScore(0);'>

	    
	    
	    <option value="2">2->使用标准欢迎语</option><option value="0">0->使用标准欢迎语</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>1</td>
<td class='Blue'>
使用标准结束语(2分)
<input type='hidden' name='itemId' value='0102'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score1' id='score1' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel1' id='itemlevel1' onchange='changeScore(1);'>

	    
	    
	    <option value="2">2->使用标准结束语</option><option value="0">0->使用标准结束语</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>2</td>
<td class='Blue'>
恰当运用礼貌用语(2分)
<input type='hidden' name='itemId' value='0103'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score2' id='score2' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel2' id='itemlevel2' onchange='changeScore(2);'>

	    
	    
	    <option value="2">2->恰当运用礼貌用语</option><option value="0">0->恰当运用礼貌用语</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>3</td>
<td class='Blue'>
使用禁用语、抢答用户(5分)
<input type='hidden' name='itemId' value='0104'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score3' id='score3' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel3' id='itemlevel3' onchange='changeScore(3);'>

	    
	    
	    <option value="5">5->使用禁用语、抢答用户</option><option value="0">0->使用禁用语、抢答用户</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>4</td>
<td class='Blue'>
语音语速适中(3分)
<input type='hidden' name='itemId' value='0105'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>3</td>
<td class='Blue' width='10px'><input type='text' name='score4' id='score4' size='6' maxlength='6' onblur='sumScore();' value='3' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel4' id='itemlevel4' onchange='changeScore(4);'>

	    
	    
	    <option value="3">3->语音语速适中</option><option value="0">0->语音语速适中</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>5</td>
<td class='Blue'>
语调柔和(5分)
<input type='hidden' name='itemId' value='0106'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score5' id='score5' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel5' id='itemlevel5' onchange='changeScore(5);'>

	    
	    
	    <option value="5">5->语调柔和</option><option value="0">0->语调柔和</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>6</td>
<td class='Blue'>
耐心解答(10分)
<input type='hidden' name='itemId' value='0107'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>10</td>
<td class='Blue' width='10px'><input type='text' name='score6' id='score6' size='6' maxlength='6' onblur='sumScore();' value='10' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel6' id='itemlevel6' onchange='changeScore(6);'>

	    
	    
	    <option value="10">10->耐心解答</option><option value="0">0->耐心解答</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>7</td>
<td class='Blue'>
推诿客户(5分)
<input type='hidden' name='itemId' value='0108'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score7' id='score7' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel7' id='itemlevel7' onchange='changeScore(7);'>

	    
	    
	    <option value="5">5->推诿客户</option><option value="0">0->推诿客户</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>8</td>
<td class='Blue'>
适当的回应(3分)
<input type='hidden' name='itemId' value='0109'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>3</td>
<td class='Blue' width='10px'><input type='text' name='score8' id='score8' size='6' maxlength='6' onblur='sumScore();' value='3' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel8' id='itemlevel8' onchange='changeScore(8);'>

	    
	    
	    <option value="3">3->适当的回应</option><option value="0">0->适当的回应</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>9</td>
<td class='Blue'>
工作态度不严谨(4分)
<input type='hidden' name='itemId' value='0110'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>4</td>
<td class='Blue' width='10px'><input type='text' name='score9' id='score9' size='6' maxlength='6' onblur='sumScore();' value='4' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel9' id='itemlevel9' onchange='changeScore(9);'>

	    
	    
	    <option value="4">4->工作态度不严谨</option><option value="0">0->工作态度不严谨</option>
</select>
</td>
</tr>
</table>

</div>



<div id="Operation_Table">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 内容概况</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 处理情况</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 改进建议</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 综合评价</li>
					<!--add for 中测 start-->
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 培训建议</li>
					<!--add for 中测 finished-->
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    	<textarea id="contentinsum" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_02">
				<textarea id="handleinfo" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_03">
				<textarea id="improveadvice" cols="70" rows="3"></textarea>
			</div>
			<div class="undis" id="tbc_04">
				<textarea id="commentinfo" cols="70" rows="3"></textarea>
			</div>
			<!--add for 中测 start-->
			<div class="undis" id="tbc_05">
				<textarea id="tranSugg" cols="70" rows="3"></textarea>
			</div>
			<!--add for 中测 finished-->
		</div>

		</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer" width="100%">
        <div id="callSearch">
        <!--add for 中测 start-->
        权重：<input type="text" name="testWeight" id="testWeight" size="6" value="" />&nbsp;
        <!--add for 中测 end-->
				总分：<input type="text" name="totalScore" id="totalScore" size="6" value="" readonly/>
				<!--<input name="confirm" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="临时保存">-->
				<input name="confirm" onClick="checkIsSendTip('1');finishedTimer();" type="button" class="b_foot" value="质检完毕">
				<input name="confirm" onClick="checkIsSendTip('0');finishedTimer();" type="button" class="b_foot" value="临时保存">
				<!--<input name="confirm" onClick="rdShowMessageDialog('设为案例！',1);finishedTimer();" type="button" class="b_foot" value="设为案例">-->
				<!--<input name="confirm" onClick="show_select_give_up_reason_win()" type="button" class="b_foot_long" value="放弃">-->
				<!--	<input name="back" onClick="grpClose();" type="button" class="b_foot" value="取消">-->
      </div>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			
			<td align="left" width="15%">处理时长：</td>     <td  width="15%" align="left" id="handleTime">0</td>
			<td align="left"  width="15%">总时长：</td>       <td align="left"   id="totalTime">0</td>
		</tr>	
	</table>	
	
	<!--隐藏域isSaved为false 表示当前结果未进行任何保存操作，包括放弃操作-->
	<input type='hidden' name='isSaved' id='isSaved' value='false'>
	<!--隐藏域isSaved结束------------->
	<!--隐藏域isClosed为false 用于控制关闭tab页方法只可调用一次-->
	<input type='hidden' name='isClosed' id='isClosed' value='false'>
	<!--隐藏域isClosed结束------------->
</div>

</form>
</body > 
</html>

<script language="javascript">

function grpClose(){
		window.opener = null;
		top.close();
}

/**
  *考评项录入框失去焦点后，计算当前得分
  */
function sumScore(){
		var inputs = document.getElementsByTagName('input');
		var objTotalScore = document.getElementById("totalScore");
		var subScore = document.getElementById("subScore");
		var totalScore = 0;
		
		for(var i = 0; i < inputs.length; i++){
				if(inputs[i].name.substring(0,5) == 'score'){
						totalScore += parseFloat(inputs[i].value);
				}
		}
		
		objTotalScore.value = totalScore;
		subScore.value = totalScore;
}

function g(o){
		return document.getElementById(o);
}
function HoverLi(n){
		//for(var i=1;i<=4;i++)
		//modify for 中测 将4改为5
		for(var i=1;i<=5;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

function ccc(){
		if(rdShowConfirmDialog("是否确定提交？")){
		}
}

/**
  *弹出选择放弃原因的窗口
  */
function show_select_give_up_reason_win(){
		var returnValue = window.showModalDialog("./K217_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var give_up_reason_texts = document.getElementById("give_up_reason_texts");
				var give_up_reason_ids   = document.getElementById("give_up_reason_ids");
				var temp = returnValue.split('_');
				give_up_reason_texts.value = trim(temp[0]);
				give_up_reason_ids.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				give_up_reason_texts.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
							if(i!=0&&i%2==0){
							give_up_reason_texts.value +='<br>';
					}
					if(i!=texts_temp_level.length-1){
				    	give_up_reason_texts.value += texts_temp_level[i] + ',';
				  }  
		}
		giveUpQcInfo();
		finishedTimer();
	 }
}

/**
  *弹出选择差错等级的窗口
  */
function show_select_error_level_win(){
		var returnValue = window.showModalDialog("./K217_get_error_level.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		if(typeof(returnValue) != "undefined"){
				var error_level_text = document.getElementById("error_level_text");
				var error_level_id   = document.getElementById("error_level_id");
				var temp = returnValue.split('_');
				error_level_text.value = trim(temp[0]);
				error_level_id.value = trim(temp[1]);
				
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_level = temp1.split(',');
				var ids_temp_level = temp2.split(',');
				error_level_text.value="";
				for(var i=0; i<texts_temp_level.length-1; i++){
						if(i!=0&&i%2==0){
								error_level_text.value +='<br>';
						}
						if(i!=texts_temp_level.length-1){
					    	error_level_text.value += texts_temp_level[i] + ',';
					  } 
				}
		}
}

/**
  *弹出选择差错类别的窗口
  */
function show_select_error_class_win(){
		var returnValue = window.showModalDialog("./K217_get_error_class.jsp",'',"dialogWidth=800px;dialogHeight=420px");
		
		if(typeof(returnValue) != "undefined"){
				var error_class_texts = document.getElementById("error_class_texts");
				var error_class_ids  = document.getElementById("error_class_ids");
				var temp = returnValue.split('_');
				error_class_texts.value = trim(temp[0]);
				error_class_ids.value   = trim(temp[1]);
				var temp1= trim(temp[0]);
				var temp2= trim(temp[1]);
				var texts_temp_arr = temp1.split(',');
				var ids_temp_arr = temp2.split(',');
				error_class_texts.value="";
				
				for(var i=0; i<texts_temp_arr.length-1; i++){
					
						if(i!=0&&i%2==0){
								error_class_texts.value +='<br>';
						}
						
						if(i!=texts_temp_arr.length-1){
						  	error_class_texts.value += texts_temp_arr[i] + ',';
						}
				}
		}
}

/**
  *弹出选择来电原因的窗口
  */
function show_select_service_class_win(){
		
}

//去左空格;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}

//去右空格;
function rtrim(s){
		return s.replace( /\s*$/, "");
}

//去左右空格;
function trim(s){
		return rtrim(ltrim(s));
}
sumScore();

</script>
