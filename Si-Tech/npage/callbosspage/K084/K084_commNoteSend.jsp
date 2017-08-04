<%
  /*
   * 功能: 一般通知发送
　 * 版本: 1.0
　 * 日期: 2008/11/1
　 * 作者: hanjc
　 * 版权: sitech
   * update:fangyuan 20090825 吉林本地化改造 
 　*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode            = "K084";
    String opName            = "一般通知发送";
	  String orgCode           = (String)session.getAttribute("orgCode");
	  String action            = (String)request.getParameter("myaction");
	  String isFirstIn         = (String)request.getParameter("isFirstIn");//是否是第一次进入。N：否，Y：是
	  String description       = "";
	  //modify wangyong 20090928 修改客服工号
	  //String send_login_no     = (String)session.getAttribute("kfWorkNo");
	  String send_login_no     = (String)session.getAttribute("workNo");
	  String cityid            = "";
	  String msg_type          = "0";//消息类型：0为一般通知，1为请求通知
	  String title             = "";
%>

<html>
<head>
<title>一般通知发送</title>
<script language=javascript>
	$(document).ready(function(){
		$("td").not("[input]").addClass("blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");
		$("input:text[@v_type]").blur(checkElement2);
		$("a").hover(function() {
			$(this).css("color", "orange");
		}, function() {
			$(this).css("color", "blue");
		});	
		scanHisMsg();
		//主动触发input.blur
		var sendtoNO =document.getElementById('receive_login_no').value;
		if(sendtoNO!=""){
			document.getElementById('receive_login_no').onblur();
		}
		sendtoNO=null;
	});

	function checkElement2() {
		checkElement(this);
	}

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
	
	/*
	var loginExist =null; //不存在时返回0;工号存在时，此值表示平台工号
	
	function checkLoginStatusdoProcess(packet){
		var counts = packet.data.findValueByName("counts");
		loginExist = packet.data.findValueByName("loginExist");

		if(parseInt(loginExist)<1){
			rdShowMessageDialog("提醒：此工号不存在！");
			document.getElementById('receive_login_no').value ="";
			return;
		}
		if(parseInt(counts)<1){
			rdShowMessageDialog("提醒：对方目前不在线！");
			document.getElementById("content").focus();
			return;
		}
	}
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

	function encodeMsg(){
		var content = trim(document.getElementById('content').value);
		content = content.replace(/\^/g,"");//替换掉^号，因为^是服务的分隔符
		content = content.replace(/\r\n/g,"");//替换回车和换行
		content = content.replace(/\+/g,"%2B");//编码+号
		return content;
	}

	function setContentVal2(rec_content){
		rec_content = rec_content.replace(/\%2B/g,"+");
		document.getElementById('rec_content').value=rec_content.replace(/\<br\>/g,'\r');
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
		var winMain = window.top;

		for(var i=0;i<PlatAndBossNoArr.length;i++){
			bossAndPlatNo = PlatAndBossNoArr[i].split("^");
			if(bossAndPlatNo.length != 2)
				return;			
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
				ret= winMain.similarMSNPop("<font color='red'>发送失败</font>");
			}
		}
	}


/*
	//通知发送
	function toSendMsg(){
		//取得要发送的工号
		//var reciveAgentNo=document.getElementById('receive_login_no').value;
		var reciveAgentNo=loginExist;
		var ret;
		var contentMsg=encodeMsg();//jsp正则自动转换特殊字符libin
		var content = trim(document.getElementById('content').value);//控件所需参数无需转换字符libin
		// 修改山西繁冗代码 by fangyuan 20090825

		//modify by hucw,20100613,获取到首页面,然后弹出窗口
		if(window.opener==undefined){
			ret=window.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}else if(window.opener.top.opener==undefined){
			ret=window.opener.opener.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}else{
			ret=window.opener.top.opener.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}
		if(ret==0){
			document.getElementById('content').value="";
			//updated by tangsong 20100902 去掉繁琐的提示
	
			// 修改 by fangyuan 20090825
			//if(window.opener==undefined){
			//ret=window.top.similarMSNPop("发送成功");
			//}else if(window.opener.top.opener==undefined){
			//ret=window.opener.opener.top.similarMSNPop("发送成功");
			//}else{
			//ret=window.opener.top.opener.top.similarMSNPop("发送成功");
			//}

			
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","正在发送通知，请稍候......");
			mypacket.data.add("description",document.getElementById('description').value);
			mypacket.data.add("send_login_no",document.getElementById('send_login_no').value);
			mypacket.data.add("receive_login_no",document.getElementById('receive_login_no').value);
			mypacket.data.add("cityid",document.getElementById('cityid').value);
			mypacket.data.add("content",contentMsg);
			mypacket.data.add("msg_type",<%=msg_type%>);
			mypacket.data.add("title",document.getElementById('title').value);
			mypacket.data.add("bak",'Y');
			core.ajax.sendPacket(mypacket,doProcess,true);
			mypacket=null;

		}else{
			//modify by hucw,20100613
			if(window.opener==undefined){
				ret=window.top.similarMSNPop("发送失败");
			}else if(window.opener.top.opener==undefined){
				ret=window.opener.opener.top.similarMSNPop("发送失败");
			}else{
				ret=window.opener.top.opener.top.similarMSNPop("发送失败");
			}
		}
	}



	function doProcess(packet){
		scanHisMsg();
	}
	*/
	
	//提取发送历史
	function scanHisMsg(){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_history_rpc.jsp","正在加载发送历史记录，请稍候......");
		core.ajax.sendPacket(mypacket,showHisMsg,true);
		mypacket=null;
	}

	//显示新通知
	function showHisMsg(packet){
		var contentList = packet.data.findValueByName("contentList");
		var contents = contentList.split(",");
		var content = null;
		var msg = "";
		if(contents.length > 0){
			for(var i = 0;i<contents.length;i++){
				content = contents[i].split("^");
				if(content.length !=3){
					continue;
				}
				msg += (setContent(content[1],content[0],content[2],3) + "\n");
			}
		}
		//document.getElementById("rec_content").value = contentList;
		//by fangyuan 20090831
		var taContent = document.getElementById("rec_content");
		$(taContent).val(msg);
		// 必须赋值两次,才可以达到效果,待优化
		taContent.scrollTop = taContent.scrollHeight;
		taContent.scrollTop = taContent.scrollHeight;
		taContent = null;
	}
	
	
	/*
	@author/date:hucw 20110309
	@function:设置通知信息到显示框
	@strftime,格式化的时间数据
	@bossNo,接收人boss工号
	@content,内容数据
	@flag,1表示发送,2表示接收,3当日历史查询
	*/
	function setContent(strftime,bossNo,content,flag) {
		var tempContent = null;
		if(flag == 1){
			tempContent = "【"+ strftime + " 我→" + bossNo + "】:" + trim(content.replace(/%2B/g,"+"));
		}else if(flag == 2){
			tempContent = "【" + strftime + " " + bossNo + "→我】:" + trim(content.replace(/%2B/g,"+"));
		}else if(flag == 3){
			tempContent = "【"+ strftime + " 我→" + bossNo + "】:" + trim(content.replace(/%2B/g,"+"));
			return tempContent;
		}
		var val = $('#rec_content').val();
		$('#rec_content').val(val + tempContent + "\n");
		$('#rec_content').attr("scrollTop",$('#rec_content').attr("scrollHeight"));
	}
	
	
	function openWinMid(url,name,iHeight,iWidth)
	{
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=yes, resizable=no,location=no, status=yes');
	}


	function getAllMember(class_id){
		if(class_id=="top"){
			return false;
		}
		if(class_id==""){
			if(rdShowConfirmDialog("你选择了所有群组,可能会使系统变慢,你确定吗?")=="1"){
				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_getGroupMember_rpc.jsp","正在发送通知，请稍候......");
				mypacket.data.add("class_id",class_id);
				core.ajax.sendPacket(mypacket,ListMember,true);
				mypacket=null;
			}
		}else{
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_getGroupMember_rpc.jsp","正在发送通知，请稍候......");
			mypacket.data.add("class_id",class_id);
			core.ajax.sendPacket(mypacket,ListMember,true);
			mypacket=null;
		}
	}

	function ListMember(packet){
		var retCode = packet.data.findValueByName("retCode");
		var memberList = packet.data.findValueByName("memberList");
		if(retCode!="000000"){
			rdShowMessageDialog("无法获取当前的班组成员，请稍候再试！");
		}else{
			document.getElementById('receive_login_no').value = memberList;
		}
	}

	/**
	*弹出窗口
	*/
	function editGroupMember(){
		openWinMid('K084_edit_group.jsp','修改班组成员', '360','650');
	}

	function checkcontent(){
	}


	function showHisContent(){
		openWinMid("K084_hisContent.jsp",'历史记录详情',650,850);
	}


	/**
	*判断短信的长度。
	*一个字母数字等表示一个长度
	*一个汉字表示两个长度
	*/
	function getLen(str){
		var len=0;
		if(str != null && str.length>0){
			for(var i=0;i<str.length;i++){
				char = str.charCodeAt(i);
				if(!(char>255)){
					len = len + 1;
				}else{
					len = len + 2;
				}
			}
		}
		return len;
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

</head>
<%
//by libin 2009-05-09 内部呼叫点击工号转到通知发送，带过来工号
String loginno_call = request.getParameter("loginno_call")==null?"":request.getParameter("loginno_call");
%>
<body >
<form id=sitechform name=sitechform>
  <%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<!--updated by tangsong 20100819 修改了字体颜色，原样式下看不清标题 -->
		<div class="title" style="color:#366FA9;">工号 &nbsp;<input id="receive_login_no" name="receive_login_no" type="text" value="<%=loginno_call%>"  onBlur="checkLoginStatus();" onkeyup="checkcontent();">				<input class="b_foot" type="button" onclick="getLoginNo();" value="查询工号"/>
		</div>
		<div class="title" style="color:#366FA9;">最近发送记录</div>
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="rec_content" id="rec_content" readonly="true" rows="6" cols="70">
   	 	
    	 	</textArea>
    	</td>
      </tr>
		</table>
		
		<div class="title" style="color:#366FA9;">发送内容</div>
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="content" id="content" rows="6" cols="70" style="width:508px" onkeydown="if(event.keyCode==13)enterSend();"   title='最大允许200个汉字或400个字符'></textArea>
    	</td>
      </tr>
		</table>
		
		<p align="right" id="footer">
			<input name="as" type="button"  id="sednd" value=">>关闭" onclick="window.close()">
			<input name="send" type="button"  id="send" value=">>发送" onClick="sendMsg()">
          <input name="send" type="button"  id="" value="历史记录" onClick="showHisContent()">			
			<hr>
		</p>

<input type="hidden" id="description" name="description" value="<%=description%>"/>  
<input type="hidden" id="send_login_no" name="send_login_no" value="<%=send_login_no%>"/>  
<input type="hidden" id="cityid" name="cityid" value="<%=cityid%>"/>  
<input type="hidden" id="msg_type" name="msg_type" value="<%=msg_type%>"/>   
<input type="hidden" id="title" name="title" value="<%=title%>"/>
	</div>                              
</div>
</form>
</body>
</html>

