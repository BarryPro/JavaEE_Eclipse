<%
 //���ֱ��Ĳ������js����
 %>

<script type="text/javascript">

function getCardFee(){
   var total = 0;
	if(feeCardArr.length>0){
  		for(var i=0;i<feeCardArr.length;i++){
  			total += parseInt(feeCardArr[i][1]);
  		}
  	}
	return total;
}

function netCodeDate(net_code, net_fee_code){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H29.NET_CODE").set(net_code);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H29.NET_FEE_CODE").set(net_fee_code);
}

function mktQryEffect(effect){
	saleOrder.find("REQUEST_INFO.GLOBAL_CONTROL.VALID_TYPE").set(effect);
}
//��ȡ��ǰʱ��
function createNowTime(){
	var dat = new Date();
	var timeStr = dat.getYear()+dat.getMonth()+dat.getDay()+"000000";
	return timeStr;
}
function meansNameret(){
	var MEANS_NAME= meansSelectedJson.find("MEANS_NAME").value();
	return MEANS_NAME;
}
//��ʼ��saleOrder
// hlj songjia 
function newBusiInfos(means){
	var printAccept = document.getElementById("login_accept").value;
	if(printAccept == "" || printAccept=="N/A"){
		showDialog('��ȡcrm��ˮʧ�ܣ����Ժ�����!!',0,'retT=window.location.reload(true);retF=cancelAction();closeFunc=window.location.reload(true)');
		return false;
	}
	if("��ʵ��" == "<%=Sname_Status%>" && "0" == "<%=oTrueCode%>"){
	   	showDialog('��ʵ���û����������ҵ��!!',0,'retT=window.location.reload(true);retF=cancelAction();closeFunc=window.location.reload(true)');
		return false;
	}
	var MEANS_NAME= meansSelectedJson.find("MEANS_NAME").value();
	var CONTRACT_TIME= meansSelectedJson.find("CONTRACT_TIME").value();//��Լ����
	var VALID_MODE= meansSelectedJson.find("VALID_MODE").value();//��Ч��ʶ����Լ���ޣ�
	
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEANS_ID").set(means);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEANS_NAME").set(MEANS_NAME);
	saleOrder.find("REQUEST_INFO.OPER_INFO.IP_ADDR").set("<%=ip_addr%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.GROUP_ID").set("<%=group_id %>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.LOGIN_NO").set("<%=login_no %>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.LOGIN_NAME").set("<%=login_name %>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.PASSWORD").set("<%=password %>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.LOGIN_ACCEPT").set(printAccept);
	saleOrder.find("REQUEST_INFO.OPER_INFO.OP_CODE").set("<%=opCode %>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.REGION_ID").set("<%=region_id%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.ORDER_ARRAYID").set("<%=orderArrayId%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.CUST_ORDERID").set("<%=custOrderId%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.SERV_BUSIID").set("<%=servBusiId%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.CHN_CODE").set("<%=chanType%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.UPDATE_NO").set("<%=updateNo%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.IS_APPREC").set("<%=isApprec%>");
	saleOrder.find("REQUEST_INFO.OPER_INFO.CONTRACT_TIME").set(CONTRACT_TIME);//��Լ����
	saleOrder.find("REQUEST_INFO.OPER_INFO.VALID_MODE").set(VALID_MODE);//��Ч��ʶ����Լ���ޣ�
	saleOrder.find("REQUEST_INFO.ACTION.ACTION_ID").set("<%=action_ID%>");
	saleOrder.find("REQUEST_INFO.ACTION.ACTION_NAME").set("<%=actName%>");
	saleOrder.find("REQUEST_INFO.ACTION.ACTION_TYPE").set("<%=act_type%>");
	saleOrder.find("REQUEST_INFO.ACTION.BIND_FLAG").set("0~0");
	saleOrder.find("REQUEST_INFO.ACTION.BUSI_TYPE").set("<%=busiType%>");	
	saleOrder.find("REQUEST_INFO.USER.ID_NO").set("<%=idNo%>");
	saleOrder.find("REQUEST_INFO.USER.CUST_ID").set("<%=cust_id%>");
	saleOrder.find("REQUEST_INFO.USER.CUST_NAME").set("<%=cust_name%>");
	saleOrder.find("REQUEST_INFO.USER.BRAND_ID").set("<%=brandId%>");
	saleOrder.find("REQUEST_INFO.USER.PHONE_NO").set("<%=svcNum%>");
	saleOrder.find("REQUEST_INFO.ACTION.IS_MESSAGE").set("<%=isMessage%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.GROUP_NAME").set("<%=regionGroup%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.CITY_ID").set("<%=regionCityId%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.AREA_NAME").set("<%=regionArea%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.AREA_ID").set("<%=regionAreaId%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.OPERM_NAME").set("<%=regionOperm%>");
	saleOrder.find("REQUEST_INFO.REGION_INFO.OPERM_ID").set("<%=regionOpermId%>");
	saleOrder.find("REQUEST_METHOD").set("WsNoticeResult");
	var myPacket = new AJAXPacket("serviceResCheck.jsp","������֤ҵ�����ƣ����Ժ�......");
	myPacket.data.add("meansid",means);
	myPacket.data.add("svcNum","<%=svcNum%>");
	myPacket.data.add("loginAccept",printAccept);
	core.ajax.sendPacket(myPacket,doserviceResCat);
	myPacket = null;
}
function doserviceResCat(packet){
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(RETURN_CODE!="000000"){
		showDialog(RETURN_MSG,0,'retT=window.location.reload(true);retF=cancelAction();closeFunc=window.location.reload(true)');
		return false;
	}	
}

function changeContractTime(CONTRACT_TIME){
	saleOrder.find("REQUEST_INFO.OPER_INFO.CONTRACT_TIME").set(CONTRACT_TIME);//��Լ����
}

