<%
	//增值产品操作相关js方法
 %>

<script type="text/javascript">

//显示用户已经订购产品列表并激活提交按钮
function doGetUserProds(packet){
	$("#prdmodify").html(packet);
	//弹出增值产品页面
	$("#button"+means).attr("disabled","");
}			

//打开增值产品页面方法,便于统一管理
function openAddProd(){
	if(isAddProd) {
		showDialog('产品已订购',1);
		return true;
		//showDialog('重新添加产品将清除已经订购?',3,'retT=reOpenProd();retF=null;closeFunc=null');
	}else{
		reOpenProd();
	}
}

function reOpenProd(){
	
	var sFeatures = "height=600,width=800,top=35,left=100,toolbar=no,menubar=no,scrollbars=no,depended=yes,z-look=yes,resizable=no,location=no, status=no";
	var opcode = "<%=opcode%>";
	var ele = meansSelectedJson.find("A06").toJson();
	//alert("ele-------"+ele);
	if(ele!='null'){
		var prod = meansSelectedJson.find("A06.PRC_INFO_LIST.PRC_INFO[0]").toJson();
		//alert(prod);
		if(prod!='null'){
			var val= meansSelectedJson.find("A06.PRC_INFO_LIST.PRC_INFO[0]").returnChildSum();
			//alert(val);
			if(('null'!=val)&&(0!=val))
			opcode = "1147";
		}
	}
	var url = "<%=request.getContextPath()%>/npage/market/14936/4938/f4938_prodDispather.jsp?svcNum=<%=svcNum%>&actId=<%=actId%>&idNo=<%=idNo%>&mainServId=<%=mainServId%>&opcode="+opcode+"&meansId="+means+"&isOpen=N&prodMsg="+prodMsg;
	url += "&routerKey=<%=routerKey%>&routerValue=<%=routerValue%>&brandId=<%=brandId%>";
	//alert(url);
	window.open(url,"增值产品列表",sFeatures);	
	return false;
}


//在主页面显示选择的增值产品信息
function showAddProdprc(){
	if(null==prods|| 'undefined'==prods) return;
	var  tab  = document.getElementById("selectedTab");
	for(var i =0; i<prods.length;i++){
		var newRow = tab.insertRow(1);
		newRow.insertCell(0).innerHTML = "<span class='red'> 新增</span>";
		newRow.insertCell(1).innerHTML = prods[i][0];
		newRow.insertCell(2).innerHTML = prods[i][1];
		newRow.insertCell(3).innerHTML = prods[i][2];
		newRow.insertCell(4).innerHTML = prods[i][3];
		newRow.insertCell(5).innerHTML = prods[i][4];
		newRow.insertCell(6).innerHTML = prods[i][5];
	}
	
   	isAddProd = true;
}

//删除已添加的产品信息
function removeAddProdprc(prodLength){
	var tab  = document.getElementById("selectedTab");
	for(var i =0; i<prodLength;i++){
		 tab.deleteRow(1);
	}
	isAddProd = false;
	prodMsg ="0";
}


//检查是否已添加增值产品
//如果没有，自动弹出增值产品选择页面
function checkHasProd(){
	if(isAddProd) return true;
	//meansSelectedJson.find("A06.LIMIT_COUNT").set("0");
	var min = "";
	if(meansSelectedJson.find("A06.LIMIT_COUNT").toJson()!='null')
		min = meansSelectedJson.find("A06.LIMIT_COUNT").value();
	if((0 == min)||(""==min)){
		if(prodServOfferId!="-1"){
					if(saleOrder.deepFind("REQUEST_INFO.BUSIINFO_LIST.BUSIINFO[>SERVICE_OFFER_ID="+prodServOfferId+"]").toJson()!='null')
		 				saleOrder.deepFind("REQUEST_INFO.BUSIINFO_LIST.BUSIINFO[>SERVICE_OFFER_ID="+prodServOfferId+"]").remove();	
		 	
		 	}
	return true;
	}
	showDialog("请添加增值产品信息",3,'retT=openAddProd();retF=null;closeFunc=closeForm()');
	return false;
}

function addProdInfoList(){
	var saleJson = meansSelectedJson;
		if(saleJson.find("A06.PRC_INFO_LIST").toJson()!='null'){
			saleJson.find("A06.PRC_INFO_LIST").remove();
			saleJson.find("A06").addNode(sitechJson({tagName: "PRC_INFO_LIST",type:"node"}));
		}else{
			saleJson.find("A06").addNode(sitechJson({tagName: "PRC_INFO_LIST",type:"node"}));
		}
		//alert(saleJson.find("A06").toJson());
}


