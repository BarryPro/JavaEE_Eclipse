<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���ŷ���
�� * �汾: 1.0
�� * ����: 2009\08\30
�� * ����: hanjc 
 ��*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<html>
<head>
<title>���ŷ���</title>
<script language=javascript>
function sendMsg(){
	/*
	if(getLen(document.sitechform.msg_content.value)>320){
		rdShowMessageDialog('������������ܳ���160������,����320���ַ���');
		return;
	}
	*/
	if(document.getElementById("msg_content").value == ""){
	  	rdShowMessageDialog('�������ݲ���Ϊ�գ������ѡ�������!');
		return;
    }
	/*modify by yinzx �޸��Ϊ500���ַ�
	if(getLen ( document.getElementById('msg_content').value ) > 500){
		rdShowMessageDialog('������������ܳ���250������,����500���ַ���');
		return;
	}*/
  sendSubmit();
}
var messageArray = new Array();//������һ��Ԫ��.
//���ŷ��Ͷ�������.
//rpc���÷���
function sendSubmit(){
	var sendData = "";
	if(window.top.opener.cCcommonTool)
		sendData = "user_phone="+ window.top.opener.cCcommonTool.getCalled();
	else
		sendData = "user_phone="+ window.top.opener.top.opener.cCcommonTool.getCalled();
	//window.top.top.opener.cCcommonTool.getCaller();�ǴӸ�ҳ��ĸ�ҳ��ȡ���û��ĵ绰����.
	//�����ݽ��б������.
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
				rdShowMessageDialog("���ͳɹ���",2);
				//window.top.top.opener.similarMSNPop("���ͳɹ���");
			}else{
				rdShowMessageDialog("����ʧ�ܣ�",0);
				//window.top.top.opener.similarMSNPop("����ʧ�ܣ�");
			}
		}
	});
}
function setContentByArrayNo(no){
	//�õ�����������.
	//alert(no);
	//alert(messageArray.length);
	document.getElementById('msg_content').value = messageArray[no];
	onCharsChange(messageArray[no]);
}
/**�ж϶��ŵĳ��ȡ�
*һ����ĸ���ֵȱ�ʾһ������
*һ�����ֱ�ʾ��������
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
//�ж϶��������ͷ��Ͷ�������
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
/**�������ɶ�������.����ʾ��һ������.*/
function genHTMLByArray(){
	var strHTML = '';
	for(var i = 0; i < messageArray.length; i ++){
		strHTML += '<a href="javaScript:setContentByArrayNo(' + i + ');">��'+(i+1)+'������</a>&nbsp;';
	}
	document.getElementById("show_array_div").innerHTML = strHTML;
	if(messageArray.length >= 1){
		//updated by tangsong 20101016 �޸Ķ���������ʾΪ���һ������
		document.getElementById("msg_content").value = messageArray[messageArray.length-1];
		/**���¼���������ʾ.*/
		parent.sendSMS.onCharsChange(messageArray[messageArray.length-1]);
	}else{/**�������ʾ��.*/
		document.getElementById("msg_content").value = "";
	}
}
</script>
</head>
<body>
	<!--TABLE����.��ʼ  -->
	<div id="Operation_Table" style="width: 100%;padding: 0px;">
	<!--�б���ɫ����.��ʼ  -->
    <div class="title"><div id="title_zi">���Ͷ���</div></div>
    <!--�б���ɫ����.����  -->
    <table width="98%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <td>
         	��<input name="charsmonitor" style="border:none;" tabindex="100" value="0" e="5" size="2" readonly>
			�ַ�  ��<input name="sendnum" style="border:none;" tabindex="100" value="0" e="5" size="2" readonly>�η���<br />
			<textarea name="msg_content" id="msg_content"
			style="width:100%;word-break:break-all"  rows="16"
			title="�������250�����ֻ�500���ַ�"
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
            <input id="send" class="b_foot" name="send" type="button" value="����" onclick="sendMsg();">
       		</div>
          </td>
		</tr>
      </table>
      <!--TABLE����.����.  -->
</div>
</body>
</html>