function changeValidMode(VALID_MODE){
	saleOrder.find("REQUEST_INFO.OPER_INFO.VALID_MODE").set(VALID_MODE);//��Լ����
}
//-----------------------------------------------------------------------------------------hlj new -----------------------------------------------------------------------------------
//ϵͳ��ֵ�������ĸ�ֵ
function addSystemPayData(getWinningStr,winningRateStr,payTypeStr,returnMoneyStr,returnMonthStr,perMonthMoneyStr,limitMoneyStr,returnTypeSTr,returnClassStr,consumeTimeStr,payFlagStr,assPhoneNoStr,sp_systemsStr,validFlagStr){
	
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST.SYSTEM_PAYS_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04").addNode(sitechJson({tagName: "SYSTEM_PAYS_LIST"}));
	}

	var isAwardStr="";//�Ƿ��н���
	var getWinningStrs = getWinningStr.split("#");
	var winningRateStrs = winningRateStr.split("#");
	var payTypeStrs = payTypeStr.split("#");
	var returnMoneyStrs = returnMoneyStr.split("#");
	var returnMonthStrs = returnMonthStr.split("#");
	var perMonthMoneyStrs = perMonthMoneyStr.split("#");
	var limitMoneyStrs = limitMoneyStr.split("#");
	var returnTypeSTrs = returnTypeSTr.split("#");
	var returnClassStrs = returnClassStr.split("#");
	var consumeTimeStrs = consumeTimeStr.split("#");
	var payFlagStrs = payFlagStr.split("#");
	var assPhoneNoStrs = assPhoneNoStr.split("#");
	var sp_systemsStrs = sp_systemsStr.split("#");
	var validFlagStrs = validFlagStr.split("#");

	for(var i=0;i<payTypeStrs.length;i++){
		var OP_TIME="";
		var IS_AWARD=""//�Ƿ��н�
		var GetRandomn=Math.floor(Math.random()*100+1);
		var b=payTypeStrs[i].indexOf("(");
		var e=payTypeStrs[i].indexOf(")");
		var PAY_TYPE_NAME=payTypeStrs[i];
		payTypeStrs[i]=payTypeStrs[i].substring(b+1,e);
		var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);

		if(getWinningStrs[i] == "1"){			
			if(winningRateStrs[i] >= GetRandomn){
				IS_AWARD="Y";
			}else{
				IS_AWARD="N";
			}
		}else{
			IS_AWARD="N";
		}
		isAwardStr = isAwardStr+"#"+IS_AWARD;
		var systemPaysInfo=instanceTemplate["SYSTEM_PAYS_INFO"]();
		systemPaysInfo.find("PAY_TYPE").set(payTypeStrs[i]);
		systemPaysInfo.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
		systemPaysInfo.find("RETURN_MONEY").set(returnMoneyStrs[i]);
		systemPaysInfo.find("RETURN_MONTH").set(returnMonthStrs[i]);
		systemPaysInfo.find("PER_MONTH_MONEY").set(perMonthMoneyStrs[i]);
		systemPaysInfo.find("LIMIT_MONEY").set(limitMoneyStrs[i]);
		systemPaysInfo.find("OP_TIME").set("");
		systemPaysInfo.find("RETURN_TYPE").set(returnTypeSTrs[i]);
		systemPaysInfo.find("RETURN_CLASS").set(returnClassStrs[i]);
		systemPaysInfo.find("CONSUME_TIME").set(consumeTimeStrs[i]);
		systemPaysInfo.find("IS_AWARD").set(IS_AWARD);
		systemPaysInfo.find("PAY_FLAG").set(payFlagStrs[i]);
		systemPaysInfo.find("PAY_PHONE_NO").set(assPhoneNoStrs[i]);
		systemPaysInfo.find("VALID_FLAG").set(validFlagStrs[i]);
		systemPaysInfo.find("SP_SYSTEM").set(sp_systemsStrs[i]);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST").addNode(systemPaysInfo);
	}
	isAwardStr = isAwardStr.substring(1,isAwardStr.length);
	document.getElementById("isAward").value=isAwardStr;
}
//�Ծɻ���
function addOldResData(show_desc,resBrandStr,resTypeStr,resCostStr){
	
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H50.OLD_RES_LIST.OLD_RES_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H50.OLD_RES_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H50").addNode(sitechJson({tagName: "OLD_RES_LIST"}));
	}

	var resBrandStrs = resBrandStr.split("#");
	var resTypeStrs = resTypeStr.split("#");
	var resCostStrs = resCostStr.split("#");

	for(var i=0;i<resBrandStrs.length;i++){
		var oldResInfo=instanceTemplate["OLD_RES_INFO"]();
		oldResInfo.find("OLD_RES_BRAND").set(resBrandStrs[i]);
		oldResInfo.find("OLD_RES_TYPE").set(resTypeStrs[i]);
		oldResInfo.find("OLD_RES_COST").set(resCostStrs[i]);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H50.OLD_RES_LIST").addNode(oldResInfo);
	}
	
	$("#orderType"+meansId).attr("disabled",true);
	$("#orderTypeInfo"+meansId).html(show_desc);
	var orderType = $("#orderType" + means).val();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H50.ORDER_TYPE_FLAG").set(orderType);
}
//Ӧ�ɽ��
function busi_infoFcon(pay_moneycould){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.BUSI_INFO.TOTAL_FEE").set(pay_moneycould);
}
//�ɷѷ�ʽ�������ĸ�ֵ
var H06_payBank = "";
var H06_payMonth = "";
function addPayTypeData(selectPayType, payBank, payMonth, montValue){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H06.PAY_TYPE_VALUE").set(selectPayType);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H06.PAY_BANK").set(payBank);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H06.PAY_MONTH").set(payMonth);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H06.MONTH_RATE").set(montValue);
	H06_payBank = payBank;
	H06_payMonth = payMonth;
}
//��ע
function note_infoFcon(pay_note){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.NOTE_INFO.PAY_NOTE").set(pay_note); 	
}
//�ֽ���
function addCashPay(){
	var PAY_TYPE=meansSelectedJson.find("H01.PAY_TYPE").value();
	var PAY_MONEY=meansSelectedJson.find("H01.PAY_MONEY").value();
	var START_TIME=meansSelectedJson.find("H01.START_TIME").value();
	if(START_TIME=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
	{
		START_TIME="";
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H01.CASH_PAY.PAY_TYPE").set(PAY_TYPE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H01.CASH_PAY.PAY_MONEY").set(PAY_MONEY); //Ӧ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H01.CASH_PAY.START_TIME").set(START_TIME);
}
//ר��
function assispCash(){
	var SUM_PAY_MONEY=0;
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02").addNode(sitechJson({tagName: "SPECIAL_FUNDS_LIST"}));
	}
	var elenum = meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST").returnChildSum ();
	for(var i=0;i<elenum;i++){    
		var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();
		var PAY_TYPE=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].PAY_TYPE").value();
		PAY_MONEY=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].PAY_MONEY").value();
		var VALID_FLAG=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].VALID_FLAG").value();
		var CONSUME_TIME=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].CONSUME_TIME").value();
		var ALLOW_PAY=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].ALLOW_PAY").value();
		var START_TIME=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].START_TIME").value();
		if(START_TIME=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
		{
			START_TIME="";
		}
		var RETURN_TYPE=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].RETURN_TYPE").value();
		var RETURN_CLASS=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].RETURN_CLASS").value();
		if(RETURN_TYPE=="û��ѡ�񵽽ڵ㣬�޷���ֵ"){
			RETURN_TYPE="";
		}
		if(RETURN_CLASS=="û��ѡ�񵽽ڵ㣬�޷���ֵ"){
			RETURN_CLASS="";
		}
		//�ɷ�����  add by zhou_wy ,date:2012-11-02
		var PAYMENT_TYPE=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].PAYMENT_TYPE").value();
		//������� add date:2015-01-07
		var RELATIVE_MONTH=meansSelectedJson.find("H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].RELATIVE_MONTH").value();
		if(RELATIVE_MONTH=="û��ѡ�񵽽ڵ㣬�޷���ֵ"){
			RELATIVE_MONTH="";
		}
		var b=PAY_TYPE.indexOf("(");
		var e=PAY_TYPE.indexOf(")");
		var PAY_TYPE_NAME=PAY_TYPE;
		PAY_TYPE=PAY_TYPE.substring(b+1,e);
		var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);
		Spe_info.find("PAY_TYPE").set(PAY_TYPE);
		Spe_info.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
		Spe_info.find("PAY_MONEY").set(PAY_MONEY);
		Spe_info.find("VALID_FLAG").set(VALID_FLAG);
		Spe_info.find("CONSUME_TIME").set(CONSUME_TIME);
		Spe_info.find("ALLOW_PAY").set(ALLOW_PAY);
		Spe_info.find("START_TIME").set(START_TIME);
		Spe_info.find("RETURN_TYPE").set(RETURN_TYPE);
		Spe_info.find("RETURN_CLASS").set(RETURN_CLASS);
		Spe_info.find("PAYMENT_TYPE").set(PAYMENT_TYPE);//�ɷ�����
		Spe_info.find("RELATIVE_MONTH").set(RELATIVE_MONTH);//ר����Ч�������
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").addNode(Spe_info);
		if(PAYMENT_TYPE != "2"){
			SUM_PAY_MONEY = Number(SUM_PAY_MONEY) + Number(PAY_MONEY);
		}
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SUM_FEE").set(SUM_PAY_MONEY);
	buildH02Flag = false;
}

//add zhangxy 20170217 Ӫ���ģ�汨�����
function buildTempletInfo(tmContentId, templetType){
	saleOrder.find("REQUEST_INFO.OPER_INFO.TM_CONTENT_ID").set(tmContentId);
	saleOrder.find("REQUEST_INFO.OPER_INFO.TEMPLET_TYPE").set(templetType);
}

//ͨ��ר������
function buildFundFeeXml(fpayTypeStr,fpayMoneyStr,fvalidFlagStr,fconsumeTimeStr,fallowPayStr,fstartTimeStr,freturnTypeStr,freturnClassStr,fpaymentTypeStr,frelativeMonthStr){
	var SUM_PAY_MONEY=0;
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02").addNode(sitechJson({tagName: "SPECIAL_FUNDS_LIST"}));
	}
	
	var fpayTypeStrs = fpayTypeStr.split("#");
	var fpayMoneyStrs = fpayMoneyStr.split("#");
	var fvalidFlagStrs = fvalidFlagStr.split("#");
	var fconsumeTimeStrs = fconsumeTimeStr.split("#");
	var fallowPayStrs = fallowPayStr.split("#");
	var fstartTimeStrs = fstartTimeStr.split("#");
	var freturnTypeStrs = freturnTypeStr.split("#");
	var freturnClassStrs = freturnClassStr.split("#");
	var fpaymentTypeStrs = fpaymentTypeStr.split("#");
	var frelativeMonthStrs = frelativeMonthStr.split("#");

	for(var i=0;i<fpayTypeStrs.length;i++){
		var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();		
		var b=fpayTypeStrs[i].indexOf("(");
		var e=fpayTypeStrs[i].indexOf(")");
		var PAY_TYPE_NAME=fpayTypeStrs[i];
		fpayTypeStrs[i]=fpayTypeStrs[i].substring(b+1,e);
		var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);
		Spe_info.find("PAY_TYPE").set(fpayTypeStrs[i]);
		Spe_info.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
		Spe_info.find("PAY_MONEY").set(fpayMoneyStrs[i]);
		Spe_info.find("VALID_FLAG").set(fvalidFlagStrs[i]);
		Spe_info.find("CONSUME_TIME").set(fconsumeTimeStrs[i]);
		Spe_info.find("ALLOW_PAY").set(fallowPayStrs[i]);
		Spe_info.find("START_TIME").set(fstartTimeStrs[i]);
		Spe_info.find("RETURN_TYPE").set(freturnTypeStrs[i]);
		Spe_info.find("RETURN_CLASS").set(freturnClassStrs[i]);
		Spe_info.find("PAYMENT_TYPE").set(fpaymentTypeStrs[i]);//�ɷ�����
		Spe_info.find("RELATIVE_MONTH").set(frelativeMonthStrs[i]);//ר����Ч�������
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").addNode(Spe_info);
		if(fpaymentTypeStrs[i] != "2"){
			SUM_PAY_MONEY = Number(SUM_PAY_MONEY) + Number(fpayMoneyStrs[i]);
		}
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SUM_FEE").set(SUM_PAY_MONEY);
}

