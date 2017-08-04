<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css"
			type=text/css rel=STYLESHEET>
		<LINK
			href="<%=request.getContextPath()%>/css/dhtmlxtree_css/dhtmlxtree.css"
			type=text/css rel=STYLESHEET>
		<SCRIPT
			src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxcommon.js"
			type=text/javascript></SCRIPT>
		<SCRIPT
			src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxtree.js"
			type=text/javascript></SCRIPT>
	</HEAD>

	<BODY>
		<TABLE>
			<TR>
				<TD vAlign=top width="300" height="450">
					<DIV id="baseTree"></DIV>
				</TD>
			</TR>
		</TABLE>
		<TABLE width="100%">
			<TR>
				<TD>
					<input type="button" onclick="showNewNodeWin()" value="����" class="b_text"/>
					<input type="button" onclick="showModifyNodeWin()" value="�޸�" class="b_text"/>
					<input type="button" onclick="deleNode()" value="ɾ��" class="b_text"/>
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
  window.top.frameright.window.ischeckBoxSelect(tree.getSelectedItemId());
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
    tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");
    // ����������¼���չ���¼��ڵ�
    tree.setOnClickHandler(onClickNodeSelect);
   // tree.setOnDblClickHandler(onClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/K280/k280_createXml.jsp");
    
    // ��ʼչ����һ��
   // alert(document.getElementById('0'));
    document.getElementById('0').click();
    alert(document.getElementById('0').tagName);
}

// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k280_getChildNodeList.jsp","aa");
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
	var height = 280;
	var width = 450;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
	window.open("k280_newNodeWin.jsp?par_Text="+par_Text, "newNodeWin", winParam);
}

function showModifyNodeWin(){
	var nodeId = tree.getSelectedItemId();
	var nodeName =tree.getSelectedItemText();
  if(nodeId=='0'){
  	rdShowMessageDialog("�Բ��𣬸��ڵ����Ʋ������޸�",2);
  	return;
  	}
	var height = 280;
	var width = 450;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
	window.open("./k2801/k280_modifyNodeWin.jsp?nodeId=" + nodeId+"&nodeName="+nodeName, "modifyNodeWin", winParam);
}
function deleNode(){
		var nodeId = tree.getSelectedItemId();
	  var nodeName =tree.getSelectedItemText(); 
	  var par_id=tree.getParentId(nodeId);
	  var isleaf =tree.getUserData(tree.getSelectedItemId(),"isleaf");
	  if(nodeId=='0'){
  	rdShowMessageDialog("�Բ��𣬸��ڵ㲻����ɾ��",2);
  	return;
  	}
  	if(isleaf=='N'){
    rdShowMessageDialog("�Բ��𣬵�ǰ�ڵ����ӽڵ㣬��ɾ���ӽڵ�����ɾ��",2);
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
			
			// ��ӳɹ�����̬��ҳ����ӽڵ�
		  tree.insertNewItem(parent_group_id,login_group_id,login_group_name,0,0,0,0,'SELECT');
   	  tree.setUserData(login_group_id,"isleaf",'Y');	
			rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
			return;
		} else {
			rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
			return false;
		}
	}
	if(retType == "modifyNode"){
		if (retCode == "000000") {
			var nodeName = packet.data.findValueByName("nodeName");

			// �����޸Ľڵ������
			var nodeId = tree.getSelectedItemId();
			tree.setItemText(nodeId,nodeName);
			rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
			return;
		} else {
			rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
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
			rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
			return;
		} else {
			rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
			return false;
		}
		}
}

//����������ĺ���
function insertNewNode(name){
	var nodeId = tree.getSelectedItemId();
	var isleaf =tree.getUserData(tree.getSelectedItemId(),"isleaf");
	//alert("isleaf:\t"+isleaf);
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k280_insertNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","insertNewNode");
	packet.data.add("nodeName",name);
	packet.data.add("nodeId",nodeId);
	packet.data.add("isleaf",isleaf);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
}

//���޸Ĳ����ĺ���
function modifyNode(login_group_id,login_group_name){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k2801/k280_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",login_group_name);
	packet.data.add("nodeId",login_group_id);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
}
//��ɾ�������ĺ���
function deleteNode(login_group_id,par_id){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k2801/k280_deleteNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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
