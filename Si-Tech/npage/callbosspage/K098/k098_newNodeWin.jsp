<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����(����)
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
<title>����Ȩ�޹���</title>

<script language=javascript>

// �������¼
function cleanValue(){
document.getElementById("newNodeName").value="";
document.getElementById("note").value="";		
}

//exit window
function closeWin(){
	window.close();
}

//add new node
function addNewNode(){
 //add  by yinzx 20091120 ��ע������� ����
			var	obj_note_value= document.all.note.value ;
	 		var note_length=obj_note_value.replace(/[^\x00-\xff]/g,"**").length;
	 		if(note_length>30)
	 		{
	 			rdShowMessageDialog("����ı�ע���ȹ��������������룡");
	 			return false;
			}	
			
	var pdoc = window.dialogArguments;
	var selectItemId =pdoc.tree.getSelectedItemId();
	var newNodeName = document.getElementById("newNodeName").value;
	var newNodeId = document.getElementById("newNodeId").value;
	var note=document.getElementById("note").value;
	var check=document.getElementById("checkImgN").style.display;
	if(check=='block'){
		rdShowMessageDialog("�ڵ����Ѵ��ڣ����������룡",1);
		return;
	}
	if(newNodeName == ""||newNodeId==""){
		rdShowMessageDialog("����������Ȩ�޵ı�ź����ƣ�",1);
		return;
	}
	var el_nodeType=document.getElementsByName("nodeType");
	var nodeType;
	for(var i=0;i<el_nodeType.length;i++){
		if(el_nodeType[i].checked==true){
			nodeType = el_nodeType[i].value;
			break;	
		}				
	}	
	//�ڵ��������û�������������Ľڵ���Ҷ��
	var isleaf = nodeType;
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_insertNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("newNodeId",newNodeId);
	packet.data.add("newNodeName",newNodeName);
	packet.data.add("parNodeId",selectItemId);
	packet.data.add("note",note);
	packet.data.add("isleaf",isleaf);
	core.ajax.sendPacket(packet,doneUpdateProcess,true);
	packet=null;	
}

// update treeview
function doneUpdateProcess(packet) {
	var pdoc = window.dialogArguments;
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
		
	if (retCode == "000000") {
		var newNodeId = packet.data.findValueByName("newNodeId");
		var newNodeName = packet.data.findValueByName("newNodeName");
		var parNodeId = packet.data.findValueByName("parNodeId");
		var note = packet.data.findValueByName("note");
		var isleaf = packet.data.findValueByName("isleaf");
		// ��ӳɹ�����̬��ҳ����ӽڵ�
	   	pdoc.tree.insertNewItem(parNodeId,newNodeId,newNodeName,0,0,0,0,'SELECT');
	   	pdoc.tree.setUserData(newNodeId,"isleaf",isleaf);
	   	pdoc.tree.setUserData(newNodeId,"note",note);	   	
		if(rdShowConfirmDialog("���Ȩ�޳ɹ����Ƿ������ӣ�",2) != 1){
			window.close();
		}		
	} else {
		rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
		window.close();
	}
}

//do initialize
function initValue(){
	var pdoc = window.dialogArguments;
	var selectItemId =pdoc.tree.getSelectedItemId();
	var level=pdoc.tree.getLevel(selectItemId);
  
     var nodeId = pdoc.tree.getSelectedItemId();
     var nodeName = pdoc.tree.getSelectedItemText();
	document.getElementById("nodeLevel").value='['+nodeName+']���ӽڵ�';

	if(level>'2'){
		defineSubNodeId();
	}		
}

//generate nodeId by system
function defineSubNodeId(){
	var pdoc = window.dialogArguments;
	var selectItemId =pdoc.tree.getSelectedItemId();	
	var packet=new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_defineNewNodeId.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");	
	packet.data.add('selectItemId',selectItemId);
	core.ajax.sendPacket(packet,doDefineSubNodeId,false);
	packet=null;
}

function doDefineSubNodeId(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='000000'){
		var newNodeId = packet.data.findValueByName("newNodeId");
		//alert(retCode+' '+newNodeId);
		document.getElementById("newNodeId").value = newNodeId;
		document.getElementById("newNodeId").readOnly = true;
	}
	
}

// check nodeId which inputed by users
function checkNodeId(el){
	/*add by yinzx 20091002*/
		if(!forNumChar(document.sitechform.newNodeId))
	{
		document.sitechform.newNodeId.value="";  
		rdShowMessageDialog("�ڵ���Ӧ����ĸ��������ɣ�",1); 
		return false;
	}
	
	var nodeId=el.value;
	if(nodeId==''){
		document.getElementById("checkImgP").style.display='none';
		document.getElementById("checkImgN").style.display='none';	
		return;
	}
	var packet=new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_checkNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");	
	packet.data.add('nodeId',nodeId);
	core.ajax.sendPacket(packet,doCheckNodeId,false);
	packet=null;

}
function doCheckNodeId(packet){
	var retCode=packet.data.findValueByName("retCode");
	if(retCode=='000000'){
		document.getElementById("checkImgP").style.display='block';
		document.getElementById("checkImgN").style.display='none';
	}else{
		document.getElementById("checkImgN").style.display='block';
		document.getElementById("checkImgP").style.display='none';
	}
}


</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
				<td class="blue">�����ڵ��� </td>
  				<td width="70%">
					<input id="nodeLevel" name ="nodeLevel" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>		
			<tr>
  				<td class="blue">�����ڵ����� </td>
  				<td width="70%">
       				<input id="nodeType1" name ="nodeType" size="30" type="radio" checked  value="N">��������Ŀ¼
       				<input id="nodeType2" name ="nodeType" size="30" type="radio"  value="Y">�������
	  			</td>
			</tr>			
			<tr>
  				<td class="blue"> �����ڵ��� </td>
  				<td width="70%">
     				 <input id="newNodeId" name ="newNodeId" size="30" type="text" v_must="1" v_type="string" onBlur=checkElement(this) value="" onkeyup="value=value.replace(/[^A-Za-z\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^A-Za-z\d]/g,''))" >
	  				<font color="orange">*</font>
	  				<span id="checkImgP" style="display:none" float:right>
	  					<img src=<%=request.getContextPath()%>"/nresources/default/images/popup_ok.gif" alt="�˱�ſ���ʹ��."/>�˱�ſ���ʹ��.
	  				</span>
	  				<span id="checkImgN" style="display:none">
	  					<img src=<%=request.getContextPath()%>"/nresources/default/images/popup_x.gif" alt="�˱���Ѵ��ڣ�����������!"/>�˱���Ѵ��ڣ�����������!
	  				</span>
	  			</td>
			</tr>		
			<tr>
  				<td class="blue">�����ڵ����� </td>
  				<td  width="70%">
  					<input id="newNodeName" name ="newNodeName" size="30" type="text" value="" v_must="1" v_type="string" onBlur=checkElement(this)>
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">���� </td>
  				<td  width="60%">
  					<textarea name="note" cols="30" rows="4"></textarea>
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
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="addNewNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="�˳�" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<SCRIPT type=text/javascript> 
	//ҳ������¼�
	initValue();	

</SCRIPT>