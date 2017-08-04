<%
  /*
   * 功能: 考评项树
　 * 版本: 1.0.0
　 * 日期: 2008/12/22
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%
/***************获得考评对象流水、考评内容流水开始******************/
//以下参数来源自K214_qc_object_tree.jsp
String content_id = request.getParameter("content_id");
String object_id  = request.getParameter("object_id");
/***************获得考评对象流水、考评内容流水结束******************/
%>

<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
</head>
<style>
		.dis
		{
		display:block;
		border-top:1px solid #6c90ca;
		background:#fff url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
		padding:8px 12px;
		}
		.undis
		{
		display:none;
		}
</style>
<script language='javascript'>
	function HoverLi(n){
		if(n==1){
			document.getElementById('checkTree').className='dis';
			document.getElementById('readMe').className='undis';
		}
		if(n==2){
			document.getElementById('checkTree').className='undis';
			document.getElementById('readMe').className='dis';
		}
}
</script>
<body onload="initBaseTree();">
<input type="button" name="cTree" class="b_text" value="考评树" onclick="HoverLi(1);"/>
<input type="button" name="rMe" class="b_text" value="说明" onclick="HoverLi(2);"/>	

<div id="checkTree" class="dis">	
	<input type="hidden" name="object_id" value="<%=object_id%>"/>
	<input type="hidden" name="content_id" value="<%=content_id%>"/>
	
	<table width="100%">
	<tr>
		<td valign="top">
		<div id="basetree" ></div>
		</td>
		<td valign=top>
		<div id="childtree"></div>
		</td>
	</tr>
	</table>
</div>

<div id="readMe" class="undis" >
	<div id="Operation_Table" style="width:120%;" >
	<table cellspacing="0">
		<tr>
			<td valign="top" id = "readMeContent" align="left" class="blue">请选择右侧评分项!</td>
		</tr>
	</table>
	</div>
</div>

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
		tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K214/K214_create_qc_item_tree_xml.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>");
		tree.enableDragAndDrop(0);
		tree.enableTreeLines(false);
		tree.setImageArrays("plus","","","","plus.gif");
		tree.setImageArrays("minus","","","","minus.gif");
		tree.setStdImages("book.gif","books_open.gif","books_close.gif");	 
		//设置鼠标单击事件
		tree.setOnClickHandler(onNodeClick);
		tree.enableCheckBoxes(0);   
		document.getElementById('0').click();
}

/**
  *响应鼠标单击事件，选中当前节点，并展示当前节点下的子结点
  *
  */
function onNodeClick(){
		//用ajax动态查询数据
		getTreeListByNodeId(tree.getSelectedItemId());
}
</script>

<script type=text/javascript>
// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(strSelectedNodeid){
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K214/K214_get_qc_item_child_tree.jsp","...");
		packet.data.add("parent_item_id",strSelectedNodeid);
		core.ajax.sendPacket(packet,doProcessGetList,true);
		//packet=null;
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