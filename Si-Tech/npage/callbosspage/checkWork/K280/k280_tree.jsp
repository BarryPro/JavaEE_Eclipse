<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->被质检组树形列表
　* 版本: 1.0.0
　* 日期: 2008/11/05
　* 作者:
　* 版权: sitech
   * update:
　*/
%>

<%@ page language="java" pageEncoding="GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<html>
	<head>
		<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>
		<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
		<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
		<!-- added by tangsong 20100823 处理问题: 安徽样式导致树形连接线断开-->
		<style type="text/css">
			#basetree td {
				padding:0;
			}
		</style>
	</head>
	<body>
		<!-- update by tangsong 20100823 避免横向滚动条的出现导致竖向滚动条的出现
		<table width="100%" height="100%" >
		-->
		<table width="100%" height="90%" >
			<input type="hidden" name="insertReturnVal" id="insertReturnVal" value=""/>
			<input type="hidden" name="modifyReturnVal" id="modifyReturnVal" value=""/>
			<tr>
				<td valign="top">
					<div id="baseTree"></div>
				</td>
			</tr>
		</table>
	</body>
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
//单击事件
function onClickNodeSelect(){
	
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
  }
	var tmpSelItemId = tree.getSelectedItemId();
	var tmpJudge = 0;
	if(parent.rightTopFrame.document.getElementById("check2").checked == true){
			tmpJudge = 1;
	}
  	parent.frameright.ischeckBoxSelect(tmpSelItemId,tmpJudge);
  	
}
function getSelectItemIdByCheck(){
	return tree.getSelectedItemId();
	}
//响应checkbox选中事件，把提示信息显示到另外一个页面
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
	 showNodeIdList(allCheckItem);//性能优化操作 不用再去查询数据库
	}
}

//判断是checkbox是否有值
function isCheckBoxsList(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null&&allCheckItem!=''){
		return true;
	}else{
		return false;
	}
}

// 取消所有的checkbox选中
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

//构建一个动态树
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
    tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
    // 鼠标左键点击事件，展开下级节点
    tree.setOnClickHandler(onClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k280_createXml.jsp");

  // 初始展开第一层
    document.getElementById('0').click();
}

// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k280_getChildNodeList.jsp","aa");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}

//getTreeListByNodeId的回调函数
function doProcessGetList(packet){
   	var childNodeList = packet.data.findValueByName("nodes");
   	var nodeId        = packet.data.findValueByName("nodeId");
    insertChildNodeList(childNodeList);
}

//做插入操作的函数
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
        tree.setUserData(retData[i][0],"object_id",retData[i][4]);
   	    tree.setUserData(retData[i][0],"note",retData[i][5]);
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
        tree.setUserData(retData[i][0],"object_id",retData[i][4]);
   	    tree.setUserData(retData[i][0],"note",retData[i][5]);
         if(retData[i][3]=='N'){
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }
        if(retData[i][3]=='Y'){
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');
          }
     	}
}

}

//做插入操作的函数
function showNewNodeWin(){

	var par_id= tree.getSelectedItemId();
	var par_Text=tree.getSelectedItemText();
	var time     = new Date();
	var winParam = 'dialogWidth=580px;dialogHeight=400px';
	window.showModalDialog("k280_newNodeWin.jsp?time="+time+"&par_Text="+par_Text,window, winParam);
}


function showModifyNodeWin(){
	var nodeId = tree.getSelectedItemId();
	var objectId=tree.getUserData(nodeId,"object_id");
    if(nodeId=='0'){
	  	similarMSNPop("对不起，根节点名称不允许修改！");
	  	return;
  	}

	var time     = new Date();
	var winParam = 'dialogWidth=580px;dialogHeight=400px';
	window.showModalDialog("./k2801/k280_modifyNodeWin.jsp?time="+time+"&object_id="+objectId,window, winParam);
}

/**
  *删除选定的被质检组，如果该组下有被质检人，同时删除。
  *
  */
function deleNode(){
	var nodeId = tree.getSelectedItemId();
	var nodeName =tree.getSelectedItemText();
	var par_id=tree.getParentId(nodeId);
	var isleaf =tree.getUserData(tree.getSelectedItemId(),"isleaf");
	if(nodeId=='0'){
	similarMSNPop("对不起，根节点不允许删除！");
	return;
	}
	if(isleaf=='N'){
	similarMSNPop("对不起，当前节点有子节点，请删除子节点后才能删除！");
	return;
	}
	if(rdShowConfirmDialog("您确认要需要删除"+nodeName+"组么？")=="1"){
	deleteNode(nodeId,par_id);
	}
}

// AJAX回调处理函数，根据返回的retType判断具体操作
function doneProcess(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");

	if(retType == "insertNewNode"){
		if (retCode == "000000") {
			var login_group_id = packet.data.findValueByName("login_group_id");
			var parent_group_id = packet.data.findValueByName("parent_group_id");
			var login_group_name = packet.data.findValueByName("login_group_name");
			var object_id = packet.data.findValueByName("object_id");
			var note = packet.data.findValueByName("note");

			// 添加成功，动态在页面添加节点
		  tree.insertNewItem(parent_group_id,login_group_id,login_group_name,0,0,0,0,'SELECT');
	   	  tree.setUserData(login_group_id,"isleaf",'Y');
	   	  tree.setUserData(login_group_id,"object_id",object_id);
	   	  tree.setUserData(login_group_id,"note",note);
	   	  document.getElementById("insertReturnVal").value="1";
		} else {
			document.getElementById("insertReturnVal").value="-1";
		}
	}
	if(retType == "modifyNode"){
		if (retCode == "000000") {
			var nodeName = packet.data.findValueByName("nodeName");
		    var object_id = packet.data.findValueByName("object_id");
			var note = packet.data.findValueByName("note");

			// 更新修改节点的名称
			var nodeId = tree.getSelectedItemId();
			tree.setItemText(nodeId,nodeName);
			tree.setUserData(nodeId,"object_id",object_id);
   	  		tree.setUserData(nodeId,"note",note);
   	  		document.getElementById("modifyReturnVal").value="1";
		} else {
			document.getElementById("modifyReturnVal").value="-1";
		}
	}
	if(retType=="deleteNode"){
				if (retCode == "000000") {
			// 更新修改节点的名称
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
			similarMSNPop("删除被检组成功！");
			return;
		} else {
			similarMSNPop("删除被检组失败！");
			return false;
		}
		}
}

//做插入操作的函数
function insertNewNode(parNode,strName,note,objectType){
	var nodeId = parNode;
	var isleaf =tree.getUserData(nodeId,"isleaf");
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k280_insertNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","insertNewNode");
	packet.data.add("nodeName",strName);
	packet.data.add("nodeId",parNode);
	packet.data.add("note",note);
	packet.data.add("isleaf",isleaf);
	packet.data.add("objectid",objectType);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
}


/**
  *修改节点信息
  */
function modifyNode(login_group_id,login_group_name,note,objectType){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k2801/k280_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",login_group_name);
	packet.data.add("nodeId",login_group_id);
	packet.data.add("note",note);
	packet.data.add("objectid",objectType);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
}

//做删除操作的函数
function deleteNode(login_group_id,par_id){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k2801/k280_deleteNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","deleteNode");
	packet.data.add("nodeId",login_group_id);
	packet.data.add("par_Id",par_id);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
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


</SCRIPT>
