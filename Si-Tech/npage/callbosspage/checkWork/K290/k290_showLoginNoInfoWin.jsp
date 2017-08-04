<%
  /*
   * 功能: 质检权限管理->维护质检员和组->查看成员信息
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<title>查看成员信息</title>

<script language=javascript>

// 清除表单记录
function cleanValue(){
document.getElementById("loginNo").value="";	
}
function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        findMsg();
    }
}
function closeWin(){
	window.close();
}
// 查找事件
//ajax
function findMemberMsg(flag,loginNo){
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k290_getMemberInfoList.jsp","aa");
	packet.data.add("flag",flag);
	packet.data.add("loginNo",loginNo);
	core.ajax.sendPacket(packet,doProcessNo,false);
	packet=null;
}

//getLoginNo的回调函数
function doProcessNo(packet){
   	var loginNoList = packet.data.findValueByName("loginNoList");
    insertTable(loginNoList);
}
function findMsg(){
	var loginNo=document.getElementById("loginNo").value;	
	var flag=getRadioValue();
	findMemberMsg(flag,loginNo);
}
//选择radiovalue
function getRadioValue()
{
	var radio = document.forms['sitechform'].elements['findType'];
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

function insertTable(dataArr){
	var dataTable = document.getElementById("dataTable");
  clearRow(dataTable);
	var rowObj;
	var cellObj1;
	var cellObj2;
	var cellObj3;
	var cellObj4;	
	var strArr=new Array();
	 rowObj =  dataTable.insertRow(0);
	 cellObj1=rowObj.insertCell(0);
	 cellObj1.innerHTML="群组号"; 
	 cellObj2=rowObj.insertCell(1);
	 cellObj2.innerHTML="群组名"; 
	 cellObj3=rowObj.insertCell(2);
	 cellObj3.innerHTML="工号";
	 cellObj4=rowObj.insertCell(3);
	 cellObj4.innerHTML="工号名";
	for(var i = 1; i <=dataArr.length; i++ ){
		  rowObj =  dataTable.insertRow(i);	
		  cellObj1=rowObj.insertCell(0);
		  cellObj1.innerHTML=dataArr[i-1][0]; 
		  cellObj2=rowObj.insertCell(1);
		  cellObj2.innerHTML=dataArr[i-1][1]; 
		  cellObj3=rowObj.insertCell(2);
		  cellObj3.innerHTML=dataArr[i-1][2]; 
		  cellObj4=rowObj.insertCell(3);
		  cellObj4.innerHTML=dataArr[i-1][3]; 
	}
}
//清除表格
function clearRow(objTable){

	var length= objTable.rows.length ; 
	for( var i=length-1; i>=0; i--)
	{
	objTable.deleteRow(i); 
	}
	
}
</script>

</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
  		<td width="40%"><input type="radio" checked="checked" id="findType" name="findType" value="0">按工号</input>
      <input type="radio" name="findType" id="findType" value="1">按工号名</input>
      </td>
  		<td width="55%">
      <input type="text" name="loginNo" id="loginNo" value="" size="15" onkeydown="KeyDown();">
      <input name="find" type="button" class="b_text" id="add" value="确定" onClick="findMsg()">
	  	</td>
			</tr>
		</table>	
		<table id="dataTable" >
			</table>	
	</div>
</form>
</body>
</html>
