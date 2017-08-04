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
					<input type="button" onclick="showNewNodeWin()" value="新增" class="b_text"/>
					<input type="button" onclick="showModifyNodeWin()" value="修改" class="b_text"/>
					<input type="button" onclick="deleNode()" value="删除" class="b_text"/>
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
//单击事件
function onClickNodeSelect(){        
   
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
  }
  // 访问另外一个框架页面
  window.top.frameright.window.ischeckBoxSelect(tree.getSelectedItemId());
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
    tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");
    // 鼠标左键点击事件，展开下级节点
    tree.setOnClickHandler(onClickNodeSelect);
   // tree.setOnDblClickHandler(onClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/K280/k280_createXml.jsp");
    
    // 初始展开第一层
   // alert(document.getElementById('0'));
    document.getElementById('0').click();
    alert(document.getElementById('0').tagName);
}

// 根据选中的节点id 返回该节点下子节点
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

//getTreeListByNodeId的回调函数
function doProcessGetList(packet){
   	var childNodeList = packet.data.findValueByName("nodes");
   	var nodeId= packet.data.findValueByName("nodeId");
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
  	rdShowMessageDialog("对不起，根节点名称不允许修改",2);
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
  	rdShowMessageDialog("对不起，根节点不允许删除",2);
  	return;
  	}
  	if(isleaf=='N'){
    rdShowMessageDialog("对不起，当前节点有子节点，请删除子节点后才能删除",2);
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
			
			// 添加成功，动态在页面添加节点
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

			// 更新修改节点的名称
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
			rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
			return;
		} else {
			rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
			return false;
		}
		}
}

//做插入操作的函数
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

//做修改操作的函数
function modifyNode(login_group_id,login_group_name){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k2801/k280_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",login_group_name);
	packet.data.add("nodeId",login_group_id);
	core.ajax.sendPacket(packet,doneProcess,true);
	packet=null;
}
//做删除操作的函数
function deleteNode(login_group_id,par_id){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K280/k2801/k280_deleteNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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