var buildH02Flag = false;
function buildH02Ex(){
		var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();
		if("<%=act_type%>"=="77" || "<%=act_type%>"=="25"){
			Spe_info.find("PAY_TYPE").set("HJ");
		}else{
			Spe_info.find("PAY_TYPE").set("FB");
		}
		Spe_info.find("PAY_TYPE_NAME").set("��Լ�ƻ�����");
		Spe_info.find("PAY_MONEY").set("0");
		Spe_info.find("VALID_FLAG").set("0");
		Spe_info.find("CONSUME_TIME").set(res_undeadline);
		Spe_info.find("ALLOW_PAY").set("0");
		Spe_info.find("START_TIME").set("0");
		Spe_info.find("RETURN_TYPE").set("1");
		Spe_info.find("RETURN_CLASS").set("2");
		Spe_info.find("PAYMENT_TYPE").set("1");
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").addNode(Spe_info);
		buildH02Flag = true;
}
var H35_cost = 0;
//ȫ��ר��
function assispAllCash(){
	var SUM_PAY_MONEY=0;
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02").addNode(sitechJson({tagName: "SPECIAL_FUNDS_LIST"}));
	}
	var elenum = meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST").returnChildSum ();
	for(var i=0;i<elenum;i++){    
		var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();
		var PAY_TYPE=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].PAY_TYPE").value();
		var PAY_MONEY=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].PAY_MONEY").value();
		var VALID_FLAG=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].VALID_FLAG").value();
		var CONSUME_TIME=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].CONSUME_TIME").value();
		var ALLOW_PAY=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].ALLOW_PAY").value();
		var START_TIME=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].START_TIME").value();
		if(START_TIME=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
		{
			START_TIME="";
		}
		var RETURN_TYPE=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].RETURN_TYPE").value();
		var RETURN_CLASS=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].RETURN_CLASS").value();
		if(RETURN_CLASS=="û��ѡ�񵽽ڵ㣬�޷���ֵ"){
			RETURN_CLASS="";
		}
		//�ɷ�����  add by zhou_wy ,date:2012-11-02
		var PAYMENT_TYPE=meansSelectedJson.find("H34.ALL_SPECIAL_FUNDS_LIST.ALL_SPECIAL_FUNDS_INFO["+i+"].PAYMENT_TYPE").value();
		var b=PAY_TYPE.indexOf("(");
		var e=PAY_TYPE.indexOf(")");
		var PAY_TYPE_NAME=PAY_TYPE;
		PAY_TYPE=PAY_TYPE.substring(b+1,e);
		var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);
		Spe_info.find("PAY_TYPE").set(PAY_TYPE);
		Spe_info.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
		Spe_info.find("PAY_MONEY").set(PAY_MONEY);
		Spe_info.find("VALID_FLAG").set(VALID_FLAG);
		Spe_info.find("CONSUME_TIME").set(CONSUME_TIME);
		Spe_info.find("ALLOW_PAY").set(ALLOW_PAY);
		Spe_info.find("START_TIME").set(START_TIME);
		Spe_info.find("RETURN_TYPE").set(RETURN_TYPE);
		Spe_info.find("RETURN_CLASS").set(RETURN_CLASS);
		Spe_info.find("PAYMENT_TYPE").set(PAYMENT_TYPE);//�ɷ�����
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").addNode(Spe_info);
		if(PAYMENT_TYPE != "2"){
			SUM_PAY_MONEY = Number(SUM_PAY_MONEY) + Number(PAY_MONEY);
		}
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SUM_FEE").set(SUM_PAY_MONEY);
}

//����Ʒ
var gift_no_bak = "";//����ǰ����Ʒ����
var giftAward = "";//����Ʒ�Ƿ��н�
function salesPromotionGift(gife_no,gife_name,Strgoodssub,StrbusInsub){
	orderGift_Check=true;
	var GIFT_NO = gife_no;
	var AWARD_RATE=meansSelectedJson.find("H07.AWARD_RATE").value();//�н���
	var GetRandomn=Math.floor(Math.random()*100+1);
	if(AWARD_RATE>=GetRandomn){
		giftAward="Y";
	}else{
		giftAward="N";
	}
	var GIFT_MODEL=meansSelectedJson.find("H07.GIFT_MODEL").value();//��Ʒģʽ
	var GIFT_PRICE=meansSelectedJson.find("H07.GIFT_PRICE").value();
	var GIFT_NAME = gife_name;
	var GIFT_SOURCE=meansSelectedJson.find("H07.GIFT_SOURCE").value();//��Ʒ��Դ
	var CHK_LENGTH=meansSelectedJson.find("H07.CHK_LENGTH").value();//У��λ��
	gift_no_bak = GIFT_NO;
/**
	if(GIFT_MODEL=="1"){
		GIFT_NO = "P"+GIFT_NO;
	}
**/

	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.IS_AWARD").set(giftAward);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFT_MODEL").set(GIFT_MODEL);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFT_NO").set(GIFT_NO);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFT_NAME").set(GIFT_NAME);
	if(GIFT_MODEL=="1"){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFT_SOURCE").set("");
	}else{
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFT_SOURCE").set(GIFT_SOURCE);
	}
	if("û��ѡ�񵽽ڵ㣬�޷���ֵ" == CHK_LENGTH){
		CHK_LENGTH = "";
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.CHK_LENGTH").set(CHK_LENGTH);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFE_NUM").set("1");
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.GOODS_INFO").set(Strgoodssub);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.BUS_INFO").set(StrbusInsub);
	
}

//�ذ󸽼��ʷ�
function addBindingTraffic(){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H41.ADD_BINDING_LIST.ADD_BINDING_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H41.ADD_BINDING_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H41").addNode(sitechJson({tagName: "ADD_BINDING_LIST"}));
	}
	var elenum = meansSelectedJson.find("H41.ADD_BINDING_LIST").returnChildSum();
	for(var i=0;i<elenum;i++){
		var addBindingInfo=instanceTemplate["ADD_BINDING_INFO"]();
		var ADD_BINDING_CODE=meansSelectedJson.find("H41.ADD_BINDING_LIST.ADD_BINDING_INFO["+i+"].ADD_BINDING_CODE").value();
		var ADD_BINDING_NAME=meansSelectedJson.find("H41.ADD_BINDING_LIST.ADD_BINDING_INFO["+i+"].ADD_BINDING_NAME").value();
		addBindingInfo.find("ADD_BINDING_CODE").set(ADD_BINDING_CODE);
		addBindingInfo.find("ADD_BINDING_NAME").set(ADD_BINDING_NAME);//Ӫ������ʹ��
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H41.ADD_BINDING_LIST").addNode(addBindingInfo);
	}
}
//spҵ��
function SpBusinessfuc(show_sp_names,sp_names,sp_codes,biz_codes,valid_flags,consume_times,sp_systems,box_ids,spType,netcode){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.SP_INFO_LIST.SP_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.SP_INFO_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12").addNode(sitechJson({tagName: "SP_INFO_LIST"}));
	}
	
	var sp_nameStrs = sp_names.split("#");
	var sp_codeSTrs = sp_codes.split("#");
	var biz_codeStrs = biz_codes.split("#");
	var valid_flags = valid_flags.split("#");
	var consume_timeStrs = consume_times.split("#");
	var sp_systemStrs = sp_systems.split("#");
	var boxIds = box_ids.split("#");

	for(var i=0;i<sp_nameStrs.length;i++){
		var sp_info=instanceTemplate["SP_INFO"]();
		sp_info.find("SP_NAME").set(sp_nameStrs[i]);
		sp_info.find("SP_CODE").set(sp_codeSTrs[i]);
		sp_info.find("BIZ_CODE").set(biz_codeStrs[i]);
		sp_info.find("VALID_FLAG").set(valid_flags[i]);
		sp_info.find("CONSUME_TIME").set(consume_timeStrs[i]);
		sp_info.find("SP_SYSTEM").set(sp_systemStrs[i]);
		sp_info.find("BOX_ID").set(boxIds[i]);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.SP_INFO_LIST").addNode(sp_info);
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.SP_TYPE").set(spType);
	if("<%=act_type%>"=="147"){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.NET_CODE").set(netcode);//spԪ��147С��ѹ�����Ŀ������	}else{
	}
	$("#SPDetails"+meansId).html(show_sp_names);
	
}

//sp�е�ϵͳ��ֵ���⴦��
var global_get_winnings ="";
var global_winning_rates ="";
var global_pay_types ="";
var global_return_moneys ="";
var global_return_months ="";
var global_per_month_moneys ="";
var global_limit_moneys ="";
var global_return_types ="";
var global_return_classs ="";
var global_consume_times ="";
var global_pay_flags ="";
var global_assPhoneNos ="";
var global_sp_systems ="";

function addSpSystemPay(get_winnings,winning_rates,pay_types,return_moneys,return_months,per_month_moneys,limit_moneys,return_types,return_classs,consume_times,pay_flags,assPhoneNos,sp_systems){
	
	global_get_winnings = get_winnings;
	global_winning_rates = winning_rates;
	global_pay_types = pay_types;
	global_return_moneys = return_moneys;
	global_return_months = return_months;
	global_per_month_moneys = per_month_moneys;
	global_limit_moneys = limit_moneys;
	global_return_types = return_types;
	global_return_classs = return_classs;
	global_consume_times = consume_times;
	global_pay_flags = pay_flags;
	global_assPhoneNos = assPhoneNos;
	global_sp_systems = sp_systems;
	
}

