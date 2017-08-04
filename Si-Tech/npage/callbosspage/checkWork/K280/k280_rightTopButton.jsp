<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->主页面上方工具条
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update: 注释掉“显示导入流水”功能 mixh 2009/12/21
　 */
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
	<input type="radio" checked="checked" onclick="isRadioSelect();"  name="groupRange" value="self">本组的被检工号分配</input>
	</td>
	<td valign="top">
	<input type="radio" name="groupRange" onclick="isRadioSelect();"  value="selfAndSub">本组及下层分组的被检工号分配情况查询</input>
	</td>
	<td valign="top">
	<input type="checkbox" id="check" name="isChecked" onclick="isRadioSelect();" value ="0" checked="checked">显示已选工号</input>
	</td>
	<td valign="top">
	<input type="checkbox" id="check1" name="isChecked" onclick="isRadioSelect();" value ="1" >显示未选工号</input>
	</td>
	<!--zengzq 20091028 增加导入流水显示-->
	<td valign="top">
	<input type="checkbox" id="check2" name="isChecked" onclick="isSerialCheck();" disabled value ="1" >显示导入流水</input>
	</td>
	</tr>
	</table>
	</form> 
</body>
</html>
<script type="text/javascript"> 
//打开新增窗口
function isRadioSelect(){
	if(document.getElementById("check2").checked == true){
		document.getElementById("check2").click();
	}
		parent.frameright.window.isRadioSelect(0);
}
//查看流水号
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
	
