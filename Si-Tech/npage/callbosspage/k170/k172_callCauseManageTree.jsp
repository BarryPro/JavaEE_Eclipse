<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
    String opCode="k172";
    String opName="����ԭ��ά��";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
%>
<HTML>     
    <HEAD>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" type=text/css rel=STYLESHEET>    
        <LINK href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></SCRIPT>    
        <SCRIPT src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></SCRIPT>
      </HEAD>
          
<BODY onload="initBaseTree();">           

<DIV id="baseTree" style="height:100%"></DIV>

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
//��Ӧ��굥���¼�����ѯ���ݿ�õ���һ�ڵ�

function onNodeSelect(){        
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){
		tree.showItemCheckbox(tree.getSelectedItemId(),0);
		tree.showItemSign(tree.getSelectedItemId(),1);	
		//added by tangsong 20100925
		parent.document.getElementById("relateButton").disabled = true;
  } else {
  	parent.document.getElementById("relateButton").disabled = false;
  }
  //����ѯ���ڵ���Ϣ��ʾ���·�
   showNodeIdInfo();
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  
 
}
 //��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
function onCheckBoxsBySelect(){	
		 parent.full_name.innerHTML="";
	  
	  
	  if(tree.getAllChecked()!=""){
   parent.full_name.innerHTML=tree.getUserData(tree.getAllChecked(),"fullname"); 
	  	}

	//	showNodeIdList();//�����Ż����� ������ȥ��ѯ���ݿ�
	}   
         //����һ����̬��
function initBaseTree(){	
	       tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
          tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");   
      //    tree.enableCheckBoxes(1);   
          tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0");      
          tree.setOnClickHandler(onNodeSelect);
          tree.setOnCheckHandler(onCheckBoxsBySelect);
          tree.enableHighlighting(0);
      //  tree.disableCheckbox("0",1);
          tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k170/k172_createCallCauseXml.jsp?id=0&manage=1");   
	        document.getElementById('0').click();
	}    
        </SCRIPT> 