function addSpSystemPayData(){

	if(global_get_winnings != ""){
		var isAwardStr=document.getElementById("isAward").value;//�Ƿ��н���
		var getWinningStrs = global_get_winnings.split("#");
		var winningRateStrs = global_winning_rates.split("#");
		var payTypeStrs = global_pay_types.split("#");
		var returnMoneyStrs = global_return_moneys.split("#");
		var returnMonthStrs = global_return_months.split("#");
		var perMonthMoneyStrs = global_per_month_moneys.split("#");
		var limitMoneyStrs = global_limit_moneys.split("#");
		var returnTypeSTrs = global_return_types.split("#");
		var returnClassStrs = global_return_classs.split("#");
		var consumeTimeStrs = global_consume_times.split("#");
		var payFlagStrs = global_pay_flags.split("#");
		var assPhoneNoStrs = global_assPhoneNos.split("#");
		var sp_systemsStrs = global_sp_systems.split("#");
	
		for(var i=0;i<payTypeStrs.length;i++){
			var OP_TIME="";
			var IS_AWARD=""//�Ƿ��н�
			var GetRandomn=Math.floor(Math.random()*100+1);
			var b=payTypeStrs[i].indexOf("(");
			var e=payTypeStrs[i].indexOf(")");
			var PAY_TYPE_NAME=payTypeStrs[i];
			payTypeStrs[i]=payTypeStrs[i].substring(b+1,e);
			var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);
			
			if(getWinningStrs[i] == "1"){
				if(winningRateStrs[i] >= GetRandomn){
					IS_AWARD="Y";
				}else{
					IS_AWARD="N";
				}
			}else{
				IS_AWARD="Y";
			}
			isAwardStr = isAwardStr+"#"+IS_AWARD;
			var systemPaysInfo=instanceTemplate["SYSTEM_PAYS_INFO"]();
			systemPaysInfo.find("PAY_TYPE").set(payTypeStrs[i]);
			systemPaysInfo.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
			systemPaysInfo.find("RETURN_MONEY").set(returnMoneyStrs[i]);
			systemPaysInfo.find("RETURN_MONTH").set(returnMonthStrs[i]);
			systemPaysInfo.find("PER_MONTH_MONEY").set(perMonthMoneyStrs[i]);
			systemPaysInfo.find("LIMIT_MONEY").set(limitMoneyStrs[i]);
			systemPaysInfo.find("OP_TIME").set("");
			systemPaysInfo.find("RETURN_TYPE").set(returnTypeSTrs[i]);
			systemPaysInfo.find("RETURN_CLASS").set(returnClassStrs[i]);
			systemPaysInfo.find("CONSUME_TIME").set(consumeTimeStrs[i]);
			systemPaysInfo.find("IS_AWARD").set(IS_AWARD);
			systemPaysInfo.find("PAY_FLAG").set(payFlagStrs[i]);
			systemPaysInfo.find("PAY_PHONE_NO").set(assPhoneNoStrs[i]);
			systemPaysInfo.find("SP_SYSTEM").set(sp_systemsStrs[i]);
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST").addNode(systemPaysInfo);
		}
		isAwardStr = isAwardStr.substring(1,isAwardStr.length);
		document.getElementById("isAward").value=isAwardStr;
	}
}

//�ۼ�����
function AbatementIntegral(vCurPoint,inputNum){
	var SCORE_VALUE=meansSelectedJson.find("H13.SCORE_VALUE").value();
	var numScore = SCORE_VALUE*inputNum;
	//alert(numScore);
	if(vCurPoint>=numScore){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H13.SCORE_VALUE").set(numScore);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H13.RES_NUM").set(inputNum);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H07.GIFE_NUM").set(inputNum);
		return true;
	}else{
		return false;
	}
}
//�ֻ�ƾ֤
function phoneCredence(){
	var GIFT_MODEL=meansSelectedJson.find("H07.GIFT_MODEL").value();//��Ʒģʽ 0Ϊ��Ʒ��1Ϊ���
	var MULTI_FLAG=meansSelectedJson.find("H08.MULTI_FLAG").value();
	var GIFT_TIME_LIMIT=meansSelectedJson.find("H08.GIFT_TIME_LIMIT").value();
	var SEND_PASS_FLAG=meansSelectedJson.find("H08.SEND_PASS_FLAG").value();
	var GIFT_TIME_MODE=meansSelectedJson.find("H08.GIFT_TIME_MODE").value();
	var GIFT_TIME_MONTH=meansSelectedJson.find("H08.GIFT_TIME_MONTH").value();
	//����������ֻ�ܶһ�һ��
	if(GIFT_MODEL == "1"){
		MULTI_FLAG = "1";
	}
	if("û��ѡ�񵽽ڵ㣬�޷���ֵ" == GIFT_TIME_LIMIT){
		GIFT_TIME_LIMIT = "";
	}
	if("û��ѡ�񵽽ڵ㣬�޷���ֵ" == GIFT_TIME_MONTH){
		GIFT_TIME_MONTH = "";
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.MULTI_FLAG").set(MULTI_FLAG);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.GIFT_TIME_LIMIT").set(GIFT_TIME_LIMIT);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.SEND_PASS_FLAG").set(SEND_PASS_FLAG);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.GIFT_TIME_MODE").set(GIFT_TIME_MODE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H08.GIFT_TIME_MONTH").set(GIFT_TIME_MONTH);
}
// ��Ʊ��ӡ���ͣ��ϴ��Ƿִ�
function nvoicePrintType(type){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H21.NVOICE_PRINT_TYPE").set(type);
}
//ע������
function sddConsiderations(){
	var NOTICE=meansSelectedJson.find("H23.NOTICE").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H23.NOTICE").set(NOTICE);
}
// ��ע
function addNotfunc(){
	var note = meansSelectedJson.find("H24.NOTE").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H24.NOTE").set(note);

}

// �˵��Ż�
function addBillDiscount(){
	var bill_discount_ratio = meansSelectedJson.find("H28.BILL_DISCOUNT_RATIO").value();
	var max_total_discount = meansSelectedJson.find("H28.MAX_TOTAL_DISCOUNT").value();
	var contract_period = meansSelectedJson.find("H28.CONTRACT_PERIOD").value();
	var is_mainfee_change = meansSelectedJson.find("H28.IS_MAINFEE_CHANGE").value();
	if("û��ѡ�񵽽ڵ㣬�޷���ֵ" == is_mainfee_change){
		is_mainfee_change = "1";
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H28.BILL_DISCOUNT_RATIO").set(bill_discount_ratio);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H28.MAX_TOTAL_DISCOUNT").set(max_total_discount);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H28.CONTRACT_PERIOD").set(contract_period);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H28.IS_MAINFEE_CHANGE").set(is_mainfee_change);
}

function addNotfuncs(){
	var note = "����Ӳ�����ע";
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H24.NOTE").set(note);
}

function addMessagefunc(){
	var message = meansSelectedJson.find("H27.MESSAGE").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H27.MESSAGE").set(message);
}

function addMessagefuncs(){
	var message = "����ӷ��Ͷ���Ԫ��";
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H27.MESSAGE").set(message);

}
function addOrderTypeData(selectPayType){
	var H10=meansFalg.charAt(9);
	var H11=meansFalg.charAt(10); 
	if( selectPayType == "1" && (H10 =="1" || H11 =="1")){
		showDialog("ԤԼ������Ӧ���ʷ����Ԫ�أ�����ϵ����Ա!!",0);
		return false;
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H33.ORDER_TYPE_VALUE").set(selectPayType);
}


function changeResourceUndeadline(RESOURCE_UNDEADLINE){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_UNDEADLINE").set(RESOURCE_UNDEADLINE);//�ն˲������
}


//�ն˱���
var res_undeadline = "";
var chooseRes = false;
var resourcecostprices = 0;
function clientData(resourceCostPrice,resourceFee,imei_code,cmit_date,quality_limit,resourceBrand,resourceModel,RESOURCE_RES_CODE,RESOURCE_BRAND_CODE,RESOURCE_COST_TOTAL,RESOURCE_COST_RAT,RESOURCE_UNDEADLINE,
	resourcePercent,resourceMonthPay,resourceDetail,res_contract_type,costAllowance,BillAllowance,opType,marketPrice,taxPercent,taxFee){
	
	//����������/�����̱���/��������
	var supplierName ="";
	var supplierCode ="";
	var resourceType ="";
	var resourceDetails = resourceDetail.split("#");
	if(resourceDetails.length >= 3){
		supplierName =resourceDetails[0]; 
		supplierCode =resourceDetails[1];
		resourceType =resourceDetails[2];
	}


	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_COST_PRICE").set(resourceCostPrice);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_FEE").set(resourceFee);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.IMEI_CODE").set(imei_code);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.DELIVERY_TIME").set(cmit_date);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.QUALITY_LIMIT").set(quality_limit);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_BRAND").set(resourceBrand);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_MODEL").set(resourceModel);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.SALE_NOTE").set("Ӫ���");
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_RES_CODE").set(RESOURCE_RES_CODE); //�ն��ͺŴ���	
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_BRAND_CODE").set(RESOURCE_BRAND_CODE);//�ն�Ʒ�ƴ���
	if("<%=act_type%>"!="117"){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_UNDEADLINE").set(RESOURCE_UNDEADLINE);//�ն˲������
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_PERCENT").set(resourcePercent);//�ն�ϵ������
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_MONTH_PAY").set(resourceMonthPay);//�ն��µ������Ѷ�
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.SUPPLIER_NAME").set(supplierName);//����������
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.SUPPLIER_CODE").set(supplierCode);//�����̴���
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RESOURCE_TYPE").set(resourceType);//��������
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.RES_CONTRACT_TYPE").set(res_contract_type);//�ն�����
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.COST_ALLOWANCE").set(costAllowance);//�ɱ�����
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.BILL_ALLOWANCE").set(BillAllowance);//���Ѳ���
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.OP_TYPE").set(opType);//opType
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.MARKET_PRICE").set(marketPrice);//��˰���
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.TAX_PERCENT").set(taxPercent);//˰��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.TAX_FEE").set(taxFee);//˰��
	res_undeadline = RESOURCE_UNDEADLINE;
	resourcecostprices = resourceCostPrice;
	chooseRes = true;
	if(score_type=="1"){
		counteractIntegral_Check = false;
	}
}
//���ʷ�
function Pri_FeeStr(PRI_FEE_CODE,DISTRI_FEE_CODE,PRI_FEE_NAME,DISTRI_FEE_NAME,kx_code_bunch,kx_habitus_bunch,kx_operation_bunch,
		kx_name_bunch,meansId,effDateStr,expDateStr,kx_stream_bunch,kx_begintime,kx_endtime,kx_distri_code,kx_distri_name){
	var	PRI_FEE_VALID=meansSelectedJson.find("H10.PRI_FEE_LIST.PRI_FEE_INFO.PRI_FEE_VALID").value();
	buildPriFeeXml(PRI_FEE_CODE, PRI_FEE_NAME, PRI_FEE_VALID, effDateStr, expDateStr,
			DISTRI_FEE_CODE, DISTRI_FEE_NAME, kx_code_bunch, kx_name_bunch, 
			kx_habitus_bunch, kx_operation_bunch, kx_stream_bunch, kx_begintime, kx_endtime,kx_distri_code,kx_distri_name);
	$("#priFee"+meansId).attr("disabled",true);
}

