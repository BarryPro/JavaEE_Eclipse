<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->�ʼ��������б�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����:
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
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css"
			type=text/css rel=STYLESHEET>
			
		<SCRIPT
			src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js"
			type=text/javascript></SCRIPT>
		<SCRIPT
			src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js"
			type=text/javascript></SCRIPT>
			
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		<!-- added by tangsong 20100823 ��������: ������ʽ�������������߶Ͽ�-->
		<style type="text/css">
			#basetree td {
				padding:0;
			}
		</style>
	</HEAD>
	<BODY >
		<!-- update by tangsong 20100823 �������������ĳ��ֵ�������������ĳ���
		<table width="100%" height="100%" >
		-->
		<table width="100%" height="90%" >
			<input type="hidden" name="insertReturnVal" id="insertReturnVal" value=""/>
			<TR>
				<TD vAlign=top>
					<DIV id="baseTree"></DIV>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</html>
<SCRIPT type=text/javascript> 
function fixImage(id){
	switch(tree.getLevel(id)){
	case -1:	
		tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
		break;
	case 0:	
		tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
		break;
	case 1:
		tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
		break;
	case 2:
		tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');			
		break;
	case 3:
		tree.setItemImage2(id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');			
		break;			
	default:
		tree.setItemImage2(id,'leaf.gif','folderClosed.gif','folderOpen.gif');			
		break;
	}
}
//�����¼�
function onClickNodeSelect(){        
   
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }
  // ��������һ�����ҳ��
  	var tmpSelItemId = tree.getSelectedItemId();
	parent.frameright.ischeckBoxSelect(tmpSelItemId);
}
function getSelectItemIdByCheck(){
	return tree.getSelectedItemId();
	}
//��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
		showNodeIdList(allCheckItem);//�����Ż����� ������ȥ��ѯ���ݿ�
	}  
}

//�ж���checkbox�Ƿ���ֵ 
function isCheckBoxsList(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null&&allCheckItem!=''){
		return true;
	}else{
		return false;	
	} 
}
	 
// ȡ�����е�checkboxѡ��
function unCheckBoxBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null&&allCheckItem!=''){
		var str = new Array();
		str=allCheckItem.split(",");
		for(var i=0;i<str.length;i++){
			tree.setCheck(str[i],false);
		}
	}
}

//����һ����̬��
function initBaseTree(){	
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
    tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
    // ����������¼���չ���¼��ڵ�
    tree.setOnClickHandler(onClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k290_createXml.jsp");
    
    // ��ʼչ����һ��
    document.getElementById('0').click();
}

// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k290_getChildNodeList.jsp","aa");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}

//getTreeListByNodeId�Ļص�����
function doProcessGetList(packet){
   	var childNodeList = packet.data.findValueByName("nodes");
   	var nodeId= packet.data.findValueByName("nodeId");
    insertChildNodeList(childNodeList);
}

//����������ĺ���  
function insertChildNodeList(retData){
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	//�жϸýڵ�д�Ƿ����ӽڵ㣬������жϹ���һ�µ�ǰ�ڵ�ֵ�Ƿ������ݿ����ֵһ��
   	if(varSubItems!=null&&varSubItems!=''){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
    //���˵�ǰ�ڵ����ӽڵ������ݿ��Ƿ���ͬ
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	 
        tree.setUserData(retData[i][0],"note",retData[i][4]);	    
       }
       //���ýڵ���ʾ��ͼƬ
       if(retData[i][3]=='N'){
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=='Y'){
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          } 
     }
    //�����ǰ�ڵ������ӽڵ㣬�����䵱ǰ�ڵ��������ӽڵ�
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
        tree.setUserData(retData[i][0],"note",retData[i][4]);		
         if(retData[i][3]=='N'){
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=='Y'){
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          }     	
     	}
}

}

//����������ĺ���
function showNewNodeWin(){
	var par_id= tree.getSelectedItemId();
	var par_Text=tree.getSelectedItemText();
	
	var time     = new Date();
	var winParam = 'dialogWidth=580px;dialogHeight=400px';
	window.showModalDialog("k290_newNodeWin.jsp?time="+time,window, winParam);
}

