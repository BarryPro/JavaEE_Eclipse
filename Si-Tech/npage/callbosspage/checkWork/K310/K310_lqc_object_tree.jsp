<%
  /*
   * ����: �ʼ�Ȩ�޹���->�ʼ�ƻ�����->ѡ���ʼ�������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K310";
	String opName = "ѡ���ʼ�������";
%>
<%@ page language="java"  pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String strFlag = (String)request.getParameter("flag");
%>

<HTML>    
<HEAD>    
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
</HEAD>   
<BODY >           
<TABLE>
	<TR>
		<TD vAlign=top width="300">
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
if(tree.getUserData(tree.getSelectedItemId(),"isleaf")==0){

	 getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }else{
  //alert("��ȷ��ѡ�иýڵ�Ϊ����ԭ��:/t1"); 
  }  
}
function onClickNodeSelect(){        
   
  if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
  }  
  
}

function onDoubleClickNodeSelect(){        

  var pdoc = window.dialogArguments;  
  pdoc.getElementById("OBJECT_ID").value=tree.getSelectedItemId();
  pdoc.getElementById("OBJECT_GETNAME").value=tree.getSelectedItemText();
  window.close();  
}  

//����һ����̬��
function initBaseTree(){	
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);    
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	// ����������¼���չ���¼��ڵ�
	tree.setOnClickHandler(onClickNodeSelect);
	tree.enableCheckBoxes(0);    
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_lcreate_qc_object_tree_xml.jsp");
	

	document.getElementById('0').click();
}     
</SCRIPT> 

<SCRIPT type=text/javascript> 
	//getIeafList�Ļص�����
	function doProcessGetIeafList(packet){
   var ieafList = packet.data.findValueByName("ieafList");
}

// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_lget_qc_object_list.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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
        tree.setUserData(retData[i][0],"fullname",retData[i][4]);	     
       }
       if(retData[i][3]=='N'){
        	 tree.showItemCheckbox(retData[i][0],0);
        	 tree.setItemImage2(retData[i][0],'folderClosed.gif','folderOpen.gif','folderClosed.gif');
          }	
        if(retData[i][3]=="Y"){
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
         if(retData[i][3]=="N"){
        	 tree.showItemSign(retData[i][0],1);
          }	
        if(retData[i][3]=="Y"){
        		tree.showItemCheckbox(retData[i][0],1);
        	  tree.showItemSign(retData[i][0],0);
          }     	
     	}
}
}

function winClose(flag){
window.opener.document.getElementById("call_cause_id").value=document.form1.treeValue.value;
window.close();
}

initBaseTree();
document.getElementById('0').click();	
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


function cancelSelectValue(){
	var pdoc = window.dialogArguments;  
  	pdoc.getElementById("OBJECT_ID").value="";
  	pdoc.getElementById("OBJECT_GETNAME").value="";
	window.close();
}
</SCRIPT> 
<br/>       
<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit1" type="button" value="ȷ��" onclick="onDoubleClickNodeSelect()">
        	<input class="b_foot" name="reset1" type="button"  onclick="cancelSelectValue();" value="ȡ��">
        </td>
       </tr>
 </table>
 
 <br/>
 <br/>
   
      
