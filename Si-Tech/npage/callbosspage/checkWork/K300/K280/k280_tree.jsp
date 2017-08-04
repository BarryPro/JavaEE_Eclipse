<%
  /**
   * 功能: 质检权限管理->分配质检权限->被检组信息树
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:		2009/04/09		mixh
   *				更新树的生成逻辑；
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
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
<table width="400px" height="1000px">
<tr>
<td valign="top" width="400" height="100%">
<div id="baseTree"></div>
</td>
</tr>
</table>
</body>

</html>

<script type="text/javascript">
	
//单击事件
function onClickNodeSelect(){
	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
		tree.showItemCheckbox(tree.getSelectedItemId(),0);
		//getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
	}else{
		tree.showItemCheckbox(tree.getSelectedItemId(),1);
	}
}

//响应checkbox选中事件，把提示信息显示到另外一个页面
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
  parent.rightCenterLoginNo.ischeckBoxSelect(allCheckItem);
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

function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",0);
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.enableCheckBoxes(1);
	tree.setOnClickHandler(onClickNodeSelect);
	tree.setOnCheckHandler(onCheckBoxsBySelect);
	//tree.disableCheckbox("0",0);
	//tree.showItemCheckbox("0",0);
	//tree.enableHighlighting(0);
	tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K280/k280_createXml.jsp");
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K280/k280_createXml.jsp?id=0");
}

//初始化树
initBaseTree();
//获得被质检组，并选中，然后显示选中被质检组中的业务代表工号及姓名
firstUnCheckItem();

function firstUnCheckItem(){
	/*mod by mixh 20090409 begin*/
	//var strlist = parent.leftCenterTree.getCheckedGroupList();
	var strlist = '<%=request.getParameter("checkedGroupList")%>';
	/*mod by mixh 20090409 end*/
        
	if(strlist!=null&&strlist!=''){
		var strdata=strlist.split(",");
                
		for(var s=0;s<strdata.length;s++){
			if(strdata[s]!=''&&strdata[s]!=null){
				unFoldNode(strdata[s]);
			}
		}
		onCheckBoxsBySelect();
		// 复制表格
		parent.rightFootLoginNo.CopyHtmlElement();
	}
}
		
/*
 *模拟onclick事件，展开节点
 * modified by liujied 20090928
 * 让其满足树状选择
 */
function unFoldNode(node_id){
     
     //var i_length=node_id.length/2;
     var half_length = node_id.length/2;
     var j=0;
     if(half_length == 1){
          tree.setCheck(node_id,true);
     }else{
          for(var i=0 ; i < half_length ; i++){
               j += 2;
               var sub_node_id = node_id.substring(0,j);
               var childItems = tree.hasChildren(sub_node_id);
               
               if(childItems)
                {
                    tree.openItem(sub_node_id);
                    continue;
                }
               tree.setCheck(node_id,true);
               
               //if(tree.getUserData(node_id.substring(0,j),"isleaf")== 'N'){
               //              
               //              document.getElementById(node_id.substring(0,j)).click();
	       //	}
               //tree.setCheck(node_id,true);
               sub_node_id = null;
               childItems  = null;
          }
	}
}
</script>