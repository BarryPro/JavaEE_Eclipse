<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
%>
<html>
<head>
<script language=javascript>
///yanghy 20090917�޸�.
searchNode();
// ����ajax����select������.
function searchNode() {
	var ccno=window.parent.parent.opener.top.document.getElementById("ccno").value;
	var packet = new AJAXPacket(
			"<%=request.getContextPath()%>/npage/callbosspage/callTrans/callTransList.jsp?ccno="+ccno,
			"���ڲ�ѯ,���Ժ�...");
	core.ajax.sendPacket(packet, doSearchNode, true);
	packet = null;
}
function searchNodeByGroupId(group_id) {
	var ccno=window.parent.parent.opener.top.document.getElementById("ccno").value;
	var packet = new AJAXPacket(
			"<%=request.getContextPath()%>/npage/callbosspage/callTrans/callTransList.jsp?ccno="+ccno+"&group_id="+group_id,
			"���ڲ�ѯ,���Ժ�...");
	core.ajax.sendPacket(packet, doSearchNode, true);
	packet = null;
}
// ����select�����������.�ص�����.
function doSearchNode(packet) {
	var contact = packet.data.findValueByName("contact");
	var tableid = document.getElementById("dataTable");
	// var tr=tableid.insertRow();
	// var td = tr.insertCell();
	var str = "";
	str = "<select id='queueid' size='18' style='width:99%;height:430px'  onClick='insertOperation(this.value)'>";
	//str += "<option value=''>��ѡ��&nbsp;</option>";
	//yanghy 20090918 del option.
	for ( var i = 0; i < contact.length; i++) {
		str += "<option value='" + contact[i][0] + "|" + contact[i][1] + "'>"
				+ contact[i][1] + "</option>";
	}
	str += "</select>";
	tableid.innerHTML = str;
	// alert(str);
}
// �������.
function insertOperation(objv) {
	var str = objv.split("|");
	document.getElementById("operation").value = str[1];
}


// ת�˹����к���.
function transQueue(){
	var usSkillID = document.getElementById("queueid").value;
	if (usSkillID == "") {
		rdShowMessageDialog("��δѡ���ܣ�");// û��ѡ����з���.
		return;
	}
	skillId = usSkillID.split("|")[0];
	var queueType;
	var ts = document.getElementsByName("trans");
	for ( var i = 0; i < ts.length; i++) {
		if (ts[i].checked) {
			queueType = ts[i].value;
		}
	}
	var ret = window.parent.parent.opener.top.cCcommonTool.transSkillGroup(skillId,queueType);
	if(ret == 0){
		recordTransToGroup(usSkillID,"Y");
	}else{
		recordTransToGroup(usSkillID,"N");
	}
	window.top.close();
}


/*
*@function:ת���ܶ��е���־��¼,�������ݵ�dcallTransfer��
*@transType:99��ʾת�˹�����
*@
*/
function recordTransToGroup(skill,flag){
	var mainWin = window.top.opener.top;
	var caller = "";
	if(mainWin.cCcommonTool.getOp_code()=="K025"){    
	   caller = mainWin.cCcommonTool.getCalled();
	}else{    
	   caller = mainWin.cCcommonTool.getCaller();
	}
	var transType = "99";
	var op_code = mainWin.cCcommonTool.getOp_code();
	var contactId = mainWin.document.getElementById("contactId").value;
	var index = skill.indexOf("|");
	var skillId = skill.substring(0,index);
	var skillName = skill.substring(index+1,skill.length);
	var packet = new AJAXPacket("../../../npage/callbosspage/K029/callSwichInsert.jsp","���ڴ���,���Ժ�...");
	packet.data.add("contactId",contactId);
	packet.data.add("caller",caller);
	packet.data.add("skillId",skillId);
	packet.data.add("skillName",skillName);
	packet.data.add("op_code",op_code);
	packet.data.add("transType",transType);
	packet.data.add("is_success",flag);
	core.ajax.sendPacket(packet, function(packet){
	}, true);
	mainWin = null;
	packet = null;
}

