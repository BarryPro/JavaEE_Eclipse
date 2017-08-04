<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
   * ����: ����֪ʶ��
�� * �汾: 1.0.0
�� * ����: 2010/9/20
�� * ����: tangsong
�� * ��Ȩ: sitech
*/
%>
<title>����֪ʶ��</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css" />
<style type="text/css">
	body {
		margin:0;
	}
	#baseTree td {
		padding:0;
	}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxcommon.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/dhtmlxtree_js/dhtmlxtree.js"></script>

<script type="text/javascript">
var tree;
var checkboxCount = 0;
//����һ����̬��
function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",-100);
	tree.setImagePath(<%=request.getContextPath()%>"/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.setXMLAutoLoading(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_createKnowledgeXml.jsp");
	tree.setOnClickHandler(onNodeSelect);
	tree.enableHighlighting(0);
	tree.loadXML(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_createKnowledgeXml.jsp");
	document.getElementById('-1').click();
}

//��Ӧ��굥���¼�����ѯ���ݿ�õ���һ�ڵ�
function onNodeSelect(){
	checkboxCount = 0;
  getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
}

//����ѡ�еĽڵ�id�����ظýڵ����ӽڵ�
function getTreeListByNodeId(selectedNodeId){
	var subNodeIds = tree.getSubItems(selectedNodeId);
	var subNodeIdArr = subNodeIds.split(",");
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_getKnowledgeChildTree.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	mypacket.data.add("superCode",selectedNodeId);
	core.ajax.sendPacket(mypacket,doProcessGetList,false);
	function doProcessGetList(packet){
		var childNodeArr = packet.data.findValueByName("resultDataArr");
		var htmlText = "";
		for(var i=0;i<childNodeArr.length;i++) {
			//Ϊ֪ʶĿ¼ʱ�������������ӽڵ�
			if (childNodeArr[i][4] == "1") {
				var insertFlag = true;
				for (var j=0;j<subNodeIdArr.length;j++) {
					if (childNodeArr[i][2] == subNodeIdArr[j]) {
						insertFlag = false;
						break;
					}
				}
				if (insertFlag) {
					insertChildNode(childNodeArr[i][3],childNodeArr[i][2],childNodeArr[i][1]);
				}
			}
			//Ϊ֪ʶ��ʱ�����֪ʶ���б�
			if (childNodeArr[i][4] == "2") {
				htmlText += getChildCheckboxList(childNodeArr[i][0],childNodeArr[i][1]);
			}
		}
		//����񲹳�����
		if (htmlText != "") {
			if (checkboxCount/3 < 1) {
				htmlText += "</tr>";
			} else {
				//Ϊ���һ�в����Ͽ���
				if (checkboxCount%3 == 1) {
					htmlText += "<td>&nbsp;</td><td>&nbsp;</td></tr>";
				}
				if (checkboxCount%3 == 2) {
					htmlText += "<td>&nbsp;</td></tr>";
				}
			}
			htmlText = "<table style='width:96%'>" + htmlText + "</table>";
		}
		window.parent.knowledgeDiv.innerHTML = htmlText;
	}
	mypacket = null;
}

//�����������ӽڵ�
function insertChildNode(parentId,nodeId,nodeText){
	tree.insertNewItem(parentId,nodeId,nodeText,0,0,0,0,'');
	tree.setItemImage2(nodeId,'folderClosed.gif','folderClosed.gif','folderOpen.gif');		
}

//��֪ʶ���Ը�ѡ���б�չʾ
function getChildCheckboxList(id,caption) {
	checkboxCount++;
	var tableText = "";
	if (checkboxCount%3 == 1) {
		tableText += "<tr>";
	}
	tableText += "<td><input type='checkbox' name='knowledge' value='"
						 + id + "' caption='" + caption + "' />" + caption + "</td>";
	if (checkboxCount%3 == 0) {
		tableText += "</tr>";
	}
	return tableText;
}
</script>
</head>

<body onload="initBaseTree();">
	<div id="baseTree" style="height:100%"></div>
</body>
</html>