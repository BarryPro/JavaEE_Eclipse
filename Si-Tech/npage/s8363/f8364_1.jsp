<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�쳣���׼������
   * �汾: 1.0
   * ����: 2009/12/24
   * ����: gaolw
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 
	String opCode = "8364";
	String opName = "�쳣���׼������";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
	
	String sql = "SELECT function_code,FUNCTION_NAME FROM sfunccodenew WHERE main_code = '1' AND length(TRIM(function_code)) = 4 order by function_code";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="opCodeData" scope="end" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
onload=function()
{		
	init();
}

function init()
{
	document.form1.confirm.disabled = true;
}	
var bind_values1 = new Array() ;
var notes = new Array() ;
var limitValue1 = new Array() ;


//��ӹ��ţ�ҵ����룬��ֵ
function addRow(){
	
	if(document.all.loginNo.value.length < 1) {
		rdShowMessageDialog("�����빤�ţ�");
		return false;
	}
	
	if(document.all.opCodeAdd.value == 0) {
		rdShowMessageDialog("��ѡ��ҵ����룡");
		return false;
	}
	
	if(document.getElementById("limitValue").value.length < 1) {
		rdShowMessageDialog("�����뷧ֵ��");
		return false;
	}
	document.form1.confirm.disabled = false;
	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			if(document.getElementById("loginNo").value == bind_values1[i] && document.getElementById("opCodeAdd").value== notes[i]) {				
				rdShowMessageDialog("�����Ϣ�ظ���");
				document.getElementById("opCodeAdd").value = "0";
				document.getElementById("limitValue").value = "";
		    return false;
			}
		}
	}
	if(bind_values1.length>=20){
		rdShowMessageDialog("���ܳ���20�У����ύ��");
		document.getElementById("opCodeAdd").value = "0";
		document.getElementById("limitValue").value = "";
		return false;
	}
	
		
  var tableobj=document.getElementById("table_1"); 
	var rowobj=tableobj.insertRow(tableobj.rows.length); 

	var cell1=rowobj.insertCell(rowobj.cells.length); 
	var cell2=rowobj.insertCell(rowobj.cells.length); 
	var cell3=rowobj.insertCell(rowobj.cells.length); 
	var cell4=rowobj.insertCell(rowobj.cells.length); 
	
    cell1.innerHTML = '<td><input type="text" name="bind_values" id="bind_values" value="'+document.getElementById("loginNo").value+'" class="input-read"  readonly/></td>' ; 
    cell2.innerHTML = '<td><input type="text" name="notes" id="notes" value="'+document.getElementById("opCodeAdd").value+'" class="input-read" readonly/></td>' ; 
    cell3.innerHTML = '<td><input type="text" name="limitValue1" id="limitValue1" size="40" value="'+document.getElementById("limitValue").value+'" class="input-read" readonly/></td>' ; 
    cell4.innerHTML = '<td><img src="../../images/ico_delete.gif" alt="ɾ��" border="0" onclick="deleteRow('+(tableobj.rows.length-1)+');leo()"></td>' ;
  
	bind_values1.push(document.getElementById("loginNo").value) ;
	notes.push(document.getElementById("opCodeAdd").value) ;
	limitValue1.push(document.getElementById("limitValue").value) ;
	document.getElementById("opCodeAdd").value = "0";
	document.getElementById("limitValue").value = "";
	////alert(bind_values1.length);
	if(bind_values1.length>=20){
		rdShowMessageDialog("���ܳ���20�У����ύ��");
		return false;
	}
}

function deleteRow(i){                        
  var tableobj = document.getElementById("table_1"); 
  var returnValue = rdShowConfirmDialog("��ȷ��Ҫɾ��������Ϣ��");
  
  if (returnValue == rdConstOK) {
		tableobj.deleteRow(i); 
	}
	
	var temp = bind_values1[i-1];
	for(j=i-1 ; j<bind_values1.length-1; j++) {
		bind_values1[j] = bind_values1[j+1] ;
	}
	bind_values1[bind_values1.length-1] = temp ;
	bind_values1.pop() ;
	
	var temp = notes[i-1];
	for(j=i-1 ; j<notes.length-1; j++) {
		notes[j] = notes[j+1] ;
	}
	notes[notes.length-1] = temp ;
	notes.pop() ;
}

