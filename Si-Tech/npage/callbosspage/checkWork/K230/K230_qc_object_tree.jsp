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
<%@page contentType="text/html;charset=GBK"%>
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
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=290px';
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
		window.parent.top.similarMSNPop("��ѡ�񱻼��������ٽ����޸ģ�");
		return false;
	}
	var time     = new Date();
	var winParam = 'dialogWidth=750px;dialogHeight=290px';
	window.showModalDialog('K230_update_qc_object.jsp?time=' + time + '&selectedItemId=' + selectedItemId, window, winParam);
}

/**
  *
  *ɾ������������
  *
  */
function delete_qc_object(){
	
	var item_id = tree.getSelectedItemId();
	if('0'==item_id){
		window.parent.top.similarMSNPop("��ѡ�����ı���������ɾ����");
		return false;
		}
	var hasContentNum = window.parent.frames.topFrame.document.formbar.hasContentNum.value;
	var selectedItemId = tree.getSelectedItemId();
	if(selectedItemId == '' || selectedItemId == undefined){
		window.parent.top.similarMSNPop("��ѡ�񱻼��������ٽ���ɾ����");
		return false;
	}
	if(hasContentNum=="1"){
		window.parent.top.similarMSNPop("�ö�����ڿ�������,���ܱ�ɾ����");
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
			window.parent.top.similarMSNPop("�ɹ�ɾ������������");
			tree.deleteItem(tree.getSelectedItemId());
		}else if(retCode == "100003"){
			window.parent.top.similarMSNPop("ɾ������������ʧ�ܣ�");
			return false;
		}
	}
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
}

</script>
<!-- added by tangsong 20100823 ��������: ������ʽ�������������߶Ͽ�-->
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head>

<body onload="initBaseTree();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td align="left">
	<input type="button" name="btn_add" value="���" class="b_text" onclick="add_qc_object()"/>
	<input type="button" name="btn_update" value="�޸�" class="b_text" onclick="update_qc_object()"/>
	<input type="button" name="btn_delete" value="ɾ��" class="b_text" onclick="delete_qc_object()"/>
</td>
</tr>
</table>
<table>
<tr>
	<td valign="top" width="300">
	<div id="basetree"></div>
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
	tree.enableTreeLines(true);
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
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
