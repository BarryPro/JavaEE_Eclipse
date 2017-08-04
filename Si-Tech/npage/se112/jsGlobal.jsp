<%
	//全局变量和全局操作相关js函数
 %>
<script type="text/javascript">
/*
*全局变量说明
*meansFalg---标识串。存在置位为1，不存在置位为0；
*prods-------订购产品list，内容为product数组对象，分别为prodid, prodname,prodprcid,prodprcname,effdate,expdate,
*prodid------产品信息转义后的报文
*means------当前单选按钮选中的手段ID
*cardNo------赠送缴费卡的卡号串
*isPrue------判断是否纯预存款
*resourceNo------赠送的终端串号
*stagesIndex---------选择的分月返还索引号
*prodJsonBak -----------开户营销已选择产品列表备份
*selectProdJsonStr------已经选择的产品json串，供开户营销产品相容性校验用
*20101025添加
*prodServOfferId ---------产品相关的ServOfferId
*resServOfferId ---------资源相关的ServOfferId
*scoreServOfferId ---------积分相关的ServOfferId
*happyServOfferId-----------喜点相关的ServOfferId
*feeServOfferId -----------费用相关的ServOfferId
*happyNodeValue -----------喜点值，需要时Ajax获取
*printData------------------开户营销免填单打印数据
*meansSelectedJson----------所选择的营销手段的json数据对象
*stageEffdate -----------所选择的分月返还的生效日期或分月返还有修改权限的修改后数据
*isClose ---------是否第一次触发关闭窗口事件
*giftMsg ------促销品信息串，格式为： 预占标识;促销品资费标识$促销品资费名称$礼品销售单价$数量|促销品资费标识$促销品资费名称$礼品销售单价$数量
*effDateA01-------------保留预存的生效时间，供有效期顺延使用
*effDateA10-------------分月返还的生效时间，供有效期顺延使用
*feeCardArr-------------有价卡信息数组，内容依次为：卡号，费用，资源类型

//hlj新增
*/	

var prodid ="";
var prods = new Array();
var feeCardArr = new Array();
var meansFalg = "";
var means = "";
var prodMsg = "0";//无赋值
var giftMsg = "-1";//无赋值
var cardNo = "-1";//无赋值
var resourceNo = "-1";//无赋值
var isAddScore = false;
var isAddProd = false;
var isAddFee = false; //是否已经添加了费用
var isPrue = false;
var saleOrder = instanceTemplate["SALEORDER"]();//hlj songjia
var root = instanceTemplate["ROOT"]();
var selectProdJsonStr ;
var prodJsonBak ;
var stageIndex = "-1";//选择的分月返还索引号
var prodServOfferId = "-1";
var resServOfferId = "-1";
var scoreServOfferId = "-1";
var happyServOfferId = "-1";
var luckServOfferId = "-1";
var happyNodeValue = "0";
var feeServOfferId = "-1";
var meansSelectedJson ;//hlj
var stageEffdate = "-1";
var effDateA01 = "-1";
var effDateA10 = "-1";
var isClose = true;
var isAddLuck = false;
var total = 0.00;

var payType_Check=false;		//副卡专款
var specialfund_Check=false;	//缴费方式
var valuableCard_Check=false;	//有价卡
var terminal_Check=false;		//终端
var mainTraffic_Check=false;	//主资费
var counteractIntegral_Check=false;//抵消积分
var UnificationPay=false;
var sysPay_Check=false;  //系统充值
var memNumber_Check=false;  //成员号码
var orderType_Check=false;  //订购类型
var orderGift_Check=false;  //促销品
var mainAllTraffic_Check=false;	//全网主资费
var agreeMent_Check = false;	//合约资费 
var templet_Check = false;	//模板元素
var sp_Check=false;		//sp业务
var card_Checkfuca = false;
var chooseCust = false;//异网号码选择
var chooseOldRes = false;//以旧换新
var chooseCardCode = false;//电子兑换码

//-------add by songjia for hlj-------------------
//是否生成副卡专款报文
var isAssisPecialfunds = false;
//是否生成系统充值报文
var isSystemPay = false;
//是否生成缴费方式报文
var  isPayType = false;
//是否生成终端报文
var isResource = false;
//是否生成抵消报文
var  isScore = false;
//xin 积分对于是否实名制的限制
var isRealName;
<%
String Sname_Status=(String) UserInfoMap.get("ELEMENT37")==null?"":(String) UserInfoMap.get("ELEMENT37");
System.out.println("Sname_Status=========实名制=============="+Sname_Status);
%>
//------------------------------------------------

/*****************set reset方法集合**********************/

//保存促销品信息，供子页面调用
function setGift(gift,itemName){
	giftMsg = gift;
	$("#resourceText"+means).text(itemName);
}

//设置某个营销手段对应的可选择增值产品资费标识列表
//供手段单选按钮改变时赋值或置位用
function setSelectProdValue(prodValues){
	prodid = prodValues;
}

//保存产品信息，供子页面调用
function setProds(prodlist){
	prods = myClone(prodlist);
	isAddProd = true;
	var name = "parseProductName"+means;
	var prodName = getSelectedProd();
	document.getElementById(name).innerHTML = prodName;
	prodMsg = prods.length;
}

//设置赠送缴费卡信息
var innerStr = "";
function setCardNo(_cardNo,_cardFee,_resCode){

   var item = new Array(_cardNo,_cardFee,_resCode);
	feeCardArr.push(item);
	cardNo = _cardNo;
	if(_cardNo == "-1"){
		return;
		}
	
	 innerStr+= "卡号："+_cardNo+"，面值："+_cardFee+"元.</br>";
	$("#feeCardSum"+means).html(innerStr);
}

function reSetVal(){
	$("#feeCardSum"+means).html(initCardFee);
	}

//设置终端信息
function setresourceNo(_resourceNo){
	resourceNo = _resourceNo;
}

//设置已选产品json串
function setSelectProdJsonStr(_jsonStr){
	selectProdJsonStr = _jsonStr;
}

//获取已选产品json串
function getSelectProdJsonStr(){
	return selectProdJsonStr;
}

//获取当前营销手段json对象
function getMeansSelectedJson(){
	return meansSelectedJson;
}


function addSitechNode(_tagname,_type,_val){
	return sitechJson({tagName: _tagname,type: _type,childNodes: [_val]});
}

 //重置
function resetTab(){
 	clearChooseRule("-1");
 	$("#prdmodify").css("display","none");
 	//frm1147.reset();
 	$("#btnSave").attr("disabled","disabled");
 	//还原缴费卡
 	var sum = $("#feeCardSum"+means+"hidden").val();
	$("#feeCardSum"+means).text(sum);
	$("#priFee"+means).attr("disabled",false);
	$("#feeDetails"+means).text("");
	//还原产品
	$("#parseProductName"+means).text("");
	//还原促销品
	$("#resourceText"+means).text("");
	//还原分月返还
	$("#stageDesc"+means).text("");
	reSetGlobalVar();
	//清除报文
	clearJsonXml();
	
 }

