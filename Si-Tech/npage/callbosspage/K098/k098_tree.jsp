<%
  /*
   * ����: 098Ȩ�޽�ɫ����->Ȩ����
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gb2312"%>
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
	</HEAD>
	<BODY >
		<TABLE width="500" height="600">
			<input type="hidden" name="insertReturnVal" id="insertReturnVal" value=""/>
			<TR>
				<TD vAlign=top width="500" height="600">
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
	}else{
     //��������һ�����ҳ��
  	var tmpSelItemId = tree.getSelectedItemId();
	parent.frameright.ischeckBoxSelect(tmpSelItemId);
  	}
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
     //����������¼���չ���¼��ڵ�
     tree.setOnClickHandler(onClickNodeSelect);
     //tree.setOnDblClickHandler(onClickNodeSelect);
     tree.enableHighlighting(0);
     tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_createXml.jsp");
     // ��ʼչ����һ��
     document.getElementById('0').click();
     // alert(document.getElementById('0').tagName);
}

// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_getChildNodeList.jsp","aa");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}

//getTreeListByNodeId�Ļص�����
function doProcessGetList(packet){
   	var childNodeList = packet.data.findValueByName("nodes");
   	var nodeId= packet.data.findValueByName("nodeId");
   	//���ӽڵ��������
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
		     	//alert("--------------");
		       	//alert(retData[i][1]+"****"+retData[i][0]+"****"+retData[i][2]);
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
   }else{
   	//�����ǰ�ڵ������ӽڵ㣬�����䵱ǰ�ڵ��������ӽڵ�
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
	//�������ʱ�ڵ�ΪҶ�ڵ�����
	var isleaf = tree.getUserData(par_id,"isleaf");
	if(isleaf=='Y'){
		rdShowMessageDialog("����Ϊ���������ӽڵ㣡",1);
		return;	
	}	
	var time     = new Date();
	var winParam = 'dialogWidth=450px;dialogHeight=350px';
	window.showModalDialog("k098_newNodeWin.jsp?time="+time,window, winParam);
}
//���޸Ĳ����ĺ���
function showModifyNodeWin(){
	var nodeId = tree.getSelectedItemId();
	var nodeName =tree.getSelectedItemText();
     if(nodeId=='0'){
  		rdShowMessageDialog("�Բ��𣬸��ڵ����Ʋ������޸�",2);
  		return;
  	}
	var time     = new Date();
	var winParam = 'dialogWidth=450px;dialogHeight=250px';
	//window.showModalDialog("./k2901/k290_modifyNodeWin.jsp?time="+time,window, winParam);
	window.showModalDialog("k098_modifyNodeWin.jsp?time="+time,window, winParam);
}

function deleNode(){
	var nodeId = tree.getSelectedItemId();
	var nodeName =tree.getSelectedItemText(); 
	var par_id=tree.getParentId(nodeId);
	var isleaf =tree.getUserData(tree.getSelectedItemId(),"isleaf");
	//�жϸ��ڵ�  
	if(nodeId=='0'){
  		rdShowMessageDialog("�Բ��𣬸��ڵ㲻����ɾ��",2);
  		return;
  	}
  	if(isleaf=='N'){
  		if(rdShowConfirmDialog("��ȷ��Ҫɾ��["+nodeName+"]���������е��ӽڵ�ô��")=="1"){
			deleteNode(nodeId,par_id,nodeName);
	 	}
  	}else{
  		if(rdShowConfirmDialog("��ȷ��Ҫɾ��["+nodeName+"]�ڵ�ô��")=="1"){
			deleteNode(nodeId,par_id,nodeName);
	 	}	
  	}
} 

//��ɾ�������ĺ���
function deleteNode(login_group_id,par_id,nodeName){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K098/k098_deleteNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",login_group_id);
	packet.data.add("par_Id",par_id);
	core.ajax.sendPacket(packet,doProcessDelNode,true);
	packet=null;
}
	
//ɾ���ڵ�Ļص�
function doProcessDelNode(packet){
	var retCode = packet.data.findValueByName("retCode");
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
