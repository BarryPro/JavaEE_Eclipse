<%
  /*
   * 功能: 质检权限管理->维护质检员和组->主页面上方工具条
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
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
	<input type="radio" name="groupRange" checked="checked" onclick="isRadioSelect();" value="self">本组的质检工号分配</input>
	</td>
	<td>
	<input type="radio" name="groupRange" onclick="isRadioSelect();" value="selfAndSub">本组及下层分组的质检工号分配情况查询</input>
	</td>
	<td>
	<input type="checkbox" name="isChecked" onclick="isRadioSelect();" value ="0" checked="checked">显示已选工号</input>
	</td>
	<td>
	<input type="checkbox" id="check1" name="isChecked" onclick="isRadioSelect();" value ="1" >显示未选工号</input>
	</td>
	</tr>
	</table>
	</form> 
</body>
</html>
<script type="text/javascript"> 
//打开新增窗口
function isRadioSelect(){
parent.frameright.window.isRadioSelect();
}
	// 说明： 用 Javascript 验证表单（form）中多选框（checkbox）值
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

// 说明： 用 Javascript 验证表单（form）中的单选（radio）值
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
	
