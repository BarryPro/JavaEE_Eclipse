<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
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
//��Ӧ��굥���¼�����ѯ���ݿ�õ���һ�ڵ�
  
function onNodeSelect(){          
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){
	tree.showItemCheckbox(tree.getSelectedItemId(),0);
	tree.showItemSign(tree.getSelectedItemId(),1);	
  } 
  //alert(tree.getLevel(tree.getSelectedItemId()));
  if(tree.getLevel(tree.getSelectedItemId())<2)
  {
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }
  
  else
  {
   var nodeId= tree.getSelectedItemId();
  // nodeId = "080301";
  //alert(nodeId);
   var fullname=tree.getUserData(nodeId,"fullname");
  
   var isleaf=tree.getUserData(nodeId,"isleaf");
   
   var mynodeId = parent.document.getElementById("node_Id").value;
   //alert(mynodeId);
  
   var caption=tree.getSelectedItemText();
   var selectPara=0;
   var iniNum=1;
   //alert(isleaf+"_"+caption);
   Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_modifyCallCauseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&iniNum="+iniNum,"myFrame3");
  }
 
}
 //��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
		showNodeIdList(allCheckItem);//�����Ż����� ������ȥ��ѯ���ݿ�
//		getIeafList(allCheckItem);  �Ϸ���(��Ҫ��ѯ���ݿ�) ���Ƽ�
		}  
	} 
//�ж���checkbox�Ƿ���ֵ 
function isCheckBoxsList(){
	var allCheckItem=tree.getAllCheckedBranches();
//	alert(allCheckItem);
	if(allCheckItem!=null&&allCheckItem!=''){
		return true;
		}else{
		return false;	
		} 
	}	
//��ϯ��������ԭ��ȡ�ö�Ӧ��ˮ����
 function findContactInfo()
 {
     var contactId=  parent.document.getElementById("contactId").value;
     var contactMonth = parent.document.getElementById("contactMonth").value;
    var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_selectCause.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
    mypacket.data.add("strContactId",contactId);
    mypacket.data.add("strContactMonth",contactMonth);
	  core.ajax.sendPacket(mypacket,doFindContactInfo,true);
	  mypacket=null;  
 }
 //findContactInfo�ص�����
 function doFindContactInfo(packet)
 {
     var call_cause_id= packet.data.findValueByName("call_cause_id");
     var callcausedescs =packet.data.findValueByName("callcausedescs");
     var remarkInfo =   packet.data.findValueByName("remarkInfo");
    //alert(call_cause_id);
    //alert(callcausedescs);
    //alert(remarkInfo);
     if(call_cause_id!=null ||call_cause_id!=''||callcausedescs!=null ||call_cause_id!='')
     { 
        insertShowName(call_cause_id,callcausedescs,remarkInfo);
     }
 }
 
// ȡ�����е�checkboxѡ��
function unCheckBoxBySelect(){
var allCheckItem=tree.getAllCheckedBranches();
//alert(allCheckItem);
if(allCheckItem!=null&&allCheckItem!=''){
var str = new Array();
str=allCheckItem.split(",");
for(var i=0;i<str.length;i++){
//	alert("str"+str[i]);
	tree.setCheck(str[i],false);
	}
		}  
	}
/*
	*ģ��onclick�¼���չ���ڵ�
	*/
	function unFoldNode(node_id){
		var i_length=node_id.length/2;
		var j=0;
   if(i_length==1){
	tree.setCheck(node_id,true);	
	}else{
		for(var i=0;i<=i_length;i++){
			 	j+=2;
	 // alert("node_id.substring:\t"+node_id.substring(0,j));
	  if(tree.getUserData(node_id.substring(0,j),"isleaf")=='N'){
	  	document.getElementById(node_id.substring(0,j)).click();
	  	}	
		tree.setCheck(node_id,true);	
    }
	}	
}
function openFirstNode(){
/*var nodeId="01";
var fullname=tree.getUserData(nodeId,"fullname");
  
   var isleaf=tree.getUserData(nodeId,"isleaf");
   
   var mynodeId = parent.document.getElementById("node_Id").value;
   //alert(mynodeId);
  
   var caption=tree.getSelectedItemText();
   var selectPara=0;
   
   //alert(isleaf+"_"+caption);
   Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_modifyCallCauseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId,"myFrame3");*/
}
        //����һ����̬��
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");  
          //tree.enableCheckBoxes(1);
       // tree.enableSmartCheckboxes(1);
        // tree.enableThreeStateCheckboxes(true);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
         // tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.enableHighlighting(0);
          tree.disableCheckbox("0",0);
          tree.showItemCheckbox("0",0);
      //  tree.setOnOpenStartHandler(onNodeSelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");   
          document.getElementById('0').click();
          //Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_modifyCallCauseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId,"myFrame3");
          //��ϯ��������ԭ��ȡ�ö�Ӧ��ˮ���� 
          openFirstNode();
          findContactInfo();
}         
        </SCRIPT> 

