<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 短信发送
　 * 版本: 1.0
　 * 日期: 2009\08\30
　 * 作者: hanjc 
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<html>
<head>
<title>短信发送</title>
<script language=javascript>
function sendMsg(){
	/*
	if(getLen(document.sitechform.msg_content.value)>320){
		rdShowMessageDialog('短信内容最大不能超过160个汉字,或者320个字符！');
		return;
	}
	*/
	if(document.getElementById("msg_content").value == ""){
	  	rdShowMessageDialog('短信内容不能为空！请从新选择后输入!');
		return;
    }
	/*modify by yinzx 修改最长为500个字符
	if(getLen ( document.getElementById('msg_content').value ) > 500){
		rdShowMessageDialog('短信内容最大不能超过250个汉字,或者500个字符！');
		return;
	}*/
  sendSubmit();
}
var messageArray = new Array();//里面有一个元素.
//短信发送多条数组.
//rpc调用发送
function sendSubmit(){
	var sendData = "";
	if(window.top.opener.cCcommonTool)
		sendData = "user_phone="+ window.top.opener.cCcommonTool.getCalled();
	else
		sendData = "user_phone="+ window.top.opener.top.opener.cCcommonTool.getCalled();
	//window.top.top.opener.cCcommonTool.getCaller();是从父页面的父页面取得用户的电话号码.
	//对内容进行编码过滤.
	//alert(sendData);
	for(var i = 0; i < messageArray.length; i ++){
		var temp_content = messageArray[i].replace(/\+/g,"%2B");
		sendData += "&msg_content=" + temp_content;
	}
	//alert(sendData);
	$.ajax({
		url: '<%=request.getContextPath()%>/npage/callbosspage/K083/K083_msgSend_rpc4CallTrans.jsp',
		data: sendData,
		type:"POST", 
		dataType:"html",
		success: function(data){
			if(data.trim() =="1"){
				rdShowMessageDialog("发送成功！",2);
				//window.top.top.opener.similarMSNPop("发送成功！");
			}else{
				rdShowMessageDialog("发送失败！",0);
				//window.top.top.opener.similarMSNPop("发送失败！");
			}
		}
	});
}
function setContentByArrayNo(no){
	//得到发短信内容.
	//alert(no);
	//alert(messageArray.length);
	document.getElementById('msg_content').value = messageArray[no];
	onCharsChange(messageArray[no]);
}
/**判断短信的长度。
*一个字母数字等表示一个长度
*一个汉字表示两个长度
*/
function getLen(str) 
{
	var len=0; 
	if(str != null && str.length>0){
		for(var i=0;i<str.length;i++){ 
			char = str.charCodeAt(i); 
			if(!(char>255)){ 
				len = len + 1; 
			}else { 
				len = len + 2; 
			}
		}
	}
	return len;
}
//判断短信字数和发送短信条数
function onCharsChange(varField){ 
	var leftChars = varField.length;
	var num = 1;
	if ( leftChars >= 0){
		document.getElementById('charsmonitor').value=leftChars;
		if(parseInt(leftChars%70)==0){
			num = leftChars/70;
		}else{
			num = parseInt(leftChars/70)+1;
		}
		document.getElementById('sendnum').value = num;
		return true;   
	}
}
/**重新生成短信链接.并显示第一条短信.*/
function genHTMLByArray(){
	var strHTML = '';
	for(var i = 0; i < messageArray.length; i ++){
		strHTML += '<a href="javaScript:setContentByArrayNo(' + i + ');">第'+(i+1)+'条短信</a>&nbsp;';
	}
	document.getElementById("show_array_div").innerHTML = strHTML;
	if(messageArray.length >= 1){
		//updated by tangsong 20101016 修改短信内容显示为最后一条短信
		document.getElementById("msg_content").value = messageArray[messageArray.length-1];
		/**更新计算字数显示.*/
		parent.sendSMS.onCharsChange(messageArray[messageArray.length-1]);
	}else{/**否则就显示空.*/
		document.getElementById("msg_content").value = "";
	}
}
</script>
</head>
<body>
	<!--TABLE主体.开始  -->
	<div id="Operation_Table" style="width: 100%;padding: 0px;">
	<!--列表蓝色标题.开始  -->
    <div class="title"><div id="title_zi">发送短信</div></div>
    <!--列表蓝色标题.结束  -->
    <table width="98%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <td>
         	共<input name="charsmonitor" style="border:none;" tabindex="100" value="0" e="5" size="2" readonly>
			字符  分<input name="sendnum" style="border:none;" tabindex="100" value="0" e="5" size="2" readonly>次发送<br />
			<textarea name="msg_content" id="msg_content"
			style="width:100%;word-break:break-all"  rows="16"
			title="最大允许250个汉字或500个字符"
			onpaste="return onCharsChange(this.value);" onkeyup="return onCharsChange(this.value);"></textArea>
			<input type="hidden" id="myaction" name="myaction" value="">
			<input type="hidden" id="isFirstIn" name="isFirstIn" value="N">
			<input type="hidden" id="flag" name="flag" value="">
         </td>
		</tr>
		<tr> 
          <td align="right" colspan="10" >
          	<div style="align: left;float: left;">
          		<div id="show_array_div"></div>
          	</div>
            <div style="align: right;float: right;">
            <input id="send" class="b_foot" name="send" type="button" value="发送" onclick="sendMsg();">
       		</div>
          </td>
		</tr>
      </table>
      <!--TABLE主体.结束.  -->
</div>
</body>
</html>

