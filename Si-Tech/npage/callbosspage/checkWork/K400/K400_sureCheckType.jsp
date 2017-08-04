<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>质检方式</title>

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

//节点选择事件
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

//临时保持
function tmpSave(flag){
		if('Y'==flag){
			opener.tempSaveQcInfo();
			opener.finishedTimer();;
			closeWin();
		}else{
			closeWin();
		}
		
}
//质检完毕
function finishedSave(flag){
	if('Y'==flag){
			opener.checkIsSendTip();
			opener.finishedTimer();
			closeWin();
	}else{
			closeWin();
	}
	
}
//设为案例
function setAsCase(flag){
	if('Y'==flag){
			if(rdShowConfirmDialog("设为典型案例需提交质检结果，您是否确定？")=="1"){
					opener.document.getElementById("idremarkFlag").value = "01";
					opener.checkIsSendTip();opener.finishedTimer();	//质检结束
			}
			closeWin();
	}else{
			closeWin();
	}
		
	
}
//放弃
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
			  <font size="2">请选择当前流水的质检方式：</font>
		  </p>
      <p>
      <input type="radio"  id="typeRange" name="typeRange" value="0">临时保存</input>
      <input type="radio"  checked="true" name="typeRange" id="typeRange" value="1">质检完毕</input>
      <input type="radio"  id="typeRange" name="typeRange" value="2">设为案例</input>
      <input type="radio"  name="typeRange" id="typeRange"  value="3">放弃</input>
      </p>
	</center>
</td>
</tr>
<tr>
<td  align="right">
 <input name="add" type="button" class="b_text" id="add" value="确定" onClick="isRadioSelect('Y')">
 <input name="close" type="button" class="b_text" id="close" value="取消" onClick="isRadioSelect('N')">
</td>
 </tr>
 </table>
 </div>
</form>
</body>
</html>