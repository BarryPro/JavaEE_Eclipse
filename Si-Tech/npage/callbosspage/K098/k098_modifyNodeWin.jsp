<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->�޸�(����)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>�޸�Ȩ��</title>

<script language=javascript>

// �������¼
function cleanValue(){
document.getElementById("nodeName").value="";
document.getElementById("note").value="";		
}
//do initialize
function initValue(){	
	var pdoc = window.dialogArguments;
	var selectItemId     =pdoc.tree.getSelectedItemId();
	var selectItemName   =pdoc.tree.getSelectedItemText();
  	var parnertId        =pdoc.tree.getParentId(selectItemId);	
  	var parnertName      =pdoc.tree.getItemText(parnertId);	
  	var note             =pdoc.tree.getUserData(selectItemId,"note");
	document.getElementById('parNodeName').value=parnertName;
	document.getElementById('parNode').value=parnertId;
	document.getElementById('nodeId').value=selectItemId;
	document.getElementById('nodeName').value=selectItemName;
  	document.getElementById('note').value=note;
  	//get node jsCode
  	//getJsCode();

}

//get jscode 
function getJsCode(){
	var pdoc = window.dialogArguments;
	var selectItemId =pdoc.tree.getSelectedItemId();	
	var packet=new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_getNodeJsCode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");	
	packet.data.add('selectItemId',selectItemId);
	core.ajax.sendPacket(packet,doGetJsCode,false);
	packet=null;
}

function doGetJsCode(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='000000'){
		var jsCode = packet.data.findValueByName("jsCode");
		document.getElementById("jsCode").value = jsCode;
	}
}


//exit window
function closeWin(){
	window.close();
}
// modify node
function modifyNode(){
	
	 //add  by yinzx 20091120 ��ע������� ����
			var	obj_note_value= document.all.note.value ;
	 		var note_length=obj_note_value.replace(/[^\x00-\xff]/g,"**").length;
	 		if(note_length>30)
	 		{
	 			rdShowMessageDialog("����ı�ע���ȹ��������������룡");
	 			return false;
			}	
			
	var pdoc = window.dialogArguments;
	var nodeName = document.getElementById("nodeName").value;
	var nodeId=document.getElementById('nodeId').value;
	var note=document.getElementById('note').value;
	if(nodeName == ""){
		rdShowMessageDialog("������ù��ܵ����ƣ�",1);
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",nodeId);
	packet.data.add("note",note);
	core.ajax.sendPacket(packet,doneModifyProcess,false);
	packet=null;
}

function doneModifyProcess(packet) {
	var pdoc = window.dialogArguments;
	var retCode = packet.data.findValueByName("retCode");	
	if (retCode == "000000") {
		var nodeName = packet.data.findValueByName("nodeName");
		var note = packet.data.findValueByName("note");
		// �����޸Ľڵ������
		var nodeId = pdoc.tree.getSelectedItemId();
		pdoc.tree.setItemText(nodeId,nodeName);
		pdoc.tree.setUserData(nodeId,"note",note);	
		rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
		return;
	} else {
		rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
		return false;
	}	
}

</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
  				<td class="blue">�ϲ�ڵ��� </td>
  				<td width="70%">
  					<input id="parNode" name="parNode" size="30" type="text"  Class="InputGrey" readOnly value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">�ϲ�ڵ����� </td>
  				<td width="70%">
       				<input id="parNodeName" name="parNodeName" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">��ǰ�ڵ��� </td>
  				<td width="70%">
  					<input id="nodeId" name="nodeId" size="30" readOnly  Class="InputGrey"  type="text" value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">��ǰ�ڵ����� </td>
  				<td width="70%">
  					<input id="nodeName" name="nodeName" size="30" type="text" value="" v_must="1" v_type="string" onBlur="checkElement(this)">
	    				<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">���� </td>
  				<td  width="60%">
  					<textarea name="note" id="note" cols="30" rows="4"></textarea>
	  			</td>
			</tr>
			<!--tr>
  				<td>js���ܴ��룺</td>
  				<td  width="60%">
  					<textarea name="jsCode" cols="30" rows="4"></textarea>
	  			</td>
			</tr-->
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="modifyNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
	//ҳ������¼�
	initValue();
</script>