<%
  /*
   * ����: �ƻ����ʼ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
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
			opName = "�Թ��������ʼ�";
	}
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
/***************��ÿ���������ˮ������������ˮ��ʼ******************/
	String contact_id     = request.getParameter("serialnum");//������ˮ
	String isOutPlanflag  = request.getParameter("isOutPlanflag");
	String staffno        = (String)request.getParameter("staffno");//���칤��
	String evterno        = (String)session.getAttribute("kfWorkNo");//�ʼ칤��
	String tabId          = WtcUtil.repNull(request.getParameter("tabId"));//tabҳ���idֵ
/***************��ÿ���������ˮ������������ˮ����******************/
%>

 
<html>
<head>
<script>

/**
  *�ʼ���Ϸ��ش�����
  */
function doProcessSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");

		if(retCode=="000000"){
					rdShowConfirmDialog("�ɹ���¼���������",2);
				}else{
					rdShowConfirmDialog("��¼�������ʧ�ܣ�",2);
				}
		
	  //��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *�ʼ���ϣ������ʼ���
  *
  */
function saveQcInfo(a) {
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc_t.jsp","���Ժ�...");

		//��ÿ�����÷�
    var scoreValues    = new Array();
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }
    
    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for �в� start ��ѵ����
    var tranSugg = document.getElementById("tranSugg").value;
    var testWeight = document.getElementById("testWeight").value;
    //add for �в� end
    
    
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    
    
		chkPacket.data.add("retType", a);
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
	  chkPacket.data.add("contact_id", "<%=contact_id%>");
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		//add for �в� start
		chkPacket.data.add("tranSugg", tranSugg);
		chkPacket.data.add("testWeight", testWeight);
		//add for �в� end
		
		chkPacket.data.add("totalScore", totalScore);
		chkPacket.data.add("flag", "1");
		chkPacket.data.add("isOutPlanflag", "<%=isOutPlanflag%>");

		chkPacket.data.add("staffno","<%=staffno%>");
		
	  core.ajax.sendPacket(chkPacket,doProcessSaveQcInfo,true);
		chkPacket =null;
}


/**
  *��ʱ���淵�ش�����
  */
function doProcessTempSaveQcInfo(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="tempSaveQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("��ʱ�����ʼ����ɹ���",2);
				}else{
					rdShowConfirmDialog("��ʱ�����ʼ���ʧ�ܣ�",1);
				}
		}
		//��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}


/**
  *
  *��ʱ�����ʼ���
  *
  */
function tempSaveQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
		//��ÿ�����÷�
    var scoreValues    = new Array();
    
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for �в� start ��ѵ����
    var tranSugg = document.getElementById("tranSugg").value;
    //add for �в� end
    
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_text = document.getElementById("error_level_text").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    //�ʼ�ʱ��
    var handleTime = document.getElementById("handleTime").innerHTML;
    //��ȡ¼��ʱ��
    var listenTime = document.getElementById("listenTime").innerHTML;
    //����ʱ��
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //��ʱ��
    var totalTime = document.getElementById("totalTime").innerHTML;    

		chkPacket.data.add("retType", "tempSaveQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
	
		//add for �в� start ��ѵ����
		chkPacket.data.add("tranSugg", tranSugg);
		//add for �в� end


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
		<!--����false��ʾͬ��ִ��-->
		core.ajax.sendPacket(chkPacket, doProcessTempSaveQcInfo, false);
		chkPacket =null;
}

/**
  *�������ش�����
  */
function doProcessGiveUpQcInfo(packet) {
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var content_id = packet.data.findValueByName("content_id");
		if(retType=="giveUpQcInfo"){
				if(retCode=="000000"){
					rdShowConfirmDialog("�ɹ������ʼ죡",2);
				}else{
					rdShowConfirmDialog("�����ʼ�ʧ�ܣ�",1);
				}
		}
		//��������isSaved��ֵ��Ϊtrue
		document.getElementById("isSaved").value='true';
		closeWin();
}

/**
  *
  *�����ʼ�
  *
  */
