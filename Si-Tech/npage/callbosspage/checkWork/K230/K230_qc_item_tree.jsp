<%
  /*
   * ����: ������ά��ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<%
	  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
 
	String opCode = "K230";
	String opName = "�������б�";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

/*---------------���Ĭ��object_id��ʼ-------------------*/
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String sqlGetObjectId = "";
if(object_id == null || object_id.equals("")){
	sqlGetObjectId = "select to_char(min(object_id)) from dqcobject where bak1='Y'";

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlGetObjectId%>"/>
</wtc:service>
<wtc:array id="object_ids" scope="end"/>
<%

	object_id = object_ids[0][0];
}
/*---------------���Ĭ��object_id����-------------------*/
%>

<%
/*---------------���Ĭ��content_id��ʼ-------------------*/
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
String sqlGetContent_id = "";
if(content_id == null || content_id.equals("")){
	sqlGetContent_id = "select min(contect_id) from dqccheckcontect where object_id= :object_id and bak1='Y'";
	myParams = "object_id="+object_id ;

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlGetContent_id%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="content_ids" scope="end"/>
<%

	content_id = content_ids[0][0];
}
/*---------------���Ĭ��content_id����-------------------*/
%>

<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script>
/**
  *
  *����ӿ������
  *
  */
function add_qc_item(){
	var object_id  = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var current_node_id = tree.getSelectedItemId();
	var father_node_id  = tree.getParentId(current_node_id);

	/*
	window.open('K230_add_qc_item.jsp?current_node_id=' + current_node_id + '&object_id=' + object_id + '&content_id=' + content_id + '&father_node_id=' + father_node_id,
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	var time     = new Date();
	var url      = 'K230_add_qc_item.jsp?time='+time+'&current_node_id=' + current_node_id + '&object_id=' + object_id +
	               '&content_id=' + content_id + '&father_node_id=' + father_node_id;
	var winParam = 'dialogWidth=800px;dialogHeight=360px';
	window.showModalDialog(url, window, winParam);
}

/**
  *
  *���޸Ŀ������
  *
  */
function update_qc_item(){
	var object_id = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var item_id = tree.getSelectedItemId();
	var parentItem_id = tree.getParentId(item_id);
	if(undefined==item_id||''==item_id||'0'==item_id){
		window.parent.top.similarMSNPop("��ѡ��Ҫ�޸ĵĿ����");
			return false;
	}

	/*
	window.open('K230_update_qc_item.jsp?item_id=' + item_id+'&parentItem_id='+parentItem_id,
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	var time     = new Date();
	var winParam = 'dialogWidth=800px;dialogHeight=360px';
	window.showModalDialog('K230_update_qc_item.jsp?time='+time+'&item_id=' + item_id+'&parentItem_id='+parentItem_id+'&object_id='+object_id+'&content_id='+content_id, window, winParam);
}

/**
  *
  *ɾ��������
  *
  */
function delete_qc_item(){
	var item_id = tree.getSelectedItemId();
	var leafNum = tree.getAllSubItems(item_id).length;

	if(undefined==item_id||''==item_id||'0'==item_id){
		window.parent.top.similarMSNPop("��ѡ��Ҫɾ���Ŀ����");
		return false;
	}

	if(leafNum>0){
		window.parent.top.similarMSNPop("����ɾ���ӿ����");
		return false;
		}

	if(rdShowConfirmDialog("ȷ��ɾ����ǰ������ô��") == 1){
		delQcItem();
	}
}

/*�Է���ֵ���д���*/
function doProcessDelQcItem(packet){
	//alert("Begin call doProcessDelQcItem()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var leafCount = packet.data.findValueByName("leafCount");
	var parentItem_id = packet.data.findValueByName("parentItem_id");
	if(retType=="delQcItem"){
		if(retCode=="000000"){
			tree.deleteItem(tree.getSelectedItemId(),true);
			if(leafCount<=1&&!(parentItem_id==0)){
				  tree.setUserData(parentItem_id,"isleaf",'Y');
				  tree.setItemImage2(parentItem_id,'leaf.gif','folderClosed.gif','folderOpen.gif');
			}else{
					tree.setUserData(parentItem_id,"isleaf",'N');
					tree.setItemImage2(parentItem_id,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
			}
			window.parent.top.similarMSNPop("�ɹ�ɾ�������");
		}else{
			window.parent.top.similarMSNPop("ɾ��������ʧ�ܣ�");
			return false;
		}
	}
}

/**
  *
  *ɾ��������
  *
  */

function delQcItem(){
	var object_id = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var item_id = tree.getSelectedItemId();
	var parentItem_id = tree.getParentId(item_id);
	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_qc_item.jsp?parentItem_id="+parentItem_id+"&object_id="+object_id+"&content_id="+content_id,"���Ժ�...");
	chkPacket.data.add("retType","delQcItem");
	chkPacket.data.add("item_id", tree.getSelectedItemId());
	core.ajax.sendPacket(chkPacket, doProcessDelQcItem, true);
	chkPacket =null;
	//alert("End call delQcItem()....");
}

/**
  *
  *����������ȼ�ά��ҳ��
  *
  */
function manage_level(){
	var selectedItemId = tree.getSelectedItemId();
	//alert(selectedItemId);
	//ȡ�Ƿ������� 0��  1��  zengzq
	var userData1 = tree.getUserData(selectedItemId.trim(),"isscored");
	if("0"==userData1.trim()||"N"==userData1.trim()){
		window.parent.top.similarMSNPop("��ѡ�����ֵĿ����");
		return false;
		}
	if(selectedItemId == '' || selectedItemId == undefined){
		window.parent.top.similarMSNPop("��ѡ�����");
		return false;
	}
	var object_id = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
	window.open('K230_qc_item_level_list.jsp?selectedItemId=' + selectedItemId + "&object_id=" + object_id + "&content_id=" + content_id, '', param);
}
</script>
<!-- added by tangsong 20100823 ��������: ������ʽ�������������߶Ͽ�-->
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head>
<body>
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="content_id" id="content_id" value="<%=content_id%>"/>
<input type="hidden" name="leafNum" id="leafNum" value="12"/>
<input type="hidden" name="itemNum" id="itemNum" value="0"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td align="right">
	<input type="button" name="btn_level"  value="�ȼ�" class="b_text" onclick="manage_level();"/>
	<input type="button" name="btn_add"    value="���" class="b_text" onclick="add_qc_item()"/>
	<input type="button" name="btn_update" value="�޸�" class="b_text" onclick="update_qc_item()"/>
	<input type="button" name="btn_delete" value="ɾ��" class="b_text" onclick="delete_qc_item()"/>
</td>
</tr>
</table>

<table width="100%">
<tr>
	<td valign="top" width="100%">
	<div id="basetree" ></div>
	</td>
</tr>
</table>
</body>
</html>
<script type="text/javascript">
/*
 *��ʼ�����ĵ�һ��ڵ�
 */
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");	
	tree.enableCheckBoxes(0);
	tree.enableDragAndDrop(0);
	tree.enableTreeLines(true);
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_create_qc_item_tree_xml.jsp?content_id=<%=content_id%>&object_id=<%=object_id%>");
	//���ĸ��ڵ�Ϊ0
	var subItemsArr = tree.getAllSubItems("0").split(',');
	for(var i = 0; i < subItemsArr.length; i++){
		if(tree.getUserData(subItemsArr[i], 'isleaf') != 'Y'){
			tree.setItemImage2(subItemsArr[i],'folderClosed.gif','folderClosed.gif','folderClosed.gif');
		}
	}
	
	//added by tangsong 20100902 Ĭ��չ��ȫ���ڵ�
	var itemObject = tree._globalIdStorageFind(0);
  for (var i=0; i<itemObject.childsCount; i++) {
  	getTreeListByNodeId(itemObject.childNodes[i].id);
  }
}


/**
  *��Ӧ��굥���¼���ѡ�е�ǰ�ڵ㣬��չʾ��ǰ�ڵ��µ��ӽ��
  *
  */
function onNodeClick(){
	if(tree.getSelectedItemId() == '0'){
		return;
	}
	getTreeListByNodeId();
}
</script>

<script type="text/javascript">
//����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
//updated by tangsong 20100902
//begin
/*
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
*/
function getTreeListByNodeId(nodeId){
	if (nodeId == null) {
		nodeId = tree.getSelectedItemId();
		var varSubItems=tree.getSubItems(tree.getSelectedItemId());
		if(varSubItems!=null&&varSubItems!=''){
			return;
		}
	}
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_get_qc_item_child_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>", "...");
	packet.data.add("parent_item_id",nodeId);
	core.ajax.sendPacket(packet,doProcessGetList,true);
}
//end

//getTreeListByNodeId�Ļص�����
function doProcessGetList(packet){
	var childNodeList = packet.data.findValueByName("worknos");
	var nodeId        = packet.data.findValueByName("nodeId");
	insertChildNodeList(childNodeList);
}


/**
  *���������߼�
  */
function insertChildNodeList(retData){
	//alert("begin insertChildNodeList....");
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId());
   	var str = new Array();

   	//�жϸýڵ�д�Ƿ����ӽڵ㣬������жϹ���һ�µ�ǰ�ڵ�ֵ�Ƿ������ݿ����ֵһ��
	if(varSubItems != null && varSubItems != ''){
		str=varSubItems.split(",");
		for(var i=0;i<retData.length;i++){
			//���˵�ǰ�ڵ����ӽڵ������ݿ��Ƿ���ͬ
			if(!isStr(retData[i][0],str)){
				//updated by tangsong 20100902 �ڵ�Ĭ�ϲ�ѡ��
				//tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
				tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'TOP');
				tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
				tree.setUserData(retData[i][0],"isscored",retData[i][4]);
				tree.setUserData(retData[i][0],"object_id",retData[i][5]);
			}
     	}
	}else{//�����ǰ�ڵ������ӽڵ㣬�����䵱ǰ�ڵ��������ӽڵ�
		for(var i = 0; i < retData.length; i++){
			tree.insertNewItem(retData[i][1], retData[i][0], retData[i][2], 0, 0, 0, 0, 'TOP');
			tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
			tree.setUserData(retData[i][0],"isscored",retData[i][4]);
			tree.setUserData(retData[i][0],"object_id",retData[i][5]);
		}
	}
	//alert("end insertChildNodeList....");
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
</script>