<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_css/style.css" type=text/css rel=stylesheet>    
<link href="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_css/dhtmlxtree.css" type=text/css rel=stylesheet>    
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>    
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
</head> 
      
<body onload="initBaseTree();">      
<table>
<tr>
	<td valign="top" width="300">
	<div id="basetree" ></div>
	</td>
	<td valign=top width="50%">
	<div id="childtree"></div>
	</td>   	
</tr>
</table>
</body>        
</html>  

<script type=text/javascript>

/*
 *构建一个动态树
 *
 */
function initBaseTree(){
		tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
		tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");   
		tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");
		//设置鼠标单击事件  
		tree.setOnClickHandler(onNodeClick);
		//设置鼠标双击事件 
		tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");   
}

/**
  *响应鼠标单击事件，选中当前节点
  *
  */
function onNodeClick(){
		top.mainFrame.location.href = "./K217_qc_content_list.jsp?object_id=" + tree.getSelectedItemId();	
		var object_id_obj = top.topFrame.document.getElementById("object_id");
		object_id_obj.value = tree.getSelectedItemId();
		var qc_object_obj = top.topFrame.document.getElementById("qc_object");
		qc_object_obj.value = tree.getItemText(tree.getSelectedItemId());
}

/**
  *响应鼠标双击事件，在右侧窗体中展示当前被检对象的评测内容 
  *
  */
function onNodeDbClick(){
	
}

/*
 *
 *添加一个节点
 *
 */
function onNodeAdd(){

}

/*
 *
 *更新一个节点
 *
 */
function onNodeUpdate(){

}

/*
 *
 *删除一个节点
 *
 */
function onNodeDelete(){
	
}

/*
 *
 *图片设定 
 *
 */
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
  
</script> 

<script type=text/javascript>
//根据选中的节点集合根据数据库里的值判断过滤到只留叶子节点(暂时不使用)
function getIeafList(selectNodeIDList){
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		mypacket.data.add("selectNodeIDList",selectNodeIDList);
		core.ajax.sendPacket(mypacket,doProcessGetIeafList,true);
		mypacket=null;
}
	
//getIeafList的回调函数
function doProcessGetIeafList(packet){
		var ieafList = packet.data.findValueByName("ieafList");
		showNodeIdList(ieafList);
}

// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(strSelectedNodeid){
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_get_qc_object_list.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("nodeId",strSelectedNodeid);
		core.ajax.sendPacket(packet,doProcessGetList,true);
		packet=null;
}

//getTreeListByNodeId的回调函数
function doProcessGetList(packet){
		var childNodeList = packet.data.findValueByName("worknos");
		var nodeId= packet.data.findValueByName("nodeId");
		insertChildNodeList(childNodeList);
} 

//做插入操作的函数  
function insertChildNodeList(retData){
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
		if(varSubItems!=null&&varSubItems!=''){
		 		 str=varSubItems.split(",");
		 		 for(var i=0;i<retData.length;i++){
			       if(!isStr(retData[i][0],str)){
			        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
			        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
			        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
			       }
			       if(retData[i][3]==0){
			        	 tree.showItemCheckbox(retData[i][0],0);
			        	 tree.showItemSign(retData[i][0],1);
			        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
			       }	
			       if(retData[i][3]==1){
			        		tree.showItemCheckbox(retData[i][0],1);
			        	  tree.showItemSign(retData[i][0],0);
			        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
			       } 
		 		}
		}else{
				for(var i=0;i<retData.length;i++){
					  tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
					  tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
					  tree.setUserData(retData[i][0],"fullname",retData[i][4]);	
						if(retData[i][3]==0){
								tree.showItemCheckbox(retData[i][0],0);
								tree.showItemSign(retData[i][0],1);
								tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
						}	
					  if(retData[i][3]==1){
					  		tree.showItemCheckbox(retData[i][0],1);
					  	  tree.showItemSign(retData[i][0],0);
					  	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
					  }     	
				}
		}
}


//显示选中节点在的全称(不查数据库判断，数据可能不准确)
function showNodeIdList(retData){
    parent.show_Name.innerHTML="";
		parent.document.form1.node_Id.value="";
		parent.document.form1.node_Name.value="";
		var arr =retData.split(",");
		var j=0;
		var isflag=0;
		for(var i=0;i<arr.length;i++,j++){
				if(j<10){
						if(tree.getUserData(arr[i],"isleaf")!=null){
								if(tree.getUserData(arr[i],"isleaf")==1){
								parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+','+arr[i];
								parent.show_Name.innerHTML=parent.show_Name.innerHTML+arr[i]+'→'+tree.getUserData(arr[i],"fullname")+'<br>';	
								parent.document.form1.node_Name.value=parent.show_Name.innerHTML;
								}
								if(tree.getUserData(arr[i],"isleaf")==0){
								tree.setCheck(arr[i],0);
								}
						}
				}else{
					//设置是否显示弹出框标志
					tree.setCheck(arr[i],false);
				  isflag=1;
				}
		}
		
		//显示提出弹出框
		if(isflag==1){
				similarMSNPop("来电原因项目添加已经满10个！");
		}
}

//判断一个字符串是否在数组中出现
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
	 
</script>