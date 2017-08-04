<script type="text/javascript">
function checkModify(){
	if("<%=priFeeMoney%>"==""){
		return -1;
	}
}
//---------------------------------------------提交单个时重新计算总金额-------------------------------
function resetCosts(meansId){
	var priFeeChangeObj = document.getElementById("allPriFeeChange"+meansId).value;
	if(priFeeChangeObj=="H35.SHOW.FALSE"){
		var allCost = Number("<%=priFeeMoney%>")+Number(H36_cost) + Number(H37_cost) + Number(H38_cost);
		$("#H40SelectValue" + meansId).text(allCost);
	}else{
		var allCost = Number(H35_cost)+Number(H36_cost) + Number(H37_cost) + Number(H38_cost);
		$("#H40SelectValue" + meansId).text(allCost);
	}
}
//---------------------------------------------提交时校验---------------------------------------------
function checkGroup(){
	var priFeeChangeObj = document.getElementById("allPriFeeChange"+means).value;
	if(priFeeChangeObj=="H35.SHOW.FALSE"){
		if("<%=priFeeMoney%>"==""){
			showDialog("当前主资费不在资费配置表中，需要变更主资费!",1);
			return -1;
		}else{
			var cost = Number(<%=priFeeMoney%>)+Number(H36_cost) + Number(H37_cost) + Number(H38_cost);
			var limitCost = $("#h40value"+means+"hidden").val();
			if(cost<limitCost){
				showDialog("当前资费项总金额为"+cost+",小于最低消费金额,请修改消费项或变更主资费!",1);
				return -1;
			}
		}
	}else{
		var allCost = Number(H35_cost)+Number(H36_cost) + Number(H37_cost) + Number(H38_cost);
		var limitCost = $("#h40value"+means+"hidden").val();
		if(allCost < limitCost){
			showDialog("当前消费总金额为"+allCost+",小于最低消费金额，请修改！",1);
			return -1;
		} 
	}
	if(H38_json.length>0){
		H37_json = H37_json + "," + H38_json;
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.GSP.GSP_STR").set(H37_json);
	return 1;
}
//---------------------------------------------H36 全网附加资费/流量套餐---------------------------------------------
var H36_cost = 0;
var H36_choose = true;
//选择全网附加资费
function chooseGAddFee(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseGAddFee.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>", "全网附加资费", "700","300");
}
//选择之后存储
function saveGAddFee(meansId, codes, feeNames, showNames, feeScores, cost, orderStr,effDateStr,expDateStr){
	$("#showGAddFee"+meansId).html(showNames);
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST.ADD_FEE_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11").addNode(sitechJson({tagName: "ADD_FEE_LIST"}));
	}
	H36_cost = cost;
	if(codes.length > 0){
		var code = codes.split("#");
		var feeName = feeNames.split("#");
		var feeScore = feeScores.split("#");
		var effDate = effDateStr.split("#");
		var expDate = expDateStr.split("#");
		for(var i=0; i<code.length; i++){
			var Add_Feeinfo=instanceTemplate["ADD_FEE_INFO"]();
			Add_Feeinfo.find("ADD_FEE_CODE").set(code[i]);
			Add_Feeinfo.find("ADD_FEE_NAME").set(feeName[i]);
			Add_Feeinfo.find("ADD_FEE_SCORE").set(feeScore[i]);
			Add_Feeinfo.find("ADD_FEE_EFFDATE").set(effDate[i]);
			Add_Feeinfo.find("ADD_FEE_EXPDATE").set(expDate[i]);
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST").addNode(Add_Feeinfo);
		}
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.STATUS_CODE").set(orderStr);
	resetCosts(meansId);
}
//---------------------------------------------B37 全网WLAN---------------------------------------------
var H37_cost = 0;
var H37_choose = true;
var H37_json = "";
//选择全网WLAN
function chooseGWlan(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseGWlan.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "全网WLAN", "700","300");
}
//选择之后存储
function saveGWlan(meansId, busi, name, cost, wlanStr){
	$("#showGWlan"+meansId).html(name);
	H37_cost = cost;
	H37_json = wlanStr;
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H37.GWLAN_COMP").set("0");
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H37.GWLAN_BUSI").set(busi);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H37.GWLAN_NAME").set(name);
	resetCosts(meansId);
}
//---------------------------------------------B38 全网数据业务---------------------------------------------
var H38_cost = 0;
var H38_choose = true;
var H38_json ="";
//选择全网数据业务
function chooseGData(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseGData.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "全网数据业务", "700","300");
}
//选择之后存储
function saveGData(meansId, codes, busis, names, showNames, cost, cancelStr){
	$("#showGData"+meansId).html(showNames);
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H38.GDATA_LIST.GDATA_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H38.GDATA_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H38").addNode(sitechJson({tagName: "GDATA_LIST"}));
	}
	H38_json = "";
	H38_cost = cost;
	if(codes.length > 0){
		var code = codes.split("~");
		var name = names.split("~");
		var busi = busis.split("~");
		var split = "";
		for(var i=0; i<code.length; i++){
			var GDATA_INFO=instanceTemplate["GDATA_INFO"]();
			GDATA_INFO.find("GDATA_COMP").set(code[i]);
			GDATA_INFO.find("GDATA_BUSI").set(busi[i]);
			GDATA_INFO.find("GDATA_NAME").set(name[i]);
			//无线音乐高级会员传特定的类型
			var biz_type = "7";//默认数据业务
			var key = "inOpCode";
			if(code[i] == "user_level"){
				biz_type = "5";
				key = "user_level";
			}
			
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H38.GDATA_LIST").addNode(GDATA_INFO);
			H38_json = H38_json + split + biz_type + "#" + "06" + "#" + code[i] + "#" + busi[i] + "#" + 2 + "#" + key + "#";
			split = ",";
		}
	}
	if(cancelStr.length > 0){
		H38_json = H38_json + split + cancelStr;
	}
	resetCosts(meansId);
}

//---------------------------------------------B39 全网终端---------------------------------------------
var H39_choose = false;
//选择全网终端
function chooseGRes(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseGRes.jsp?meansId="+means, "全网终端", "700","300");
}
//选择之后存储
function saveGRes(meansId, res_code, brand, model, price, fee, imei, cmit_date, quality_limit, brand_code, des, undeadline){
	H39_choose = true;
	$("#showGRes"+meansId).html(des);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_COST_PRICE").set(price);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_FEE").set(fee);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.IMEI_CODE").set(imei);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.DELIVERY_TIME").set(cmit_date);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.QUALITY_LIMIT").set(quality_limit);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_BRAND").set(brand);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_MODEL").set(model);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.SALE_NOTE").set("营销活动");
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_RES_CODE").set(res_code); 	
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_BRAND_CODE").set(brand_code);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_UNDEADLINE").set(undeadline);
	var pay_moneycould = document.getElementById("pay_moneycouldhid").value;
	pay_moneycould = Number(pay_moneycould) + Number(fee);
	document.getElementById("pay_moneycould").value=parseFloat(pay_moneycould);
	resetCosts(meansId);
}
</script>