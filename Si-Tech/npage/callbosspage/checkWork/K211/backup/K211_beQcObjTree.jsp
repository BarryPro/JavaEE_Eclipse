<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
//ѡ�񱻼����
    String opCode="K201";
    String opName="�������";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String strFlag = (String)request.getParameter("flag");

%>

<HTML>    
    <HEAD> 
    	<title>ѡ�񱻼����</title>   
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD> 
<BODY >           
<TABLE><TR><TD vAlign=top width="300">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="50%">

</TD>
</TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 


//��Ӧ��굥���¼�����ѯ���ݿ�õ���һ�ڵ�

function onNodeSelect(){        
if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }  
  alert(tree.getSelectedItemId());
  // ��������һ�����ҳ��
  var framemiddle=window.parent.frames['framemiddle'];
  framemiddle.parent.document.sitechform.beQcObjName.value=tree.getSelectedItemText();
  framemiddle.parent.document.sitechform.beQcObjId.value=tree.getSelectedItemId();
  framemiddle.parent.window.sendIframemiddleId(tree.getSelectedItemId());
	
	}
  
 //����һ����̬��
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
          tree.enableCheckBoxes(0); 
          tree.enableThreeStateCheckboxes(false);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_createObjectIdTreeXml.jsp");      
          tree.setOnClickHandler(onNodeSelect);
          //tree.setOnDblClickHandler(onDbClickSelect);
          tree.enableHighlighting(1);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_createObjectIdTreeXml.jsp");   
          document.getElementById('0').click();		
	}   
</SCRIPT> 

<SCRIPT type=text/javascript> 
// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K211/K211_getObjectIdChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeId",strSelectedNodeid);
	core.ajax.sendPacket(packet,doProcessGetList,false);
	packet=null;
}
//getTreeListByNodeId�Ļص�����
	function doProcessGetList(packet){
   var childNodeList = packet.data.findValueByName("worknos");
   var nodeId= packet.data.findValueByName("nodeId");
     insertChildNodeList(childNodeList);
} 
//����������ĺ���  
function insertChildNodeList(retData){
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	if(varSubItems!=null){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	 
       }
       if(retData[i][3]=='N'){
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=='Y'){
        	  tree.showItemSign(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');			
          } 
     }
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
         if(retData[i][3]=='N'){
        	 tree.showItemSign(retData[i][0],1);
          }	
        if(retData[i][3]=='Y'){
        	  tree.showItemSign(retData[i][0],0);
          }     	
     	}
}
}

initBaseTree();

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
</SCRIPT>        

   
      
