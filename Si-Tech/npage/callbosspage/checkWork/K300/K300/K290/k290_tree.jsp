<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
		<TABLE width="400" height="1000" >
			<TR>
				<TD vAlign=top width="400" height="100%">
					<DIV id="baseTree"></DIV>
				</TD>
			</TR>
		</TABLE>
		<input type="hidden"   id="checkedGroup" value=""/>
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
     if(tree.getSelectedItemId()!=0){
  	  getCheckGroupLoginNo();
  	}
  }else{
  	  getCheckGroupLoginNo();
  	
  }

//  alert("getSelectedItemId"+tree.getSelectedItemId());
}	 
//����һ����̬��
function initBaseTree(){	
	  tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
    tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
    // ����������¼���չ���¼��ڵ�
    tree.setOnClickHandler(onClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K290/k290_createXml.jsp");
    // ��ʼչ����һ��
    //��һ��ģ�����¼�
    document.getElementById('0').click();
}

// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K290/k290_getChildNodeList.jsp","aa");
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

//���������ӽڵ�  
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
// ���ص�ǰ�ʼ칤�����Ӧ�Ĺ���
function getCheckGroupLoginNo(){
  var nodeId = tree.getSelectedItemId();
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K290/k290_getLoginNoByCheckGroupId.jsp","aa");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessCheckLoginList,false);
	packet=null;
}
//getTreeListByNodeId�Ļص�����
function doProcessCheckLoginList(packet){
   	var loginNoList = packet.data.findValueByName("loginNoList");
   	var checkedGroupList = packet.data.findValueByName("checkedGroupList");
  // 	var num=loginNoList.length;
   //	setGroupLoginNoNum(num);
    document.getElementById("checkedGroup").value=checkedGroupList; 
    window.parent.leftFootFrame.addOption(loginNoList); 
    window.parent.rightCenterTree.location.href="/npage/callbosspage/checkWork/K300/K280/k280_tree.jsp";  
   
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
function getCheckedGroupList(){
	var checkedGroup= document.getElementById("checkedGroup").value;
  return checkedGroup;
 }
function setGroupLoginNoNum(num){
	//alert(tree.getSelectedItemId()+tree.getSelectedItemText());
	if(tree.getUserData(tree.getSelectedItemId(),"flag")!='0'){
	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='Y'){
		tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��');
		tree.setUserData(tree.getSelectedItemId(),"flag",'0');	
	}else{
		tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��,��������������');
		tree.setUserData(tree.getSelectedItemId(),"flag",'0');	
		}
	}
	} 
//��ʼ����
initBaseTree();


</SCRIPT>
