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
        String strFlag =request.getParameter("strFlag");
        String contactId =request.getParameter("contactId");
        String contactMonth =request.getParameter("contactMonth"); 
        String strId =request.getParameter("strId");       
     %>    
<BODY  onload="initBaseTree();">   
<form name="form2" method="POST" action="">	        
<TABLE><TR>
<TD vAlign=top width="300">
<DIV id="baseTree" ></DIV>
</TD>
<TD vAlign=top width="50%">
<DIV id="childTree">
	</DIV>
</TD>
      <input type="hidden" name="strFlag" id="strFlag" value="<%=strFlag%>">
      <input type="hidden" name="contactId" id="contactId" value="<%=contactId%>">
      <input type="hidden" name="contactMonth" id="contactMonth" value="<%=contactMonth%>"> 
      <input type="hidden" name="strId" id="strId" value="<%=strId%>"> 	
        </TR>
        
        </TABLE>
        </form>
</BODY>        
</html>  
 <SCRIPT type=text/javascript> 
 	    var ii=0;
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
  
function onNodeSelect(id){           
  if(tree.getLevel(tree.getSelectedItemId())<3&&tree.getUserData(tree.getSelectedItemId(),"isleaf")==0)
  {
   	  if(tree.getOpenState(id)==1){
         tree.closeAllItems(id);
        }
       else if(tree.getOpenState(id)==-1){
    	   tree.openItem(id);
       }
      else{
    	getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
      }
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
   Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseBaseLeaveTree.jsp?nodeId="+nodeId+"&fullname="+fullname+"&isleaf="+isleaf+"&caption="+caption+"&selectPara="+selectPara+"&mynodeId="+mynodeId+"&iniNum="+iniNum,"myFrame3");
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
     var contactId="";
     var contactMonth="";
     var strFlag='<%=strFlag%>';
    
     if(strFlag==9){
     contactId='<%=contactId%>';
     contactMonth='<%=contactMonth%>';
     }
     else{
      contactId=parent.document.getElementById("contactId").value; 
      contactMonth = parent.document.getElementById("contactMonth").value;
     }
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
     
     if(call_cause_id!=''||call_cause_id!='')
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
        //����һ����̬��
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");      
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
          tree.enableHighlighting(0);
          tree.disableCheckbox("0",0);
          tree.showItemCheckbox("0",0);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");   
          document.getElementById('0').click();
          //��ϯ��������ԭ��ȡ�ö�Ӧ��ˮ����
          if(document.getElementById("strId").value.length<=4){
             findContactInfo();
            }
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
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,1,1,1,'SELECT') ; 
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	
         if(retData[i][3]==0){
         	  var strId=document.getElementById("strId").value;
         	  if(strId.length>4){
         	  	var subStrId="";
         	  	
         	  	subStrId=strId.substring(0,ii+2);
         	  	if(retData[i][0]==subStrId){
         	  	  ii=ii+2;
          	    document.getElementById(subStrId).click();
          	   }
         	  }  
        	  tree.showItemSign(retData[i][0],1);
        	  tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        	  tree.showItemSign(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');	
        	  
          }     	
     	} 
        		 
}

function insertShowName(call_cause_id,callcausedescs,remarkInfo)
{
  parent.document.getElementById("node_Id").value=call_cause_id;
  parent.document.getElementById("my_div").innerHTML=callcausedescs;
  var arr = parent.document.getElementsByTagName("span");
  //alert(arr.length);
  //alert("1");
  var mynodename = "";
  for(var i=0;i<arr.length;i++){
  		var name = arr[i].innerHTML;
 			name = name.replace("&lt;","");
 			name = name.replace("&gt;","");
 			name = name.replace("<BR>","");
 			mynodename = mynodename+","+name;
  }
  parent.show_Name.value=mynodename;
  //parent.document.getElementById("show_Name").value=callcausedescs;
  var strFlag='<%=strFlag%>';
  if(strFlag==9){
		   parent.document.getElementById("node_Name").value="";
		   parent.document.getElementById("remarkInfo").value="";
		   parent.document.frames["myFrame3"].window.unCheckBoxBySelect();
   
   }
   else{
   
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
		   //alert(mynodename);
		   parent.document.getElementById("node_Name").value=mynodename;
   }
}
//��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(retData){
  //  alert(retData);
    parent.show_Name.value="";
		parent.document.form1.node_Id.value="";
		parent.document.form1.node_Name.value="";
		var arr =retData.split(",");
		var j=0;
		var isflag=0;
	 for(var i=0;i<arr.length;i++,j++){
	 	if(j<10){
	  if(tree.getUserData(arr[i],"isleaf")!=null){
	 	if(tree.getUserData(arr[i],"isleaf")==1){
	 	 if(!isInShowName(arr[i])){
  	  parent.document.form1.node_Id.value=parent.document.form1.node_Id.value+','+arr[i];
      parent.show_Name.value=parent.show_Name.value+arr[i]+'��'+tree.getUserData(arr[i],"fullname");	
      parent.document.form1.node_Name.value=parent.show_Name.value;
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
	//�����ѯ��������
	function selectInfo(selectName)
	{      
          Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_callCauseNewTree.jsp?caption="+selectName,"myFrame2");
	  
	}
	/*
	*ģ��onclick�¼���չ���ڵ�
	*/
	function unFoldNode(node_id){
		//var i_length=node_id.length/2;
		var j=0;
   if(i_length==1){
	tree.setCheck(node_id,true);	
	}else{
		for(var i=0;i<=2;i++){
			 	j+=2;
	 // alert("node_id.substring:\t"+node_id.substring(0,j));
	  if(tree.getUserData(node_id.substring(0,j),"isleaf")==0){
	  	document.getElementById(node_id.substring(0,j)).click();
	  	}	
		//tree.setCheck(node_id,true);	
    }
	}	
}
</SCRIPT>        

   
      
