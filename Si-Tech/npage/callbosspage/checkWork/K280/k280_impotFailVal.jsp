<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->�鿴����ʧ�ܻ��ظ���Ϣ
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

function insertTable(){
	var pdoc = window.dialogArguments;
	var repeatVal = pdoc.document.getElementById("repeatVal").value;
	var failVal = pdoc.document.getElementById("failVal").value;
	repeatVal = repeatVal.substring(0,(repeatVal.length-1));
	failVal = failVal.substring(0,(failVal.length-1));
	var dataTable = document.getElementById("dataTable");
	var repeatValArr = repeatVal.split(",");
	var failValArr = failVal.split(",");
  clearRow(dataTable);
	var rowObj;
	var cellObj1;
	var cellObj2;
	var cellObj3;	
	var cellObj4;
	var strArr=new Array();
	 /*
	 rowObj = dataTable.insertRow(0);
	 cellObj1=rowObj.insertCell(0);
	 cellObj1.colspan='4';
	 cellObj1.innerHTML="��Ч����"; 
	 cellObj2=rowObj.insertCell(1);
	 cellObj2.innerHTML=""; 
	 cellObj3=rowObj.insertCell(2);
	 cellObj3.innerHTML="";
	 cellObj3=rowObj.insertCell(3);
	 cellObj3.innerHTML="";
	 */
	for(var i = 0; i <repeatVal.length; i++){
			if(i%4 == 0){
					rowObj =  dataTable.insertRow(i/4);	
				  cellObj1=rowObj.insertCell(0);
				  cellObj1.innerHTML=repeatVal[i]; 
			}else{
					cellObj2=rowObj.insertCell(i%4);
		  		cellObj2.innerHTML=repeatVal[i]; 
			}
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
<%
/*String repeatVal = request.getParameter("repeatVal") ;
String failVal = request.getParameter("failVal") ;
out.print(repeatVal);
out.print(failVal);
*/
%>
<body onload="insertTable();">
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table id="dataTable" >
			</table>	
	</div>
</form>
</body>
</html>
