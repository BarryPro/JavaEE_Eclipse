<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->��Χѡ���
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
<title>��Χѡ��ͷ�Χȡ��</title>

<script language=javascript>

// �������¼
function cleanValue(){
	document.getElementById("startLoginNo").value='';
	document.getElementById("endLoginNo").value='';
	document.getElementById("loginNo").value='';
}

function closeWin(){
	window.close();
}

function checkLoginNo(){
	var pdoc = window.dialogArguments;
	/*modify by zhengjiang 20090925 start*/
	var startLoginNo= document.getElementById("startLoginNo").value.substring(2);
	var endLoginNo=	document.getElementById("endLoginNo").value.substring(2);
	/*modify by zhengjiang 20090925 end*/
	var loginNo=	document.getElementById("loginNo").value;
	var typeRange=getRadioValue();
	var isCheck=getIsCheck();
	if(typeRange=='0'){
		pdoc.selectCheckLoginNo(isCheck,loginNo);
		pdoc.findInPage(loginNo);
	}
	if(typeRange=='1'){
		if(startLoginNo>endLoginNo){
			return;
		}
		
		/*modify by mixh 20090402 begin*/
		pdoc.selectRange(isCheck, startLoginNo, endLoginNo);
		//for(var i=startLoginNo;i<=endLoginNo;i++){
		//	pdoc.selectCheckLoginNo(isCheck,i);
		//    pdoc.findInPage(i);
		//}
		/*modify by mixh 20090402 end*/
	}
}

function getRadioValue()
{
	var radio = document.forms['sitechform'].elements['typeRange'];
	if (!radio.length && radio.type.toLowerCase() == 'radio')
	{ return (radio.checked)?radio.value:'';  }

	if (radio[0].tagName.toLowerCase() != 'input' ||
		radio[0].type.toLowerCase() != 'radio')
	{ return ''; }
	var len = radio.length;
	for(i=0; i<len; i++)
	{
		if (radio[i].checked)
		{
			return radio[i].value;
		}
	}
	return '';
}
function getIsCheck()
{
	var radio = document.forms['sitechform'].elements['isCheck'];
	if (!radio.length && radio.type.toLowerCase() == 'radio')
	{ return (radio.checked)?radio.value:'';  }

	if (radio[0].tagName.toLowerCase() != 'input' ||
		radio[0].type.toLowerCase() != 'radio')
	{ return ''; }

	var len = radio.length;
	for(i=0; i<len; i++)
	{
		if (radio[i].checked)
		{
			return radio[i].value;
		}
	}
	return '';
}
function showTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="block";
var odiv2 = document.getElementById('div2');
odiv2.style.display ="none";
}
//����������
function hiddenTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="none";
var odiv2 = document.getElementById('div2');
odiv2.style.display ="block";
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
						<tr>
<td colspan="2"  width="70%">
<input type="radio" checked="checked" onclick="isRadioSelect();"  id="typeRange" name="typeRange" value="0">��λ</input>
<input type="radio"  onclick="isRadioSelect();"  name="typeRange" id="typeRange" value="1">���ŷ�Χѡ��</input>
</td>
			</tr>
	</table>
			<div id="div1" style="display: none" >
		<table>
			<tr id="orientation" >
  				<td>��λ��</td>
  				<td width="80%">
  				<!--modify by zhengjiang 20090925 ������ʽ[^\d]Ϊ[^kf\d]-->
       <input id="loginNo" name ="loginNo" size="15" type="text"  onkeyup="value=value.replace(/[^kf\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"  value="">
	  			</td>
			</tr>
				</table>
		</div>
		<div id="div2" style="display: none" >
				<table>
			<tr id="range" >
  				<td >��ʼ��</td>
  				<td width="80%">
      <input id="startLoginNo" name ="startLoginNo" size="15" type="text"  onkeyup="value=value.replace(/[^kf\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value="">
	  			</td>
			</tr>
			<tr id="range2" >
  				<td>��ֹ��</td>
  				<td width="80%">
       <input id="endLoginNo" name ="endLoginNo" size="15" type="text"  onkeyup="value=value.replace(/[^kf\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"   value="">
	  			</td>
			</tr>
				</table>
		</div>
				<table>
						<tr>
  				<td   width="70%">
<input type="radio" checked="checked" onclick=""  name="isCheck"  id="isCheck" value="0">ѡ��</input>
<input type="radio"  onclick=""  name="isCheck" id="isCheck"  value="1">ȡ��ѡ��</input>
</td>
			</tr>
	</table>
			<table>
			<tr >
  				<td  align="center">
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="checkLoginNo()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<SCRIPT type=text/javascript>
	showTable();
//�ڵ�ѡ���¼�
function isRadioSelect(){
var radiovalue=getRadioValue();
if(radiovalue==0){
	showTable();
	}else{
	hiddenTable();
	}
}
</SCRIPT>