function giveUpQcInfo(){
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_save_out_plan_qc.jsp","���Ժ�...");
	//��ÿ�����÷�
    var scoreValues    = new Array();
    
    for(var i = 0; i < 10; i++){
    		scoreValues[i] = document.getElementById("score"+i).value;
    }

    //��ÿ�����id
    var itemIdObjs      = document.getElementsByName("itemId");
    var itemIdValues    = new Array();
    
    for(var i = 0; i < itemIdObjs.length; i++){
    		itemIdValues[i] = itemIdObjs[i].value;
    }

		//�����ˮ��
		var serialnum = document.getElementById("serialnum").value;
		//���ݸſ�
    var contentinsum = document.getElementById("contentinsum").value;
    //�������
    var handleinfo = document.getElementById("handleinfo").value;
    //�Ľ�����
    var improveadvice = document.getElementById("improveadvice").value;
    //�ۺ�����
    var commentinfo = document.getElementById("commentinfo").value;
    
    //add for �в� start
    var tranSugg = document.getElementById("tranSugg").value;
    //add for �в� end
    
    //���ȼ�id
    var error_level_id = document.getElementById("error_level_id").value;
    //���ȼ�
    var error_level_text = document.getElementById("error_level_text").value;
    //������id
    var error_class_ids = document.getElementById("error_class_ids").value;
    //������
    var error_class_texts = document.getElementById("error_class_texts").value;
    //����ԭ��id
    var service_class_ids = document.getElementById("service_class_ids").value;
    //����ԭ��
    var service_class_texts = document.getElementById("service_class_texts").value;
    //����ԭ��id
    var give_up_reason_ids = document.getElementById("give_up_reason_ids").value;    
    //����ԭ��
    var give_up_reason_texts = document.getElementById("give_up_reason_texts").value;
    //�ܵ÷�
    var totalScore = document.getElementById("totalScore").value;
    //�ʼ�ʱ��
    var handleTime = document.getElementById("handleTime").innerHTML;
    //��ȡ¼��ʱ��
    var listenTime = document.getElementById("listenTime").innerHTML;
    //����ʱ��
    var adjustTime = document.getElementById("adjustTime").innerHTML;     
    //��ʱ��
    var totalTime = document.getElementById("totalTime").innerHTML; 

		chkPacket.data.add("retType", "giveUpQcInfo");
		chkPacket.data.add("scores", scoreValues);
		chkPacket.data.add("itemIds", itemIdValues);
		chkPacket.data.add("serialnum", serialnum);
		chkPacket.data.add("contentinsum", contentinsum);
		chkPacket.data.add("handleinfo", handleinfo);
		chkPacket.data.add("improveadvice", improveadvice);
		chkPacket.data.add("commentinfo", commentinfo);
		
		//add for �в� start
		chkPacket.data.add("tranSugg", tranSugg);
		//add for �в� end
		
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


//ѡ�����ȼ���ı�������ܷ�
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
 *���ܣ���¼�ʼ���֪ͨ
*/
function doQcCfm(flag){
	  var totalScore = document.getElementById("totalScore").value;	
		var mypacket = new AJAXPacket("../K203/K203_appOrCfm_rpc.jsp","���ڷ����������Ժ�......");
		mypacket.data.add("belongno","");
		mypacket.data.add("type",0);
		mypacket.data.add("staffno","<%=staffno%>");
		mypacket.data.add("evterno","<%=evterno%>");
		mypacket.data.add("apptitle","��ˮ�ţ�<%=contact_id%> �����÷֣�"+totalScore);                   	
		mypacket.data.add("content","");  
		mypacket.data.add("flag",flag);  	
		core.ajax.sendPacket(mypacket,doQcCfmdoProcess,true);
		mypacket=null;     
}

//����֪ͨ�ص�����
function doQcCfmdoProcess(packet){	
		var flag = packet.data.findValueByName("flag");
		toSendMsg(flag);
}

//add by hanjc for �в� begin
//���͵����ʼ�����
function doMailCfm(){
	 var path='<%=request.getContextPath()%>/npage/callbosspage/K083/K083_mailSend.jsp?mailcontent=��鿴��ˮ�ţ�<%=contact_id%>�����ֽ��';
	 var obj = openWinMid(path,'�ʼ�����',650,850);
}
//add by hanjc for �в� end

//�����ʼ���֪ͨ����
function toSendMsg(flag){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
		mypacket.data.add("description","�ʼ���");//���ܳ���10λ
		mypacket.data.add("send_login_no","<%=evterno%>");
		mypacket.data.add("receive_login_no","<%=staffno%>");
		mypacket.data.add("cityid","");
		mypacket.data.add("content","��鿴��ˮ�ţ�<%=contact_id%>�����ֽ��");
		mypacket.data.add("msg_type",0);
		mypacket.data.add("title","�ʼ���֪ͨ");
	  mypacket.data.add("bak",flag);
	  core.ajax.sendPacket(mypacket,toSendMsgdoProcess,true);
		mypacket=null;
}

//�����ʼ���֪ͨ���ѻص�����
function toSendMsgdoProcess(packet){
		var retCode = packet.data.findValueByName("retCode");
		saveQcInfo();
}

/*-------------��ȡ¼�����ܿ�ʼ-----------------*/
function doLisenRecord(filepath,contact_id,idname){
		window.parent.top.document.getElementById("recordfile").value     = filepath;
		window.parent.top.document.getElementById("lisenContactId").value = contact_id;
		window.parent.top.document.getElementById("qcTabId").value        = '<%=tabId%>';
		window.parent.top.document.getElementById(idname).click();
}
function ListenPause(idname){
}

/**
	*��ʼ��ʱ��ȡ¼����ַ
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
  *¼����ȡ����
  *
  *id:     ��ˮID
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
		openWinMid(path,'¼����ȡ',650,850);
}

/*--------------��ȡ¼�����ܽ���----------------*/

/*----------------������ʱ��ʼ--------------*/

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
/*----------------������ʱ����--------------*/

/*--------------��ʱ����ʼ----------------*/
window.onload=function(){
		setTimer();
		
}
var scan = "";
function setTimer(){
		scan = setInterval("timer()",1000);
}

//�����ʼ�ʱ��
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

/*----------------��ʱ������--------------*/

//���д򿪴���
function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//�رյ�ǰ����
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

/*---------------��ȡ¼����ťstyle��ʼ-------*/
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

/*---------------��ȡ¼����ťstyle����------------*/

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
    ������Ŀ &nbsp;����÷ֺϼ� &nbsp;
  	<input type="text" disabled id="subScore" size="6" value=""/> &nbsp;
  </div>
  <table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="2px" cellspacing="0">
	  <tr>
	    <td>���</td>
	    <td>����</td>
	    <td>��ͷ�</td>
	    <td>��߷� </td>
	    <td>�÷�</td>
	    <td>�����ȼ�</td>    
	  </tr>

<tr>
<td class='Blue' width='30px'>0</td>
<td class='Blue'>
ʹ�ñ�׼��ӭ��(2��)
<input type='hidden' name='itemId' value='0101'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score0' id='score0' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel0' id='itemlevel0' onchange='changeScore(0);'>

	    
	    
	    <option value="2">2->ʹ�ñ�׼��ӭ��</option><option value="0">0->ʹ�ñ�׼��ӭ��</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>1</td>
<td class='Blue'>
ʹ�ñ�׼������(2��)
<input type='hidden' name='itemId' value='0102'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score1' id='score1' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel1' id='itemlevel1' onchange='changeScore(1);'>

	    
	    
	    <option value="2">2->ʹ�ñ�׼������</option><option value="0">0->ʹ�ñ�׼������</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>2</td>
<td class='Blue'>
ǡ��������ò����(2��)
<input type='hidden' name='itemId' value='0103'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>2</td>
<td class='Blue' width='10px'><input type='text' name='score2' id='score2' size='6' maxlength='6' onblur='sumScore();' value='2' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel2' id='itemlevel2' onchange='changeScore(2);'>

	    
	    
	    <option value="2">2->ǡ��������ò����</option><option value="0">0->ǡ��������ò����</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>3</td>
<td class='Blue'>
ʹ�ý���������û�(5��)
<input type='hidden' name='itemId' value='0104'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score3' id='score3' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel3' id='itemlevel3' onchange='changeScore(3);'>

	    
	    
	    <option value="5">5->ʹ�ý���������û�</option><option value="0">0->ʹ�ý���������û�</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>4</td>
<td class='Blue'>
������������(3��)
<input type='hidden' name='itemId' value='0105'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>3</td>
<td class='Blue' width='10px'><input type='text' name='score4' id='score4' size='6' maxlength='6' onblur='sumScore();' value='3' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel4' id='itemlevel4' onchange='changeScore(4);'>

	    
	    
	    <option value="3">3->������������</option><option value="0">0->������������</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>5</td>
<td class='Blue'>
������(5��)
<input type='hidden' name='itemId' value='0106'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score5' id='score5' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel5' id='itemlevel5' onchange='changeScore(5);'>

	    
	    
	    <option value="5">5->������</option><option value="0">0->������</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>6</td>
<td class='Blue'>
���Ľ��(10��)
<input type='hidden' name='itemId' value='0107'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>10</td>
<td class='Blue' width='10px'><input type='text' name='score6' id='score6' size='6' maxlength='6' onblur='sumScore();' value='10' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel6' id='itemlevel6' onchange='changeScore(6);'>

	    
	    
	    <option value="10">10->���Ľ��</option><option value="0">0->���Ľ��</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>7</td>
<td class='Blue'>
���ÿͻ�(5��)
<input type='hidden' name='itemId' value='0108'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>5</td>
<td class='Blue' width='10px'><input type='text' name='score7' id='score7' size='6' maxlength='6' onblur='sumScore();' value='5' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel7' id='itemlevel7' onchange='changeScore(7);'>

	    
	    
	    <option value="5">5->���ÿͻ�</option><option value="0">0->���ÿͻ�</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>8</td>
<td class='Blue'>
�ʵ��Ļ�Ӧ(3��)
<input type='hidden' name='itemId' value='0109'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>3</td>
<td class='Blue' width='10px'><input type='text' name='score8' id='score8' size='6' maxlength='6' onblur='sumScore();' value='3' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel8' id='itemlevel8' onchange='changeScore(8);'>

	    
	    
	    <option value="3">3->�ʵ��Ļ�Ӧ</option><option value="0">0->�ʵ��Ļ�Ӧ</option>
</select>
</td>
</tr>
<tr>
<td class='Blue' width='30px'>9</td>
<td class='Blue'>
����̬�Ȳ��Ͻ�(4��)
<input type='hidden' name='itemId' value='0110'/>
</td>
<td class='Blue' width='40px'>0</td>
<td class='Blue' width='40px'>4</td>
<td class='Blue' width='10px'><input type='text' name='score9' id='score9' size='6' maxlength='6' onblur='sumScore();' value='4' onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
<td class='Blue' width='50px'>
<select style='width:100px;' name='itemlevel9' id='itemlevel9' onchange='changeScore(9);'>

	    
	    
	    <option value="4">4->����̬�Ȳ��Ͻ�</option><option value="0">0->����̬�Ȳ��Ͻ�</option>
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
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">1 ���ݸſ�</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 �������</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">3 �Ľ�����</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">4 �ۺ�����</li>
					<!--add for �в� start-->
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">5 ��ѵ����</li>
					<!--add for �в� finished-->
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
			<!--add for �в� start-->
			<div class="undis" id="tbc_05">
				<textarea id="tranSugg" cols="70" rows="3"></textarea>
			</div>
			<!--add for �в� finished-->
		</div>

		</td>
	</tr>
	</table>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer" width="100%">
        <div id="callSearch">
        <!--add for �в� start-->
        Ȩ�أ�<input type="text" name="testWeight" id="testWeight" size="6" value="" />&nbsp;
        <!--add for �в� end-->
				�ܷ֣�<input type="text" name="totalScore" id="totalScore" size="6" value="" readonly/>
				<!--<input name="confirm" onClick="tempSaveQcInfo();finishedTimer();" type="button" class="b_foot" value="��ʱ����">-->
				<input name="confirm" onClick="checkIsSendTip('1');finishedTimer();" type="button" class="b_foot" value="�ʼ����">
				<input name="confirm" onClick="checkIsSendTip('0');finishedTimer();" type="button" class="b_foot" value="��ʱ����">
				<!--<input name="confirm" onClick="rdShowMessageDialog('��Ϊ������',1);finishedTimer();" type="button" class="b_foot" value="��Ϊ����">-->
				<!--<input name="confirm" onClick="show_select_give_up_reason_win()" type="button" class="b_foot_long" value="����">-->
				<!--	<input name="back" onClick="grpClose();" type="button" class="b_foot" value="ȡ��">-->
      </div>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			
			<td align="left" width="15%">����ʱ����</td>     <td  width="15%" align="left" id="handleTime">0</td>
			<td align="left"  width="15%">��ʱ����</td>       <td align="left"   id="totalTime">0</td>
		</tr>	
	</table>	
	
	<!--������isSavedΪfalse ��ʾ��ǰ���δ�����κα��������������������-->
	<input type='hidden' name='isSaved' id='isSaved' value='false'>
	<!--������isSaved����------------->
	<!--������isClosedΪfalse ���ڿ��ƹر�tabҳ����ֻ�ɵ���һ��-->
	<input type='hidden' name='isClosed' id='isClosed' value='false'>
	<!--������isClosed����------------->
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
  *������¼���ʧȥ����󣬼��㵱ǰ�÷�
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
		//modify for �в� ��4��Ϊ5
		for(var i=1;i<=5;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
}

function ccc(){
		if(rdShowConfirmDialog("�Ƿ�ȷ���ύ��")){
		}
}

/**
  *����ѡ�����ԭ��Ĵ���
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
  *����ѡ����ȼ��Ĵ���
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
  *����ѡ�������Ĵ���
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
  *����ѡ������ԭ��Ĵ���
  */
function show_select_service_class_win(){
		
}

//ȥ��ո�;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}

//ȥ�ҿո�;
function rtrim(s){
		return s.replace( /\s*$/, "");
}

//ȥ���ҿո�;
function trim(s){
		return rtrim(ltrim(s));
}
sumScore();

</script>
