<%
	//��ֵ��Ʒ�������js����
 %>

<script type="text/javascript">

//��ʾ�û��Ѿ�������Ʒ�б������ύ��ť
function doGetUserProds(packet){
	$("#prdmodify").html(packet);
	//������ֵ��Ʒҳ��
	$("#button"+means).attr("disabled","");
}			

//����ֵ��Ʒҳ�淽��,����ͳһ����
function openAddProd(){
	if(isAddProd) {
		showDialog('��Ʒ�Ѷ���',1);
		return true;
		//showDialog('������Ӳ�Ʒ������Ѿ�����?',3,'retT=reOpenProd();retF=null;closeFunc=null');
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
	window.open(url,"��ֵ��Ʒ�б�",sFeatures);	
	return false;
}


//����ҳ����ʾѡ�����ֵ��Ʒ��Ϣ
function showAddProdprc(){
	if(null==prods|| 'undefined'==prods) return;
	var  tab  = document.getElementById("selectedTab");
	for(var i =0; i<prods.length;i++){
		var newRow = tab.insertRow(1);
		newRow.insertCell(0).innerHTML = "<span class='red'> ����</span>";
		newRow.insertCell(1).innerHTML = prods[i][0];
		newRow.insertCell(2).innerHTML = prods[i][1];
		newRow.insertCell(3).innerHTML = prods[i][2];
		newRow.insertCell(4).innerHTML = prods[i][3];
		newRow.insertCell(5).innerHTML = prods[i][4];
		newRow.insertCell(6).innerHTML = prods[i][5];
	}
	
   	isAddProd = true;
}

//ɾ������ӵĲ�Ʒ��Ϣ
function removeAddProdprc(prodLength){
	var tab  = document.getElementById("selectedTab");
	for(var i =0; i<prodLength;i++){
		 tab.deleteRow(1);
	}
	isAddProd = false;
	prodMsg ="0";
}


//����Ƿ��������ֵ��Ʒ
//���û�У��Զ�������ֵ��Ʒѡ��ҳ��
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
	showDialog("�������ֵ��Ʒ��Ϣ",3,'retT=openAddProd();retF=null;closeFunc=closeForm()');
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


//�ն�����ʱ�����ýڵ�ƴ��meansSelectedJson
function addProdInfo(_prodPrc,_prcName,feeCode,feeType,busiFee,realFee,favRate,feeName,_effdate,_expdate,index){
		//�ڵ�ǰmeansJson�й���A06�ڵ㣬��ƴд���ñ�����
		//��Ӳ�Ʒ��Ϣ�ڵ�
		var prodInfo= sitechJson({tagName: "PRC_INFO",type:"node"});
			//��Ӳ�Ʒ�ʷ�ID
		prodInfo.addNode(sitechJson({tagName: "PROD_PRCID",type: "string",childNodes: [_prodPrc]}));
		prodInfo.addNode(sitechJson({tagName: "INDEX",type: "string",childNodes: [index]}));
		//alert(prodInfo.find("PROD_PRCID").toJson());
		//��Ӳ�Ʒ�ʷ�����
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
		//����Ʒ�����б������PRC_INFO�ڵ���
		prodInfo.addNode(prodFeeList);
		//��PRC_INFO�ڵ������PRC_INFO_LIST�ڵ���
		if(meansSelectedJson.find("A06.PRC_INFO_LIST").isNull())
			{
				addProdInfoList();
			}
			meansSelectedJson.find("A06.PRC_INFO_LIST").addNode(prodInfo);
			
}


	//���������У��json
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
*�û��Ѷ�����Ʒ�б�
*meansId ���ֶ�ID
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
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1147/f1147_ajax_getUserProds.jsp","���Ե�...");
			  packet.data.add("IdNo" ,"<%=idNo%>");
			  core.ajax.sendPacketHtml(packet,doGetUserProds);
			  packet =null;
	}else{
		$("#prdmodify").css("display","none");
	}
}

</script>