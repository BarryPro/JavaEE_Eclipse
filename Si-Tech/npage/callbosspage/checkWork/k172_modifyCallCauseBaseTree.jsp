<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>    
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/css/dhtmlxtree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/js/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD> 
          
<BODY>           
 <TABLE>	
	<TR>
		 <TD vAlign=top width="300">
      <DIV id="baseTree" ></DIV>
     </TD>
     <TD vAlign=top width="50%">
      <DIV id="childTree"></DIV>
     </TD>
  </TR>
 </TABLE>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
//����ԭ���춯�޸� treeҳ��
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
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
 
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
	if(allCheckItem!=null&&allCheckItem!=''){
		return true;
		}else{
		return false;	
		} 
	}	 
// ȡ�����е�checkboxѡ��
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
        //����һ����̬��
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");   
          tree.enableCheckBoxes(1); 
       // tree.enableSmartCheckboxes(1);
          tree.enableThreeStateCheckboxes(true);    
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createModifyCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.enableHighlighting(0);
          tree.disableCheckbox("0",1);
      //  tree.setOnOpenStartHandler(onNodeSelect);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createModifyCallCauseXml.jsp?id=0");   
	} 
 

	     
</SCRIPT> 

<SCRIPT type=text/javascript> 
//����ѡ�еĽڵ㼯�ϸ������ݿ����ֵ�жϹ��˵�ֻ��Ҷ�ӽڵ�(��ʱ��ʹ��)
function getIeafList(selectNodeIDList){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp","aa");
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
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getChildTreeList.jsp","aa");
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
//��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(retData){
    parent.show_Name.innerHTML="";
		parent.document.form1.node_Id.value="";
		parent.document.form1.node_Name.value="";
		var arr =retData.split(",");
		var j=0;
		var isflag=0;
	 for(var i=0;i<arr.length;i++,j++){
	 	if(j<10){
	  if(tree.getUserData(arr[i],"isleaf")!=null){
	 	if(tree.getUserData(arr[i],"isleaf")==1){
  	parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+','+arr[i];
    parent.show_Name.innerHTML=parent.show_Name.innerHTML+arr[i]+'��'+tree.getUserData(arr[i],"fullname")+'<br>';	
    parent.document.form1.node_Name.value=parent.show_Name.innerHTML;
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
	//��ʼ����
	initBaseTree();
	firstUnCheckItem();	
	
	//�޸�����ԭ�򣬽�ԭ��������ԭ��ѡ��
	function firstUnCheckItem(){
		document.getElementById('0').click();	
	  parent.show_Name.innerHTML="";
    parent.document.form1.node_Name.value="";	
		var strlist =parent.document.form1.node_Id.value;		
		var strdata=strlist.split(",");
		for(var s=0;s<strdata.length;s++){
			if(strdata[s]!=''&&strdata[s]!=null){
		//	alert(strdata[s]);			
		  unFoldNode(strdata[s]);
		  parent.show_Name.innerHTML=parent.show_Name.innerHTML+strdata[s]+'��'+tree.getUserData(strdata[s],"fullname")+'<br>';	
				}
			}
		parent.document.form1.node_Id.value=tree.getAllCheckedBranches();
		parent.document.form1.node_Name.value=parent.show_Name.innerHTML;
		parent.document.form1.pre_node_Id.value=parent.document.form1.node_Id.value;
		parent.document.form1.pre_node_Name.value=parent.document.form1.node_Name.value;
	//	alert("id___"+parent.document.form1.pre_node_Id.value);
	//	alert("name___"+parent.document.form1.pre_node_Name.value);
		}

	/*
	*ģ��onclick�¼���չ���ڵ�
	*/
	
	function unFoldNode(node_id){
		var i_length=node_id.length/2;
		var j=0;
		for(var i=0;i<i_length;i++) {
			 	j+=2;
		document.getElementById(node_id.substring(0,j)).click();
		}
		tree.setCheck(node_id,true);	
		
	}	
</SCRIPT>        
