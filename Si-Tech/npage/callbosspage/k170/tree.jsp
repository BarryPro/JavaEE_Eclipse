<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>       
        <TABLE><TBODY><TR><TD vAlign=top>
        <DIV id=treeboxbox_tree></DIV></TD>
        <BR><a href="javascript:void(0);" onclick="getTreeListByNodeId();">test</a><BR>
 
        </TD></TR>
        
        </TBODY></TABLE>
<SCRIPT type=text/javascript> 

		function fixImage(id){
			switch(tree.getLevel(id)){
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
		    function onNodeSelect(node){    
                   // window.parent.frames['main'].document.location="";  
                    getTreeListByNodeId(tree.getSelectedItemId());
     }
		
                tree=new dhtmlXTreeObject("treeboxbox_tree","100%","100%",0);    
                tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");   
                tree.enableCheckBoxes(1); 
                tree.enableThreeStateCheckboxes(true);    
                tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/xml.jsp");      
               // tree.setOnClickHandler(onNodeSelect);
                tree.setOnDblClickHandler(onNodeSelect)
              //  tree.setOnOpenHandler (onNodeSelect);
              //  tree.setOnOpenHandler(onOpenHandlerSql);   
                tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/xml.jsp");   
               
        </SCRIPT> 

<SCRIPT type=text/javascript> 


function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/getChildTreeList.jsp","aa");
	packet.data.add("nodeId",strSelectedNodeid);
	core.ajax.sendPacket(packet,doProcessGetList,true);
	packet=null;
}
	function doProcessGetList(packet){
   var worknos = packet.data.findValueByName("worknos");
    var nodeId= packet.data.findValueByName("nodeId");
    // alert(nodeId);
     fillDataTable (worknos,nodeId);
}   
function fillDataTable(retData,nodeId)
{
	if(nodeId!='000'||nodeId!='0')
  {  
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
     var str=varSubItems.split(",") ;
      alert(str[0]);
        alert(str.length);

	 for(var i=0;i<retData.length;i++){
  //  增加当前节点子节点 
         alert(isStr(retData[i],str)) ;
          if(isStr(retData[i],str)){
            tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 	
          	}        
 }
	}
  
}
      function isStr(strtreeData,str){
      	
      	  for(var j=0;j<str.length;j++){
           	if(str[j]==strtreeData){
           		return true;
           		}
         	}  
         	return false;
      	}   



</SCRIPT> 
   
      