//关闭按钮事件
function closeSale(){
	releasCardResource();
	isClose = false;
	window.close()
}

//页面初始化时为每一个radio添加点击单击事件
//为防止js加载延迟错误而编写
// hlj ,初始化按钮点击事件。songjia

function initPageEvent(){
	$("input:radio").each(function(){
		$(this).click(chooseRule);
		$(this).removeAttr("disabled");
	});	

}

window.onunload=function(){
		if(isClose){
			releasCardResource();
		}
	}

//为所有营销手段添加伸缩事件
//活动规则详细信息的隐藏或者展现
//hlj 展现营销内容规则内容样式 songjia
<%if(!"".equals(meansIdStr)){%>
$(document).ready(function(){
	
<%
String[] means = meansIdStr.split("@");
for(int i=0;i<means.length;i++){
if((null!=means[i])&&(!"".equals(means[i]))){
%>
	$("#pic<%=means[i]%>").toggle(function(){
          $("#ruleDetail<%=means[i]%>").slideDown("fast");
          $("#pic<%=means[i]%>").attr("class", "butClose");
       },function(){
      
          $("#ruleDetail<%=means[i]%>").slideUp("fast");
          $("#pic<%=means[i]%>").attr("class","butOpen");
      	});
 <%}}%> 
 //用户信息切换
 $("#picUserMsg").toggle(function(){
          $("#userMsgDiv").slideUp("fast");
          $("#picUserMsg").attr("class","butOpen");
       },function(){
          $("#userMsgDiv").slideDown("fast");
          $("#picUserMsg").attr("class", "butClose");
      	});
    	initPageEvent();
 });
<%}%>

//---------------------------------------------------------------------------------hlj-----------------------------------------------------------------------------------------

//重新设置全局变量//hlj
function reSetGlobalVar(){
	//如果存在错误占用的终端数据，回滚之
	if(resourceNo != "-1"){
		getAjaxCheckSellEndsetNo(resourceNo);
		}
	 //释放卡资源
	 releasCardResource();
	 prodid ="";
	 prods = new Array();
	 meansFalg = "";
	 means = "";
	 prodMsg = "0";//无赋值
	 giftMsg = "-1";//无赋值
	 cardNo = "-1";//无赋值
	 resourceNo = "-1";//无赋值
	 isAddScore = false;
	 isAddProd = false;
	 isAddFee = false; //是否已经添加了费用
	 isPrue = false;
	 stageIndex = "-1";//选择的分月返还索引号
	 prodServOfferId = "-1";
	 resServOfferId = "-1";
	 scoreServOfferId = "-1";
	 happyServOfferId = "-1";
	 luckServOfferId = "-1";
	 happyNodeValue = "0";
	 feeServOfferId = "-1";
	 stageEffdate = "-1";
	 effDateA01 = "-1";
	 effDateA10 = "-1";
	 isClose = true;
	 isAddLuck = false;
	 total = 0.00;
	 meansSelectedJson = {};
	 feeCardArr = new Array();
	 payType_Check=false;		//副卡专款               
	 specialfund_Check=false;	//缴费方式             
	 terminal_Check=false;		//终端                 
	 mainTraffic_Check=false;	//主资费               
	 memNumber_Check=false;		//成员号码 
	 counteractIntegral_Check=false;    //抵消积分   
	 orderType_Check=false;  //订购类型
	 orderGift_Check=false; 
	 sysPay_Check=false; //系统充值
	 mainAllTraffic_Check=false;	//主资费  
	 H11_choose = false;	//附加资费  
	 H42_choose = false;	
	 agreeMent_Check = false;	//合约资费
	 templet_Check = false;	//模板元素
	 sp_Check=false;		//sp业务
	 card_Checkfuca = false;
	 chooseCust = false;   //异网号码
	 chooseH54 = false;
	//$("#payTypeInfo"+means).html("");
	//document.getElementById("payTypeInfo"+means).innerHTML = "";
//	$("#B15DataCard"+means).text("");
	$("#payTypeInfo"+means).val("");
	

	 //还原缴费卡
 	var sum = $("#feeCardSum"+means+"hidden").val();
	$("#feeCardSum"+means).text(sum);
	//还原产品
	$("#parseProductName"+means).text("");
	//还原促销品
	$("#resourceText"+means).text("");
	//还原分月返还
	$("#stageDesc"+means).text("");
	
}

// songjia update for hlj
//专款
function showSpeFunDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/specialDispather.jsp?meansId="+means, "专款预存款信息", "700","300");
}

//副卡专款
function showAssiSpeFun(){
	openDivWin("<%=request.getContextPath()%>/npage/se112/assispeDispather.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "副卡专款预存款信息", "700","300");
}
//系统充值
function toSysPay(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/systemPayDispather.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "系统充值", "700","380");
}
//银行卡分期付款
function chooPayType(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/payTypeDispather.jsp?meansId="+means, "银行卡分期付款", "700","300");
}
//订购方式
function chooOrderType(){ 
	var H10=meansFalg.charAt(9);
	var H11=meansFalg.charAt(10); 
    openDivWin("<%=request.getContextPath()%>/npage/se112/orderTypeDispather.jsp?meansId="+means+"&H10="+H10+"&H11="+H11, "订购方式", "700","300");
}
//合包电子券
function chooCardType(){ 
    openDivWin("<%=request.getContextPath()%>/npage/se112/cardTypeDispather.jsp?meansId="+means+"&imeiCode="+imeiCode+"&svcNum=<%=svcNum%>","电子终端兑换码", "700","300");
}
//模板选择
var chooseH54 = false;
function chooTemplet(){
	chooseH54 = false;
	
	if("<%=act_type%>"=="140"||"<%=act_type%>"=="141"){
		terminal_Check=false;
	}
	
	var H09=meansFalg.charAt(8); 
	var resourceMoney =""; 
	if(H09=='1'){
		resourceMoney = meansSelectedJson.find("H09.RESOURCE_MONEY").value();
	}
	
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/templetDispather.jsp?meansId="+means+"&actId=<%=actId%>&orderId="+orderId+"&brandId=<%=brandId%>&id_no=<%=id_no%>&svcNum=<%=svcNum%>&mode_code=<%=mode_code%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&act_type=<%=act_type%>&selectMeansId=<%=selectMeansId%>&resourceMoney="+resourceMoney, "模板业务", "700","300");
}

