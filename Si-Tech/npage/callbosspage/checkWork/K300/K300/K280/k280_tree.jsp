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
		<TABLE width="400" height="1000">
			<TR>
				<TD vAlign=top width="400" height="100%">
					<DIV id="baseTree"></DIV>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</html>
<SCRIPT type=text/javascript> 

//�����¼�
function onClickNodeSelect(){        
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  	tree.showItemCheckbox(tree.getSelectedItemId(),0);
  	getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }else{
  	tree.showItemCheckbox(tree.getSelectedItemId(),1);
  }
}
//��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
	//	alert(allCheckItem);
  parent.rightCenterLoginNo.ischeckBoxSelect(allCheckItem);
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
    tree.enableCheckBoxes(1); 
    tree.setOnClickHandler(onClickNodeSelect);
    tree.setOnCheckHandler(onCheckBoxsBySelect);
    tree.disableCheckbox("0",0);
    tree.showItemCheckbox("0",0);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K280/k280_createXml.jsp");   
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
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K280/k280_getChildNodeList.jsp","aa");
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
        tree.setUserData(retData[i][0],"object_id",retData[i][4]);	
   	    tree.setUserData(retData[i][0],"note",retData[i][5]);	  
       }
       //���ýڵ���ʾ��ͼƬ
       if(retData[i][3]=='N'){
       	   tree.showItemCheckbox(retData[i][0],0);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=='Y'){
        	tree.showItemCheckbox(retData[i][0],1);
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          } 
     }
    //�����ǰ�ڵ������ӽڵ㣬�����䵱ǰ�ڵ��������ӽڵ�
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"object_id",retData[i][4]);	
   	    tree.setUserData(retData[i][0],"note",retData[i][5]);	  
         if(retData[i][3]=='N'){
         	  tree.showItemCheckbox(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=='Y'){
        	  tree.showItemCheckbox(retData[i][0],1);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          }     	
     	}
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
firstUnCheckItem();
	function firstUnCheckItem(){
	  document.getElementById('0').click();	  
		var strlist =parent.leftCenterTree.getCheckedGroupList();
	//  alert("parent:t"+parent.leftCenterTree.getCheckedGroupList());		
		if(strlist!=null&&strlist!=''){
			var strdata=strlist.split(",");
		for(var s=0;s<strdata.length;s++){
			if(strdata[s]!=''&&strdata[s]!=null){
		  //alert(strdata[s]);			
		  unFoldNode(strdata[s]);
				}
			}
			onCheckBoxsBySelect();
		// ���Ʊ��	
			parent.rightFootLoginNo.CopyHtmlElement();
			}
		
		}

	/*
	*ģ��onclick�¼���չ���ڵ�
	*/
	function unFoldNode(node_id){
		var i_length=node_id.length/2;
		var j=0;
	//alert(i_length);
   if(i_length==1){
	  tree.setCheck(node_id,true);	
	 }else{
		for(var i=0;i<=i_length;i++){
			 	j+=2;
	 // alert("node_id.substring:\t"+node_id.substring(0,j));
	  if(tree.getUserData(node_id.substring(0,j),"isleaf")=='N'){
	  	document.getElementById(node_id.substring(0,j)).click();
	  	}	
		tree.setCheck(node_id,true);	
    }
	}	
}
</SCRIPT>
