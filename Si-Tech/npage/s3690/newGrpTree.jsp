   
<%
/********************
 version v2.0
 开发商 si-tech
 update liubo@2009-10-07
********************/
%>                
<%
  String opCode = "3690";
  String opName = "销售品目录树";
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
<title>销售品目录树</title>
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
//选择品牌
var openme=window.opener;
function selectBand(){
	  var band_id = "9999";//根节点ID
		var packet = new AJAXPacket("newGrpTreeXml.jsp","请稍后...");
		packet.data.add("ProdType" ,'<%=ProdType%>');
		packet.data.add("sm_code" ,'<%=sm_code%>');
		packet.data.add("prod_direct" ,'<%=prod_direct%>');
		packet.data.add("biz_code" ,'<%=biz_code%>');
		core.ajax.sendPacket(packet,doSCatalogItem);
		packet =null;
}
//选择品牌回调方法
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


//点击树节点触发事件
function stGetTreeNode(chId)
{			
	if(chId!="9998"){
			productOfferQryByCat(chId);//查询附加销售品信息(按目录)
			}
			else{
						tree1 = new stdTree("tree","rootTree");
						tree1.imgSrc="<%=request.getContextPath()%>/nresources/default/images/mztree/"
						with(tree1){
								eval("N[\""+9998+"\"]=\""+9998+";"+销售品目录+";"+9998+";0\"");		
							}
						tree1.writeTree();
						tree1=null;
			}
}


//查询销售品信息(按目录)
function productOfferQryByCat(nodeID)
{
	  var channelSegment="";     //渠道类型标识
		var packet = new AJAXPacket("newGrpTreeInfo.jsp","请稍后...");
		packet.data.add("catalog_item_id" ,nodeID);
		packet.data.add("channelSegment" ,channelSegment);
		core.ajax.sendPacket(packet,doProductOfferQryByCat,true);
		packet =null;
}


//回调方法
function doProductOfferQryByCat(packet)
{
	var catalog_item_id = packet.data.findValueByName("catalog_item_id"); 
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	var backArrMsg = packet.data.findValueByName("backArrMsg");
		if(backArrMsg==null||backArrMsg==""){
			  rdShowMessageDialog("没有查询到您所需的数据1");
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
						alert("销售品查询失败!请联系管理员!");
					}
			}
}


//添加到结果表:销售品标识,销售品名称,上级代码
function addResultTab(offer_id,offer_name,parent_offer_id)
{
		//alert("销售品标识|"+offer_id);
		//alert("销售品名称|"+offer_name);
		//alert("销售品名称|"+parent_offer_id);		

		var packet = new AJAXPacket("newGrpTreeSave.jsp","请稍后...");
		packet.data.add("offer_id" ,offer_id);
		packet.data.add("offer_name" ,offer_name);
		packet.data.add("parent_offer_id" ,parent_offer_id);
		core.ajax.sendPacket(packet,doSaveTo,true);
		packet =null;
}

//-----返回组织节点-------
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
				openme.frm.product_code.value=product_code+"|"+product_name;     //将信息返回到调用的页面去  
				openme.frm.product_name.value=product_name;                      //将信息返回到调用的页面去  
				<% if(sm_code.equals("AD") || sm_code.equals("ML") || sm_code.equals("MA")){ %>
				   openme.getBillingType(biz_code);
			  <%}%>
				window.close();
	 }else{
	 	 rdShowMessageDialog("错误"+retMsg);
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
				<!--树-->
	<div class="title" id="treeList">
	<div id="title_zi">按目录树查询</div>
  </div>
  </div>
	<div id="rootTree" style="height:280px"></div>
				<!--树-->
	</div>
	</div>
	   	  <%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</form>
</html>

<SCRIPT>
selectBand();
</SCRIPT>