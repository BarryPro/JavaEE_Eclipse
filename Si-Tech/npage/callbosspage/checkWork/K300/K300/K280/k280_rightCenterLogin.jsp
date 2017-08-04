<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY scroll=auto>
		<TABLE id="dataTable" border="0"  style="font-size:12px;"  valign="top">
		</TABLE>
	</BODY>
</html>
<SCRIPT type=text/javascript> 
// ��ȡ��ǰѡ������
function ischeckBoxSelect(selectedItemList){
	var dataTable = document.getElementById("dataTable");
  clearRow(dataTable);
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
    insertTable(loginNoList);
}
//��̬��������Ա�����
function insertTable(dataArr){
	var dataTable = document.getElementById("dataTable");
	clearRow(dataTable);
	var rowObj = dataTable.insertRow();
	var m=0;
	var cellObj2;
	//var strArr=new Array();
	for(var i = 0; i <dataArr.length; i++ ){
		m = i%10;
		if(i == 0 || m == 0){
			cellObj2 = rowObj.insertCell();
			cellObj2.innerHTML+= "<input type='checkbox' checked='checked' onclick='checked=!checked'  name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>";					
		 // cellObj2.setAttribute("vAlign","top");
		}else{			
      cellObj2.innerHTML+= "<input type='checkbox' checked='checked'  onclick='checked=!checked'  name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>";					
		 // cellObj2.setAttribute("vAlign","top");
		}
	}
 
}
//������
function clearRow(objTable){ 
var length= objTable.rows.length ; 
for( var i=0; i<length; i++ )
{
objTable.deleteRow(i); 
}
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
		//	alert("strArr[j] "+strArr[j]);
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
		//alert(len);
	 if (!checkbox.checked&&checkbox.isgroup=='true')
	 {
			//alert(checkbox.value);
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