<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>�ʼ췽ʽ</title>

<script language=javascript>

function closeWin(){
		window.close();
}

function getRadioValue(){
		var radio = document.forms['sitechform'].elements['typeRange'];
		if (!radio.length && radio.type.toLowerCase() == 'radio') {
					 return (radio.checked)?radio.value:''; 
		}
		
		if (radio[0].tagName.toLowerCase() != 'input' || 
		radio[0].type.toLowerCase() != 'radio')
				{ return ''; }
		
		var len = radio.length;
		for(i=0; i<len; i++){
				if (radio[i].checked){
						return radio[i].value;
				}
		}
		return '';
}

//�ڵ�ѡ���¼�
function isRadioSelect(flag){
		var radiovalue=getRadioValue();
		
		if(radiovalue==0){
				tmpSave(flag);
		}else if(radiovalue==1){
				finishedSave(flag);
		}else if(radiovalue==2){
				setAsCase(flag);
		}else if(radiovalue==3){
				giveUpCheck(flag);
		}
}

//��ʱ����
function tmpSave(flag){
		if('Y'==flag){
			opener.tempSaveQcInfo();
			opener.finishedTimer();;
			closeWin();
		}else{
			closeWin();
		}
		
}
//�ʼ����
function finishedSave(flag){
	if('Y'==flag){
			opener.checkIsSendTip();
			opener.finishedTimer();
			closeWin();
	}else{
			closeWin();
	}
	
}
//��Ϊ����
function setAsCase(flag){
	if('Y'==flag){
			if(rdShowConfirmDialog("��Ϊ���Ͱ������ύ�ʼ��������Ƿ�ȷ����")=="1"){
					opener.document.getElementById("idremarkFlag").value = "01";
					opener.checkIsSendTip();opener.finishedTimer();	//�ʼ����
			}
			closeWin();
	}else{
			closeWin();
	}
		
	
}
//����
function giveUpCheck(flag){
	
	if('Y'==flag){
			var pdoc = window.dialogArguments;
			var returnValue = window.showModalDialog("../K217/K217_get_give_up_reason.jsp",'',"dialogWidth=800px;dialogHeight=420px");		
			opener.mult_show_select_give_up_reason_win(returnValue);
			closeWin();
	}else{
			closeWin();
	}	
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
	   <tr>
      <td>
	    <center>
	    	<br>
		  <p >
			  <font size="2">��ѡ��ǰ��ˮ���ʼ췽ʽ��</font>
		  </p>
      <p>
      <input type="radio"  id="typeRange" name="typeRange" value="0">��ʱ����</input>
      <input type="radio"  checked="true" name="typeRange" id="typeRange" value="1">�ʼ����</input>
      <input type="radio"  id="typeRange" name="typeRange" value="2">��Ϊ����</input>
      <input type="radio"  name="typeRange" id="typeRange"  value="3">����</input>
      </p>
	</center>
</td>
</tr>
<tr>
<td  align="right">
 <input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="isRadioSelect('Y')">
 <input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="isRadioSelect('N')">
</td>
 </tr>
 </table>
 </div>
</form>
</body>
</html>