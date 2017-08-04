<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    String opCode="k172";
    String opName="来电原因维护";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD> 
          
<BODY onload="initBaseTree();">           
<TABLE><TR><TD vAlign=top width="300">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="50%">
<DIV id="childTree">
	</DIV>
</TD>
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 

		function fixImage(id){
			switch(tree.getLevel(id)){
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
//响应鼠标单击事件，查询数据库得到下一节点

function onNodeSelect(){        
  // initChildTree(tree.getSelectedItemId());
   alert("SelectedItemId"+tree.getSelectedItemId());
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){
	tree.showItemCheckbox(tree.getSelectedItemId(),0);
	tree.showItemSign(tree.getSelectedItemId(),1);	
	//    tree.disableCheckbox("00",1);
  }  
  getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
 
}
 //响应checkbox选中事件，把提示信息显示到另外一个页面
function onCheckBoxsBySelect(){	
		 parent.full_name.innerHTML="";
	  alert("checkBoxSelectedItemId"+tree.getAllChecked());
	  
	  if(tree.getAllChecked()!=""){
   parent.full_name.innerHTML=tree.getUserData(tree.getAllChecked(),"fullname"); 
	  	}

	//	showNodeIdList();//性能优化操作 不用再去查询数据库
	}   
         //构建一个动态树
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");   
      //    tree.enableCheckBoxes(1); 
       // tree.enableSmartCheckboxes(1);
          tree.enableThreeStateCheckboxes(false);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.enableHighlighting(0);
          tree.enableRadioButtons(true);
      //  tree.disableCheckbox("0",1);
      //  tree.setOnOpenStartHandler(onNodeSelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");   
	}
      
 function initChildTree(nodeId){
 	   var  childTree=new dhtmlXTreeObject("childTree","100%","100%",0);    
          childTree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");   
          childTree.enableCheckBoxes(1); 
          // tree.enableSmartCheckboxes(1);
          childTree.enableThreeStateCheckboxes(false);    
          childTree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createChildTreeXml.jsp");      
          childTree.setOnClickHandler(onNodeSelect);
          childTree.setOnCheckHandler(onCheckBoxsBySelect);
          childTree.enableHighlighting(0);
          //  tree.disableCheckbox("0",1);
          // tree.setOnOpenStartHandler(onNodeSelect);
          childTree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createChildTreeXml.jsp");    
 	}        
        </SCRIPT> 

<SCRIPT type=text/javascript> 
//根据选中的节点集合根据数据库里的值判断过滤到只留叶子节点
function getIeafList(selectNodeIDList){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("selectNodeIDList",selectNodeIDList);
  core.ajax.sendPacket(mypacket,doProcessGetIeafList,false);
	mypacket=null;
	}
	//getIeafList的回调函数
	function doProcessGetIeafList(packet){
   var ieafList = packet.data.findValueByName("ieafList");
   // showNodeIdList(ieafList);
} 
// 根据选中的节点id 返回该节点下子节点
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeId",strSelectedNodeid);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}
//getTreeListByNodeId的回调函数
	function doProcessGetList(packet){
   var childNodeList = packet.data.findValueByName("worknos");
   var nodeId= packet.data.findValueByName("nodeId");
     insertChildNodeList(childNodeList);
} 
//做插入操作的函数  
function insertChildNodeList(retData){
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	if(varSubItems!=null&&varSubItems!=''){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
   		//alert("getSubItems is not null:\t"+retData[i][3]);
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
       }
        // alert("isleaf0:\t"+retData[i][3]);
       if(retData[i][3]==0){
        	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        		tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          } 
     
     }
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	
       //  alert("getSubItems is null:\t"+retData[i][3]);
         if(retData[i][3]==0){
        	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        		tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
        	   tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          }     	
     	}
}
}
//显示选中节点在的全称(不查数据库判断，数据可能不准确)
function showNodeIdList(){
	 parent.full_name.innerHTML="";
   parent.full_name.innerHTML=tree.getUserData(tree.getSelectedItemId(),"fullname");

}

//显示选中节点在的全称(查询数据库判断)
function nodeListBySql(retData){
//    parent.myH3.innerHTML="";
 //   parent.myH2.innerHTML="";
//		parent.document.form1.treeValue.value="";
//	 for(var i=0;i<retData.length;i++){
//	 	alert(retData[i][4]);
 // 	parent.document.form1.treeValue.value=parent.document.form1.treeValue.value+','+retData[i][0];
 //   parent.myH3.innerHTML=parent.myH3.innerHTML+'<br>'+'→'+retData[i][0]+'→'+retData[i][4];	
//	  }
	}
	
	function addtest(){
		alert("aaaa:/t"+tree.getAllChecked());
	alert("aaaa");	
	tree.insertNewItem(tree.getAllChecked(),"333","tttttt",0,0,0,0,'SELECT') ; 
	}
	function deltest(){
	tree.deleteItem(tree.getAllChecked(),true);	
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
</SCRIPT>        

   
      
