<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:Ӫҵ����mac��ַ������
   * �汾: 1.0
   * ����: 2009/12/17
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
 
	String opCode = "8363";
	String opName = "Ӫҵ����mac��ַ������";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
%>

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
//----����һ����ҳ��ѡ����֯�ڵ�--- ����
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree_login.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
//У��mac��ַ
function macAddrCheck() {
	var macAddr = document.form1.macAddr.value;
	if (macAddr.search(/^\w{2}(-\w{2}){5}$/) != -1)
	{
	  //rdShowMessageDialog("У��ɹ�!",2);	
		return true;
	}
	else{
		rdShowMessageDialog("mac��ַ��ʽ����mac��ַ��ʽӦΪ��(XX-XX-XX-XX-XX-XX)");
		document.form1.macAddr.value = "";
	  document.form1.macAddr.focus();
	  return false;
	}
}
//���mac��ַ
function addRow(){
	
	if(document.all.groupName.value.length < 1) {
		rdShowMessageDialog("��ѡ��Ӫҵ����");
		return false;
	}
	
	if(document.all.macAddr.value.length < 1) {
		rdShowMessageDialog("������mac��ַ��");
		document.getElementById("macAddr").focus();
		return false;
	}
	if(document.all.macAddr.value.length != 17) {
		rdShowMessageDialog("mac��ַ������17λ�����������룡");
		document.getElementById("macAddr").value = "";
		document.getElementById("macAddr").focus();
		return false;
	}
	var bool = macAddrCheck();
	if (bool == true) {
	document.form1.confirm.disabled = false;
	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			if(document.getElementById("macAddr").value== notes[i]) {				
				rdShowMessageDialog("�����Ϣ�ظ���");
				document.getElementById("macAddr").value = "";
		    return false;
			}
		}
	}
	if(bind_values1.length>=20){
		rdShowMessageDialog("���ܳ���20�У����ύ��");
		document.getElementById("macAddr").value = "";
		return false;
	}
	
		
  var tableobj=document.getElementById("table_1"); 
	var rowobj=tableobj.insertRow(tableobj.rows.length); 

	var cell1=rowobj.insertCell(rowobj.cells.length); 
	var cell2=rowobj.insertCell(rowobj.cells.length); 
	var cell3=rowobj.insertCell(rowobj.cells.length); 
	var cell4=rowobj.insertCell(rowobj.cells.length); 
	
    cell1.innerHTML = '<td><input type="text" name="bind_values" id="bind_values" value="'+document.getElementById("groupId").value+'" class="input-read"  readonly/></td>' ; 
    cell2.innerHTML = '<td><input type="text" name="townname" id="townname" size="40" value="'+document.getElementById("groupName").value+'" class="input-read" readonly/></td>' ; 
    cell3.innerHTML = '<td><input type="text" name="notes" id="notes" value="'+document.getElementById("macAddr").value+'" class="input-read" readonly/></td>' ; 
    cell4.innerHTML = '<td><img src="../../images/ico_delete.gif" alt="ɾ��" border="0" onclick="deleteRow('+(tableobj.rows.length-1)+');leo()"></td>' ;
  
	bind_values1.push(document.getElementById("groupId").value) ;
	notes.push(document.getElementById("macAddr").value) ;
	document.getElementById("macAddr").value = "";
	//alert(bind_values1.length);
	if(bind_values1.length>=20){
		rdShowMessageDialog("���ܳ���20�У����ύ��");
		return false;
	}
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
	var groupidList="";
	var macAddrList="";
	
	if(bind_values1.length==0){
		rdShowMessageDialog("������Ӫҵ����mac��ַ��Ӧ��ϵ��");
		return false;
	}
	
	document.all.opCount.value=bind_values1.length;
	//alert(document.all.opCount.value);

	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			groupidList=groupidList+bind_values1[i]+",";
			macAddrList=macAddrList+notes[i]+",";
		}	
	}
	document.all.groupidStr.value=groupidList;
	//alert(document.all.groupidStr.value);
	document.all.macAddrStr.value=macAddrList;
	//alert(document.all.macAddrStr.value);
	document.form1.action="f8363_2.jsp";
 	form1.submit();
}

function commitJspQry(){//��ѯ��ť
	if(document.all.groupName.value.length < 1) {
		rdShowMessageDialog("��ѡ��Ӫҵ����");
		return false;
	}
	document.form1.action="f8363_3.jsp";
 	form1.submit();
}

</script> 
 
<title>Ӫҵ����mac��ַ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫҵ����mac��ַ������</div>
	</div>
<table cellspacing="0">             
	<tr>
		<td class="blue" width="10%">Ӫҵ��</td>
		<td colspan="3">
			<input type="hidden" name="groupId" id="groupId">
			<input type="text" name="groupName" id="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="30">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >	
		</td>
	</tr>
	
	<tr>
		<td class="blue" width="10%">mac��ַ</td>
		<td colspan="3">
			<input type="text" name="macAddr" id="macAddr" v_must="1" v_type="string" maxlength="17" size="30">&nbsp;&nbsp;&nbsp;
			<input name="addButton" class="b_text" type="button" value="���" onClick="addRow()" >
			&nbsp;<font color="orange">(��ʽ��XX-XX-XX-XX-XX-XX)</font>
		</td>
	</tr>	
	
	<tr>
		<td colspan="4">
			<table id="table_1">       
				<tr>
				<td class="blue" width="20%">Ӫҵ������</td>
				<td class="blue" width="40%">Ӫҵ������</td>
				<td class="blue" width="30%">mac��ַ</td>
				<td class="blue" width="10%">����</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="fileimport" class="b_foot" value="�ļ�����" onclick="location='f8363_import.jsp'">
			&nbsp;
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
	
	<input type="hidden" name="groupidStr">   
	<input type="hidden" name="macAddrStr">   
	<input type="hidden" name="opCount">  
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>