//ȫ�����ʷ�
function All_Pri_FeeStr(PRI_FEE_CODE,ALL_PAY_MONEY,DISTRI_FEE_CODE,PRI_FEE_NAME,DISTRI_FEE_NAME,kx_code_bunch,kx_habitus_bunch,kx_operation_bunch,kx_name_bunch,meansId,effDateStr,expDateStr,kx_stream_bunch,kx_begintime,kx_endtime){
	var	ALL_FEE_VALID=meansSelectedJson.find("H35.ALL_FEE_LIST.ALL_FEE_INFO.PRI_FEE_VALID").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_CODE").set(PRI_FEE_CODE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_NAME").set(PRI_FEE_NAME);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_VALID").set(ALL_FEE_VALID);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_EFFDATE").set(effDateStr);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_EXPDATE").set(expDateStr);//
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.DISTRI_FEE_CODE").set(DISTRI_FEE_CODE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.DISTRI_FEE_NAME").set(DISTRI_FEE_NAME);//Ӫ������ʹ��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_CODE_BUNCH").set(kx_code_bunch);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_NAME_BUNCH").set(kx_name_bunch);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_HABITUS_BUNCH").set(kx_habitus_bunch);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_OPERATION_BUNCH").set(kx_operation_bunch);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_STREAM_BUNCH").set(kx_stream_bunch);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_BEGINTIME_BUNCH").set(kx_begintime);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_ENDTIME_BUNCH").set(kx_endtime);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_DISTRI_CODE").set("");
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_DISTRI_NAME").set("");
	H35_cost = ALL_PAY_MONEY;
	resetCosts(meansId);
	$("#allFee"+meansId).attr("disabled",true);
}

//��������
var score_type = "";
function h14ScoreData(scoreValue,scoreMoney,scoreType){
	score_type = scoreType;
	document.getElementById("global_scoreValue").value=scoreValue;
	document.getElementById("global_scoreMoney").value=scoreMoney;
	if(scoreType=='3'){
		document.getElementById("global_netScoreMoney").value=scoreMoney;
	}
	var H09=meansFalg.charAt(8); 
	var H01=meansFalg.charAt(0);
	var c=document.getElementById("pay_moneycould").value;//�ܽ��
    /*������ڹ�������ǻ��ֵ��������� */
	if(H09=='1'&& scoreType=='1')
	{

		var taxPercent = meansSelectedJson.find("H09.TAX_PERCENT").value();
		if(taxPercent=="û��ѡ�񵽽ڵ㣬�޷���ֵ" || taxPercent=="N/A" || taxPercent=="")
		{
			taxPercent="0.17";
		}
		var pay_moneycouldclient = meansSelectedJson.find("H09.RESOURCE_FEE").value();
		var pay_moneycould=document.getElementById("pay_moneycouldhid").value;
		var b=parseFloat(pay_moneycouldclient)-parseFloat(scoreMoney);//�ۼ��������Ǯ
		var a=parseFloat(pay_moneycould)-parseFloat(pay_moneycouldclient);//ר���Ǯ
		
		//����ۼ�֮���˰��
		//alert("b="+b+"; taxPercent="+taxPercent+";pay_moneycouldclient="+pay_moneycouldclient);
		
		var taxFeeTemp =  Number(b)/(1+Number(taxPercent))*Number(taxPercent);//ԭ˰��
		var taxFee = taxFeeTemp.toFixed(2);//����֮��˰��
		var marketPrice = Number(b-taxFee).toFixed(2);//��˰���
		if(b>0){
			c=parseFloat(a)+parseFloat(b);
		}else{
			c=a;
		}
	//alert("marketPrice="+marketPrice+"; taxPercent="+taxPercent+"; taxFee="+taxFee);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.MARKET_PRICE").set(marketPrice);//��˰���
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.TAX_PERCENT").set(taxPercent);//˰��
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.TAX_FEE").set(taxFee);//˰��
	}
	/*��������ֽ����ǻ��ֵ����ֽ�*/
	if(H01=='1'&&scoreType=='2'){
		var pay_moneycould=document.getElementById("pay_moneycouldhid").value;
		var cashMoney=meansSelectedJson.find("H01.PAY_MONEY").value();
		var b = parseFloat(cashMoney)-parseFloat(scoreMoney);//�ֽ�- ���ֵ�����Ǯ = Ӧ�������ֽ��Ǯ 
		var a=parseFloat(pay_moneycould)-parseFloat(cashMoney);//ר���Ǯ
		if(b>0){
			c=parseFloat(a)+parseFloat(b);
		}else{
			c=a;
		}
	}
	document.getElementById("pay_moneycould").value=c;
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H14.SCORE_VALUE").set(scoreValue);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H14.CON_MONEY").set(scoreMoney);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H14.SCORE_TYPE").set(scoreType); //���ֵ�������
}
//����ר���
function assispecialData(){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H03.SPECIAL_FUNDS_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H03").addNode(sitechJson({tagName: "SPECIAL_FUNDS_LIST"}));
	}
	var elenum = meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST").returnChildSum ();
	for(var i=0;i<elenum;i++){    
		var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();
		var PAY_TYPE=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].PAY_TYPE").value();
		var PAY_MONEY=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].PAY_MONEY").value();
		var VALID_FLAG=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].VALID_FLAG").value();
		var CONSUME_TIME=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].CONSUME_TIME").value();
		var ALLOW_PAY=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].ALLOW_PAY").value();
		var START_TIME=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].START_TIME").value();
		if(START_TIME=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
		{
			START_TIME="";
		}
		var RETURN_TYPE=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].RETURN_TYPE").value();
		var RETURN_CLASS=meansSelectedJson.find("H03.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO["+i+"].RETURN_CLASS").value();
		if(RETURN_CLASS=="û��ѡ�񵽽ڵ㣬�޷���ֵ"){
			RETURN_CLASS="";
		}
		var b=PAY_TYPE.indexOf("(");
		var e=PAY_TYPE.indexOf(")");
		var PAY_TYPE_NAME=PAY_TYPE;
		PAY_TYPE=PAY_TYPE.substring(b+1,e);
		var PAY_TYPE_NAME=PAY_TYPE_NAME.substring(0,b);
		Spe_info.find("PAY_TYPE").set(PAY_TYPE);
		Spe_info.find("PAY_TYPE_NAME").set(PAY_TYPE_NAME);
		Spe_info.find("PAY_MONEY").set(PAY_MONEY);
		Spe_info.find("VALID_FLAG").set(VALID_FLAG);
		Spe_info.find("CONSUME_TIME").set(CONSUME_TIME);
		Spe_info.find("ALLOW_PAY").set(ALLOW_PAY);
		Spe_info.find("START_TIME").set(START_TIME);
		Spe_info.find("RETURN_TYPE").set(RETURN_TYPE);
		Spe_info.find("RETURN_CLASS").set(RETURN_CLASS);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H03.SPECIAL_FUNDS_LIST").addNode(Spe_info);
	}
}

