<%
  /**
   * 功能: 质检权限管理->分配质检权限->被检组工号列表操作栏
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY scroll=auto>
		<div id="dataTableDiv">
	
  	</div>
	</BODY>
</html>
<SCRIPT type=text/javascript> 
// 获取当前选中条件
function ischeckBoxSelect(selectedItemList){
  var dataTableDiv = document.getElementById("dataTableDiv");
	dataTableDiv.innerHTML = "";
  getLoginNo(selectedItemList);
 }
function getLoginNo(selectedItemList){
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K280/k280_getLoginNoList.jsp","aa");
	packet.data.add("selectedItemList",selectedItemList);
	core.ajax.sendPacket(packet,doProcessNo,false);
	packet=null;
}
//getLoginNo的回调函数
function doProcessNo(packet){
   	var loginNoList = packet.data.findValueByName("nodes"); 	
    //insertTable(loginNoList);
    insertTable_(loginNoList);
}
//动态创建被检员工表格

function insertTable_(dataStr){
	var dataTableDiv = document.getElementById("dataTableDiv");
	dataTableDiv.innerHTML = "";
	dataTableDiv.innerHTML = dataStr;
}


//清除表格
function clearRow(objTable){ 
var dataTableDiv = document.getElementById("dataTableDiv");
dataTableDiv.innerHTML = "";
}
//清除全部选中复选框
function clearAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = false;
        }
    }
}
//选中全部复选框
function checkAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = true;
        }
    }
}

 //判断一个字符串是否在数组中出现
function isStr(str,strArr){
	if(strArr!=null&&strArr!=''){
		for(var j=0;j<strArr.length;j++){
     		if(str==strArr[j]){
     			return true;
     		}
		}
	}
	return false;
}
//获取本组之外新增ID
function getUnCheckboxValue()
{
	var checkbox =document.all('loginNo');
	var val = [];
	var len = checkbox.length;
	if(len=='undefined'||len==undefined){
	 if (checkbox.checked&&checkbox.isgroup=='false')
	 {
			return checkbox.value;
	 }else{
	 	  return '';
	 	}
	}else{
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked&&checkbox[i].isgroup=='false')
		{
			val[val.length] = checkbox[i].value;
		}
	}
	}
	return (val.length)?val:'';
}
//获取本组取消ID
function getGroupCheckboxValue()
{
	var checkbox =document.all('loginNo');
	var val = [];
	var len = checkbox.length;
	if(len=='undefined'||len==undefined){
	 if (!checkbox.checked&&checkbox.isgroup=='true')
	 {

			return checkbox.value;
	 }else{
	 	  return '';
	 	}
	}else{
	for(i=0; i<len; i++)
	{
		if (!checkbox[i].checked&&checkbox[i].isgroup=='true')
		{
			val[val.length] = checkbox[i].value;
		}
	}
	}
	return (val.length)?val:'';
}
</SCRIPT>