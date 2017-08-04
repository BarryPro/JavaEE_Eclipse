<%
  /*
   * 功能: 被检群组
　 * 版本: 1.0
　 * 日期: 2008/10/20
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
 
<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<!--被检群组-->
<HTML>
	<HEAD>
		<!--LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css" type=text/css rel=STYLESHEET -->
		<LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>
		<SCRIPT
			src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js"
			type=text/javascript></SCRIPT>
		<SCRIPT
			src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js"
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
}

//双击事件
function onDbClickNodeSelect(){         
	  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
	  		getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
	  }
	  // 访问另外一个框架页面
	  window.returnValue=tree.getSelectedItemId()+'_'+tree.getSelectedItemText();    
	  window.close();
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
	 


//构建一个动态树
function initBaseTree(){	
		tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
    tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
    // 鼠标左键点击事件，展开下级节点
    tree.setOnClickHandler(onClickNodeSelect);
    tree.setOnDblClickHandler(onDbClickNodeSelect);
    tree.enableHighlighting(0);
    tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K204/K204_createXml.jsp");
    
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
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K204/K204_getChildNodeList.jsp","aa");
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
