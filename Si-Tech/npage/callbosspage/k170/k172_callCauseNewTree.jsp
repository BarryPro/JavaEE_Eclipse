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
     <%
        String caption =request.getParameter("caption");
        String strFlag =request.getParameter("strFlag");
        String contactId =request.getParameter("contactId");
        String contactMonth =request.getParameter("contactMonth");
     %>     
<BODY >           
<TABLE><TR><TD vAlign=top width="500">
<form name="form2" method="POST" action="">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="60%" >
<DIV id="childTree">
	</DIV>
</TD>
<input type="hidden" name="strFlag" id="strFlag" value="<%=strFlag%>">
<input type="hidden" name="contactId" id="contactId" value="<%=contactId%>">
<input type="hidden" name="contactMonth" id="contactMonth" value="<%=contactMonth%>">
        	
        </TR>
        
        </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
     var  caption='<%=caption%>';
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
 
   var fullname=tree.getUserData(nodeId,"fullname");
  
   var isleaf=tree.getUserData(nodeId,"isleaf");
  
   //var caption=tree.getSelectedItemText();
     var captionName=tree.getUserData(nodeId,"caption");
     var selectPara=1;
     var iniNum=1;
     var mynodeId = parent.document.getElementById("node_Id").value;
     //alert(mynodeId);
     Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+captionName+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&iniNum="+iniNum,"myFrame3");
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
    var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_insertCause081126.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
    mypacket.data.add("strContactId","111120081100000000000681");
    mypacket.data.add("strContactMonth","200811");
	  core.ajax.sendPacket(mypacket,doFindContactInfo,true);
	  mypacket=null;  
 }
 //findContactInfo�ص�����
 function doFindContactInfo(packet)
 {
     var call_cause_id= packet.data.findValueByName("call_cause_id");
     var callcausedescs =packet.data.findValueByName("callcausedescs");
     if(call_cause_id!=null ||call_cause_id!=''||callcausedescs!=null ||call_cause_id!='')
     { 
        insertShowName(callcausedescs);
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
initBaseTree(caption);	
	
        //����һ����̬��
function initBaseTree(caption){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");      
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createNewCauseXml.jsp?cation="+caption);      
          tree.setOnClickHandler(onNodeSelect);
          tree.enableHighlighting(0);
          tree.disableCheckbox("0",0);
          tree.showItemCheckbox("0",0);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createNewCauseXml.jsp?cation="+caption);   
          //document.getElementById('0').click();
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
        tree.setUserData(retData[i][0],"caption",retData[i][2]); 
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
        tree.setUserData(retData[i][0],"caption",retData[i][2]);
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

function insertShowName(callcausedescs)
{
  //var els=parent.document.getElementsByTagName("span");
  //if(els.length<=10){
  parent.show_Name.innerHTML=callcausedescs;
  //}
}
//��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(retData){
  //  alert(retData);
    parent.show_Name.innerHTML="";
    		//modify by fangyuan 20090228
		//parent.document.form1.node_Id.value="";
		//parent.document.form1.node_Name.value="";
		parent.document.getElementById("node_Id").value="";
		parent.document.getElementById("node_Name").value="";
		//end
		var arr =retData.split(",");
		var j=0;
		var isflag=0;
	 for(var i=0;i<arr.length;i++,j++){
	 	if(j<10){
	  if(tree.getUserData(arr[i],"isleaf")!=null){
	 	if(tree.getUserData(arr[i],"isleaf")==1){
	 	 if(!isInShowName(arr[i])){
	 	 	//modify by fangyuan 20090228
		  	 //parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+','+arr[i];
		  	 parent.document.getElementById("node_Id").value=parent.document.getElementById("node_Id").value+','+arr[i];
		      parent.show_Name.innerHTML=parent.show_Name.innerHTML+"<span id='"+arr[i]+"'>"+arr[i]+'��'+tree.getUserData(arr[i],"fullname")+'</span><br>';	
		      //parent.document.form1.node_Name.value=parent.show_Name.innerHTML;
		      parent.document.getElementById("node_Name").value=parent.show_Name.innerHTML;
      		//end 
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

   
      