<SCRIPT type=text/javascript> 
//����ѡ�еĽڵ㼯�ϸ������ݿ����ֵ�жϹ��˵�ֻ��Ҷ�ӽڵ�(��ʱ��ʹ��)
function getIeafList(selectNodeIDList){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("selectNodeIDList",selectNodeIDList);
  core.ajax.sendPacket(mypacket,doProcessGetIeafList,true);
	mypacket=null;
	}
	//getIeafList�Ļص�����
	function doProcessGetIeafList(packet){
   var ieafList = packet.data.findValueByName("ieafList");
    showNodeIdList(ieafList);
} 
// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("nodeId",strSelectedNodeid);
	core.ajax.sendPacket(packet,doProcessGetList,true);
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
   	if(varSubItems!=null&&varSubItems!=''){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
   		//alert("getSubItems is not null:\t"+retData[i][3]);
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
       }
       if(retData[i][3]==0){
        	// tree.showItemCheckbox(retData[i][0],0);
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
        	// tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        		//tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          }     	
     	}
}
}

function insertShowName(call_cause_id,callcausedescs,remarkInfo)
{
  //var els=parent.document.getElementsByTagName("span");
  //if(els.length<=10){
  //parent.document.getElementById("node_Id").value=call_cause_id;
  //parent.show_Name.innerHTML=callcausedescs;
  parent.document.getElementById("pre_node_Id").value=call_cause_id;
	parent.document.getElementById("pre_node_Name").value=callcausedescs;
	
	parent.document.getElementById("node_Id").value=call_cause_id;
  parent.document.getElementById("my_div").innerHTML=callcausedescs;
  var arr = parent.document.getElementsByTagName("span");
  //alert(arr);
  var mynodename = "";
  for(var i=0;i<arr.length;i++){
  		var name = arr[i].innerHTML;
  		//alert(name);
 			name = name.replace("&lt;","");
 			name = name.replace("&gt;","");
 			name = name.replace("<BR>","");
 			mynodename = mynodename+","+name;
  }
  //alert(mynodename);
  parent.document.getElementById("show_Name").value=mynodename;
  parent.document.getElementById("remarkInfo").value=remarkInfo;
		   
  //alert(mynodename);
  var arrid =call_cause_id.split(",");
  var arrname = mynodename.split(",");
  for(var i=0;i<arrid.length;i++){
   		
 		var myid = arrid[i];
 		var myname =arrname[i];
   		//alert(myid);
 		if(myid!=""){
 				parent.document.getElementById("select_Name").options.add(new Option(myname,myid));
 		}
  }
  
  parent.document.getElementById("node_Name").value=mynodename;

}
//��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(retData){
  //  alert(retData);
    parent.show_Name.innerHTML="";
		parent.document.getElementById("node_Id").value="";
		parent.document.getElementById("node_Name").value="";
		var arr =retData.split(",");
		var j=0;
		var isflag=0;
	 for(var i=0;i<arr.length;i++,j++){
	 	if(j<10){
	  if(tree.getUserData(arr[i],"isleaf")!=null){
	 	if(tree.getUserData(arr[i],"isleaf")==1){
	 	 if(!isInShowName(arr[i])){
  	  parent.document.getElementById("node_Id").value=parent.document.getElementById("node_Id").value+','+arr[i];
      parent.show_Name.innerHTML=parent.show_Name.innerHTML+"<span id='"+arr[i]+"'>"+arr[i]+'��'+tree.getUserData(arr[i],"fullname")+'</span><br>';	
      parent.document.getElementById("node_Name").value=parent.show_Name.innerHTML;
     } 
    }
  if(tree.getUserData(arr[i],"isleaf")==0){
  	//alert('����ѡ����ڵ�');	
  	tree.setCheck(arr[i],0);
  //	 tree.disableCheckbox(arr[i],1);
  	}
	 		
	 		}
	 
	 		}else{
	 			//�����Ƿ���ʾ�������־
	 			tree.setCheck(arr[i],false);
	 		  isflag=1;
	 		}

	}
	//��ʾ���������
	if(isflag==1){
			rdShowMessageDialog('����ԭ����Ŀ����Ѿ���10��',2);
		}
}

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
	
	/*
	*�жϽڵ�ID�Ƿ���ѡ�еļ�����
	*/
	function isInShowName(node_id){
	
	 var els =parent.document.getElementsByTagName("span");
	 if(els==null||els==undefined)return false;
	 for(var i=0;i<els.length;i++){
	   if(els[i].id==node_id){
	     return true;
	   }
	 }
	 return false;
	}
	
	
	
</SCRIPT>        

   
      
