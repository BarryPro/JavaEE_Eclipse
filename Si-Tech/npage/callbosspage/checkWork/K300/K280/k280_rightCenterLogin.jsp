<%
  /**
   * ����: �ʼ�Ȩ�޹���->�����ʼ�Ȩ��->�����鹤���б������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
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
// ��ȡ��ǰѡ������
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
//getLoginNo�Ļص�����
function doProcessNo(packet){
   	var loginNoList = packet.data.findValueByName("nodes"); 	
    //insertTable(loginNoList);
    insertTable_(loginNoList);
}
//��̬��������Ա�����

function insertTable_(dataStr){
	var dataTableDiv = document.getElementById("dataTableDiv");
	dataTableDiv.innerHTML = "";
	dataTableDiv.innerHTML = dataStr;
}


//������
function clearRow(objTable){ 
var dataTableDiv = document.getElementById("dataTableDiv");
dataTableDiv.innerHTML = "";
}
//���ȫ��ѡ�и�ѡ��
function clearAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = false;
        }
    }
}
//ѡ��ȫ����ѡ��
function checkAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = true;
        }
    }
}

 //�ж�һ���ַ����Ƿ��������г���
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
//��ȡ����֮������ID
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
//��ȡ����ȡ��ID
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