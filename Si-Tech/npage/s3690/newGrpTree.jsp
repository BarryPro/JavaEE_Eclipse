   
<%
/********************
 version v2.0
 ������ si-tech
 update liubo@2009-10-07
********************/
%>                
<%
  String opCode = "3690";
  String opName = "����ƷĿ¼��";
%>              
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String ProdType=WtcUtil.repNull(request.getParameter("ProdType"));
  String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));
	String prod_direct=WtcUtil.repNull(request.getParameter("prod_direct"));
	String biz_code=WtcUtil.repNull(request.getParameter("biz_code"));
	
	System.out.println("ProdType=="+ ProdType);
	System.out.println("sm_code=="+ sm_code);
	System.out.println("prod_direct=="+ prod_direct);
	System.out.println("biz_code=="+ biz_code);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>����ƷĿ¼��</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/spCar.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/nresources/default/css/products.css" rel="stylesheet"type="text/css">
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/mztree/stTree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<style type="text/css">

</style>
<script language="JavaScript">
//ѡ��Ʒ��
var openme=window.opener;
function selectBand(){
	  var band_id = "9999";//���ڵ�ID
		var packet = new AJAXPacket("newGrpTreeXml.jsp","���Ժ�...");
		packet.data.add("ProdType" ,'<%=ProdType%>');
		packet.data.add("sm_code" ,'<%=sm_code%>');
		packet.data.add("prod_direct" ,'<%=prod_direct%>');
		packet.data.add("biz_code" ,'<%=biz_code%>');
		core.ajax.sendPacket(packet,doSCatalogItem);
		packet =null;
}
//ѡ��Ʒ�ƻص�����
function doSCatalogItem(packet)
{
	 	var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  var backArrMsg = packet.data.findValueByName("backArrMsg");
		
		tree1 = new stdTree("tree","rootTree");
		tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/";
		with(tree1)
		{
			for(var i=0 ; i<backArrMsg.length; i++)
			{ 
				var parentID = backArrMsg[i][3]==0?"000":backArrMsg[i][3]
				eval("N[\""+backArrMsg[i][0]+"\"]=\""+backArrMsg[i][0]+";"+backArrMsg[i][1]+";"+parentID+";1\"");						
			 }
		}
			tree1.writeTree();
		  tree1=null;
}


//������ڵ㴥���¼�
function stGetTreeNode(chId)
{			
	if(chId!="9998"){
			productOfferQryByCat(chId);//��ѯ��������Ʒ��Ϣ(��Ŀ¼)
			}
			else{
						tree1 = new stdTree("tree","rootTree");
						tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
						with(tree1){
								eval("N[\""+9998+"\"]=\""+9998+";"+����ƷĿ¼+";"+9998+";0\"");		
							}
						tree1.writeTree();
						tree1=null;
			}
}


//��ѯ����Ʒ��Ϣ(��Ŀ¼)
function productOfferQryByCat(nodeID)
{
	  var channelSegment="";     //�������ͱ�ʶ
		var packet = new AJAXPacket("newGrpTreeInfo.jsp","���Ժ�...");
		packet.data.add("catalog_item_id" ,nodeID);
		packet.data.add("channelSegment" ,channelSegment);
		core.ajax.sendPacket(packet,doProductOfferQryByCat,true);
		packet =null;
}


//�ص�����
function doProductOfferQryByCat(packet)
{
	var catalog_item_id = packet.data.findValueByName("catalog_item_id"); 
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	var backArrMsg = packet.data.findValueByName("backArrMsg");
		if(backArrMsg==null||backArrMsg==""){
			  rdShowMessageDialog("û�в�ѯ�������������1");
		}else{
				if(retCode==0)
					{
						tree1 = new stdTree("tree","rootTree");
						tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
						with(tree1)
						{
							//alert(catalog_item_id);
							for(var i=0 ; i<backArrMsg.length; i++)
							{
								eval("N[\""+backArrMsg[i][0]+"\"]=\""+backArrMsg[i][0]+";"+backArrMsg[i][1]+";"+catalog_item_id+";0;addResultTab('"+backArrMsg[i][0]+"','"+backArrMsg[i][1]+"','"+catalog_item_id+"')\"");
							}
						}
						tree1.writeTree();
						tree1=null;
					}
					else
					{
						alert("����Ʒ��ѯʧ��!����ϵ����Ա!");
					}
			}
}


//��ӵ������:����Ʒ��ʶ,����Ʒ����,�ϼ�����
function addResultTab(offer_id,offer_name,parent_offer_id)
{
		//alert("����Ʒ��ʶ|"+offer_id);
		//alert("����Ʒ����|"+offer_name);
		//alert("����Ʒ����|"+parent_offer_id);		

		var packet = new AJAXPacket("newGrpTreeSave.jsp","���Ժ�...");
		packet.data.add("offer_id" ,offer_id);
		packet.data.add("offer_name" ,offer_name);
		packet.data.add("parent_offer_id" ,parent_offer_id);
		core.ajax.sendPacket(packet,doSaveTo,true);
		packet =null;
}

//-----������֯�ڵ�-------
function doSaveTo(packet)
{
	  var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  var product_code = packet.data.findValueByName("offer_id");
	  var product_name = packet.data.findValueByName("offer_name");
	  var biz_code = packet.data.findValueByName("biz_code");
	  var biz_name = packet.data.findValueByName("biz_name");
	  var catalog_item_id = packet.data.findValueByName("catalog_item_id");
	  
	 if(retCode=="000000"){
				openme.frm.F00017.value=product_code+"|"+product_name;
				openme.frm.bizCode.value=biz_code;
				openme.frm.F00018.value=biz_name;
				openme.frm.catalog_item_id.value=catalog_item_id;
				openme.frm.product_code.value=product_code+"|"+product_name;     //����Ϣ���ص����õ�ҳ��ȥ  
				openme.frm.product_name.value=product_name;                      //����Ϣ���ص����õ�ҳ��ȥ  
				<% if(sm_code.equals("AD") || sm_code.equals("ML") || sm_code.equals("MA")){ %>
				   openme.getBillingType(biz_code);
			  <%}%>
				window.close();
	 }else{
	 	 rdShowMessageDialog("����"+retMsg);
	} 
}
</SCRIPT>
</head>
<body>
<form name="frm" method="post" onload="">
<input type="hidden" name="result2" value=" ">
<input type="hidden" name="result8" value="999">
<input type="hidden" name="result9" value="999">
<input type="hidden" name="result10" value="999">
<input type="hidden" name="result11" value="999">
<input type="hidden" name="result12" value="999">
<input type="hidden" name="result13" value="999">
<input type="hidden" name="result14" value="999">
	<%@ include file="/npage/include/header_pop.jsp" %>
  <div class="unmztree" id="tbc_01">
				<!--��-->
	<div class="title" id="treeList">
	<div id="title_zi">��Ŀ¼����ѯ</div>
  </div>
  </div>
	<div id="rootTree" style="height:280px"></div>
				<!--��-->
	</div>
	</div>
	   	  <%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</form>
</html>

<SCRIPT>
selectBand();
</SCRIPT>