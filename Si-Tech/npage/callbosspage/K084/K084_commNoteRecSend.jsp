<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%

try{
  /*
   * 功能: 一般通知接收、发送
　 * 版本: 1.0
　 * 日期: 2008/11/1
　 * 作者: hanjc
　 * 版权: sitech
   *
 　*/
 %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
	String send_login_no = (String)session.getAttribute("workNo");
	String messageNotice = request.getParameter("messageNotice") == null ? "" : request.getParameter("messageNotice");
	String sendWork = request.getParameter("sendWork") == null ? "" : request.getParameter("sendWork");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String opCode="K084";
	String opName="一般通知发送";
	String orgCode = (String)session.getAttribute("orgCode");
	String sqlStr = null;
	String myParams = null;
	String[][] dataRows = new String[][]{};
	
	if(!"".equals(sendWork)){
		sqlStr = "select t.boss_login_no, to_char(sysdate,'hh24:mi:ss')"
								+ "  from dloginmsgrelation t"
							  + " where trim(t.kf_login_no)=:sendWork";
  	myParams = "sendWork=" + sendWork;
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
 	 <wtc:param value="<%=sqlStr%>" />
 	 <wtc:param value="<%=myParams%>"/>
 </wtc:service>
 <wtc:array id="queryList" start="0" length="2" scope="end"/>
<%
	dataRows = queryList;
}%>

<html>
<head>
<title>一般通知发送</title>
<script language=javascript>
	$(document).ready(function()
	{
		$("td").not("[input]").addClass("blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");
		$("input:text[@v_type]").blur(checkElement2);

		$("a").hover(function() {
			$(this).css("color", "orange");
		}, function() {
			$(this).css("color", "blue");
		});

		if("<%=sendWork%>" != "" && "<%=messageNotice%>" != ""){
			setContent("<%=dataRows[0][1]%>","<%=dataRows[0][0]%>","<%=messageNotice%>",2);
		}
		$("#content").focus();
	});

	function checkElement2() {
		checkElement(this);
	}

	//=========================================================================
	// SUBMIT INPUTS TO THE SERVELET
	//=========================================================================

	/*
	@function:检查boss工号是否在线
	@flag = 1,表示需要发送通知,否则只检验工号是否在线
	*/
	function checkLoginStatus(flag){
		var temp=document.sitechform.receive_login_no.value;
		if( temp == ""){
			return;
		}
		var swap=temp.split(',');
		if(swap.length<5){
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_checkLoginStatus_rpc.jsp","正在校验对方状态，请稍候......");
			mypacket.data.add("receive_login_no",document.sitechform.receive_login_no.value);
			core.ajax.sendPacket(mypacket,function(packet){
				var counts = packet.data.findValueByName("counts");
				var loginExists = packet.data.findValueByName("loginExist");
				var temp=document.sitechform.receive_login_no.value;
				var loginbossno=loginExists.split(",");
				var logintemp=temp.split(",");
				if(loginbossno.length < logintemp.length){
					rdShowMessageDialog("提醒：工号不存在！");
					document.sitechform.receive_login_no.value ="";
					return;
				}
				if(parseInt(counts)<logintemp.length){
					rdShowMessageDialog("提醒：对方目前不在线！");
					return;
				}else{
					if(flag && flag == 1)
						toSendMsg(loginbossno);
				}
			},true);
			mypacket=null;
		}
	}

	/*comment by hucw,20110309
		var loginExist =null; //不存在时返回0;工号存在时，此值表示平台工号^boss工号的结构
	*/
	
	
	//响应发送按钮按钮
	function sendMsg() {
		var content = document.sitechform.content.value;
		var receive_no = document.sitechform.receive_login_no.value;
		if(checkInput(content,receive_no)){
			document.sitechform.content.value=content;
			checkLoginStatus(1);
			$("#content").focus();
		}
	}

	//响应回车发送事件,直接调用sendMsg()函数
	function enterSend(e) {
		if(event.keyCode==13){
			event.returnValue = false;
			sendMsg();
		}
		return;
	}

	/*
	@author/date:hucw 20110309
	@function:通知发送的基本校验;
	@content:发送内容
	@receive_no:接收boss工号
	@return:成功返回true
	*/
	function checkInput(content,receive_no){
		if(trim(content) == ""){
			rdShowMessageDialog("发送内容不能为空！");
			return false;
		}else if(trim(receive_no) == ""){
			rdShowMessageDialog("接收工号不能为空！");
			return false;
		}else if(getLen(trim(content))>400){
			rdShowMessageDialog('通知内容最大不能超过200个汉字,或者400个字符！');
			return false;
		}
		return true;
	}
	
	/*
	@function:替换特殊字符
	*/
	function encodeMsg(){
		var content = trim(document.getElementById('content').value);
		content = content.replace(/\+/g,"%2B");
		content = content.replace(/\^/g,"");//20090729 add 替换掉^号，因为^是服务的分隔符
		content = content.replace(/\r\n/g,"");//20090729 add 替换回车和换行
		return content;
	}

	/*
	@PlatAndBossNoArr,数组,元素类型: 平台工号^boss工号
	*/
	function toSendMsg(PlatAndBossNoArr) {
		var content=encodeMsg();
		//updated by tangsong 20110112 发送通知窗口都从主页面打开，否则父页面关闭后发通知会出错
		/*
		var ret;
		var w = window.top;
		while(w){
		if(w.document.title=='黑龙江移动综合客户服务系统'){
		ret=w.cCcommonTool.sendNotify(reciveAgentNo,content);
		break;
		} else {
		w=w.opener.top;
		}
		}*/
		var ret=null;
		var bossAndPlatNo=null;	//接收人工号数据, platNo^bossNo(平台工号^boss工号)
		var winMain =null;
		for(var i=0;i<PlatAndBossNoArr.length;i++){
			bossAndPlatNo = PlatAndBossNoArr[i].split("^");
			if(bossAndPlatNo.length != 2)
				return;
				
			if(window.opener.cCcommonTool != null && window.opener.cCcommonTool != 'undefined'){
			winMain = window.opener;//,媒体发送的通知发送
		  }else{
			winMain = window.top.opener.top.opener;//更多里的内部求助的通知发送
		  }
			ret = winMain.cCcommonTool.sendNotify(bossAndPlatNo[0],content);
			
			//end. tangsong 20110112
			if(ret==0){
				var now = "";
				var date = new Date();
				var hour=date.getHours()>9?date.getHours():("0"+date.getHours());
				var minute=date.getMinutes()>9?date.getMinutes():("0"+date.getMinutes());
				var second=date.getSeconds()>9?date.getSeconds():("0"+date.getSeconds());
				var strftime = hour+":"+minute+":"+second;
 
				setContent(strftime,bossAndPlatNo[1],content,1);
				$('#content').val("");

				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","正在发送通知，请稍候......");
				mypacket.data.add("description","");
				mypacket.data.add("send_login_no","<%=send_login_no%>");
				mypacket.data.add("receive_login_no",$('#receive_login_no').val());
				mypacket.data.add("cityid","");
				mypacket.data.add("content",content);
				mypacket.data.add("msg_type","0");
				mypacket.data.add("title","");
				mypacket.data.add("bak",'Y');
				core.ajax.sendPacket(mypacket,function(){},true);
				mypacket=null;
			} else {
				ret = winMain.similarMSNPop("<font color='red'>发送失败</font>");
			}
		}
	}

	function setContentVal(messageNotice,sendWork){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_scan_rpc.jsp","信息查询中...");
		mypacket.data.add("sendWork",sendWork);
		core.ajax.sendPacket(mypacket,function(packet){
			var bossNo = packet.data.findValueByName("boss_login_no");
			var curDate = packet.data.findValueByName("sysdate");
			setContent(curDate,bossNo,messageNotice,2);
		},true);
		mypacket = null;
	}

	/*
	@author/date:hucw 20110309
	@function:设置通知信息到显示框
	@strftime,格式化的时间数据
	@bossNo,接收人boss工号
	@content,内容数据
	@flag,1表示发送,2表示接收
	*/
	function setContent(strftime,bossNo,content,flag) {
		var tempContent = null;
		if(flag == 1){
			tempContent = "【"+ strftime + " 我→" + bossNo + "】:" + trim(content.replace(/%2B/g,"+"));
		}else if(flag == 2){
			tempContent = "【" + strftime + " " + bossNo + "→我】:" + trim(content.replace(/%2B/g,"+"));
		}
		var val = $('#rec_content').val();
		$('#rec_content').val(val + tempContent + "\n");
		$('#rec_content').attr("scrollTop",$('#rec_content').attr("scrollHeight"));
	}

	function keepContentVal(){
		var msgContent=document.getElementById("content").value;
		window.opener.document.getElementById("msgContent").value=msgContent;
	}

	function showHisContent(){
		openWinMid("K084_hisContent.jsp",'历史记录',650,850);
	}

	//居中打开窗口
	function openWinMid(url,name,iHeight,iWidth)
	{
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}


	function checkcontent(){
		window.sitechform.receive_login_no.value=window.sitechform.receive_login_no.value.replace(/[^\d|^,]/g,'');
	}


	/**判断短信的长度。
	*一个字母数字等表示一个长度
	*一个汉字表示两个长度
	*/
	function getLen(str) {
		var len=0;
		if(str != null && str.length>0){
			for(var i=0;i<str.length;i++){
				char = str.charCodeAt(i);
				if(!(char>255)) {
					len = len + 1;
				} else {
					len = len + 2;
				}
			}
		}
		return len;
	}

	//去左右空格;
	function trim(s){
		return s.replace(/^\s*|\s*$/,"");
	}

	//居中打开窗口
	function openWinMid(url,name,iHeight,iWidth)
	{
		var iTop = (window.screen.availHeight-20-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-5-iWidth)/2; //获得窗口的水平位置;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}

	function getLoginNo(){
		var width = 400,height = 300;
		var feather = 'width='+width+'px,height='
		+height+'px,top='+((screen.availHeight-width)/2)
		+',left= '+((screen.availWidth-height)/2)+',';

		openWinMid('k084_getLoginNo.jsp','查询工号',180,360);
	}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body onunload="opener.showMsg_temp=''">
<form id="sitechform" name="sitechform">
  <%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title" style="color:#366FA9;">工号 &nbsp;
			<input type="text" id="receive_login_no" name="receive_login_no" value="<%=dataRows[0][0]%>" onBlur="checkLoginStatus();" onkeyup="checkcontent();" />   <input class="b_foot" type="button" onclick="getLoginNo();" value="查询工号"/>
		</div>
		<div class="title" style="color:#366FA9;">通知内容</div>
    <table cellspacing="0" cellpadding="0">
    	<tr>
	    	<td>
	    	 <textarea name="rec_content" id="rec_content" readonly="true" rows="12" style="width:100%" ></textArea>
	    	</td>
      </tr>
		</table>

    <div class="title" style="color:#366FA9;">发送内容</div>
    <table cellspacing="0" cellpadding="0">
    	<tr>
	    	<td>
	    	 <textarea name="content" id="content" rows="6" style="width:100%" onkeydown="if(event.keyCode==13)enterSend();" title='最大允许200个汉字或400个字符'></textArea>
	    	</td>
      </tr>
		</table>

		<p align="right" id="footer">
			<input name="send" type="button"  id="send" value=">>发送" onClick="sendMsg()">
			<input name="send" type="button"  id="" value="<<关闭" onClick="window.close()">
      <input name="send" type="button"  id="" value="历史记录" onClick="showHisContent()">
		</p>
 		<input type="hidden" id="msgContent" name="msgContent" value=""/>
	</div>
</form>
</body>
</html>

<%

}catch(Exception e) {
	e.printStackTrace();
}
%>