function assispecialPhoneData(assPhoneNo){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H03.ASSI_PHONE_NO").set(assPhoneNo);
}
//��ӳ�Աר���
function addMemSpicialFunds(){
	var memPayType=meansSelectedJson.find("H30.MEM_PAY_TYPE").value();
	var memReturnType=meansSelectedJson.find("H30.MEM_RETURN_TYPE").value();
	var memConsumeTime=meansSelectedJson.find("H30.MEM_CONSUME_TIME").value();
	var memReturnClass = meansSelectedJson.find("H30.MEM_RETURN_CLASS").value();
	if(memReturnClass == "û��ѡ�񵽽ڵ㣬�޷���ֵ"){
		memReturnClass = "";
	}
	var mptstrs = memPayType.split("(");
	var mpt1 = mptstrs[0];
	var mpt2 = mptstrs[1].substr(0,mptstrs[1].length-1);
	var infostr = mpt2 + "," + mpt1 + "," + memConsumeTime + "," + memReturnType;
	if(memReturnClass != ""){
		infostr += "," + memReturnClass;
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H30.MEM_SPECIALFUNDS").set(infostr);
}

//��ӳ�Աϵͳ��ֵ����
function addMemSystemPay(){
	var memPayType=meansSelectedJson.find("H31.MEM_PAY_TYPE").value();
	var memReturnMoney=meansSelectedJson.find("H31.MEM_RETURN_MONEY").value();
	var memConsumeTime=meansSelectedJson.find("H31.MEM_CONSUME_TIME").value();
	var memReturnType=meansSelectedJson.find("H31.MEM_RETURN_TYPE").value();
	var memReturnClass = meansSelectedJson.find("H31.RETURN_CLASS").value();
	if(memReturnClass == "û��ѡ�񵽽ڵ㣬�޷���ֵ"){
		memReturnClass = "";
	}
	var mptstrs = memPayType.split("(");
	var mpt1 = mptstrs[0];
	var mpt2 = mptstrs[1].substr(0,mptstrs[1].length-1);
	var infostr = mpt2 + "," + mpt1 + "," + memReturnMoney + "," + memConsumeTime + "," + memReturnType;
	if(memReturnClass != ""){
		infostr += "," + memReturnClass;
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H31.MEM_SYSTEMPAY").set(infostr);
}

//��ӳ�Ա���뱨��
function addMemNumberData(orderMemXML){
	//alert("orderMemXML=" + orderMemXML);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H32.MEM_NUMBER").set(orderMemXML);
}

//-----------------hlj end --------------------------------

//��ѡ��ť״̬�����ı�ʱ�����
//BUSIINFO_LIST�����е�busiInfo�ڵ�
function clearJsonXml(){
	var count = saleOrder.findArr("REQUEST_INFO.BUSIINFO_LIST.BUSIINFO").length();
	//alert(count);
	if((count!='undefined')&&(count>0)){
		for(var i=0;i<count;i++){
			saleOrder.find("REQUEST_INFO.BUSIINFO_LIST.BUSIINFO").remove();
		}
	}
	saleOrder = instanceTemplate["SALEORDER"]();//hlj quyl
	buildH02Flag = false;
	chooseRes = false;
}

function addSelectGiftData(giftNO, giftName,Strgoodssub,StrbusInsub){
	$("#H07AwardRate"+means).val(giftName);
	$("#H07AwardRate"+means+"hidden").val(giftNO);
	//orderGift_Checkfuc();
	salesPromotionGift(giftNO, giftName,Strgoodssub,StrbusInsub);
}
//-----------------------------------------B42 ��Ա����ʷ�-----------------------------------------
var printStrH42 = "";
function buildB42XML(feeStr, showStr, printStr){
	isH42Check = true;
	$("#H42_show"+means).html(showStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.MEMBER_FEE").set(feeStr);
	printStrH42 = printStr;
}
//-----------------------------------------H15 ��Ա����-----------------------------------------
//��Աר���븽���ʷѵĿ�ʼʱ�� �̶�Ϊ0 �������Զ���ʱ������
var netCode = "";
var isH15Selected = false;
function buildH15XML(allMemberInfo, totalMoney, preNetFlag){
	if(!isH15Selected){
		$("#pay_moneycould").val(Number($("#pay_moneycould").val()) + Number(totalMoney));
		$("#pay_moneycouldhid").val(Number($("#pay_moneycouldhid").val()) + Number(totalMoney));
	}
	isH15Selected = true;
	//������Ϣ
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.MEM_EXT_INFO.PRE_NET_FLAG").set(preNetFlag);
	//��Ա����
	var memberInfos = allMemberInfo.split("@@");
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.MEMBER_INFO_LIST.MEMBER_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.MEMBER_INFO_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER").addNode(sitechJson({tagName: "MEMBER_INFO_LIST"}));
	}
	var memberForShow = "";
	var memberSplit = "";
	for(var i=0; i<memberInfos.length; i++){
		var memberInfo = memberInfos[i].split("|");
		var MEMBER_INFO = instanceTemplate["MEMBER_INFO"]();
		MEMBER_INFO.find("PHONE_NO").set(memberInfo[0]);
		MEMBER_INFO.find("MEM_TYPE").set(memberInfo[1]);
		if(memberInfo[1] == "B"){//ȡ��������H20ʹ��
			netCode = memberInfo[16];
			document.getElementById("global_netCode_temp").value=memberInfo[0];
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H12.NET_CODE").set(netCode);//ȫ�ֱ����������			
		}
		MEMBER_INFO.find("ID_NO").set(memberInfo[2]);
		MEMBER_INFO.find("CUST_ID").set(memberInfo[3]);
		MEMBER_INFO.find("GROUP_ID").set(memberInfo[4]);
		MEMBER_INFO.find("BRAND_ID").set(memberInfo[5]);
		MEMBER_INFO.find("FEE").set(memberInfo[6]);
		MEMBER_INFO.find("FEE_START").set(memberInfo[7]);
		MEMBER_INFO.find("FEE_END").set(memberInfo[8]);
		MEMBER_INFO.find("ADDFEE").set(memberInfo[9]);
		MEMBER_INFO.find("ADDFEE_START").set(memberInfo[10]);
		MEMBER_INFO.find("ADDFEE_END").set(memberInfo[11]);
		MEMBER_INFO.find("FUND").set(memberInfo[12]);
		MEMBER_INFO.find("SYSPAY").set(memberInfo[13]);
		MEMBER_INFO.find("FUND_VAL").set(memberInfo[14]);
		MEMBER_INFO.find("SYSPAY_VAL").set(memberInfo[15]);
		MEMBER_INFO.find("NET_CODE").set(memberInfo[16]);
		MEMBER_INFO.find("KX_CODE_BUNCH").set(memberInfo[17]);
		MEMBER_INFO.find("KX_NAME_BUNCH").set(memberInfo[18]);
		MEMBER_INFO.find("KX_HABITUS_BUNCH").set(memberInfo[19]);
		MEMBER_INFO.find("KX_OPERATION_BUNCH").set(memberInfo[20]);
		MEMBER_INFO.find("KX_INST_ID").set(memberInfo[21]);
		MEMBER_INFO.find("KX_START_TIME").set(memberInfo[22]);
		MEMBER_INFO.find("KX_END_TIME").set(memberInfo[23]);
		memberForShow += memberSplit + memberInfo[24];
		memberSplit = "<BR>";
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.MEMBER_INFO_LIST").addNode(MEMBER_INFO);
	}
	$("#member"+means).html(memberForShow);
	//���ʷ�
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FEE_LIST.MEMBER_FEE").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FEE_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER").addNode(sitechJson({tagName: "FEE_LIST"}));
	}
	var feeList = meansSelectedJson.find("H16.FEE_LIST").returnChildSum();
	for(var i=0; i<feeList; i++){
		var priFeeCode = meansSelectedJson.find("H16.FEE_LIST.FEE_INFO["+i+"].PRI_FEE_CODE").value();
		var priFeeName = meansSelectedJson.find("H16.FEE_LIST.FEE_INFO["+i+"].PRI_FEE_NAME").value();
		var priFeeValid = meansSelectedJson.find("H16.FEE_LIST.FEE_INFO["+i+"].PRI_FEE_VALID").value();
		var memberType = meansSelectedJson.find("H16.FEE_LIST.FEE_INFO["+i+"].MEMBER_TYPE").value();
		
		var MEMBER_FEE = instanceTemplate["MEMBER_FEE"]();
		MEMBER_FEE.find("FEE_CODE").set(priFeeCode);
		MEMBER_FEE.find("FEE_NAME").set(priFeeName);
		MEMBER_FEE.find("FEE_VALID").set(priFeeValid);
		MEMBER_FEE.find("MEM_TYPE").set(memberType);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FEE_LIST").addNode(MEMBER_FEE);
	}
	//�����ʷ�
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.ADD_FEE_LIST.MEMBER_ADD_FEE").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.ADD_FEE_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER").addNode(sitechJson({tagName: "ADD_FEE_LIST"}));
	}
	var addFeeList = meansSelectedJson.find("H17.ADDFEE_LIST").returnChildSum();
	for(var i=0; i<addFeeList; i++){
		var addFeeCode = meansSelectedJson.find("H17.ADDFEE_LIST.ADDFEE_INFO["+i+"].ADD_FEE_CODE").value();
		var addFeeName = meansSelectedJson.find("H17.ADDFEE_LIST.ADDFEE_INFO["+i+"].ADD_FEE_NAME").value();
		var addFeeTime = meansSelectedJson.find("H17.ADDFEE_LIST.ADDFEE_INFO["+i+"].ADD_FEE_TIME").value();
		var memberType = meansSelectedJson.find("H17.ADDFEE_LIST.ADDFEE_INFO["+i+"].ADD_FEE_TYPE").value();
		
		var MEMBER_ADD_FEE = instanceTemplate["MEMBER_ADD_FEE"]();
		MEMBER_ADD_FEE.find("ADD_FEE_CODE").set(addFeeCode);
		MEMBER_ADD_FEE.find("ADD_FEE_NAME").set(addFeeName);
		MEMBER_ADD_FEE.find("ADD_FEE_TIME").set(addFeeTime);
		MEMBER_ADD_FEE.find("MEM_TYPE").set(memberType);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.ADD_FEE_LIST").addNode(MEMBER_ADD_FEE);
	}
	//ר��
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FUND_LIST.MEMBER_FUND").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FUND_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER").addNode(sitechJson({tagName: "FUND_LIST"}));
	}
	var fundList = meansSelectedJson.find("H18.FUND_LIST").returnChildSum();
	for(var i=1; i<fundList; i++){
		var payTypeTmp = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].PAY_TYPE").value();
		var start=payTypeTmp.indexOf("(");
		var end=payTypeTmp.indexOf(")");
		var payType=payTypeTmp.substring(start+1,end);
		var payTypeName=payTypeTmp.substring(0,start);
		var consumeTime = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].CONSUME_TIME").value();
		var returnClass = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].RETURN_CLASS").value();
		var returnType = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].RETURN_TYPE").value();
		//var startTime = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].START_TIME").value();
		var validFlag = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].VALID_FLAG").value();
		var memberType = meansSelectedJson.find("H18.FUND_LIST.FUND_INFO["+i+"].MEMBER_TYPE").value();
		
		var MEMBER_FUND = instanceTemplate["MEMBER_FUND"]();
		MEMBER_FUND.find("PAY_TYPE").set(payType);
		MEMBER_FUND.find("PAY_TYPE_NAME").set(payTypeName);
		MEMBER_FUND.find("CONSUME_TIME").set(consumeTime);
		MEMBER_FUND.find("RETURN_CLASS").set(returnClass);
		MEMBER_FUND.find("RETURN_TYPE").set(returnType);
		MEMBER_FUND.find("START_TIME").set("0");
		MEMBER_FUND.find("VALID_FLAG").set(validFlag);
		MEMBER_FUND.find("PAYMENT_TYPE").set("1");
		MEMBER_FUND.find("MEM_TYPE").set(memberType);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.FUND_LIST").addNode(MEMBER_FUND);
	}
	//ϵͳ��ֵ
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.SYS_PAY_LIST.MEMBER_SYSPAY").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.SYS_PAY_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER").addNode(sitechJson({tagName: "SYS_PAY_LIST"}));
	}
	var sysPay = meansSelectedJson.find("H19.SYSPAY_LIST").returnChildSum();
	for(var i=1; i<sysPay; i++){
		var payTypeTmp = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].PAY_TYPE").value();
		var start=payTypeTmp.indexOf("(");
		var end=payTypeTmp.indexOf(")");
		var payType=payTypeTmp.substring(start+1,end);
		var payTypeName=payTypeTmp.substring(0,start);
		var consumeTime = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].CONSUME_TIME").value();
		var returnClass = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].RETURN_CLASS").value();
		var returnType = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].RETURN_TYPE").value();
		//var startTime = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].START_TIME").value();
		var validFlag = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].VALID_FLAG").value();
		var memberType = meansSelectedJson.find("H19.SYSPAY_LIST.SYSPAY_INFO["+i+"].MEMBER_TYPE").value();
		
		var MEMBER_SYSPAY = instanceTemplate["MEMBER_SYSPAY"]();
		MEMBER_SYSPAY.find("PAY_TYPE").set(payType);
		MEMBER_SYSPAY.find("PAY_TYPE_NAME").set(payTypeName);
		MEMBER_SYSPAY.find("CONSUME_TIME").set(consumeTime);
		MEMBER_SYSPAY.find("RETURN_CLASS").set(returnClass);
		MEMBER_SYSPAY.find("RETURN_TYPE").set(returnType);
		MEMBER_SYSPAY.find("START_TIME").set("0");
		MEMBER_SYSPAY.find("VALID_FLAG").set(validFlag);
		MEMBER_SYSPAY.find("PAY_FLAG").set("0");
		MEMBER_SYSPAY.find("OP_TIME").set("");
		MEMBER_SYSPAY.find("LIMIT_MONEY").set("");
		MEMBER_SYSPAY.find("PAY_PHONE_NO").set("");
		MEMBER_SYSPAY.find("IS_AWARD").set("Y");
		MEMBER_SYSPAY.find("MEM_TYPE").set(memberType);
		MEMBER_SYSPAY.find("RETURN_MONTH").set(consumeTime);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.MEMBER.SYS_PAY_LIST").addNode(MEMBER_SYSPAY);
	}
		//��ͥ��������
	
	var lowType = meansSelectedJson.find("H47.LOW_TYPE").value();
	var lowMoney = meansSelectedJson.find("H47.LOW_FEE").value();
	if(lowType != null && lowType != "" && 	lowType != "û��ѡ�񵽽ڵ㣬�޷���ֵ"){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H47.LOW_TYPE").set(lowType);
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H47.LOW_MONEY").set(lowMoney);
	}
	
}

