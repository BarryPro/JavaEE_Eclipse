<%
  /**
   * ����: �ʼ�Ȩ�޹���->�����ʼ�Ȩ��->�ʼ�����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:		2009/04/09		mixh
   *				�޸����������߼�
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" type=text/css rel=STYLESHEET>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js" type=text/javascript></script>
<!-- added by tangsong 20100823 ��������: ������ʽ�������������߶Ͽ�-->
<style type="text/css">
	#basetree td {
		padding:0;
	}
</style>
</head>

<body >
<table width="400" height="1000">
<TR>
<td vAlign=top width="400" height="100%">
<div id="baseTree"></DIV>
</td>
</tr>
</table>
<input type="hidden" id="checkedGroup" name="checkedGroup"  value=""/>
</body>
</html>
<script type="text/javascript">

//�����¼�
function onClickNodeSelect(){
	//�屻���鹤���б�
	parent.frames.rightCenterLoginNo.clearRow(parent.frames.rightCenterLoginNo.dataTable);
	//��ȷ��ʾ�ʼ�Աӵ���ʼ����¹���Ȩ��
	parent.frames.rightFootLoginNo.CopyHtmlElement();

	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
		if(tree.getSelectedItemId()!=0){
			getCheckGroupLoginNo();
		}
	}else{
		getCheckGroupLoginNo();
	}
}

function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",0);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.setOnClickHandler(onClickNodeSelect);
	tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K290/k290_createXml.jsp");
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K290/k290_createXml.jsp?id=0");
}


/**
  *����ѡ���ʼ��������ʼ�Ա����
  */
function getCheckGroupLoginNo(){
	var nodeId = tree.getSelectedItemId();
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K300/K290/k290_getLoginNoByCheckGroupId.jsp","");
	packet.data.add("nodeId",nodeId);
	core.ajax.sendPacket(packet,doProcessCheckLoginList,false);
	packet=null;
}

/**
  *getCheckGroupLoginNo�ص�����
  *1��չʾ�ʼ�Ա���ţ�
  *2����ø��ʼ������ʼ�Ȩ�޵ı����飬ˢ�±�����ҳ�棻
  */
function doProcessCheckLoginList(packet){
   	var loginNoList = packet.data.findValueByName("loginNoList");   	
   	var checkedGroupList = packet.data.findValueByName("checkedGroupList");
        
    document.getElementById("checkedGroup").value = checkedGroupList;
    window.parent.leftFootFrame.addOption(loginNoList);
    /*mod by mixh 20090409 begin*/
    window.parent.rightCenterTree.location.href = "/npage/callbosspage/checkWork/K300/K280/k280_tree.jsp?checkedGroupList=" +  checkedGroupList;
	/*mod by mixh 20090409 end*/
}

/**
  *���ص�ǰѡ���ʼ������ʼ�Ȩ�޵ı��ʼ���ID
  *��k280_tree.jspҳ���firstUnCheckItem()��������
  */
function getCheckedGroupList(){
	var checkedGroup= document.getElementById("checkedGroup").value;
	return checkedGroup;
}

/**
  *����������δ��
  */
function setGroupLoginNoNum(num){
	if(tree.getUserData(tree.getSelectedItemId(),"flag")!='0'){
		if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='Y'){
			tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��');
			tree.setUserData(tree.getSelectedItemId(),"flag",'0');
		}else{
			tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��,��������������');
			tree.setUserData(tree.getSelectedItemId(),"flag",'0');
		}
	}
}
//��ʼ����
initBaseTree();


</SCRIPT>