//终端
function chooResDetails(){
	
	/*若是140小类，则判断必须选择H54模板元素后，才能选择终端*/
	if("<%=act_type%>"=="140"||"<%=act_type%>"=="141"){
		if(!chooseH54){
			showDialog("140和141小类的营销活动请先选择模板元素，再选择终端!",0);
			return false;
		}
	}
	var H56 = meansFalg.charAt(55);
	if(H56 == '1' && !isH56Selected){
		showDialog("请先配置[使用和包电子券]元素，再选择[终端]元素!",0);
		return false;
	}
	
	chooseRes = false;
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/clientDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>&act_type=<%=act_type%>&resFeeTemp="+resFeeTemp+"&scoreFeeTemp="+scoreFeeTemp, "终端信息", "700","300");
}
//电子卡
function chooseCards(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/cardsDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>", "有价卡", "700","300");
}
//抵消积分
function chooH14Score(){
	/*
		获取现金元素，并将参数传入抵消积分的详细页面中 
		add by zhouwy,date:20130422
	*/
	var H01 = meansFalg.charAt(0);
	var cashInfo = "";
	if(H01=='1'){
		cashInfo = document.getElementById("global_cashInfo").value;
	}
	var H13=meansFalg.charAt(12);
	var subScore = "";
	if(H13=='1'){
		alert("请确保扣减积分兑换数量输入正确！！");
		var reg=/^([1-9]\d*)$/;
		var inputNum = $("#H13Num" + means).val();
		var scoreValue =$("#subScores"+means).val();
		if(inputNum==null||inputNum==""){
			showDialog("请输入扣减积分兑换数量!",0);
			return false;
		}
		if(!reg.test(inputNum)){
			showDialog("扣减积分兑换数量输入格式有误，请重新输入!",0);
			return false;
		}
		subScore = scoreValue*inputNum;
	}
	var H09=meansFalg.charAt(8); 
	var resourcefee =""; 
	if(H09=='1'){
		resourcefee = meansSelectedJson.find("H09.RESOURCE_FEE").value();
		var scoreTypeTemp = meansSelectedJson.find("H14.IS_SCORE").value();//积分抵消类型
		//alert("scoreTypeTemp="+scoreTypeTemp);
 		if(!chooseRes && scoreTypeTemp=="1"){//如果是积分抵消购机款，需要先选择终端，再进行积分抵消操作 
			showDialog("请先选择终端元素，再使用积分抵消!",0);
			return false;
		} 
	}
    //xin isRealName传入是否实名制
	openDivWin("<%=request.getContextPath()%>/npage/se112/chooReScoreDispather.jsp?meansId="+means+"&vCurPoint=<%=vCurPoint%>&brandId=<%=brandId%>&gScore=<%=gScore%>&isRealName=<%=Sname_Status%>&subScore="+subScore+"&cashInfo="+cashInfo+"&resourcefee="+resourcefee, "抵消积分", "700","300");
}
//将扣减积分的数量置为灰
function subScoreDisable(){
	$("#H13Num" + means).attr("disabled","true");
}
//将抵消积分选择置为灰
function subH14ScoreDisable(){
	$("#chooH14ScoreBtn" + means).attr("disabled","true");
}
//将sp 选择按钮置为灰
function subH12SPDisable(){
	$("#chooseSPDet" + means).attr("disabled","true");
}
//设置全局终端imei
var imeiCode = "";
function putImeiCode(imeicode){
	imeiCode = imeicode;
}
//促销品
function sysShowGife(){
	var H08=meansFalg.charAt(7);
	openDivWin("<%=request.getContextPath()%>/npage/se112/sysShowGifefoud.jsp?meansId="+means+"&H08="+H08, "促销品", "700","300");
}
//扣减积分
function showScoreDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreDispather.jsp?meansId="+means, "积分信息", "700","300");
}
//主资费选择
function chooFeeDetails(){
	var inputNum = $("#priFee" + means).val();
	var netFlag = document.getElementById("global_netFlag").value;
	var H15 = meansFalg.charAt(14);
	if(H15 == '1' && !isH15Selected){
		showDialog("请先配置[成员信息]，再选择[主资费]!",0);
		return false;
	}
	if(inputNum ==""){
		showDialog("请选择一个主资费再点击选择按钮!!",0);
		return false;
	}
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/feeDispather.jsp?meansId="+means+"&orderId="+orderId+"&startTime="+H11_effDateStr+"&H15="+H15+"&netFlag="+netFlag+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>&act_type=<%=act_type%>", "资费信息", "1000","500");
}

//合约资费选择
function chooAgreeFee(){
	var orderId = document.getElementById("login_accept").value;
	var contracttime  = document.getElementById("global_contracttime").value;
	var validmode= meansSelectedJson.find("VALID_MODE").value();//生效标识（合约期限）
    openDivWin("<%=request.getContextPath()%>/npage/se112/agreeFeeDispather.jsp?meansId="+means+"&orderId="+orderId+"&validmode="+validmode+"&contracttime="+contracttime+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>&act_type=<%=act_type%>&selectvalidMode=<%=selectvalidMode%>", "合约资费信息", "700","300");
}

//和包电子券金额
function chooseH42(){
	var scornMoney= meansSelectedJson.find("H42.DEDUCT_MONEY").value();
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreMoneyInfo.jsp?meansId="+means+"&scornMoney="+scornMoney+"&svcNum=<%=svcNum%>", "和包电子券", "700","200");
}
//使用和包电子券
var isH56Selected = false;
function chooseH56(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreMoneyInfoNew.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "和包电子券(新)", "700","200");
}

//选择以旧换新
function chooOrderTypeH50(){
	var orderType = $("#orderType" + means).val();
	if(orderType=="0"){
		showDialog("'是否以旧换新'请选择 '是' 再点击选择按钮!!",0);
		return false;
	}
	var pay_moneycould = document.getElementById("pay_moneycould").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooOldResDispather.jsp?meansId="+means+"&pay_moneycould="+pay_moneycould+"&svcNum=<%=svcNum%>&act_type=<%=act_type%>", "以旧换新信息", "700","300");
}
//家庭资费选择
function choofamilyPay(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/feeDispather.jsp?meansId="+means+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>", "资费信息", "700","300");
}
//SP业务
function chooSPDetails(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/spDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>&innetMons=<%=innetMons%>&actType=<%=act_type%>", "SP业务信息", "1000","300");
}
//手机凭证
function chooseCredence(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/phoneCredenceDispather.jsp?meansId="+means, "手机凭证业务信息", "700","300");
}
//全网专款
function showAllSpeFunDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/specialAllDispather.jsp?meansId="+means, "全网专款预存款信息", "700","300");
}
//全网主资费
function chooseAllFee(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseAllFee.jsp?meansId="+means+"&orderId="+orderId+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>", "全网主资费", "700","300");
}

//必绑附加资费
function showfeeBindingFun(){
	 openDivWin("<%=request.getContextPath()%>/npage/se112/bindingfeeDispather.jsp?meansId="+means, "必绑附加资费", "700","300");
}

