<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->��ҳ���Ϸ�������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
</head>
<body>
	<form name="testForm">
	<table height="20" cellSpacing="0" vAlign=top>
	<tr vAlign="top" id="title_zi">
	<td>
	<input type="radio" name="groupRange" checked="checked" onclick="isRadioSelect();" value="self">������ʼ칤�ŷ���</input>
	</td>
	<td>
	<input type="radio" name="groupRange" onclick="isRadioSelect();" value="selfAndSub">���鼰�²������ʼ칤�ŷ��������ѯ</input>
	</td>
	<td>
	<input type="checkbox" name="isChecked" onclick="isRadioSelect();" value ="0" checked="checked">��ʾ��ѡ����</input>
	</td>
	<td>
	<input type="checkbox" id="check1" name="isChecked" onclick="isRadioSelect();" value ="1" >��ʾδѡ����</input>
	</td>
	</tr>
	</table>
	</form> 
</body>
</html>
<script type="text/javascript"> 
//����������
function isRadioSelect(){
parent.frameright.window.isRadioSelect();
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
	