//终端销售时将费用节点拼入meansSelectedJson
function addProdInfo(_prodPrc,_prcName,feeCode,feeType,busiFee,realFee,favRate,feeName,_effdate,_expdate,index){
		//在当前meansJson中构造A06节点，供拼写费用报文用
		//添加产品信息节点
		var prodInfo= sitechJson({tagName: "PRC_INFO",type:"node"});
			//添加产品资费ID
		prodInfo.addNode(sitechJson({tagName: "PROD_PRCID",type: "string",childNodes: [_prodPrc]}));
		prodInfo.addNode(sitechJson({tagName: "INDEX",type: "string",childNodes: [index]}));
		//alert(prodInfo.find("PROD_PRCID").toJson());
		//添加产品资费名称
		prodInfo.addNode(sitechJson({tagName: "PROD_PRC_NAME",type: "string",childNodes: [_prcName]}));	
		prodInfo.addNode(sitechJson({tagName: "EFF_DATE",type: "string",childNodes: [_effdate]}));	
		prodInfo.addNode(sitechJson({tagName: "EXP_DATE",type: "string",childNodes: [_expdate]}));	
		//alert(prodInfo.find("PROD_PRC_NAME").toJson());
		var prodFeeList = sitechJson({tagName: "FEE_INFO_LIST"});
		for(var i=0;i<feeCode.length;i++){
			var feeInfo = instanceTemplate["FEE_INFO"]();
				feeInfo.find("BUSI_FEE").set((parseInt(busiFee[i].value)/100));
				feeInfo.find("FEE_TYPE").set(feeType[i].value);
				feeInfo.find("FEE_CODE").set(feeCode[i].value);
				feeInfo.find("FEE_NAME").set(feeName[i].value);
				feeInfo.find("FAV_RATE").set(favRate[i].value);
				feeInfo.find("REAL_FEE").set((parseInt(realFee[i].value)/100));
				prodFeeList.addNode(feeInfo);
		}
		//将产品费用列表添加入PRC_INFO节点下
		prodInfo.addNode(prodFeeList);
		//将PRC_INFO节点添加入PRC_INFO_LIST节点下
		if(meansSelectedJson.find("A06.PRC_INFO_LIST").isNull())
			{
				addProdInfoList();
			}
			meansSelectedJson.find("A06.PRC_INFO_LIST").addNode(prodInfo);
			
}


	//添加相容性校验json
function addSellBusi(prodRelBag,prcId,prodId,effdate,expdate){
		var sellBusi = instanceTemplate["SEL_BUSI"]();
		sellBusi.find("OP_TYPE").set("A");
		sellBusi.find("PROD_PRCID").set(prcId);
		sellBusi.find("PROD_ID").set(prodId);
		sellBusi.find("EFF_DATE").set(effdate);
		sellBusi.find("EXP_DATE").set(expdate);
		//alert(sellBusi.toJson());
		prodRelBag.find("SEL_BUSI_LIST").addNode(sellBusi);
	}


function relChkToJson(prodRelBag){
	//alert(prodRelBag.toJson());
	return prodRelBag.find("SEL_BUSI_LIST").toJson();
}


function getSelectedProd(){
	var prodNames = "";
	for(var i=0;i<prods.length;i++){
		prodNames +=prods[i][3]+"+";
	}
	return prodNames.substring(0,(prodNames.length-1));

}
//-------------------------------------------------------------------------------------------------hlj------------------------------------------------------------------------------

/*
*用户已订购产品列表
*meansId ：手段ID
*/
function showProdList(meansId){
	var prod = $("#flag"+meansId).val();
	if((prod!= "")&&('undefined'!=prod)&&(undefined!=prod)){
		prod = prod.charAt(6);
		alert(prod);
	}else{
		return ;
	}
	
	if("1"==prod){
		$("#prdmodify").css("display","block");
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1147/f1147_ajax_getUserProds.jsp","请稍等...");
			  packet.data.add("IdNo" ,"<%=idNo%>");
			  core.ajax.sendPacketHtml(packet,doGetUserProds);
			  packet =null;
	}else{
		$("#prdmodify").css("display","none");
	}
}

</script>