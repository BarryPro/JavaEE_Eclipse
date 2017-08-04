<%
  /*
   * 功能: 计划外质检-》选择考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head> 
      
<body onload="initBaseTree();showFirstNode();">      
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
 
// 
var tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);

function initBaseTree(){
		
		tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
		tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");
		
		//设置鼠标单击事件  
		tree.setOnClickHandler(onNodeClick);
		tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");   	
}

//此段代码用于加载页面时默认选中类别树中第一个对象类别
function showFirstNode(){
		var treeValues = tree.getSubItems(0);
		if(treeValues.length>1){
			var a = treeValues.split(",");
			document.getElementById(a[0].trim()).click();
		}
}

/**
  *响应鼠标单击事件，选中当前节点
  *
  */
function onNodeClick(){
		parent.mainFrame.location.href = "./K217_qc_content_list.jsp?object_id=" + tree.getSelectedItemId();
		var object_id_obj = parent.topFrame.document.getElementById("object_id");
		object_id_obj.value = tree.getSelectedItemId();
		var qc_object_obj = parent.topFrame.document.getElementById("qc_object");
		qc_object_obj.value = tree.getItemText(tree.getSelectedItemId());
}

//初始化方法
//initBaseTree();
//showFirstNode();
</script> 