//���ϵͳ��ֵ/����ۿ� 
function addBroadDiscountPay(){
	var BROAD_TYPE=meansSelectedJson.find("H20.BROAD_TYPE").value();
	var BROAD_SYSTEM_PAY=meansSelectedJson.find("H20.BROAD_SYSTEM_PAY").value();
	var BROAD_DISCOUNT_PAY=meansSelectedJson.find("H20.BROAD_DISCOUNT_PAY").value();
	if(BROAD_SYSTEM_PAY=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
	{
		BROAD_SYSTEM_PAY="";
	}
	if(BROAD_DISCOUNT_PAY=="û��ѡ�񵽽ڵ㣬�޷���ֵ")
	{
		BROAD_DISCOUNT_PAY="";
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H20.BROAD_TYPE").set(BROAD_TYPE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H20.BROAD_SYSTEM_PAY").set(BROAD_SYSTEM_PAY); 
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H20.BROAD_DISCOUNT_PAY").set(BROAD_DISCOUNT_PAY);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H20.NET_CODE").set(netCode);
}




//================================================�ʷ��ն˷��� start=========================================================


//�ʷ��ն˷���ƴ��ר��
function buildH05SPECIAL(PAY_MONEY,CONSUME_TIME,ALLOW_PAY,PAY_MONEYCOULD,validFlag){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST.SPECIAL_FUNDS_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02").addNode(sitechJson({tagName: "SPECIAL_FUNDS_LIST"}));
	}
	var Spe_info=instanceTemplate["SPECIAL_FUNDS_INFO"]();
	Spe_info.find("PAY_TYPE").set("CQ");
	Spe_info.find("PAY_TYPE_NAME").set("ǩԼ�����·�");
	Spe_info.find("PAY_MONEY").set(PAY_MONEY);
	Spe_info.find("VALID_FLAG").set(validFlag);
	Spe_info.find("CONSUME_TIME").set(CONSUME_TIME);
	Spe_info.find("ALLOW_PAY").set(ALLOW_PAY);
	Spe_info.find("START_TIME").set("0");
	Spe_info.find("RETURN_TYPE").set("1");
	Spe_info.find("RETURN_CLASS").set("3");
	Spe_info.find("PAYMENT_TYPE").set("1");//�ɷ�����
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SPECIAL_FUNDS_LIST").addNode(Spe_info);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H02.SUM_FEE").set(PAY_MONEY);
	document.getElementById("pay_moneycould").value=parseFloat(PAY_MONEYCOULD);
	document.getElementById("pay_moneycouldhid").value=parseFloat(PAY_MONEYCOULD);
}

//�ʷ��ն˷���ϵͳ��ֵ
function buildH05SYSTEM(PAY_MONEY,CONSUME_TIME,ALLOW_PAY,PAY_MONEYCOULD,validFlag){
	
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST.SYSTEM_PAYS_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04").addNode(sitechJson({tagName: "SYSTEM_PAYS_LIST"}));
	}
	var systemPaysInfo=instanceTemplate["SYSTEM_PAYS_INFO"]();
	systemPaysInfo.find("PAY_TYPE").set("DR");
	systemPaysInfo.find("PAY_TYPE_NAME").set("�����һ����");
	systemPaysInfo.find("RETURN_MONEY").set(PAY_MONEY);
	systemPaysInfo.find("RETURN_MONTH").set(CONSUME_TIME);
	systemPaysInfo.find("VALID_FLAG").set(validFlag);
	systemPaysInfo.find("PER_MONTH_MONEY").set(ALLOW_PAY);//ÿ�·������
	systemPaysInfo.find("LIMIT_MONEY").set("");//�������
	systemPaysInfo.find("OP_TIME").set("");
	systemPaysInfo.find("RETURN_TYPE").set("1");
	systemPaysInfo.find("RETURN_CLASS").set("2");
	systemPaysInfo.find("CONSUME_TIME").set(CONSUME_TIME);//ר���������
	systemPaysInfo.find("IS_AWARD").set("Y");
	systemPaysInfo.find("PAY_FLAG").set("0");//��� 0 ����
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H04.SYSTEM_PAYS_LIST").addNode(systemPaysInfo);
	document.getElementById("isAward").value="Y";
	document.getElementById("pay_moneycould").value=parseFloat(PAY_MONEYCOULD);
	document.getElementById("pay_moneycouldhid").value=parseFloat(PAY_MONEYCOULD);
}

//�ʷ��ն˷���ƴ�����е�������
function buildH05BankBuyRES(SERIAL_NO,CHARGE_AMOUNT,PRCNO,PRCMONEY,BANKFEE){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H05.SERIAL_NO").set(SERIAL_NO);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H05.CHARGE_AMOUNT").set(CHARGE_AMOUNT); 
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H05.ADD_FEE_CODE").set(PRCNO);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H05.ADD_FEE_MONEY").set(PRCMONEY); 
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H05.BANK_FEE").set(BANKFEE);
}
//================================================�ʷ��ն˷��� end=========================================================
//================================================�����Ӹ����ʷѵ����⴦�� start==================================================
var H11_effDateStr ="";

function addH11NetBindingFun(effDateStr){
	H11_effDateStr = effDateStr;
}
//================================================�����Ӹ����ʷѵ����⴦�� end==================================================
//---------------------------------------------H11 �����ʷ�---------------------------------------------
var H11_choose = false;
//ѡ�񸽼��ʷ�
function chooseAssifeeFun(){
	var H15 = meansFalg.charAt(14);
	if(H15 == '1' && !isH15Selected){
		showDialog("��������[��Ա��Ϣ]����ѡ��[�����ʷ�]!",0);
		return false;
	}
	var orderId = document.getElementById("login_accept").value;
	openDivWin("<%=request.getContextPath()%>/npage/se112/chooseAssifeeFun.jsp?meansId="+means+"&orderId="+orderId+"&H11_effDateStr="+H11_effDateStr+"&H15="+H15+"&svcNum=<%=svcNum%>&act_type=<%=act_type%>", "�����ʷ�", "700","300");
}
//ѡ��֮��洢
function saveAssFee(meansId, codes, feeNames, showNames, feeScores, orderStr,effDateStr,expDateStr,MNET_CODE, xqCodes, xqNames){
	H11_choose = true;
	//alert("�����ʷ�+��ѡ");
	$("#showAssifee"+meansId).html(showNames);
	buildAddFeeXml(codes, feeNames, feeScores, effDateStr, expDateStr, orderStr, xqCodes, xqNames);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.STATUS_CODE").set(orderStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.MNET_CODE").set(MNET_CODE);
}
function saveCardTypeCode(codes){
	$("#showCardCode"+meansId).html(codes);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H52.CARD_CODE").set(codes);
}

