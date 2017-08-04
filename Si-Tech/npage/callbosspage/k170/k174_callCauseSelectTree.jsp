<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
//选择来电原因查询条件
    String opCode="k172";
    String opName="来电原因";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String strFlag = (String)request.getParameter("flag");
	//  out.println("strFlag="+strFlag);
%>

<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD> 
<BODY >           
<TABLE><TR><TD vAlign=top >
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top >

</TD>
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 


//响应鼠标单击事件，查询数据库得到下一节点

function onNodeSelect(){        
if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){

	 getTreeListByNodeId(tree.getSelectedItemId()); //用ajax动态查询数据
  }else{
  //alert("您确认选中该节点为来电原因:/t1"); 
  }  
}
function onDbClickSelect(){
	 //if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==1){
	 var str=<%=strFlag%>;	
	if(str==0){
		window.opener.document.getElementById("call_cause_id").value=tree.getSelectedItemId();
		window.opener.document.getElementById("show_CauseName").value=tree.getSelectedItemText();
		}
	if(str==1){
			window.opener.document.getElementById("pre_call_cause_id").value=tree.getSelectedItemId();
			window.opener.document.getElementById("pre_cause_name_id").value=tree.getSelectedItemText();
		}
  if(str==2){
   	window.opener.document.getElementById("last_call_cause_id").value=tree.getSelectedItemId();
   	window.opener.document.getElementById("last_cause_name_id").value=tree.getSelectedItemText();
 	  }
 	  window.close();
  //}
	
	}
  
         //构建一个动态树
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
          tree.enableCheckBoxes(0); 
       // tree.enableSmartCheckboxes(1);
          tree.enableThreeStateCheckboxes(false);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnDblClickHandler(onDbClickSelect);
       // tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.enableHighlighting(1);
        //  tree.enableRadioButtons(true);
      //  tree.disableCheckbox("0",1);
      //  tree.setOnOpenStartHandler(onNodeSelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");   
	}      
        </SCRIPT> 

<SCRIPT type=text/javascript> 
//根据选中的节点集合根据数据库里的值判断过滤到只留叶子节点
function getIeafList(selectNodeIDList){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("selectNodeIDList",selectNodeIDList);
  core.ajax.sendPacket(mypacket,doProcessGetIeafList,true);
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
	core.ajax.sendPacket(packet,doProcessGetList,true);
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
   	if(varSubItems!=null){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
   		//Alert("getSubItems is not null:\t"+retData[i][3]);
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
       }
        // alert("isleaf0:\t"+retData[i][3]);
       if(retData[i][3]==0){
        //	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        	//	tree.showItemCheckbox(retData[i][0],1);
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
        //	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
          }	
        if(retData[i][3]==1){
        	//	tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
          }     	
     	}
}
}
	function winClose(flag){
		if(flag=='0'){
			
			}
		if(flag='1'){
			}
		if(flag='2'){
			
			}
window.opener.document.getElementById("call_cause_id").value=document.form1.treeValue.value;
window.close();
}
initBaseTree();
document.getElementById('0').click();	
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

   
      