//成员订购
var newNetCode = "<%=netCode%>";
var RETURN_CODE = "";
var RETURN_MSG = "";
function memberInfo(){
	//add date:20150730,校验如果是16 19类宽带，包含sp业务，则必须先选择sp
	var H12=meansFalg.charAt(11);
	if(H12=='1' && ("<%=act_type%>"=="16" || "<%=act_type%>" == "19")){
		if(!sp_Check){
			showDialog("请先选择SP业务，再进行成员配置!",0);
		 	return false;
		}
	}
	var spNetFlag = document.getElementById("global_spNetFlag").value;
	if(spNetFlag=="Y" && ("<%=act_type%>"=="16" || "<%=act_type%>" == "19")){
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/marketLimit.jsp","请稍后...");
		packet.data.add("actId","A");
		packet.data.add("svcNum","<%=svcNum%>");
		packet.data.add("opCode","0012");
		packet.data.add("actClass","<%=act_type%>");
		core.ajax.sendPacketHtml(packet,doSPFunction,true);
		packet =null;
	}else{
		var h15xml = document.getElementById("global_memNo").value;
		if(h15xml.indexOf("<MEMBER_TYPE type='string'>B</MEMBER_TYPE>") >= 0){
			if( newNetCode == "" && ("<%=act_type%>"=="16" || "<%=act_type%>" == "18")){
				getMemberInfo();
				if(RETURN_CODE!="000000"){
					showDialog(RETURN_CODE+" "+RETURN_MSG,0);
					return false;
				}
			}
		}
		var orderId = document.getElementById("login_accept").value;
		openDivWin("<%=request.getContextPath()%>/npage/se112/toMemberInfo.jsp?meansId="+means+"&orderId="+orderId+"&netCode="+newNetCode+"&actType=<%=act_type%>&svcNum=<%=svcNum%>", "成员订购", "1000","700");

	}
	
}

function doSPFunction(data){
	var sdata = data.split("~");
	var retCode1 = sdata[0];
	var retMsg1 = sdata[1];
	var retCode2 = sdata[2];
	var retMsg2 = sdata[3];
	 if(retCode1 !=000000){
		showDialog(retMsg1,1);
		return false;
	}else if (retCode2 != 0){
		showDialog(retMsg2,1);
		return false;
	}
	var h15xml = document.getElementById("global_memNo").value;
	if(h15xml.indexOf("<MEMBER_TYPE type='string'>B</MEMBER_TYPE>") >= 0){
		if( newNetCode == "" && ("<%=act_type%>"=="16" || "<%=act_type%>" == "18")){
			getMemberInfo();
			if(RETURN_CODE!="000000"){
				showDialog(RETURN_CODE+" "+RETURN_MSG,0);
				return false;
			}
		}
	}
	var orderId = document.getElementById("login_accept").value;
	openDivWin("<%=request.getContextPath()%>/npage/se112/toMemberInfo.jsp?meansId="+means+"&orderId="+orderId+"&netCode="+newNetCode+"&actType=<%=act_type%>&svcNum=<%=svcNum%>", "成员订购", "1000","700");
} 


function getMemberInfo(){
	var myPacket = null;
	myPacket = new AJAXPacket("getNetCode.jsp","请稍后...");
	myPacket.data.add("custOrderId","<%=custOrderId%>");
	core.ajax.sendPacket(myPacket,doMemberInfo);
	myPacket = null;
}

function doMemberInfo(packet){
	RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	newNetCode = packet.data.findValueByName("netCode");
}


//异网号码 add by zhouwy date:20140711
function chooCustDetails(){
	chooseCust = false;
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/custInfoDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>", "异网号码信息", "700","300");
}