<SCRIPT type=text/javascript> 
//����ѡ�еĽڵ㼯�ϸ������ݿ����ֵ�жϹ��˵�ֻ��Ҷ�ӽڵ�
function getIeafList(selectNodeIDList){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_isLeafIdList.jsp?manage=1","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("selectNodeIDList",selectNodeIDList);
  core.ajax.sendPacket(mypacket,doProcessGetIeafList,false);
	mypacket=null;
	}
	//getIeafList�Ļص�����
	function doProcessGetIeafList(packet){
   var ieafList = packet.data.findValueByName("ieafList");
   // showNodeIdList(ieafList);
} 
// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_getChildTreeLeaveList.jsp?manage=1","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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
        tree.setUserData(retData[i][0],"superid",retData[i][1]);
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);
        tree.setUserData(retData[i][0],"cityid",retData[i][5]);
        tree.setUserData(retData[i][0],"causedes",retData[i][6]); 
        tree.setUserData(retData[i][0],"visible",retData[i][7]); 
       // alert("aaaaa:\t"+tree.getUserData(retData[i][0],"cityid"));   
       }
        // alert("isleaf0:\t"+retData[i][3]);
       if(retData[i][3]==0){
        //	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.showItemSign(retData[i][0],1);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]==1){
        //		tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
        	  tree.setItemImage2(retData[i][0],'leaf.gif','folderClosed.gif','folderOpen.gif');		
          } 
          
          if(retData[i][7]!='1'){
        	 //���ýڵ���ʽ
           tree.setItemStyle(retData[i][0],"color:red");
        }
     
     }
   }else{
     	for(var i=0;i<retData.length;i++){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ; 
        tree.setUserData(retData[i][0],"superid",retData[i][1]);
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);	
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	
        tree.setUserData(retData[i][0],"cityid",retData[i][5]); 
        tree.setUserData(retData[i][0],"causedes",retData[i][6]);
        tree.setUserData(retData[i][0],"visible",retData[i][7]);
       // alert("getSubItems is null:\t"+retData[i][3]);
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
           if(retData[i][7]!='1'){
        	 //���ýڵ���ʽ
           tree.setItemStyle(retData[i][0],"color:red");
        }   	
     	}
}
}
//��ʾѡ�нڵ��ڵ�ȫ��(�������ݿ��жϣ����ݿ��ܲ�׼ȷ)
function showNodeIdList(){
	 parent.full_name.innerHTML="";
   parent.full_name.innerHTML=tree.getUserData(tree.getSelectedItemId(),"fullname");

}

	
	function addtest(){
	tree.insertNewItem(tree.getAllChecked(),"333","tttttt",0,0,0,0,'SELECT') ; 
	}
	function deltest(){
	tree.deleteItem(tree.getAllChecked(),true);	
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
	
//��ʾѡ�нڵ����Ϣ
  function showNodeIdInfo()
  {
   
    if(tree.getUserData(tree.getSelectedItemId(),"cityid")=="")
    {
       parent.node_city.innerHTML="��";
    }
    else{
    parent.node_city.innerHTML=tree.getUserData(tree.getSelectedItemId(),"cityid");
    }
    parent.nodeName.innerHTML=tree.getSelectedItemText();
    parent.tele_code.innerHTML=tree.getSelectedItemId();
    parent.node_code.innerHTML=tree.getSelectedItemId();
    parent.super_id.innerHTML=tree.getUserData(tree.getSelectedItemId(),"superid");
    parent.node_bak.innerHTML=tree.getSelectedItemText();
    parent.call_type.innerHTML=tree.getSelectedItemText();
    parent.full_name.innerHTML=tree.getUserData(tree.getSelectedItemId(),"fullname");
    if(tree.getUserData(tree.getSelectedItemId(),"visible")==1)
    {
       parent.flag.innerHTML="��";  
    }
    else{
       parent.flag.innerHTML="��"; 
    }
  }
  
  
  //����������ĺ���
function insertCause(){
	
	 if(tree.getUserData(tree.getSelectedItemId(),"visible")==0)
    {
       rdShowMessageDialog('�Բ���,δ��ʾ�Ľ�㲻��������ؽ����Ϣ!',2);
       return false;
    }else
    	{
    		 var par_id= tree.getSelectedItemId();
				 var par_Text=tree.getSelectedItemText();
				 var height = 280;
				 var width = 450;
				 var top = screen.availHeight/2 - height/2;
				 var left=screen.availWidth/2 - width/2;
				 var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
				 window.open("k170_newNodeWin.jsp?par_Text="+par_Text, "newNodeWin", winParam);
    	}
}
//��������Ϣ�����޸�
function updateCause()
{
  var par_id= tree.getSelectedItemId();
	var par_Text=tree.getSelectedItemText();
	var height = 280;
	var width = 450;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
	window.open("k170_updateNode.jsp?par_Text="+par_Text, "newNodeWin", winParam);
}
//ɾ�����ݽڵ�
function delCause()
{
	//added by tangsong 20100925
	if (rdShowConfirmDialog("��ȷ��Ҫɾ���˽ڵ���") == 0) {
		return;
	}
  var selectId=tree.getSelectedItemId();
  var superId=tree.getUserData(selectId,"superid")
  
  if(tree.getUserData(selectId,"isleaf")==1)
  {
    var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_deleteNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("retType","deleteNode");
		packet.data.add("selectId",selectId);
		packet.data.add("superId",superId); 
		core.ajax.sendPacket(packet,doneProcess,true);
		packet=null;
  }
  else
  {
    rdShowMessageDialog('�Բ���,ֻ��ɾ��Ҷ�ӽڵ�!',2);
  }
}

// AJAX�ص������������ݷ��ص�retType�жϾ������
function doneProcess(packet) {
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retCode == "000000") {
		// �����޸Ľڵ������
		var flag = packet.data.findValueByName("flag");
		var superId=packet.data.findValueByName("superId");		
		var nodeId = tree.getSelectedItemId();
		tree.deleteItem(nodeId,true);
		if(flag=='Y'){
			  tree.setUserData(superId,"isleaf",'1');	
			  tree.setItemImage2(superId,'leaf.gif','folderClosed.gif','folderOpen.gif');		
			}else{
				tree.setUserData(superId,"isleaf",'0');	
				tree.setItemImage2(superId,'folderClosed.gif','folderOpen.gif','folderClosed.gif');
			}
		
		rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
		return;
	} else {
		rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
		return false;
	}
}

//�޸����ݿ���Ϣ
 function checkNode(flag)
 {
 	  /*modify by yinzx  20091002*/
 	    var selectId=tree.getSelectedItemId();
 	    var selectSuperId=tree.getUserData(tree.getSelectedItemId(),"superid");
 	    var ssflag=	tree.getUserData(selectSuperId,"visible") ;
 	    if(ssflag=='0' && flag=='1')
    {
	 		 return false; 
	  }else
	  {
	  	 return true;  
	  }
 }

function tongbu()
{
	genxmlnow();
	genxmlnow1();
	genxmlnow2();
	genxmlnow3();
	
	rdShowMessageDialog("ͬ���������",2);	
}

function genxmlnow()
{
 
	 var packet = new AJAXPacket("http://10.161.1.185:15000/npage/callbosspage/k170/k172_callCauseGenXml.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	 core.ajax.sendPacket(packet,doneProcess2,true);
	 packet=null;
	 	 
}

function genxmlnow1()
{
 
	 var packet = new AJAXPacket("http://10.161.1.186:15000/npage/callbosspage/k170/k172_callCauseGenXml.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	 core.ajax.sendPacket(packet,doneProcess2,true);
	 packet=null;
	 	 
}

function genxmlnow2()
{
 
	 var packet = new AJAXPacket("http://10.161.1.187:15000/npage/callbosspage/k170/k172_callCauseGenXml.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	 core.ajax.sendPacket(packet,doneProcess2,true);
	 packet=null;
	 	 
}

function genxmlnow3()
{
 
	 var packet = new AJAXPacket("http://10.161.1.188:15000/npage/callbosspage/k170/k172_callCauseGenXml.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	 core.ajax.sendPacket(packet,doneProcess2,true);
	 packet=null;
	 	 
}

function doneProcess2(packet)
{
			
}
</SCRIPT>        

   
      