//-----------------------------------------�Ҹ���ͥ(��������������)-----------------------------------------
//����ҵ��ڵ�
function buildSpInfoXml(compCode, busiCode, effType, effTime, expTime){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.COMMON_SP_INFO.COMP_CODE").set(compCode);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.COMMON_SP_INFO.BUSI_CODE").set(busiCode);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.COMMON_SP_INFO.EFF_TYPE").set(effType);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.COMMON_SP_INFO.EFF_TIME").set(effTime);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.COMMON_SP_INFO.EXP_TIME").set(expTime);
}
//ͨ�����ʷѽڵ�
function buildPriFeeXml(priFeeCode, priFeeName, priFeeValid, priFeeEffTime, priFeeExpTime,
			compFeeCode, compFeeName, bindFeeCodeStr, bindFeeNameStr, bindFeeStateStr, 
			bindFeeValidStr, bindFeeInstStr, bindFeeEffStr, bindFeeExpStr,kx_distri_code,kx_distri_name){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_CODE").set(priFeeCode);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_NAME").set(priFeeName);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_VALID").set(priFeeValid);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_EFFDATE").set(priFeeEffTime);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.PRI_FEE_EXPDATE").set(priFeeExpTime);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.DISTRI_FEE_CODE").set(compFeeCode);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.DISTRI_FEE_NAME").set(compFeeName);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_CODE_BUNCH").set(bindFeeCodeStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_NAME_BUNCH").set(bindFeeNameStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_HABITUS_BUNCH").set(bindFeeStateStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_OPERATION_BUNCH").set(bindFeeValidStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_STREAM_BUNCH").set(bindFeeInstStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_BEGINTIME_BUNCH").set(bindFeeEffStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_ENDTIME_BUNCH").set(bindFeeExpStr);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_DISTRI_CODE").set(kx_distri_code);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H10.KX_DISTRI_NAME").set(kx_distri_name);
}
//ͨ�ø����ʷѽڵ�
function buildAddFeeXml(addFeeCodes, addFeeNames, addFeeScores, addFeeEffs, addFeeExps, addFeeOrders ,xqCodes, xqNames){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST.ADD_FEE_INFO").isNull())){
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST").remove();
		saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11").addNode(sitechJson({tagName: "ADD_FEE_LIST"}));
	}
	var xqCode="";
	var xqName="";
	if(addFeeCodes.length > 0){
		var code = addFeeCodes.split("#");
		var feeName = addFeeNames.split("#");
		var feeScore = addFeeScores.split("#");
		var effDate = addFeeEffs.split("#");
		var expDate = addFeeExps.split("#");
		if(xqCodes!=null&&xqNames!=null){
			xqCode=xqCodes.split("#");
			xqName=xqNames.split("#");
		}
		for(var i=0; i<code.length; i++){
			var addFeeInfo=instanceTemplate["ADD_FEE_INFO"]();
			addFeeInfo.find("ADD_FEE_CODE").set(code[i]);
			addFeeInfo.find("ADD_FEE_NAME").set(feeName[i]);
			addFeeInfo.find("ADD_FEE_SCORE").set(feeScore[i]);
			addFeeInfo.find("ADD_FEE_EFFDATE").set(effDate[i]);
			addFeeInfo.find("ADD_FEE_EXPDATE").set(expDate[i]);
			addFeeInfo.find("DISTRI_FEE_CODE").set(xqCode[i]);
			addFeeInfo.find("DISTRI_FEE_NAME").set(xqName[i]);
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.ADD_FEE_LIST").addNode(addFeeInfo);
		}
	}
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H11.STATUS_CODE").set(addFeeOrders);
}

function h22CustData(otherPhoneNo){
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H22.OTHER_CUST_INFO").set(otherPhoneNo);
}
function addScore(){
	var PAY_TYPE=meansSelectedJson.find("H49.PAY_TYPE").value();
	var b=PAY_TYPE.indexOf("(");
	var e=PAY_TYPE.indexOf(")");
	var PAY_TYPE_NAME=PAY_TYPE;
	PAY_TYPE=PAY_TYPE.substring(b+1,e);
	var SCORE_VALUE=meansSelectedJson.find("H49.SCORE_VALUE").value();
	var VALID_FLAG=meansSelectedJson.find("H49.VALID_FLAG").value();
	var CONSUME_TIME=meansSelectedJson.find("H49.CONSUME_TIME").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H49.PAY_TYPE").set(PAY_TYPE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H49.SCORE_VALUE").set(SCORE_VALUE);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H49.VALID_FLAG").set(VALID_FLAG);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H49.CONSUME_TIME").set(CONSUME_TIME);
}
var H42_choose = false;
var deductmoney = 0;
function buildScoreValueXml(scoreValue,giftCode,plantFlag,deductMoney,befBusiid){
	H42_choose = true;
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.SCORE_VALUE").set(scoreValue);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.GIFT_CODE").set(giftCode);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.PLANT_FLAG").set(plantFlag);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.DEDUCT_MONEY").set(deductMoney);
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H42.BEF_BUSIID").set(befBusiid);
	deductmoney = deductMoney;
}
function builCardXml(cardtype,cardno,cardcount){
	if(!(saleOrder.find("REQUEST_INFO.MEANS.MEAN.H48.SPECIAL_CARDS_LIST.SPECIAL_CARDS_INFO").isNull())){
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H48.SPECIAL_CARDS_LIST").remove();
			saleOrder.find("REQUEST_INFO.MEANS.MEAN.H48").addNode(sitechJson({tagName: "SPECIAL_CARDS_LIST"}));
	}
	if(cardtype.length>0){
	  var card_type = cardtype.split("#");
	  var card_no = cardno.split("#");
	  var card_count = cardcount.split("#");
	  for (var i=0; i<card_type.length-1; i++){
	  var systemCardsInfo=instanceTemplate["SPECIAL_CARDS_INFO"]();
	      systemCardsInfo.find("CARD_TYPE").set(card_type[i]);
	      systemCardsInfo.find("CARD_NO").set(card_no[i]);
	      systemCardsInfo.find("CARD_COUNT").set(card_count[i]);
	      systemCardsInfo.find("PHONE_NO").set("<%=svcNum%>");
	      systemCardsInfo.find("OCCUPY_ACCEPT").set("<%=orderId%>");
	      saleOrder.find("REQUEST_INFO.MEANS.MEAN.H48.SPECIAL_CARDS_LIST").addNode(systemCardsInfo);
	    }
	}
}

//Ѻ����
function addDeposit(){
	var DEPOSIT_TYPE=meansSelectedJson.find("H55.DEPOSIT_TYPE").value();
	var DEPOSIT_MONEY=meansSelectedJson.find("H55.DEPOSIT_MONEY").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H55.DEPOSIT.DEPOSIT_TYPE").set(DEPOSIT_TYPE);//Ѻ������
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H55.DEPOSIT.DEPOSIT_MONEY").set(DEPOSIT_MONEY); //Ѻ����
}

//����ħ�ٺ�
function addEleGift(){
	var ELE_GIFT_TYPE=meansSelectedJson.find("H53.ELE_GIFT_TYPE").value();
	var ELE_GIFT_MONEY=meansSelectedJson.find("H53.ELE_GIFT_MONEY").value();
	var ELE_GIFT_MONTH=meansSelectedJson.find("H53.ELE_GIFT_MONTH").value();
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H53.ELE_GIFT_TYPE").set(ELE_GIFT_TYPE);//���ͺͰ�����ȯ����
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H53.ELE_GIFT_MONEY").set(ELE_GIFT_MONEY); //���ͺͰ�����ȯ���
	saleOrder.find("REQUEST_INFO.MEANS.MEAN.H53.ELE_GIFT_MONTH").set(ELE_GIFT_MONTH); //���ͺͰ�����ȯ����
}


function buildGlobalNetInfo(gNetSmCode,gNetFlag){
	document.getElementById("global_netSmCode").value = gNetSmCode;
	document.getElementById("global_netFlag").value = gNetFlag;

}

/*ħ�ٺ�ҵ���ʶ */
function BuildSPNetFlag(gSPNetFlag){
	document.getElementById("global_spNetFlag").value = gSPNetFlag;
}

function setOperationNoteFun(note){
	document.getElementById("global_operationNote").value=note;
}

/*�ʷѷ������*/
function setAgreeFeeDesc(desc,gFeeNoteStr){
	//alert("desc2 ="+desc);
	//alert("gFeeNoteStr2 ="+gFeeNoteStr);
	document.getElementById("global_agreeFeeDesc").value = desc;
	document.getElementById("global_agreeFeeNote").value = gFeeNoteStr;
	//alert("desc3 ="+document.getElementById("global_agreeFeeDesc").value);
	//alert("gFeeNoteStr3 ="+document.getElementById("global_agreeFeeNote").value);
}

/*���ʷ����*/
function setFeeDetails(desc,gFeeNoteStr){
	document.getElementById("global_feeDesc").value = desc;
	document.getElementById("global_feeNote").value = gFeeNoteStr;
	//alert("desc3 ="+document.getElementById("global_agreeFeeDesc").value);
	//alert("gFeeNoteStr3 ="+document.getElementById("global_agreeFeeNote").value);
}

/*�����ʷ����*/
function saveAssFeeNote(desc,gFeeNoteStr){
	document.getElementById("global_AssiFeeDesc").value = desc;
	document.getElementById("global_AssiFeeNote").value = gFeeNoteStr;
}
function setNotice(oNotice){
        document.getElementById("global_Notice").value = oNotice;
}

var resFeeTemp = 0;
function saveResFee(temp){
	resFeeTemp = temp;
}
var scoreFeeTemp = 0;
function saveScoreFee(temp){
	scoreFeeTemp = temp;
}
</script>