//submit提交订单报文--hlj无改变
function submitAct(){
	var H01=meansFalg.charAt(0); 
	var H02=meansFalg.charAt(1); 
	var H03=meansFalg.charAt(2); 
	var H04=meansFalg.charAt(3); 
	var H05=meansFalg.charAt(4); 
	var H06=meansFalg.charAt(5); 
	var H07=meansFalg.charAt(6); 
	var H08=meansFalg.charAt(7); 
	var H09=meansFalg.charAt(8); 
	var H10=meansFalg.charAt(9); 
	var H11=meansFalg.charAt(10);
	var H12=meansFalg.charAt(11);
	var H13=meansFalg.charAt(12);
	var H14=meansFalg.charAt(13);
	var H15=meansFalg.charAt(14);
	var H20=meansFalg.charAt(19);
	var H21=meansFalg.charAt(20);
	var H23=meansFalg.charAt(22);
	var H24=meansFalg.charAt(23);
	var H25=meansFalg.charAt(24);
	var H26=meansFalg.charAt(25);
	var H27=meansFalg.charAt(26);
	var H28=meansFalg.charAt(27);
	var H29=meansFalg.charAt(28);
	var H30=meansFalg.charAt(29);
	var H31=meansFalg.charAt(30);
	var H32=meansFalg.charAt(31);
	var H33=meansFalg.charAt(32);
	var H34=meansFalg.charAt(33);
	var H35=meansFalg.charAt(34);//全网主资费
	var H36=meansFalg.charAt(35);
	var H37=meansFalg.charAt(36);
	var H38=meansFalg.charAt(37);
	var H39=meansFalg.charAt(38);
	var H41=meansFalg.charAt(40);
	var H42=meansFalg.charAt(41);
	var H43=meansFalg.charAt(42);
	var H44=meansFalg.charAt(43);
	var H22=meansFalg.charAt(21); 
	var H48=meansFalg.charAt(47);
	var H49=meansFalg.charAt(48); 
	var H50=meansFalg.charAt(49); 
	var H52=meansFalg.charAt(51); 
	var H53=meansFalg.charAt(52); 
	var H54=meansFalg.charAt(53);
	var H55=meansFalg.charAt(54);
	var H56=meansFalg.charAt(55);
	//xin
	if ((H13=='1'||H14=='1'||H49=='1')&&!checkdate()){
	    showDialog("4月1日至3日进行积分系统升级，在此间不能使用积分，请引导客户不使用积分办理或4月4日后再进行办理",0);
		return false;
	}
	if(H01=='1'){
		addCashPay();	       //现金
	
	}
	if(H02=='1'){
		assispCash();          //专款预存款
	}
	//集团协议增机 act_type=15
	//如果为false则没有拼FB专款，则需要buildH02Ex()拼接
	if((!buildH02Flag) && ("<%=act_type%>"=="15" || "<%=act_type%>"=="77" || "<%=act_type%>"=="25")){
		buildH02Ex();
	}
	if(H03=='1'){
		if(!payType_Check){
			showDialog("请选择副卡专款!",0);
		 	return false;
		}
		assispecialData();
	}
	if(H04=='1'){
	  if(!sysPay_Check){
			showDialog("请选择系统充值!",0);
		 	return false;
	  }
	}
	if(H05=='1'){
	  if(!agreeMent_Check){
			showDialog("请选择合约资费!",0);
		 	return false;
	  }
	}
	if(H06=='1'){
	   if(!specialfund_Check){
			showDialog("请选择银行分期付款!",0);
		 	return false;
		}
	}
	if(H07=='1'){
	   if(!orderGift_Check){
			showDialog("请选择促销品!",0);
		 	return false;
		}
		//salesPromotionGift();	//促销品
	}
	if(H08=='1'){
		phoneCredence();    
	}
	if(H09=='1'){
		if(!terminal_Check){
			showDialog("请选择终端!",0);
		 	return false;
		}
	}
	if(H10=='1'){
		if(!mainTraffic_Check){
			showDialog("请选择主资费!",0);
		 	return false;
		}
	}
	if(H11=='1'){
		//additionTraffic();		//附加资费
		if(!H11_choose){showDialog("请选择附加资费",1);return -1;}
	}
	if(H42=='1'){
		if(!H42_choose){showDialog("请选积分兑换码信息",1);return -1;}
	}
	if(H56=='1'){
		if(!isH56Selected){showDialog("请选使用和包电子券",1);return -1;}
	}
	if(H12=='1'){		//SP业务
		if(!sp_Check){
			showDialog("请选择SP业务!",0);
		 	return false;
		}
		addSpSystemPayData();		
	}
	if(H13=='1'){
		var reg=/^([1-9]\d*)$/;
		var inputNum = $("#H13Num" + means).val();
		if(inputNum==null||inputNum==""){
			showDialog("请输入扣减积分兑换数量!",0);
			return false;
		}
		if(!reg.test(inputNum)){
			showDialog("扣减积分兑换数量输入格式有误，请重新输入!",0);
			return false;
		}
		if(!AbatementIntegral("<%=vCurPoint%>",inputNum))//扣减积分
		{
			showDialog("当前积分不足!",0);
		 	return false;
		}
		//xin
		if("非实名"=="<%=Sname_Status%>"){ 
			//System.out.println(Sname_Status+"============Sname_Status");
			showDialog("提醒进行实名登记后方可进行积分兑换操作!",0);
			return false;
		}
	}
	if(H14=='1'){
		if(!counteractIntegral_Check){
			showDialog("请选择抵消积分!",0);
		 	return false;
		}
	}
	if(H15=='1'){
		if(!isH15Selected){
			showDialog("请配置成员信息!",0);
		 	return false;
		}
	}
	if(H20=='1'){
		addBroadDiscountPay();
	}
	if(H21=='1'){
		var printType = meansSelectedJson.find("H21.NVOICE_PRINT_TYPE").value();
		if("1"==meansFalg.charAt(8)){
			nvoicePrintType(printType);	//发票打印类型
		}else{
			nvoicePrintType("0");
		}
	}else{
		nvoicePrintType("0");
	}
	if(H23=='1'){
		sddConsiderations();	//注意事项
	}
	if(H24=='1'){
		addNotfunc();			//备注
	} else{
		addNotfuncs();
	}
	if(H27=='1'){
		addMessagefunc();			//发送短信
	} else{
		addMessagefuncs();
	}
	if(H28=='1'){
		addBillDiscount();	//账单优惠
	}
	if(H33=='1'){
		if(!orderType_Check){
			showDialog("请选择订购方式!",0);
		 	return false;
		}
	}else{
		addOrderTypeData("0");
	}
	if(H34=='1'){
		assispAllCash();          //全网专款预存款
	}
	//全网主资费
	if(H35=='1'){
		if(!mainAllTraffic_Check){
			showDialog("请选择语音套餐!",0);
		 	return false;
		}
	} 
	if(H36 == "1"){
		if(!H36_choose){showDialog("请选择流量套餐",1);return -1;}
	}
	if(H37 == "1"){
		if(!H37_choose){showDialog("请选择Wlan",1);return -1;}
	}
	if(H38 == "1"){
		if(!H38_choose){showDialog("请选择数据业务",1);return -1;}
	}
	if(H39 == "1"){
		if(!H39_choose){showDialog("请选择终端",1);return -1;}
	} 
	if(H35=="1"){
		if(checkGroup()<0 ){
			return;
		}
	}
	if(H41=='1'){
		addBindingTraffic();		//必绑附加资费
	}
	if(H43=='1'){
		buildH43XML();
	}
	if(H44=='1'){
		if($.trim($("#pay_moneycould").val()) != $.trim($("#H44value"+means).text())){
			showDialog("实际预存金额与约定预存金额不相等，请重新配置!",1);
			return;			
		}
	}
	if(H22=='1'){
		if(!chooseCust){
			showDialog("请选择异网号码!",0);
		 	return false;
		}
	}
	if(H48=='1'){
		if(!card_Checkfuca){
			showDialog("请选择有价卡!",0);
		 	return false;
		}
	}
	if(H49=='1'){
		//xin
		if("非实名"=="<%=Sname_Status%>"){ 
			//System.out.println(Sname_Status+"============Sname_Status");
			showDialog("非实名制客户不能享受积分，请您前往中国移动营业厅进行实名登记!",0);
			return false;
		}
		addScore();	       //赠送积分
	}
	
	if(H50=='1'){
		var orderType = $("#orderType" + means).val();
		if(!chooseOldRes && orderType=="1"){
			showDialog("请选择添加‘以旧换新’机型或者将‘是否以旧换新’置为‘否’!",0);
		 	return false;
		}
	}
	if(H52=='1'){
		if(!chooseCardCode){
			showDialog("请选择电子兑换码!",0);
		 	return false;
		}
	}
	if(H54=='1'){
	  if(!templet_Check){
			showDialog("请选择模板信息!",0);
		 	return false;
	  }
	}
	if(H55=='1'){
		addDeposit();//押金
	
	}
	if(H53=='1'){
		addEleGift();//赠送魔百盒
	}

	if("<%=act_type%>"=="140" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "149"|| "<%=act_type%>" == "71"|| "<%=act_type%>" == "157"){
		if((H42=='1' && H05=='1')||(H54=='1' && H09=='1')||(H42=='1' && H09=='1')){
			if(parseFloat(deductmoney)>=parseFloat(resourcecostprices)){
				showDialog("抵扣的积分电子券金额大于等于所选机型的终端采购价，请选择低档位套餐或减少合约期。",0);
				return false;
			}
		}
	}
	
	var pay_moneycould=document.getElementById("pay_moneycould").value;
 	if(pay_moneycould==null||pay_moneycould==""||pay_moneycould=="null"){
		showDialog("系统应付金额为空，请重新选择该活动，重新选择后问题将解决!",0);
	 	return false;
	}
	busi_infoFcon(pay_moneycould);//应缴纳的钱数
	var pay_note=document.getElementById("pay_note").value;//增加备注
	note_infoFcon(pay_note);//备注信息
	if("<%=printAccept %>"=="N/A" || "<%=printAccept %>"=="n/a" || "<%=printAccept %>"=="" 
		|| "<%=printAccept %>"=="NULL" ||"<%=printAccept %>"=="null"){
		showDialog("系统销售流水处理错误,请重新进入活动页面办理!",0);
	 	return false;
	}
	//预提交订单
	preSubmitForm();
}
//预提交订单
function preSubmitForm(){
	$("#btnSave").attr("disabled","disabled");
	var saleorderStrs=saleOrder.toJson();
	var myPacket = null;
	myPacket = new AJAXPacket("preMessageOprateOder.jsp","请稍后...");
	myPacket.data.add("saleOrder",saleorderStrs);
	core.ajax.sendPacket(myPacket,preDoSubmit);
	myPacket = null;
}

