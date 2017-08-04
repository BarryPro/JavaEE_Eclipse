<%
  /*
   * ����: ��ӱ������ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	//String opCode = "K230";
	//String opName = "���������";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>

<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=stylesheet>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>

<script>

/**
  *
  *����ӱ��������𴰿�
  *
  */
function add_qc_object(){
	/*
	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
	window.open('K230_add_qc_object.jsp', '', param);
	*/
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=300px';
	window.showModalDialog('K230_add_qc_object.jsp?time=' + time, window, winParam);
}

/**
  *
  *���޸ı��������𴰿�
  *
  */
function update_qc_object(){
	var selectedItemId = tree.getSelectedItemId();
	if(selectedItemId == '' || selectedItemId == undefined||'0'==selectedItemId){
		rdShowMessageDialog('��ѡ�񱻼��������ٽ����޸ģ�', 0);
		return false;
	}
	/*
	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
	window.open('K230_update_qc_object.jsp?selectedItemId=' + selectedItemId, '', param);
	*/
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=300px';
	window.showModalDialog('K230_update_qc_object.jsp?time=' + time + '&selectedItemId=' + selectedItemId, window, winParam);
}

/**
  *
  *ɾ������������
  *
  */
function delete_qc_object(){
	//alert(window.parent.frames.topFrame.document.getElementById("hasContentNum").value);
	
	var item_id = tree.getSelectedItemId();
	if('0'==item_id){
		rdShowMessageDialog('��ѡ�����ı���������ɾ����', 0);
		return false;
		}
	var hasContentNum = window.parent.frames.topFrame.document.formbar.hasContentNum.value;
	var selectedItemId = tree.getSelectedItemId();
	if(selectedItemId == '' || selectedItemId == undefined){
		rdShowMessageDialog('��ѡ�񱻼��������ٽ���ɾ����', 0);
		return false;
	}
	//alert(window.parent.frames.topFrame.document.formbar.hasContentNum.value);
	if(hasContentNum=="1"){
		rdShowMessageDialog('�ö�����ڿ�������,���ܱ�ɾ��!', 0);
		return false;
		}
	if(rdShowConfirmDialog("ȷ��ɾ����ǰ����������ô��") == 1){
		
		delQcObject();
	}
}


/*�Է���ֵ���д���*/
function doProcessDelQcObject(packet){
	//alert("Begin call doProcessDelQcObject()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="delQcObject"){
		if(retCode=="000000"){
			rdShowMessageDialog('�ɹ�ɾ������������', 2);
			tree.deleteItem(tree.getSelectedItemId());


		}else if(retCode == "100003"){
			rdShowMessageDialog('ɾ������������ʧ��!', 0);
			return false;
		}
	}

	//alert("End call doProcessDelQcObject()......");
}

/**
  *
  *ɾ������������
  *
  */
function delQcObject(){
	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_object.jsp","���Ժ�...");

	chkPacket.data.add("retType","delQcObject");
	chkPacket.data.add("selectedItemId", tree.getSelectedItemId());
	core.ajax.sendPacket(chkPacket, doProcessDelQcObject, true);
	chkPacket =null;
	//alert("End call delQcObject()....");
}

</script>

</head>

<body onload="initBaseTree();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td id="footer"  align="left">
	<input type="button" name="btn_add" value="���" class="b_foot" onclick="add_qc_object()"/>
	<input type="button" name="btn_update" value="�޸�" class="b_foot" onclick="update_qc_object()"/>
	<input type="button" name="btn_delete" value="ɾ��" class="b_foot" onclick="delete_qc_object()"/>
</td>
</tr>
</table>
<table>
<tr>
	<td valign="top" width="300">
	<div id="basetree" ></div>
	</td>
	<td valign=top width="50%">
	<div id="childtree"></div>
	</td>
</tr>
</table>
</body>
</html>

<script type=text/javascript>

/*
 *����һ����̬��
 *
 */
function initBaseTree(){

	tree=new dhtmlXTreeObject("baseTree","100%","100%",-1);
	tree.setImagePath(<%=request.getContextPath()%>"/images/dtmltree_imgs/csh_books/");
	tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");

	//������굥���¼�
	tree.setOnClickHandler(onNodeClick);
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_create_qc_object_tree_xml.jsp?id=0");
}

/**
  *��Ӧ��굥���¼���ѡ�е�ǰ�ڵ�
  *
  */
function onNodeClick(){
	window.parent.frames['topFrame'].location.href = "./K230_qc_content_list.jsp?object_id=" + tree.getSelectedItemId();
	window.parent.frames['mainFrame'].location.href = "./K230_blank.jsp";
}

</script>

<script type=text/javascript>

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
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K230/K230_get_qc_object_list.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
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

</script>