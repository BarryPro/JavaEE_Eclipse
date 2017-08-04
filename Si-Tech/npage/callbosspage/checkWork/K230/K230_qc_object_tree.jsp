<%
  /*
   * 功能: 添加被检对象页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "被检对象树";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>

<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script>

/**
  *
  *打开添加被检对象类别窗口
  *
  */
function add_qc_object(){
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=290px';
	window.showModalDialog('K230_add_qc_object.jsp?time=' + time, window, winParam);
}

/**
  *
  *打开修改被检对象类别窗口
  *
  */
function update_qc_object(){
	var selectedItemId = tree.getSelectedItemId();
	if(selectedItemId == '' || selectedItemId == undefined||'0'==selectedItemId){
		window.parent.top.similarMSNPop("请选择被检对象类别再进行修改！");
		return false;
	}
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=290px';
	window.showModalDialog('K230_update_qc_object.jsp?time=' + time + '&selectedItemId=' + selectedItemId, window, winParam);
}

/**
  *
  *删除被检对象类别
  *
  */
function delete_qc_object(){
	
	var item_id = tree.getSelectedItemId();
	if('0'==item_id){
		window.parent.top.similarMSNPop("请选择具体的被检对象进行删除！");
		return false;
		}
	var hasContentNum = window.parent.frames.topFrame.document.formbar.hasContentNum.value;
	var selectedItemId = tree.getSelectedItemId();
	if(selectedItemId == '' || selectedItemId == undefined){
		window.parent.top.similarMSNPop("请选择被检对象类别再进行删除！");
		return false;
	}
	if(hasContentNum=="1"){
		window.parent.top.similarMSNPop("该对象存在考评内容,不能被删除！");
		return false;
		}
	if(rdShowConfirmDialog("确认删除当前被检对象类别么？") == 1){
		
		delQcObject();
	}
}


/*对返回值进行处理*/
function doProcessDelQcObject(packet){
	//alert("Begin call doProcessDelQcObject()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="delQcObject"){
		if(retCode=="000000"){
			window.parent.top.similarMSNPop("成功删除被检对象类别！");
			tree.deleteItem(tree.getSelectedItemId());
		}else if(retCode == "100003"){
			window.parent.top.similarMSNPop("删除被检对象类别失败！");
			return false;
		}
	}
}

/**
  *
  *删除被检对象类别
  *
  */
function delQcObject(){
	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_object.jsp","请稍后...");

	chkPacket.data.add("retType","delQcObject");
	chkPacket.data.add("selectedItemId", tree.getSelectedItemId());
	core.ajax.sendPacket(chkPacket, doProcessDelQcObject, true);
	chkPacket =null;
}

</script>
<!-- added by tangsong 20100823 处理问题: 安徽样式导致树形连接线断开-->
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head>

<body onload="initBaseTree();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td align="left">
	<input type="button" name="btn_add" value="添加" class="b_text" onclick="add_qc_object()"/>
	<input type="button" name="btn_update" value="修改" class="b_text" onclick="update_qc_object()"/>
	<input type="button" name="btn_delete" value="删除" class="b_text" onclick="delete_qc_object()"/>
</td>
</tr>
</table>
<table>
<tr>
	<td valign="top" width="300">
	<div id="basetree"></div>
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
	tree.enableTreeLines(true);
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");

	//设置鼠标单击事件
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");
}

/**
  *响应鼠标单击事件，选中当前节点
  *
  */
function onNodeClick(){
	window.parent.frames['topFrame'].location.href = "./K230_qc_content_list.jsp?object_id=" + tree.getSelectedItemId();
	window.parent.frames['mainFrame'].location.href = "./K230_blank.jsp";
}

</script>
