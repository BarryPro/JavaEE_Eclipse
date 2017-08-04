<%
  /**
   * 功能: 质检权限管理->分配质检权限->质检组树
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:		2009/04/09		mixh
   *				修改树的生成逻辑
　 */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<!-- added by tangsong 20100823 处理问题: 安徽样式导致树形连接线断开-->
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head>

<body >
<table width="400" height="1000">
<TR>
<td vAlign=top width="400" height="100%">
<div id="baseTree"></DIV>
</td>
</tr>
</table>
<input type="hidden" id="checkedGroup" name="checkedGroup"  value=""/>
</body>
</html>
<script type="text/javascript">

//单击事件
function onClickNodeSelect(){
	//清被检组工号列表
	parent.frames.rightCenterLoginNo.clearRow(parent.frames.rightCenterLoginNo.dataTable);
	//正确显示质检员拥有质检以下工号权限
	parent.frames.rightFootLoginNo.CopyHtmlElement();

	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
		if(tree.getSelectedItemId()!=0){
			getCheckGroupLoginNo();
		}
	}else{
		getCheckGroupLoginNo();
	}
}

function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",0);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.setOnClickHandler(onClickNodeSelect);
	tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K290/k290_createXml.jsp");
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K290/k290_createXml.jsp?id=0");
}


/**
  *返回选定质检组下属质检员工号
  */
function getCheckGroupLoginNo(){
	var nodeId = tree.getSelectedItemId();
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K290/k290_getLoginNoByCheckGroupId.jsp","");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessCheckLoginList,false);
	packet=null;
}

/**
  *getCheckGroupLoginNo回调函数
  *1、展示质检员工号；
  *2、获得该质检组有质检权限的被检组，刷新被检组页面；
  */
function doProcessCheckLoginList(packet){
   	var loginNoList = packet.data.findValueByName("loginNoList");   	
   	var checkedGroupList = packet.data.findValueByName("checkedGroupList");
        
    document.getElementById("checkedGroup").value = checkedGroupList;
    window.parent.leftFootFrame.addOption(loginNoList);
    /*mod by mixh 20090409 begin*/
    window.parent.rightCenterTree.location.href = "/npage/callbosspage/checkWork/K300/K280/k280_tree.jsp?checkedGroupList=" +  checkedGroupList;
	/*mod by mixh 20090409 end*/
}

/**
  *返回当前选定质检组有质检权限的被质检组ID
  *供k280_tree.jsp页面的firstUnCheckItem()方法调用
  */
function getCheckedGroupList(){
	var checkedGroup= document.getElementById("checkedGroup").value;
	return checkedGroup;
}

/**
  *废弃方法，未用
  */
function setGroupLoginNoNum(num){
	if(tree.getUserData(tree.getSelectedItemId(),"flag")!='0'){
		if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='Y'){
			tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')人');
			tree.setUserData(tree.getSelectedItemId(),"flag",'0');
		}else{
			tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')人,不包括子组人数');
			tree.setUserData(tree.getSelectedItemId(),"flag",'0');
		}
	}
}
//初始化树
initBaseTree();


</SCRIPT>
