<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script src="/njs/extend/mztree/stTree.js" type="text/javascript" ></script>

<script language="javascript" type="text/javascript">
	

	
	window.onload=function(){
	
		tree = new stdTree("tree","rootTree");
		tree.imgSrc= "/nresources/default/images/mztree";
		with(tree){
			N["0299"]="0299;晋中;000;1;L('0299~晋中~0299~晋中')";	
			N["0201"]="0201;左权县;0299;1;L('0201~左权县~0299~晋中~')";	
			N["0202"]="0202;和顺县;0299;1;L('0202~和顺县~0299~晋中~')";	
			N["0203"]="0203;昔阳县;0299;1;L('0203~昔阳县~0299~晋中~')";	
			N["0204"]="0204;寿阳县;0299;1;L('0204~寿阳县~0299~晋中~')";	
			N["0205"]="0205;灵石县;0299;1;L('0205~灵石县~0299~晋中~')";	
			N["0206"]="0206;榆社县;0299;1;L('0206~榆社县~0299~晋中~')";	
			N["0207"]="0207;平遥县;0299;1;L('0207~平遥县~0299~晋中~')";	
			N["0208"]="0208;祁县;0299;1;L('0208~祁县~0299~晋中~')";	
			N["0209"]="0209;太谷县;0299;1;L('0209~太谷县~0299~晋中~')";	
		}
		tree.writeTree();		
		tree = null;
	}
	//点击树节点触发事件
	
	function stGetTreeNode(chId){
		
		//alert('chick node id is :' + chId);
		//testSub();
		loadChildNodes(chId);
	}
	
	//AJAX 查询当前节点的子节点
	
	function loadChildNodes(nodeID){
		var packet = new AJAXPacket("ajax_tree.jsp");
		core.ajax.sendPacket(packet,doTest);
		packet =null;
	}
	
	//回调方法	
	function doTest(){
		tree = new stdTree("tree","rootTree");
		tree.imgSrc= "/nresources/default/images/mztree";
		with(tree){
			
			N["11119"]="0201;树叶1;0201;0;L('11')";
			N["11118"]="0201;树叶2;0201;0;L('22')";
				
				var rootNodeId = "11117";
				var rootNodeName = "树叶9";
				var parentNodeId ="0201";
				var hasChild ="0";
				var info = rootNodeId+"~"+rootNodeName+"~"+parentNodeId+"~11111~";
				hasChild = "0";	
			N[eval(rootNodeId)]="\""+rootNodeId+";"+rootNodeName+";"+parentNodeId+";"+hasChild+";L('"+info+"')";	
		}
		tree.writeTree();		
		tree = null;	
	}
	
	function L(str){
		alert(str);
	}	
	
</script>
	
<style>


#rootTree {
	float : left; 	
	padding-left: 6px ;
	width:20%;
	height:100%;
	border-right:1px solid #aaa;
}

#workPan {
	width:80%;
	height:100%;
	float: right; 	
	text-align:left;	
}

</style>	
	
</head>

<body>

<div id="rootTree"></div>
<div id="workPan">123</div>
			
	
</body>
</html>