function leo(){//��ɾ��һ�к󣬶Ը������½������������� 
	var tableobj=document.getElementById("table_1"); 
	for(i=1;i<tableobj.rows.length;i++) { 
		tableobj.rows[i].cells[3].innerHTML = '<img src="../../images/ico_delete.gif" alt="Delete" border="0" onclick="deleteRow('+i+');leo()">';
	} 
} 

function CommitJsp(){//ȷ�ϰ�ť
	var loginNoList="";
	var opCodeAddList="";
	var limitValueList="";
	
	if(bind_values1.length==0){
		rdShowMessageDialog("�����ù�����ҵ�����Ķ�Ӧ��ϵ��");
		return false;
	}
	
	document.all.opCount.value=bind_values1.length;
	//alert(document.all.opCount.value);

	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			loginNoList=loginNoList+bind_values1[i]+",";
			opCodeAddList=opCodeAddList+notes[i]+",";
			limitValueList=limitValueList+limitValue1[i]+",";
		}	
	}
	document.all.loginNoStr.value=loginNoList;
	//alert(document.all.loginNoStr.value);
	document.all.opCodeAddStr.value=opCodeAddList;
	//alert(document.all.opCodeAddStr.value);
	document.all.limitValueStr.value=limitValueList;
	//alert(document.all.limitValueStr.value);
	document.form1.action="f8364_2.jsp";
 	form1.submit();
}

function commitJspQry(){//��ѯ��ť
	if(document.all.loginNo.value.length < 1) {
		rdShowMessageDialog("�����빤�ţ�");
		return false;
	}
	document.form1.action="f8364_3.jsp";
 	form1.submit();
}

</script> 
 
<title>�쳣���׼������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�쳣���׼������</div>
	</div>
<table cellspacing="0">             
	<tr>
		<td class="blue" width="10%">����</td>
		<td colspan="3">
			<input type="text" name="loginNo" id="loginNo" v_must="1" v_type="string" maxlength="6"  size="10">&nbsp;<font color="orange">*</font>
		</td>
	</tr>
	
	<tr>
		<td class="blue" width="10%">ҵ�����</td>
		<td nowrap colspan='3'> 
		  <select name="opCodeAdd" id="opCodeAdd" class="button">
		  	<option value="0">--��ѡ��--</option>
		 	  <%for (int i = 0; i < opCodeData.length; i++) {%>
			  <option value="<%=opCodeData[i][0]%>"><%=opCodeData[i][0]%>--><%=opCodeData[i][1]%>
			  </option>
		    <%}%>
		  </select>
		</td>
	</tr>	
	
	<tr>
		<td class="blue" width="10%">��ֵ</td>
		<td colspan="3">
			<input type="text" name="limitValue" id="limitValue" v_must="1" v_type="0_9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" maxlength="4" size="30">&nbsp;&nbsp;&nbsp;
			<input name="addButton" class="b_text" type="button" value="���" onClick="addRow()" >
		</td>
	</tr>	
	
	<tr>
		<td colspan="4">
			<table id="table_1">       
				<tr>
				<td class="blue" width="20%">����</td>
				<td class="blue" width="40%">ҵ�����</td>
				<td class="blue" width="30%">��ֵ</td>
				<td class="blue" width="10%">����</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="CommitJsp()">
			&nbsp;
			<input type="button" name="querry"  class="b_foot" value="��ѯ" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="close" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	
	<input type="hidden" name="loginNoStr">   
	<input type="hidden" name="opCodeAddStr">   
	<input type="hidden" name="limitValueStr">
	<input type="hidden" name="opCount">  
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>