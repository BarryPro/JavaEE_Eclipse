<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->�鿴��Ա��Ϣ
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<title>�鿴��Ա��Ϣ</title>

<script language=javascript>

// �������¼
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
// �����¼�
//ajax
function findMemberMsg(flag,loginNo){
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k290_getMemberInfoList.jsp","aa");
	packet.data.add("flag",flag);
	packet.data.add("loginNo",loginNo);
	core.ajax.sendPacket(packet,doProcessNo,false);
	packet=null;
}

//getLoginNo�Ļص�����
function doProcessNo(packet){
   	var loginNoList = packet.data.findValueByName("loginNoList");
    insertTable(loginNoList);
}
function findMsg(){
	var loginNo=document.getElementById("loginNo").value;	
	var flag=getRadioValue();
	findMemberMsg(flag,loginNo);
}
//ѡ��radiovalue
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
	 cellObj1.innerHTML="Ⱥ���"; 
	 cellObj2=rowObj.insertCell(1);
	 cellObj2.innerHTML="Ⱥ����"; 
	 cellObj3=rowObj.insertCell(2);
	 cellObj3.innerHTML="����";
	 cellObj4=rowObj.insertCell(3);
	 cellObj4.innerHTML="������";
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
//������
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
  		<td width="40%"><input type="radio" checked="checked" id="findType" name="findType" value="0">������</input>
      <input type="radio" name="findType" id="findType" value="1">��������</input>
      </td>
  		<td width="55%">
      <input type="text" name="loginNo" id="loginNo" value="" size="15" onkeydown="KeyDown();">
      <input name="find" type="button" class="b_text" id="add" value="ȷ��" onClick="findMsg()">
	  	</td>
			</tr>
		</table>	
		<table id="dataTable" >
			</table>	
	</div>
</form>
</body>
</html>
