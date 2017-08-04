<%
  /*
   * 功能: 自动质检->左侧的考评项树型结构
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
<%
	String opCode = "K400";
	String opName = "左侧的考评项树型结构";
%>
<%
	String object_id  = request.getParameter("object_id");
	String content_id = request.getParameter("content_id");
%>

<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
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
<body>
<input type="button" name="cTree" class="b_text" value="考评树" onclick="HoverLi(1);"/>
<input type="button" name="rMe" class="b_text" value="说明" onclick="HoverLi(2);"/>	
<div id="checkTree" class="dis">	
	<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
	<input type="hidden" name="content_id" id="content_id" value="<%=content_id%>"/>
	
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
 *初始化树的第一层节点
 */
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");	
	tree.enableCheckBoxes(0);
	tree.enableDragAndDrop(0);
	tree.enableTreeLines(true);
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_create_qc_item_tree_xml.jsp?content_id=<%=content_id%>&object_id=<%=object_id%>");
	//树的根节点为0
	var subItemsArr = tree.getAllSubItems("0").split(',');
	for(var i = 0; i < subItemsArr.length; i++){
		if(tree.getUserData(subItemsArr[i], 'isleaf') != 'Y'){
			tree.setItemImage2(subItemsArr[i],'folderClosed.gif','folderClosed.gif','folderClosed.gif');
		}
	}
}


/**
  *响应鼠标单击事件，选中当前节点，并展示当前节点下的子结点
  *
  */
function onNodeClick(){
	if(tree.getSelectedItemId() == '0'){
		return;
	}
	getTreeListByNodeId();
}
</script>

<script type=text/javascript>
//根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(){
	var nodeId = tree.getSelectedItemId();
	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
	if(varSubItems!=null&&varSubItems!=''){
		return;
	}

	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>", "...");
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
	//alert("begin insertChildNodeList....");
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
   	var str = new Array();

   	//判断该节点写是否有子节点，如果有判断过滤一下当前节点值是否与数据库里的值一致
	if(varSubItems != null && varSubItems != ''){
		str=varSubItems.split(",");
		for(var i=0;i<retData.length;i++){
			//过滤当前节点下子节点与数据库是否相同
			if(!isStr(retData[i][0],str)){
				tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
				tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
				tree.setUserData(retData[i][0],"isscored",retData[i][4]);
				tree.setUserData(retData[i][0],"object_id",retData[i][5]);
			}
     	}
	}else{//如果当前节点下无子节点，则在其当前节点下新增子节点
		for(var i = 0; i < retData.length; i++){
			tree.insertNewItem(retData[i][1], retData[i][0], retData[i][2], 0, 0, 0, 0, 'TOP');
			tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
			tree.setUserData(retData[i][0],"isscored",retData[i][4]);
			tree.setUserData(retData[i][0],"object_id",retData[i][5]);
		}
	}
	//alert("end insertChildNodeList....");
}

//判断一个字符串是否在数组中出现
function isStr(strtreeData,str){
		if(str!=null){
				for(var j=0;j<str.length;j++){
						if(strtreeData.trim()==str[j].trim()){
								return true;
						}
				}
		}
		return false;
}

//初始话树
initBaseTree();
</script>