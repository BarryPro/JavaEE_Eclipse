<%
  /*
   * ����: ѡ���ʼ칤��Ⱥ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: tancf
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K310";
	String opName = "ѡ���ʼ칤��Ⱥ��";
%>

<%@ page language="java"  pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	  String loginNo = (String)session.getAttribute("workNo");
	  String orgCode = (String)session.getAttribute("orgCode");
	  String strFlag = (String)request.getParameter("flag");
	  String selectedBefore = (String)request.getParameter("selectedBefore");
	 
%>

<HTML>
    <HEAD>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
   </HEAD>
<title>���ʼ���</title>
<BODY >
<TABLE>
	<TR>
		<TD vAlign=top width="300">
			<DIV id="baseTree" ></DIV>
		</TD>
		<TD vAlign=top width="50%">
		</TD>
 </TR>
 <TR>
     <td align="center">
         	<input type="button" name="bqcname1" class="b_text" value="ȷ�����ر�" onclick="getSelected();">
    		<input type="button" name="bqcname2" class="b_text" value="ȡ��" onclick="window.close();">
     </td>
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

  }
}

function onClickNodeSelect(){ 

if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
	
getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
}

}

//����һ����̬��
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	// ����������¼���չ���¼��ڵ�
	tree.setOnClickHandler(onClickNodeSelect);
	tree.setOnCheckHandler(onCheckStateChange);
	tree.setOnDblClickHandler(onClickNodeSelect);
	tree.enableHighlighting(0);
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_createCallCauseXml.jsp");
	
	// ��ʼչ����һ��
	document.getElementById('0').click();
	
	//ԭѡ�нڵ�Ĭ�Ϲ�ѡ
	var tmpSelected = '<%=selectedBefore%>';
	if(tmpSelected!=''&&tmpSelected!=undefined){
			var tmpArr = tmpSelected.split(",");
			for(var i=0;i<tmpArr.length;i++){
					unFoldNode(tmpArr[i].trim());
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

	  if(tree.getUserData(node_id.substring(0,j),"isleaf")=='N'){

	  	document.getElementById(node_id.substring(0,j)).click();

	  	}	

		tree.setCheck(node_id,true);	

    }

	}	

}

//checkbox״̬�ı�
function onCheckStateChange(id){
	var checkedIds = tree.getAllChecked();
		var str = new Array();
		var objectId1;
		var objectId3;
		var objectId2 = tree.getUserData(id,"objectId");;
   	if(checkedIds!=""&&checkedIds!=undefined){
   		 str=checkedIds.split(",");
   		 if(str.length>1){
   		 	objectId1 = tree.getUserData(str[0],"objectId");
   		 	objectId3 = tree.getUserData(str[1],"objectId");
   		 	if(objectId2.trim()!=objectId1.trim()||objectId2.trim()!=objectId3.trim()){
   		 		similarMSNPop("������Ӳ�ͬ����������ı�������飡");
   		 		tree.setCheck(id,0);	
   		 	}
   		 }
   	}
   	
   	var pdoc = window.dialogArguments;
   	var tmpVal = pdoc.parent.frames.rightFrame.document.getElementById("select_object_id").value;
   	if(tmpVal!='')
   	{
			var checkedGroupIds = pdoc.document.getElementById("right_select_object_id").value;
			var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310bqcCheckRelation.jsp?flag=bqc","��ȴ�");
			packet.data.add("checkGroupId",id);
			packet.data.add("checkedGroupIds",checkedGroupIds);
			core.ajax.sendPacket(packet,doProcessRelation,false);
			packet=null;
		}
		
	}
	
	/**
  *����ֵ����
  */
function doProcessRelation(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var tmpNum = packet.data.findValueByName("tmpNum");
	var chkGpId = packet.data.findValueByName("chkGpId");
	var checkedNum = packet.data.findValueByName("checkedNum");
	if(retCode=="000000"){
		if(checkedNum.trim()>tmpNum.trim()){
				similarMSNPop("ѡ�еı������в��ֲ��ܱ���ѡ�е��ʼ����ʼ죡");
   		 	tree.setCheck(chkGpId,0);	
		}
	}
}

/**
  *����ѡ��ı��ʼ칤��
  *
  */
function getSelected(){
var pdoc = window.dialogArguments;
pdoc.document.getElementById("select_object_id").value = tree.getAllChecked();
pdoc.document.getElementById("formbar").submit();
window.close();
}
</SCRIPT>

<SCRIPT type=text/javascript>
	//getIeafList�Ļص�����
	function doProcessGetIeafList(packet){
   var ieafList = packet.data.findValueByName("ieafList");
}
// ����ѡ�еĽڵ�id ���ظýڵ����ӽڵ�
function getTreeListByNodeId(strSelectedNodeid){
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_getChildTreeList.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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
	var pdoc = window.dialogArguments;
   	var varSubItems=tree.getSubItems(tree.getSelectedItemId()) ;
   	var str = new Array();
   	if(varSubItems!=null){
   		 str=varSubItems.split(",");
   		 for(var i=0;i<retData.length;i++){
       if(!isStr(retData[i][0],str)){
        tree.insertNewItem(retData[i][1],retData[i][0],retData[i][2],0,0,0,0,'SELECT') ;
        tree.setUserData(retData[i][0],"isleaf",retData[i][3]);
        tree.setUserData(retData[i][0],"objectId",retData[i][4]);
        tree.setUserData(retData[i][0],"fullname",retData[i][5]);
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
        tree.setUserData(retData[i][0],"objectId",retData[i][4]);
        tree.setUserData(retData[i][0],"fullname",retData[i][5]);
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
		if(flag=='0'){

			}
		if(flag='1'){
			}
		if(flag='2'){

			}
pdoc.document.getElementById("call_cause_id").value=document.form1.treeValue.value;
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
</SCRIPT>