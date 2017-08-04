<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/19
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
	String opCode = "K501";
	String opName = "预定义短信树";
%>

<%@ include file="/npage/include/public_title_name.jsp" %>



<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

</head>

<!--body onload="initBaseTree();"-->
<body>

<input type="hidden" name="leafNum" id="leafNum" value="12"/>
<input type="hidden" name="itemNum" id="itemNum" value="0"/>


<table width="100%">
<tr>
	<td valign="top" width="100%">
	<div id="basetree" ></div>
	</td>
	<td valign=top width="100%">
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

	tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/12580/9KA51/K501/K501_message_tree_xml.jsp");
	//设置鼠标单击事件
	tree.setOnClickHandler(onNodeClick);
	tree.enableCheckBoxes(0);
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/12580/9KA51/K501/K501_message_tree_xml.jsp");
	document.getElementById('0').click();
}


/**
  *响应鼠标单击事件，选中当前节点，并展示当前节点下的子结点
  *
  */
function onNodeClick(){
	//用ajax动态查询数据
	getTreeListByNodeId(tree.getSelectedItemId());
	//alert("end onNodeClick ....");
}

</script>


<script type=text/javascript>
// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(strSelectedNodeid){
	
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/12580/9KA51/K501/K501_message_tree_child.jsp", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}

//getTreeListByNodeId的回调函数
function doProcessGetList(packet){
	var childNodeList = packet.data.findValueByName("worknos");
	var nodeId        = packet.data.findValueByName("nodeId");
	insertChildNodeList(childNodeList);
}

/**
  *树的生成逻辑
  */
function insertChildNodeList(retData){
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	//判断该节点写是否有子节点，如果有判断过滤一下当前节点值是否与数据库里的值一致
   	if(varSubItems!=null&&varSubItems!=''){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
    //过滤当前节点下子节点与数据库是否相同
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
        tree.setUserData(retData[i][0],"isscored",retData[i][4]);
        tree.setUserData(retData[i][0],"object_id",retData[i][5]);
       }
       //设置节点显示的图片
       if(retData[i][3]=='N'){
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }
        if(retData[i][3]=='Y'){
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');
          }
     }
    //如果当前节点下无子节点，则在其当前节点下新增子节点
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
        tree.setUserData(retData[i][0],"isscored",retData[i][4]);
        tree.setUserData(retData[i][0],"object_id",retData[i][5]);
         if(retData[i][3]=='N'){
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }
        if(retData[i][3]=='Y'){
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');
          }
     	}
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

//初始话树
initBaseTree();
</script>
