<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->��ҳ���Ϸ�������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update: ע�͵�����ʾ������ˮ������ mixh 2009/12/21
�� */
%>
<%@ page language="java" pageEncoding="GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
</head>
<body>
	<form name="testForm">
	<table height="20" cellSpacing="0" valign="top">
	<tr valign="top" id="title_zi">
	<td valign="top">
	<input type="radio" checked="checked" onclick="isRadioSelect();"  name="groupRange" value="self">����ı��칤�ŷ���</input>
	</td>
	<td valign="top">
	<input type="radio" name="groupRange" onclick="isRadioSelect();"  value="selfAndSub">���鼰�²����ı��칤�ŷ��������ѯ</input>
	</td>
	<td valign="top">
	<input type="checkbox" id="check" name="isChecked" onclick="isRadioSelect();" value ="0" checked="checked">��ʾ��ѡ����</input>
	</td>
	<td valign="top">
	<input type="checkbox" id="check1" name="isChecked" onclick="isRadioSelect();" value ="1" >��ʾδѡ����</input>
	</td>
	<!--zengzq 20091028 ���ӵ�����ˮ��ʾ-->
	<td valign="top">
	<input type="checkbox" id="check2" name="isChecked" onclick="isSerialCheck();" disabled value ="1" >��ʾ������ˮ</input>
	</td>
	</tr>
	</table>
	</form> 
</body>
</html>
<script type="text/javascript"> 
//����������
function isRadioSelect(){
	if(document.getElementById("check2").checked == true){
		document.getElementById("check2").click();
	}
		parent.frameright.window.isRadioSelect(0);
}
//�鿴��ˮ��
function isSerialCheck(){
	if(document.getElementById("check2").checked == true){
			parent.rightFootFrame.document.getElementById("saveBtn").disabled=true;
	}else{
			parent.rightFootFrame.document.getElementById("saveBtn").disabled=false;
	}
	if(document.getElementById("check").checked == true){
		document.getElementById("check").click();
	}
	if(document.getElementById("check1").checked == true){
		document.getElementById("check1").click();
	}
	parent.frameright.window.isRadioSelect(1);
}
// ˵���� �� Javascript ��֤����form���ж�ѡ��checkbox��ֵ
function getCheckboxValue()
{
   var checkbox=document.forms['testForm'].elements['isChecked'];
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].value;
		}
	}
	return (val.length)?val:'';
}

// ˵���� �� Javascript ��֤����form���еĵ�ѡ��radio��ֵ
function getRadioValue()
{
	var radio = document.forms['testForm'].elements['groupRange'];
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
</script>
	