var XML_STR = "";//设置订单报文为全局变量
function preDoSubmit(packet){
	isClose = false;
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	XML_STR = packet.data.findValueByName("XML_STR");
	if(RETURN_CODE!="0"){
		showDialog(RETURN_CODE+" "+RETURN_MSG,0);
		return false;
	}
	if("<%=chanType%>"=="16"){
		showDialog('确认要提交信息吗?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
	}else{
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
 				showDialog('确认电子免填单吗？',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
		}
		if(ret=="continueSub"){
	 			showDialog('确认要提交信息吗?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
		}
  	}else{
     showDialog('请确认要提交信息吗?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
  	}
	}
}

//提交订单

function submitForm(){
	var myPacket = null;
	var score_type = meansSelectedJson.find("H14.IS_SCORE").value();//积分抵消类型
	var score_value = document.getElementById("global_scoreValue").value;
	var score_money = document.getElementById("global_scoreMoney").value;
	var net_code = document.getElementById("global_netCode_temp").value;
	var net_sm_code = document.getElementById("global_netSmCode").value;
	var net_flag = document.getElementById("global_netFlag").value;
	myPacket = new AJAXPacket("messageOprateOder.jsp","请稍后...");
	myPacket.data.add("XML_STR",XML_STR);
	
	myPacket.data.add("busiId","<%=printAccept %>");
	myPacket.data.add("chnType","<%=chanType%>");
	myPacket.data.add("opCode","g794");
	myPacket.data.add("loginNo","<%=login_no%>");
	myPacket.data.add("loginPwd","<%=password%>");
	myPacket.data.add("netCode",net_code);//宽带号码
	myPacket.data.add("userPwd","");//用户密码（传空)
	myPacket.data.add("phoneChgNo","<%=svcNum%>");//抵扣积分的手机号码
	myPacket.data.add("scoreType",score_type);//抵扣类型
	myPacket.data.add("scoreValue",score_value);//抵扣积分值
	myPacket.data.add("scoreMoney",score_money);//抵扣钱数
	myPacket.data.add("netSmCode",net_sm_code);//宽带品牌
	myPacket.data.add("netFlag",net_flag);//宽带标识
	
	core.ajax.sendPacket(myPacket,doSubmit);
	myPacket = null;
}
function doSubmit(packet){
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(RETURN_CODE!="0"){
		showDialog(RETURN_CODE+" "+RETURN_MSG,0);
		return false;
	}
	var H10=meansFalg.charAt(9);
	if(H10=='1'){
		var priFee=$("#feeDetails"+means).text();
		alert("主资费: <%=mode_name%>  变更为 :"+priFee);
	}
	showDialog('操作成功!',3,'retT=goNextActiond();retF=goNextActiond();closeFunc=goNextActiond()');
}


function goNextActiond(){
	 goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
}

function payType_Checkfuc(){
	payType_Check=true;	//副卡专款         
}
function specialfund_Checkfuc(){ 
	specialfund_Check=true;	//缴费方式     
}
function valuableCard_Checkfuc(){       
	valuableCard_Check=true;	//有价卡       
}    
function terminal_Checkfuc(){   
	terminal_Check=true;		//终端  
}
function oldRes_Checkfuc(){   
	chooseOldRes=true;		//以旧换新
}
function agreeMent_Checkfuc(){   
	agreeMent_Check=true;		//资费终端分离 
}
function templet_Checkfuc(){   
	templet_Check=true;		//模板元素 
	chooseH54=true;
}
function sp_Checkfuc(){   
	sp_Check=true;		//sp业务
}
function mainTraffic_Checkfuc(){            
	mainTraffic_Check=true;	//主资费   
}
function counteractIntegral_Checkfuc(){      
	counteractIntegral_Check=true;    //抵消积分    
}
function viceSysPay_Checkfuc(){      
	sysPay_Check=true;    //系统充值    
}
function memNumber_Checkfuc(){
	memNumber_Check=true;	//成员号码         
}
function orderType_Checkfuc(){ 
	orderType_Check=true;	//订购方式     
}
function mainAllTraffic_Checkfuc(){            
	mainAllTraffic_Check=true;	//全网主资费   
}
var netCodePrintStr = "";
function NET_CODE_FUC(desc){ 
	netCodePrintStr = desc;
	Net_code_Check=true;		//宽带
}
function card_Checkfuc(){
	card_Checkfuca = true;
}
function h22CustInfo_Checkfuc(){      
	chooseCust=true;//异网号码 
}
function cardCode_Checkfuc(){   
	chooseCardCode=true;		//电子兑换码
}
function H56_Checkfuc(){   
	isH56Selected=true;		//使用和包电子券
}

//提交前的取消操作
function cancelAction(){
	if(resourceNo != "-1"){
		getAjaxCheckSellEndsetNo(resourceNo);
		releasCardResource();
	}
	window.location.reload(true);
}

function closeForm(){
	try{
		parent.insertCar('<%=contactId%>');//参数为接触ID
		parent.removeTab("<%=opCode%>");
	}catch(e){
		//window.close();
	}	
}

function reSubmitAct(){
	isClose = false;//不触发关闭窗口事件
		 if(checksubmit(frm1147)){
			showDialog('是否确认提交?',3,'retT=submit();retF=cancelAction();closeFunc=closeForm()');
		}
}
//--songjia add for hlj 20100309
//免填单对话框
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var obj =new Object();
	obj.name=printStr;
	//取免填单流水
	var sysAccept = document.getElementById("login_accept").value;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path +="&mode_code="+fav_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%="g794"%>&sysAccept="+sysAccept+"&phoneNo=<%=svcNum%>&submitCfm=" ;
	path += submitCfm+"&pType="+pType+"&billType="+billType;
	path +="&printInfo=" +trim(printStr);
	//alert(path);
	/* var ret=window.showModalDialog(path,obj,prop,'status:yes;help:yes;scroll:yes'); */
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}
function replaceConnectChar(s)
{
  var str = s.replace(/#/g, "＃");
  return str;
}
function strcat()
{
	var result = "";
	for(var i = 0; i< arguments.length; i++)
	{
		result = result + replaceConnectChar(arguments[i]) + '#';
	}
	return result;
}

function printInfo(printType)
{
	 //客户信息
	 var cust_info="";
   //内容
	 var opr_info="";
	 //备注
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 //返回总字符串
	 var retInfo = "";
		var meansNamerets=meansNameret();
		cust_info+="手机号码：   "+document.all.user_phone_no.innerText+"|";
		cust_info+="客户姓名：   "+document.all.user_cust_name.innerText;
		opr_info+="用户品牌："+document.all.user_sm_name.innerText+"          业务类型："+meansNamerets+"|";
		opr_info+="业务流水："+document.getElementById("login_accept").value+"|";
		//means 
		//现金
		var cashPay = $("#cashPay"+means).text();
		if(cashPay != ""){
			opr_info+="现金："+cashPay+"|";
		}
		//专款预存款
		var specialFunds = $("#specialFunds"+means).text();
		if(specialFunds != ""&&specialFunds!="null"){
			if("<%=act_type%>"=="70"){
				var values = "";
				var strs = specialFunds.split("，");
				for(var k=0; k<strs.length; k++) {
					if(strs[k].indexOf("消费期限") < 0) {
						values += strs[k] + "，";
					}
				}
				opr_info+="专款预存款："+values.substring(0, (values.length - 1))+"|";
				//alert(values.substring(0, (values.length - 1)));
			}else{
				opr_info+="专款预存款："+specialFunds+"|";
		    }
    }

		//副卡专款
		var showAssiSpe = $("#showAssiSpe"+means).text();
		if(showAssiSpe != ""&&showAssiSpe!="null"){
			opr_info+="副卡专款："+showAssiSpe+"|";
		}
		//系统充值
		var isAward = document.getElementById("isAward").value;
//		alert(isAward);
		if(isAward != ""){
		 	var isAwards = isAward.split("#");
		    var systemPay = $("#systemPay"+means).text();
		    if(systemPay != ""&&systemPay!="null"){
		   		 opr_info+="系统充值:"+systemPay+"|";
		    }
		    for(var i =0;i<isAwards.length;i++){
			     if(isAwards[i] == "Y"){
					if(systemPay != "" && systemPay!="null"){
						opr_info+="系统充值"+(i+1)+": 该用户已中奖|";
					}
			     }
			}
		}
		
		var H07=meansFalg.charAt(6); 
		if(H07=='1'){
			var awardRate = $("#H07AwardRate"+means).val();
			if(awardRate != ""&&awardRate!="null"){
				opr_info+="礼品名称："+awardRate+"|";
			}
			if(giftAward == "N"){
				opr_info+="该用户未中奖|";
			}
		}
		
		//有价卡
		var cardType = $("#cardType"+means).text();
		if(cardType != ""&&cardType!="null"){
			opr_info+="有价卡："+cardType+"|";
		}
		//终端
		var resourceDetails = $("#resourceDetails"+means).text();
		if(resourceDetails != ""&&resourceDetails!="null"){
			var imei_code = saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.IMEI_CODE").value(); 
			opr_info+="终端："+resourceDetails+"|";
			opr_info+="终端IMEI："+imei_code+"|";
		}
		//主资费feeDetails
		var feeDetails = document.getElementById("global_feeDesc").value;
		//alert("feeDetails = "+feeDetails);
		//var feeDetails = $("#feeDetails"+means).text();
		if(feeDetails != ""&&feeDetails!="null"){
			
			if(feeDetails.length>500 && feeDetails.length<1000){
				opr_info+=feeDetails.substr(0,500)+"|";
				opr_info+=feeDetails.substr(500)+"|";
			}else if(feeDetails.length>1000 && feeDetails.length<1500){
				opr_info+=feeDetails.substr(0,500)+"|";
				opr_info+=feeDetails.substr(500,1000)+"|";
				opr_info+=feeDetails.substr(1000)+"|";
			}else if(feeDetails.length>1500 && feeDetails.length<2000){
				opr_info+=feeDetails.substr(0,500)+"|";
				opr_info+=feeDetails.substr(500,1000)+"|";
				opr_info+=feeDetails.substr(1000,1500)+"|";
				opr_info+=feeDetails.substr(1500)+"|";
			}else{
				opr_info+=feeDetails+"|";
			}
			
			
			//opr_info+=feeDetails+"|";
		}
		var goNotice = document.getElementById("global_Notice").value;
if(goNotice != ""&&goNotice!="null"){
	if(goNotice.length>500 && goNotice.length<1000){
			opr_info+=goNotice.substr(0,500)+"|";
			opr_info+=goNotice.substr(500)+"|";
	}else if(goNotice.length>1000 && goNotice.length<1500){
			opr_info+=goNotice.substr(0,500)+"|";
			opr_info+=goNotice.substr(500,1000)+"|";
			opr_info+=goNotice.substr(1000)+"|";
	}else if(goNotice.length>1500 && goNotice.length<2000){
			opr_info+=goNotice.substr(0,500)+"|";
			opr_info+=goNotice.substr(500,1000)+"|";
			opr_info+=goNotice.substr(1000,1500)+"|";
			opr_info+=goNotice.substr(1500)+"|";
	}else{
			opr_info+=goNotice+"|";
	}
}
		
		var feeNote = document.getElementById("global_feeNote").value;
		//alert("feeNote="+feeNote);
		if(feeNote != ""&& feeNote!="null"){
			opr_info+=feeNote+"|";
		}
		
		//附加资费showAssifee
		var showAssifee = document.getElementById("global_AssiFeeDesc").value;
		//alert("showAssifee = "+showAssifee);
		//var showAssifee = $("#showAssifee"+means).text();
		if(showAssifee != ""&&showAssifee!="null"){
			
			if(showAssifee.length>500 && showAssifee.length<1000){
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500)+"|";
				}else{
					opr_info+="附加资费："+showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500)+"|";
				}
				
			}else if(showAssifee.length>1000 && showAssifee.length<1500){
				
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000)+"|";
				}else{
					opr_info+="附加资费："+showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000)+"|";
				}
				
			}else if(showAssifee.length>1500 && showAssifee.length<2000){
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000,1500)+"|";
					opr_info+=showAssifee.substr(1500)+"|";
				}else{
					opr_info+="附加资费："+showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000,1500)+"|";
					opr_info+=showAssifee.substr(1500)+"|";
				}
			}else{
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee+"|";
				}else{
					opr_info+="附加资费："+showAssifee+"|";
				}
			}
			
			<%-- if("<%=act_type%>"=="71"){
				opr_info+=showAssifee+"|";
			}else{
				opr_info+="附加资费："+showAssifee+"|";
			} --%>
		}
		
		var assiFeeNote = document.getElementById("global_AssiFeeNote").value;
		//alert("assiFeeNote="+assiFeeNote);
		if(assiFeeNote != ""&& assiFeeNote!="null"){
			opr_info+=assiFeeNote+"|";
		}
		
		//SP业务SPDetails
		var SPDetails = $("#SPDetails"+means).text();
		if(SPDetails != ""&&SPDetails!="null"){
			opr_info+="SP业务："+SPDetails+"|";
		}
		//扣减积分subScore
		var subScores = $("#subScores"+means).text();
		if(subScores != ""){
			opr_info+="扣减积分："+subScores+"|";
		}
		//抵消积分b14Score	
		var h14Score = $("#H14Score"+means).text();
		if(h14Score != ""&&h14Score!="null"){
			opr_info+="抵消积分："+h14Score+"|";
		}
		//赠送积分H49Score	
		var H49Score = $("#H49Score"+means).text();
		if(H49Score != ""&&H49Score!="null"){
			opr_info+=H49Score+"|";
		}
		//赠送积分h42Show	
		var h42Show = $("#H42_show"+means).text();
		if(h42Show != ""&&h42Show!="null"){
			opr_info+=h42Show+"|";
		}
		//银行卡分期付款	
		var payTypeInfo = $("#payTypeInfo"+means).text();
		if(payTypeInfo != ""&&payTypeInfo!="null"){
			opr_info+="银行卡分期付款："+payTypeInfo+"|";
		}
		var orderType =  saleOrder.find("REQUEST_INFO.MEANS.MEAN.H33.ORDER_TYPE_VALUE").value();
		if("没有选择到节点，无返回值" != orderType){
		   if(orderType == "1"){
		   	 opr_info+="订购类型：预约办理|";
		   }
		}
		//成员专款（复杂宽带营销案）
		if(printStrH32 != ""){
			opr_info += "成员专款："+printStrH32+"|";
		}
		//宽带账号(宽带营销案)
		if(netCodePrintStr != ""){
			opr_info += netCodePrintStr+"|"; 
		}
		//合约资费分离
		
		var agreeFeeDetails = document.getElementById("global_agreeFeeDesc").value;
		//alert("global_agreeFeeDesc="+agreeFeeDetails);
		//var agreeFeeDetails = $("#agreeFeeDetails"+means).text();
		if(agreeFeeDetails != ""&&agreeFeeDetails!="null"){
			
			if(agreeFeeDetails.length>500 && agreeFeeDetails.length<1000){
				opr_info+=agreeFeeDetails.substr(0,500)+"|";
				opr_info+=agreeFeeDetails.substr(500)+"|";
			}else if(agreeFeeDetails.length>1000 && agreeFeeDetails.length<1500){
				opr_info+=agreeFeeDetails.substr(0,500)+"|";
				opr_info+=agreeFeeDetails.substr(500,1000)+"|";
				opr_info+=agreeFeeDetails.substr(1000)+"|";
			}else if(agreeFeeDetails.length>1500 && agreeFeeDetails.length<2000){
				opr_info+=agreeFeeDetails.substr(0,500)+"|";
				opr_info+=agreeFeeDetails.substr(500,1000)+"|";
				opr_info+=agreeFeeDetails.substr(1000,1500)+"|";
				opr_info+=agreeFeeDetails.substr(1500)+"|";
			}else{
				opr_info+=agreeFeeDetails+"|";
			}
			
			//opr_info+=agreeFeeDetails+"|";
		}
		
		var agreeFeeNote = document.getElementById("global_agreeFeeNote").value;
		//alert("agreeFeeNote="+agreeFeeNote);
		if(agreeFeeNote != ""&& agreeFeeNote!="null"){
			opr_info+=agreeFeeNote+"|";
		}
		
		//模板数据
		var templetDetails = $("#templetDetails"+means).text();
		if(templetDetails != ""&&templetDetails!="null"){
			
			if(templetDetails.length>500 && templetDetails.length<1000){
				opr_info+=templetDetails.substr(0,500)+"|";
				opr_info+=templetDetails.substr(500)+"|";
			}else if(templetDetails.length>1000 && templetDetails.length<1500){
				opr_info+=templetDetails.substr(0,500)+"|";
				opr_info+=templetDetails.substr(500,1000)+"|";
				opr_info+=templetDetails.substr(1000)+"|";
			}else if(templetDetails.length>1500 && templetDetails.length<2000){
				opr_info+=templetDetails.substr(0,500)+"|";
				opr_info+=templetDetails.substr(500,1000)+"|";
				opr_info+=templetDetails.substr(1000,1500)+"|";
				opr_info+=templetDetails.substr(1500)+"|";
			}else{
				opr_info+=templetDetails+"|";
			}
			
			//opr_info+=templetDetails+"|";
		}
		
		var attention = $("#attention"+means).text();
		if(attention != ""&&attention!="null"){
			if(attention.length>500 && attention.length<1000){
				opr_info+="注意事项："+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500)+"|";
			}else if(attention.length>1000 && attention.length<1500){
				opr_info+="注意事项："+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500,1000)+"|";
				opr_info+=attention.substr(1000)+"|";
			}else if(attention.length>1500 && attention.length<2000){
				opr_info+="注意事项："+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500,1000)+"|";
				opr_info+=attention.substr(1000,1500)+"|";
				opr_info+=attention.substr(1500)+"|";
			}else{
				opr_info+="注意事项："+attention+"|";
			}
			//opr_info+="注意事项："+attention+"|";
		}	
		var gudingz = "结束";
		if(gudingz != ""&&gudingz!="null"){
			opr_info+="结束："+gudingz+"|";
		}
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