function showModifyNodeWin(){
	var nodeId = tree.getSelectedItemId();
	var nodeName =tree.getSelectedItemText();
  if(nodeId=='0'){
  	similarMSNPop("�Բ��𣬸��ڵ����Ʋ������޸ģ�");
  	return;
  	}
	var time     = new Date();
	var winParam = 'dialogWidth=580px;dialogHeight=400px';
	window.showModalDialog("./k2901/k290_modifyNodeWin.jsp?time="+time,window, winParam);
}
function deleNode(){
		var nodeId = tree.getSelectedItemId();
	  var nodeName =tree.getSelectedItemText(); 
	  var par_id=tree.getParentId(nodeId);
	  var isleaf =tree.getUserData(tree.getSelectedItemId(),"isleaf");
	  
	  if(nodeId=='0'){
  	similarMSNPop("�Բ��𣬸��ڵ㲻����ɾ����");
  	return;
  	}
  	if(isleaf=='N'){
    similarMSNPop("�Բ��𣬵�ǰ�ڵ����ӽڵ㣬��ɾ���ӽڵ�����ɾ����");
  	return;
  	}
   if(rdShowConfirmDialog("��ȷ��Ҫ��Ҫɾ��"+nodeName+"��ô��")=="1"){
		deleteNode(nodeId,par_id);
	 }
	} 

// AJAX�ص������������ݷ��ص�retType�жϾ������
function doneProcess(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType == "insertNewNode"){
		if (retCode == "000000") {
			var login_group_id = packet.data.findValueByName("login_group_id");
			var parent_group_id = packet.data.findValueByName("parent_group_id");
			var login_group_name = packet.data.findValueByName("login_group_name");
			var note = packet.data.findValueByName("note");
			// ��ӳɹ�����̬��ҳ����ӽڵ�
		  tree.insertNewItem(parent_group_id,login_group_id,login_group_name,0,0,0,0,'SELECT');
	   	  tree.setUserData(login_group_id,"isleaf",'Y');	
	   	  tree.setUserData(login_group_id,"note",note);	
	   	  document.getElementById("insertReturnVal").value="1";
			return;
		} else {
			document.getElementById("insertReturnVal").value="-1";
			return false;
		}
	}
	if(retType == "modifyNode"){
		if (retCode == "000000") {
			var nodeName = packet.data.findValueByName("nodeName");
			var note = packet.data.findValueByName("note");
			// �����޸Ľڵ������
			var nodeId = tree.getSelectedItemId();
			tree.setItemText(nodeId,nodeName);
			tree.setUserData(nodeId,"note",note);	
			similarMSNPop("\u5904\u7406\u6210\u529f");
			return;
		} else {
			similarMSNPop("\u5904\u7406\u5931\u8d25");
			return false;
		}
	}
	if(retType=="deleteNode"){
				if (retCode == "000000") {
			// �����޸Ľڵ������
			var flag = packet.data.findValueByName("flag");
			var par_Id=packet.data.findValueByName("par_Id");		
			var nodeId = tree.getSelectedItemId();
			tree.deleteItem(nodeId,true);
			if(flag=='Y'){
				  tree.setUserData(par_Id,"isleaf",'Y');	
				  tree.setItemImage2(par_Id,'leaf.gif','folderClosed.gif','folderOpen.gif');		
				}else{
					tree.setUserData(par_Id,"isleaf",'N');	
					tree.setItemImage2(par_Id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
				}
			similarMSNPop("ɾ���ʼ���ɹ���");
			return;
		} else {
			similarMSNPop("ɾ���ʼ���ʧ�ܣ�");
			return false;
		}
		}
}

//����������ĺ���
function insertNewNode(parNode,nodeName,note){
	var nodeId = parNode;
	//alert(nodeName);
	var isleaf =tree.getUserData(nodeId,"isleaf");
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k290_insertNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","insertNewNode");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",parNode);
	packet.data.add("note",note);
	packet.data.add("isleaf",isleaf);
	core.ajax.sendPacket(packet,doneProcess,false);
	packet=null;
}

//���޸Ĳ����ĺ���
function modifyNode(login_group_id,login_group_name,note){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k2901/k290_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",login_group_name);
	packet.data.add("nodeId",login_group_id);
	packet.data.add("note",note);
	core.ajax.sendPacket(packet,doneProcess,false);
	packet=null;
}
//��ɾ�������ĺ���
function deleteNode(login_group_id,par_id){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k2901/k290_deleteNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("retType","deleteNode");
	  packet.data.add("nodeId",login_group_id);
	  packet.data.add("par_Id",par_id);
	  core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
	}
//�ж�һ���ַ����Ƿ��������г���
function isStr(strtreeData,str){
	if(str!=null){
		for(var j=0;j<str.length;j++){
     		if(strtreeData==str[j]){
     			return true;
     		}
		}
	}
	return false;
}
   
//��ʼ����
initBaseTree();


</SCRIPT>