var is_request = 0;
// �ڲ���������.
function transInnerHelp() {
	if(is_request==1){
		return;
		}
	is_request = 1;
	var usSkillID = document.getElementById("queueid").value;
	if (usSkillID == "") {
		rdShowMessageDialog("��δѡ���ܣ�");// û��ѡ����з���.
		return;
	}
	usSkillID = usSkillID.split("|")[0];
	var queueType = 2;
	var work_no;
	var ret;
	ret = window.parent.parent.opener.top.cCcommonTool.InternalHelpEx2(5,usSkillID,1,work_no);

	if(ret==0){
		window.top.opener.innerHelpSkill = document.getElementById("operation").value;
		window.top.close();
	}else if (ret==1138)
		{
			  document.getElementById("InnerHelpButton").disabled='true';
 
			  setTimeout(InnerHelpUser,5000);   
		}
	is_request = 0;
}

//���ð�ť.
function resettext() {
	document.getElementById("queueid").value = "";
	document.getElementById("operation").value = "";
}

function InnerHelpUser() {
	 document.getElementById("InnerHelpButton").disabled='';
}
</script>
<style type="text/css">
body
{
 margin:0;
 padding:0;
 font:12px Verdana, Arial, Helvetica, sans-serif,"����"��"����";
 line-height:1.8em;
 text-align:left;
 color:#003399;
 background-color: #eef2f7;
}
html {
 scrollbar-face-color:#d5e1f7;
 scrollbar-highlight-color:#FFFFFF;
 scrollbar-shadow-color:#DEEBF7;
 scrollbar-3dlight-color:#89b3e3;
 scrollbar-arrow-color: #121f54;
 scrollbar-track-color:#F4F0EB;
 scrollbar-darkshadow-color:#89b3e3;
 overflow:hidden;
}
</style>
</head>
<body>
<form name="queueForm" method="post" action="">
<!--���д��� -->
<div id="Operation_Table" width="100%" style="margin: 0; padding: 0;">
	<table  width="100%" height="200px" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="middle" colspan="2">
		<input type="hidden" id="CityCode" name="CityCode" value=""/>
		<div id="dataTable" cellspacing="0" width="98%">
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" id="footer">
			<div style="float: left;">
			ҵ�����
			<select id="city_code" name="city_code" style="width: 70px;" onchange="searchNodeByGroupId(this.value)">
			<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
			<wtc:sql>select CITY_CODE , region_name from scallregioncode where valid_flag = 'Y' order by region_code</wtc:sql>
			</wtc:qoption>
			</select>	
			ҵ��<input type="text" id="operation" value="" size="40" style="width: 180px;" readonly="readonly"> 
			<input type="button" class="b_foot" value="ת��"  
			 onClick="transQueue()">
			<input type="radio" name="trans" value="2" checked>�ɹ�ת
			<input type="radio" name="trans" value="0">�ͷ�ת 
			
			<input type="button" class="b_foot" id="InnerHelpButton" value="�ڲ�����" 
			 onClick="transInnerHelp()">
			<input type="button" class="b_foot" value="ȡ��"  
			 onClick="resettext();">
			<input type="button" class="b_foot" value="�ر�"  
			 onClick="parent.window.close();">
			</div>
		</td>
	  </tr>
	</table>	
</div>
</form>
<script language=javascript>
//��ȡ���б��.
var callData = window.parent.parent.opener.top.cCcommonTool.QueryCallDataEx();
if (callData == '' || callData == undefined) {
	rdShowMessageDialog('�Բ���û�в鵽��Ӧ������', 0);
} else {
	var str = callData.split(",");
	document.queueForm.CityCode.value = str[1];
}
document.getElementById("city_code").value = document.getElementById("CityCode").value;
</script>
</body>
</html>