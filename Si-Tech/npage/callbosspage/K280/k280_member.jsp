<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY>
		<form name="testForm">
		<TABLE height="30">
			<TR>
				<TD>
					<input type="radio" checked="checked" onclick="isRadioSelect();"  name="groupRange" value="self">本组的被检工号分配情况</input>
				</TD>
				<TD>
					<input type="radio" name="groupRange" onclick="isRadioSelect();"  value="selfAndSub">本组及下层分组的被检工号分配情况</input>
				</TD>
				<TD>
					<input type="checkbox" name="isChecked" onclick="isRadioSelect();" value ="true" checked="checked">显示已选工号</input>
				</TD>
				<TD>
					<input type="checkbox"  name="isChecked" onclick="isRadioSelect();" value ="false">显示未选工号</input>
				</TD>
			</TR>
		</TABLE>
		<TABLE id="dataTable" border="0" height="420">
		</TABLE>
		<TABLE width="100%">
			<TR>
				<TD>
					<input type="button" class="b_text"  onclick="setRange()" value="范围选择"/>
					<input type="button" class="b_text" onclick="seach()" value="定位"/>
					<input type="button" class="b_text" onclick="cleanAll()" value="全部清除"/>
					<input type="button" class="b_text"  onclick="multipleGroup()" value="多重组人员"/>
					<input type="button" class="b_text" onclick="memberMsg()" value="查询成员信息"/>
				<TD align="left">
					<input type="button" class="b_text" onclick="saveChange()" value="保存"/>
					<input type="button" class="b_text"  onclick="cancel()" value="退出"/>
				</TD>
			</TR>
		</TABLE>
		</form>
	</BODY>
</html>
<SCRIPT type=text/javascript> 
	
	// 说明： 用 Javascript 验证表单（form）中多选框（checkbox）值

function getCheckboxValue(checkbox)
{
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
function getRadioValue(radio)
{
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
// 获取当前选中条件
function ischeckBoxSelect(selectedItemId){
var checkboxTest = document.forms['testForm'].elements['isChecked'];
var radioTest = document.forms['testForm'].elements['groupRange'];
var checkBoxValue=getCheckboxValue(checkboxTest);
var radioValue=getRadioValue(radioTest);
 alert("checkbox is value:\t"+getCheckboxValue(checkboxTest)); 
 alert("radio is value:\t"+getRadioValue(radioTest));
// document.getElementById("aa").innerHTML=selectedItemId;
 getLoginNo(selectedItemId,checkBoxValue,radioValue);
 }
function getLoginNo(selectedItemId,checkBoxValue,radioValue){
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k280_getLoginNoList.jsp","aa");
	packet.data.add("selectedItemId",selectedItemId);
	packet.data.add("checkBoxValue",checkBoxValue);
	packet.data.add("radioValue",radioValue);
	core.ajax.sendPacket(packet,doProcessLoginNo,true);
	packet=null;
}

//getLoginNo的回调函数
function doProcessLoginNo(packet){
   	var loginNoList = packet.data.findValueByName("nodes");
   	var selectloginNoList = packet.data.findValueByName("selectloginNoList");
   	alert(selectloginNoList);
    insertTable(loginNoList);
}
//创建表格
function insertTable(dataArr){
	var dataTable = document.getElementById("dataTable");
	clearRow(dataTable);
	dataTable.setAttribute("height",420);
	var rowObj = dataTable.insertRow();
	var m=0;
	var cellObj2;
	alert("length --> " + dataArr.length);
	for(var i = 0; i <dataArr.length; i++ ){
		m = i%2;
		if(i == 0 || m == 0){
			cellObj2 = rowObj.insertCell();
			cellObj2.innerHTML+= "<input type='checkbox' name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>";		
      cellObj2.setAttribute("vAlign","top");
      cellObj2.setAttribute("width",100);
      cellObj2.setAttribute("height",420);
		}else{
			cellObj2.innerHTML+= "<input type='checkbox' name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>";		
      cellObj2.setAttribute("vAlign","top");
      cellObj2.setAttribute("width",100);
      cellObj2.setAttribute("height",420);
		}
	}
 
}
//清除表格
function clearRow(objTable){ 
var length= objTable.rows.length ; 
for( var i=0; i<length; i++ )
{
objTable.deleteRow(i); 
}
}

//单选按钮的响应事件
function isRadioSelect(){
var selectItemId=window.top.frameleft.window.tree.getSelectedItemId();
alert("is radio :\t"+selectItemId);
ischeckBoxSelect(selectItemId);
 }
</SCRIPT>