function closeForm1(){
	window.location.reload(true);
}
//-----------------------------------------B32 成员专款-----------------------------------------
var printStrH32 = "";
function addShowMemInfo(desc,totalMoney, printStr){
	meansFalg = $("#flag"+means).val(); 
	var otherMoney = calcMoney(meansFalg);
	var finalMoney = Number(otherMoney) + Number(totalMoney);
	document.getElementById("pay_moneycould").value=parseFloat(finalMoney);
	document.getElementById("pay_moneycouldhid").value=parseFloat(finalMoney);
	document.getElementById("memNumSpan" + means).innerHTML = desc;
	printStrH32 = printStr;
}

function showAllFeeList(obj){
	var value = obj.value;
	if(value == "H35.SHOW.FALSE"){
		var ret = checkModify();
		if(ret!=-1){
			document.getElementById("showAllFee" + means).innerHTML = "当前主资费：<%=mode_code%>_<%=mode_name%>";
			$("#allPriFee"+means).attr("disabled","disabled");
			$("#showAllFeeButton"+means).attr("disabled","disabled");
			mainAllTraffic_Check=true;
		}else{
			obj.value="H35.SHOW.TRUE";
			showDialog("当前主资费不在资费配置表中，需要变更主资费!",1);
		}
	}else{
		document.getElementById("showAllFee" + means).innerHTML="";
		$("#allPriFee"+means).removeAttr("disabled");
		$("#showAllFeeButton"+means).removeAttr("disabled");
		mainAllTraffic_Check=false;
	}
		resetCosts(means);
}
function submit_disabled(){//有价卡电子化选择按钮控制
	$("#cardsPreOccupied"+means).attr("disabled","disabled");
}
function meansSearch(){
	var searchMeansId = $.trim($("#searchMeansId").val()); 
	if(searchMeansId != ""){
		var meaIdSearch = document.getElementsByName("meaIdSearch");
		for(var i=0;i<meaIdSearch.length;i++){
			var meaIdName = meaIdSearch[i].value;
			var meaIdNameStrs = meaIdName.split("&");
			if(meaIdNameStrs[0].indexOf(searchMeansId) != -1){
				$("#title_"+meaIdNameStrs[1]).show();
			}else{
				$("#title_"+meaIdNameStrs[1]).hide();
				$("#ruleDetail"+meaIdNameStrs[1]).hide();
			}
		}
	}else{
		var meaIdSearch = document.getElementsByName("meaIdSearch");
		for(var i=0;i<meaIdSearch.length;i++){
			var meaIdName = meaIdSearch[i].value;
			var meaIdNameStrs = meaIdName.split("&");
			$("#title_"+meaIdNameStrs[1]).show();
		}
	}
}
function checkdate()
{   
	var myDate = new Date();
    var $startDate = new Date(2015,03,01,00,00,00);
    var $endDate = new Date(2015,03,03,23,59,59); 
    //4月1日到4月4日 7点 都不能办理
	if((myDate >= $startDate) && (myDate <= $endDate)){
	   return false;
	 }
	return true;
}

</script>
