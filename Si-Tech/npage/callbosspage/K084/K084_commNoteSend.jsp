<%
  /*
   * ����: һ��֪ͨ����
�� * �汾: 1.0
�� * ����: 2008/11/1
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:fangyuan 20090825 ���ֱ��ػ����� 
 ��*/
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode            = "K084";
    String opName            = "һ��֪ͨ����";
	  String orgCode           = (String)session.getAttribute("orgCode");
	  String action            = (String)request.getParameter("myaction");
	  String isFirstIn         = (String)request.getParameter("isFirstIn");//�Ƿ��ǵ�һ�ν��롣N����Y����
	  String description       = "";
	  //modify wangyong 20090928 �޸Ŀͷ�����
	  //String send_login_no     = (String)session.getAttribute("kfWorkNo");
	  String send_login_no     = (String)session.getAttribute("workNo");
	  String cityid            = "";
	  String msg_type          = "0";//��Ϣ���ͣ�0Ϊһ��֪ͨ��1Ϊ����֪ͨ
	  String title             = "";
%>

<html>
<head>
<title>һ��֪ͨ����</title>
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
		//��������input.blur
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
	@function:���boss�����Ƿ�����
	@flag = 1,��ʾ��Ҫ����֪ͨ,����ֻ���鹤���Ƿ�����
	*/
	function checkLoginStatus(flag){
		var temp=document.sitechform.receive_login_no.value;
		if( temp == ""){
			return;
		}
		var swap=temp.split(',');
		if(swap.length<5){
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_checkLoginStatus_rpc.jsp","����У��Է�״̬�����Ժ�......");
			mypacket.data.add("receive_login_no",document.sitechform.receive_login_no.value);
			core.ajax.sendPacket(mypacket,function(packet){
				var counts = packet.data.findValueByName("counts");
				var loginExists = packet.data.findValueByName("loginExist");
				var temp=document.sitechform.receive_login_no.value;
				var loginbossno=loginExists.split(",");
				var logintemp=temp.split(",");
				if(loginbossno.length < logintemp.length){
					rdShowMessageDialog("���ѣ����Ų����ڣ�");
					document.sitechform.receive_login_no.value ="";
					return;
				}
				if(parseInt(counts)<logintemp.length){
					rdShowMessageDialog("���ѣ��Է�Ŀǰ�����ߣ�");
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
	var loginExist =null; //������ʱ����0;���Ŵ���ʱ����ֵ��ʾƽ̨����
	
	function checkLoginStatusdoProcess(packet){
		var counts = packet.data.findValueByName("counts");
		loginExist = packet.data.findValueByName("loginExist");

		if(parseInt(loginExist)<1){
			rdShowMessageDialog("���ѣ��˹��Ų����ڣ�");
			document.getElementById('receive_login_no').value ="";
			return;
		}
		if(parseInt(counts)<1){
			rdShowMessageDialog("���ѣ��Է�Ŀǰ�����ߣ�");
			document.getElementById("content").focus();
			return;
		}
	}
	*/
	
	//��Ӧ���Ͱ�ť��ť
	function sendMsg() {
		var content = document.sitechform.content.value;
		var receive_no = document.sitechform.receive_login_no.value;
		if(checkInput(content,receive_no)){
			document.sitechform.content.value=content;
			checkLoginStatus(1);
			$("#content").focus();
		}
	}

	//��Ӧ�س������¼�,ֱ�ӵ���sendMsg()����
	function enterSend(e) {
		if(event.keyCode==13){
			event.returnValue = false;
			sendMsg();
		}
		return;
	}

	/*
	@author/date:hucw 20110309
	@function:֪ͨ���͵Ļ���У��;
	@content:��������
	@receive_no:����boss����
	@return:�ɹ�����true
	*/
	function checkInput(content,receive_no){
		if(trim(content) == ""){
			rdShowMessageDialog("�������ݲ���Ϊ�գ�");
			return false;
		}else if(trim(receive_no) == ""){
			rdShowMessageDialog("���չ��Ų���Ϊ�գ�");
			return false;
		}else if(getLen(trim(content))>400){
			rdShowMessageDialog('֪ͨ��������ܳ���200������,����400���ַ���');
			return false;
		}
		return true;
	}

	function encodeMsg(){
		var content = trim(document.getElementById('content').value);
		content = content.replace(/\^/g,"");//�滻��^�ţ���Ϊ^�Ƿ���ķָ���
		content = content.replace(/\r\n/g,"");//�滻�س��ͻ���
		content = content.replace(/\+/g,"%2B");//����+��
		return content;
	}

	function setContentVal2(rec_content){
		rec_content = rec_content.replace(/\%2B/g,"+");
		document.getElementById('rec_content').value=rec_content.replace(/\<br\>/g,'\r');
	}


/*
	@PlatAndBossNoArr,����,Ԫ������: ƽ̨����^boss����
	*/
	function toSendMsg(PlatAndBossNoArr) {
		var content=encodeMsg();
		//updated by tangsong 20110112 ����֪ͨ���ڶ�����ҳ��򿪣�����ҳ��رպ�֪ͨ�����
		/*
		var ret;
		var w = window.top;
		while(w){
		if(w.document.title=='�������ƶ��ۺϿͻ�����ϵͳ'){
		ret=w.cCcommonTool.sendNotify(reciveAgentNo,content);
		break;
		} else {
		w=w.opener.top;
		}
		}*/
		var ret=null;
		var bossAndPlatNo=null;	//�����˹�������, platNo^bossNo(ƽ̨����^boss����)
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

				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
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
				ret= winMain.similarMSNPop("<font color='red'>����ʧ��</font>");
			}
		}
	}


/*
	//֪ͨ����
	function toSendMsg(){
		//ȡ��Ҫ���͵Ĺ���
		//var reciveAgentNo=document.getElementById('receive_login_no').value;
		var reciveAgentNo=loginExist;
		var ret;
		var contentMsg=encodeMsg();//jsp�����Զ�ת�������ַ�libin
		var content = trim(document.getElementById('content').value);//�ؼ������������ת���ַ�libin
		// �޸�ɽ�����ߴ��� by fangyuan 20090825

		//modify by hucw,20100613,��ȡ����ҳ��,Ȼ�󵯳�����
		if(window.opener==undefined){
			ret=window.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}else if(window.opener.top.opener==undefined){
			ret=window.opener.opener.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}else{
			ret=window.opener.top.opener.top.cCcommonTool.sendNotify(reciveAgentNo,content);
		}
		if(ret==0){
			document.getElementById('content').value="";
			//updated by tangsong 20100902 ȥ����������ʾ
	
			// �޸� by fangyuan 20090825
			//if(window.opener==undefined){
			//ret=window.top.similarMSNPop("���ͳɹ�");
			//}else if(window.opener.top.opener==undefined){
			//ret=window.opener.opener.top.similarMSNPop("���ͳɹ�");
			//}else{
			//ret=window.opener.top.opener.top.similarMSNPop("���ͳɹ�");
			//}

			
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_note_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
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
				ret=window.top.similarMSNPop("����ʧ��");
			}else if(window.opener.top.opener==undefined){
				ret=window.opener.opener.top.similarMSNPop("����ʧ��");
			}else{
				ret=window.opener.top.opener.top.similarMSNPop("����ʧ��");
			}
		}
	}



	function doProcess(packet){
		scanHisMsg();
	}
	*/
	
	//��ȡ������ʷ
	function scanHisMsg(){
		var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_history_rpc.jsp","���ڼ��ط�����ʷ��¼�����Ժ�......");
		core.ajax.sendPacket(mypacket,showHisMsg,true);
		mypacket=null;
	}

	//��ʾ��֪ͨ
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
		// ���븳ֵ����,�ſ��ԴﵽЧ��,���Ż�
		taContent.scrollTop = taContent.scrollHeight;
		taContent.scrollTop = taContent.scrollHeight;
		taContent = null;
	}
	
	
	/*
	@author/date:hucw 20110309
	@function:����֪ͨ��Ϣ����ʾ��
	@strftime,��ʽ����ʱ������
	@bossNo,������boss����
	@content,��������
	@flag,1��ʾ����,2��ʾ����,3������ʷ��ѯ
	*/
	function setContent(strftime,bossNo,content,flag) {
		var tempContent = null;
		if(flag == 1){
			tempContent = "��"+ strftime + " �ҡ�" + bossNo + "��:" + trim(content.replace(/%2B/g,"+"));
		}else if(flag == 2){
			tempContent = "��" + strftime + " " + bossNo + "���ҡ�:" + trim(content.replace(/%2B/g,"+"));
		}else if(flag == 3){
			tempContent = "��"+ strftime + " �ҡ�" + bossNo + "��:" + trim(content.replace(/%2B/g,"+"));
			return tempContent;
		}
		var val = $('#rec_content').val();
		$('#rec_content').val(val + tempContent + "\n");
		$('#rec_content').attr("scrollTop",$('#rec_content').attr("scrollHeight"));
	}
	
	
	function openWinMid(url,name,iHeight,iWidth)
	{
		var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=yes, resizable=no,location=no, status=yes');
	}


	function getAllMember(class_id){
		if(class_id=="top"){
			return false;
		}
		if(class_id==""){
			if(rdShowConfirmDialog("��ѡ��������Ⱥ��,���ܻ�ʹϵͳ����,��ȷ����?")=="1"){
				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_getGroupMember_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
				mypacket.data.add("class_id",class_id);
				core.ajax.sendPacket(mypacket,ListMember,true);
				mypacket=null;
			}
		}else{
			var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_getGroupMember_rpc.jsp","���ڷ���֪ͨ�����Ժ�......");
			mypacket.data.add("class_id",class_id);
			core.ajax.sendPacket(mypacket,ListMember,true);
			mypacket=null;
		}
	}

	function ListMember(packet){
		var retCode = packet.data.findValueByName("retCode");
		var memberList = packet.data.findValueByName("memberList");
		if(retCode!="000000"){
			rdShowMessageDialog("�޷���ȡ��ǰ�İ����Ա�����Ժ����ԣ�");
		}else{
			document.getElementById('receive_login_no').value = memberList;
		}
	}

	/**
	*��������
	*/
	function editGroupMember(){
		openWinMid('K084_edit_group.jsp','�޸İ����Ա', '360','650');
	}

	function checkcontent(){
	}


	function showHisContent(){
		openWinMid("K084_hisContent.jsp",'��ʷ��¼����',650,850);
	}


	/**
	*�ж϶��ŵĳ��ȡ�
	*һ����ĸ���ֵȱ�ʾһ������
	*һ�����ֱ�ʾ��������
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

	//���д򿪴���
	function openWinMid(url,name,iHeight,iWidth)
	{
		var iTop = (window.screen.availHeight-20-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		var iLeft = (window.screen.availWidth-5-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}
	function getLoginNo(){
		var width = 400,height = 300;
		var feather = 'width='+width+'px,height='
		+height+'px,top='+((screen.availHeight-width)/2)
		+',left= '+((screen.availWidth-height)/2)+',';

		openWinMid('k084_getLoginNo.jsp','��ѯ����',180,360);
	}
</script>

</head>
<%
//by libin 2009-05-09 �ڲ����е������ת��֪ͨ���ͣ�����������
String loginno_call = request.getParameter("loginno_call")==null?"":request.getParameter("loginno_call");
%>
<body >
<form id=sitechform name=sitechform>
  <%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<!--updated by tangsong 20100819 �޸���������ɫ��ԭ��ʽ�¿�������� -->
		<div class="title" style="color:#366FA9;">���� &nbsp;<input id="receive_login_no" name="receive_login_no" type="text" value="<%=loginno_call%>"  onBlur="checkLoginStatus();" onkeyup="checkcontent();">				<input class="b_foot" type="button" onclick="getLoginNo();" value="��ѯ����"/>
		</div>
		<div class="title" style="color:#366FA9;">������ͼ�¼</div>
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="rec_content" id="rec_content" readonly="true" rows="6" cols="70">
   	 	
    	 	</textArea>
    	</td>
      </tr>
		</table>
		
		<div class="title" style="color:#366FA9;">��������</div>
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="content" id="content" rows="6" cols="70" style="width:508px" onkeydown="if(event.keyCode==13)enterSend();"   title='�������200�����ֻ�400���ַ�'></textArea>
    	</td>
      </tr>
		</table>
		
		<p align="right" id="footer">
			<input name="as" type="button"  id="sednd" value=">>�ر�" onclick="window.close()">
			<input name="send" type="button"  id="send" value=">>����" onClick="sendMsg()">
          <input name="send" type="button"  id="" value="��ʷ��¼" onClick="showHisContent()">			
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

