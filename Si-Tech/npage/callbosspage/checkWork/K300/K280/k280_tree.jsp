<%
  /**
   * ����: �ʼ�Ȩ�޹���->�����ʼ�Ȩ��->��������Ϣ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:		2009/04/09		mixh
   *				�������������߼���
�� */
%>
<%@page contentType="text/html;charset=GBK"%>
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
<table width="400px" height="1000px">
<tr>
<td valign="top" width="400" height="100%">
<div id="baseTree"></div>
</td>
</tr>
</table>
</body>

</html>

<script type="text/javascript">
	
//�����¼�
function onClickNodeSelect(){
	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='N'){
		tree.showItemCheckbox(tree.getSelectedItemId(),0);
		//getTreeListByNodeId(tree.getSelectedItemId()); //��ajax��̬��ѯ����
	}else{
		tree.showItemCheckbox(tree.getSelectedItemId(),1);
	}
}

//��Ӧcheckboxѡ���¼�������ʾ��Ϣ��ʾ������һ��ҳ��
function onCheckBoxsBySelect(){
	var allCheckItem=tree.getAllCheckedBranches();
	if(allCheckItem!=null){
  parent.rightCenterLoginNo.ischeckBoxSelect(allCheckItem);
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

function initBaseTree(){
	tree=new dhtmlXTreeObject("baseTree","100%","100%",0);
	tree.setImagePath("<%=request.getContextPath()%>/nresources/default/images/callimage/dtmltree_imgs/csh_books/");
	tree.enableCheckBoxes(1);
	tree.setOnClickHandler(onClickNodeSelect);
	tree.setOnCheckHandler(onCheckBoxsBySelect);
	//tree.disableCheckbox("0",0);
	//tree.showItemCheckbox("0",0);
	//tree.enableHighlighting(0);
	tree.setXMLAutoLoading("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K280/k280_createXml.jsp");
	tree.loadXML("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K300/K280/k280_createXml.jsp?id=0");
}

//��ʼ����
initBaseTree();
//��ñ��ʼ��飬��ѡ�У�Ȼ����ʾѡ�б��ʼ����е�ҵ������ż�����
firstUnCheckItem();

function firstUnCheckItem(){
	/*mod by mixh 20090409 begin*/
	//var strlist = parent.leftCenterTree.getCheckedGroupList();
	var strlist = '<%=request.getParameter("checkedGroupList")%>';
	/*mod by mixh 20090409 end*/
        
	if(strlist!=null&&strlist!=''){
		var strdata=strlist.split(",");
                
		for(var s=0;s<strdata.length;s++){
			if(strdata[s]!=''&&strdata[s]!=null){
				unFoldNode(strdata[s]);
			}
		}
		onCheckBoxsBySelect();
		// ���Ʊ��
		parent.rightFootLoginNo.CopyHtmlElement();
	}
}
		
/*
 *ģ��onclick�¼���չ���ڵ�
 * modified by liujied 20090928
 * ����������״ѡ��
 */
function unFoldNode(node_id){
     
     //var i_length=node_id.length/2;
     var half_length = node_id.length/2;
     var j=0;
     if(half_length == 1){
          tree.setCheck(node_id,true);
     }else{
          for(var i=0 ; i < half_length ; i++){
               j += 2;
               var sub_node_id = node_id.substring(0,j);
               var childItems = tree.hasChildren(sub_node_id);
               
               if(childItems)
                {
                    tree.openItem(sub_node_id);
                    continue;
                }
               tree.setCheck(node_id,true);
               
               //if(tree.getUserData(node_id.substring(0,j),"isleaf")== 'N'){
               //              
               //              document.getElementById(node_id.substring(0,j)).click();
	       //	}
               //tree.setCheck(node_id,true);
               sub_node_id = null;
               childItems  = null;
          }
	}
}
</script>