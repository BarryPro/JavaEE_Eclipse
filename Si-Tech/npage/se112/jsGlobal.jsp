<%
	//ȫ�ֱ�����ȫ�ֲ������js����
 %>
<script type="text/javascript">
/*
*ȫ�ֱ���˵��
*meansFalg---��ʶ����������λΪ1����������λΪ0��
*prods-------������Ʒlist������Ϊproduct������󣬷ֱ�Ϊprodid, prodname,prodprcid,prodprcname,effdate,expdate,
*prodid------��Ʒ��Ϣת���ı���
*means------��ǰ��ѡ��ťѡ�е��ֶ�ID
*cardNo------���ͽɷѿ��Ŀ��Ŵ�
*isPrue------�ж��Ƿ�Ԥ���
*resourceNo------���͵��ն˴���
*stagesIndex---------ѡ��ķ��·���������
*prodJsonBak -----------����Ӫ����ѡ���Ʒ�б���
*selectProdJsonStr------�Ѿ�ѡ��Ĳ�Ʒjson����������Ӫ����Ʒ������У����
*20101025���
*prodServOfferId ---------��Ʒ��ص�ServOfferId
*resServOfferId ---------��Դ��ص�ServOfferId
*scoreServOfferId ---------������ص�ServOfferId
*happyServOfferId-----------ϲ����ص�ServOfferId
*feeServOfferId -----------������ص�ServOfferId
*happyNodeValue -----------ϲ��ֵ����ҪʱAjax��ȡ
*printData------------------����Ӫ�������ӡ����
*meansSelectedJson----------��ѡ���Ӫ���ֶε�json���ݶ���
*stageEffdate -----------��ѡ��ķ��·�������Ч���ڻ���·������޸�Ȩ�޵��޸ĺ�����
*isClose ---------�Ƿ��һ�δ����رմ����¼�
*giftMsg ------����Ʒ��Ϣ������ʽΪ�� Ԥռ��ʶ;����Ʒ�ʷѱ�ʶ$����Ʒ�ʷ�����$��Ʒ���۵���$����|����Ʒ�ʷѱ�ʶ$����Ʒ�ʷ�����$��Ʒ���۵���$����
*effDateA01-------------����Ԥ�����Чʱ�䣬����Ч��˳��ʹ��
*effDateA10-------------���·�������Чʱ�䣬����Ч��˳��ʹ��
*feeCardArr-------------�мۿ���Ϣ���飬��������Ϊ�����ţ����ã���Դ����

//hlj����
*/	

var prodid ="";
var prods = new Array();
var feeCardArr = new Array();
var meansFalg = "";
var means = "";
var prodMsg = "0";//�޸�ֵ
var giftMsg = "-1";//�޸�ֵ
var cardNo = "-1";//�޸�ֵ
var resourceNo = "-1";//�޸�ֵ
var isAddScore = false;
var isAddProd = false;
var isAddFee = false; //�Ƿ��Ѿ�����˷���
var isPrue = false;
var saleOrder = instanceTemplate["SALEORDER"]();//hlj songjia
var root = instanceTemplate["ROOT"]();
var selectProdJsonStr ;
var prodJsonBak ;
var stageIndex = "-1";//ѡ��ķ��·���������
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

var payType_Check=false;		//����ר��
var specialfund_Check=false;	//�ɷѷ�ʽ
var valuableCard_Check=false;	//�мۿ�
var terminal_Check=false;		//�ն�
var mainTraffic_Check=false;	//���ʷ�
var counteractIntegral_Check=false;//��������
var UnificationPay=false;
var sysPay_Check=false;  //ϵͳ��ֵ
var memNumber_Check=false;  //��Ա����
var orderType_Check=false;  //��������
var orderGift_Check=false;  //����Ʒ
var mainAllTraffic_Check=false;	//ȫ�����ʷ�
var agreeMent_Check = false;	//��Լ�ʷ� 
var templet_Check = false;	//ģ��Ԫ��
var sp_Check=false;		//spҵ��
var card_Checkfuca = false;
var chooseCust = false;//��������ѡ��
var chooseOldRes = false;//�Ծɻ���
var chooseCardCode = false;//���Ӷһ���

//-------add by songjia for hlj-------------------
//�Ƿ����ɸ���ר���
var isAssisPecialfunds = false;
//�Ƿ�����ϵͳ��ֵ����
var isSystemPay = false;
//�Ƿ����ɽɷѷ�ʽ����
var  isPayType = false;
//�Ƿ������ն˱���
var isResource = false;
//�Ƿ����ɵ�������
var  isScore = false;
//xin ���ֶ����Ƿ�ʵ���Ƶ�����
var isRealName;
<%
String Sname_Status=(String) UserInfoMap.get("ELEMENT37")==null?"":(String) UserInfoMap.get("ELEMENT37");
System.out.println("Sname_Status=========ʵ����=============="+Sname_Status);
%>
//------------------------------------------------

/*****************set reset��������**********************/

//�������Ʒ��Ϣ������ҳ�����
function setGift(gift,itemName){
	giftMsg = gift;
	$("#resourceText"+means).text(itemName);
}

//����ĳ��Ӫ���ֶζ�Ӧ�Ŀ�ѡ����ֵ��Ʒ�ʷѱ�ʶ�б�
//���ֶε�ѡ��ť�ı�ʱ��ֵ����λ��
function setSelectProdValue(prodValues){
	prodid = prodValues;
}

//�����Ʒ��Ϣ������ҳ�����
function setProds(prodlist){
	prods = myClone(prodlist);
	isAddProd = true;
	var name = "parseProductName"+means;
	var prodName = getSelectedProd();
	document.getElementById(name).innerHTML = prodName;
	prodMsg = prods.length;
}

//�������ͽɷѿ���Ϣ
var innerStr = "";
function setCardNo(_cardNo,_cardFee,_resCode){

   var item = new Array(_cardNo,_cardFee,_resCode);
	feeCardArr.push(item);
	cardNo = _cardNo;
	if(_cardNo == "-1"){
		return;
		}
	
	 innerStr+= "���ţ�"+_cardNo+"����ֵ��"+_cardFee+"Ԫ.</br>";
	$("#feeCardSum"+means).html(innerStr);
}

function reSetVal(){
	$("#feeCardSum"+means).html(initCardFee);
	}

//�����ն���Ϣ
function setresourceNo(_resourceNo){
	resourceNo = _resourceNo;
}

//������ѡ��Ʒjson��
function setSelectProdJsonStr(_jsonStr){
	selectProdJsonStr = _jsonStr;
}

//��ȡ��ѡ��Ʒjson��
function getSelectProdJsonStr(){
	return selectProdJsonStr;
}

//��ȡ��ǰӪ���ֶ�json����
function getMeansSelectedJson(){
	return meansSelectedJson;
}


function addSitechNode(_tagname,_type,_val){
	return sitechJson({tagName: _tagname,type: _type,childNodes: [_val]});
}

 //����
function resetTab(){
 	clearChooseRule("-1");
 	$("#prdmodify").css("display","none");
 	//frm1147.reset();
 	$("#btnSave").attr("disabled","disabled");
 	//��ԭ�ɷѿ�
 	var sum = $("#feeCardSum"+means+"hidden").val();
	$("#feeCardSum"+means).text(sum);
	$("#priFee"+means).attr("disabled",false);
	$("#feeDetails"+means).text("");
	//��ԭ��Ʒ
	$("#parseProductName"+means).text("");
	//��ԭ����Ʒ
	$("#resourceText"+means).text("");
	//��ԭ���·���
	$("#stageDesc"+means).text("");
	reSetGlobalVar();
	//�������
	clearJsonXml();
	
 }

//�رհ�ť�¼�
function closeSale(){
	releasCardResource();
	isClose = false;
	window.close()
}

//ҳ���ʼ��ʱΪÿһ��radio��ӵ�������¼�
//Ϊ��ֹjs�����ӳٴ������д
// hlj ,��ʼ����ť����¼���songjia

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

//Ϊ����Ӫ���ֶ���������¼�
//�������ϸ��Ϣ�����ػ���չ��
//hlj չ��Ӫ�����ݹ���������ʽ songjia
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
 //�û���Ϣ�л�
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

//��������ȫ�ֱ���//hlj
function reSetGlobalVar(){
	//������ڴ���ռ�õ��ն����ݣ��ع�֮
	if(resourceNo != "-1"){
		getAjaxCheckSellEndsetNo(resourceNo);
		}
	 //�ͷſ���Դ
	 releasCardResource();
	 prodid ="";
	 prods = new Array();
	 meansFalg = "";
	 means = "";
	 prodMsg = "0";//�޸�ֵ
	 giftMsg = "-1";//�޸�ֵ
	 cardNo = "-1";//�޸�ֵ
	 resourceNo = "-1";//�޸�ֵ
	 isAddScore = false;
	 isAddProd = false;
	 isAddFee = false; //�Ƿ��Ѿ�����˷���
	 isPrue = false;
	 stageIndex = "-1";//ѡ��ķ��·���������
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
	 payType_Check=false;		//����ר��               
	 specialfund_Check=false;	//�ɷѷ�ʽ             
	 terminal_Check=false;		//�ն�                 
	 mainTraffic_Check=false;	//���ʷ�               
	 memNumber_Check=false;		//��Ա���� 
	 counteractIntegral_Check=false;    //��������   
	 orderType_Check=false;  //��������
	 orderGift_Check=false; 
	 sysPay_Check=false; //ϵͳ��ֵ
	 mainAllTraffic_Check=false;	//���ʷ�  
	 H11_choose = false;	//�����ʷ�  
	 H42_choose = false;	
	 agreeMent_Check = false;	//��Լ�ʷ�
	 templet_Check = false;	//ģ��Ԫ��
	 sp_Check=false;		//spҵ��
	 card_Checkfuca = false;
	 chooseCust = false;   //��������
	 chooseH54 = false;
	//$("#payTypeInfo"+means).html("");
	//document.getElementById("payTypeInfo"+means).innerHTML = "";
//	$("#B15DataCard"+means).text("");
	$("#payTypeInfo"+means).val("");
	

	 //��ԭ�ɷѿ�
 	var sum = $("#feeCardSum"+means+"hidden").val();
	$("#feeCardSum"+means).text(sum);
	//��ԭ��Ʒ
	$("#parseProductName"+means).text("");
	//��ԭ����Ʒ
	$("#resourceText"+means).text("");
	//��ԭ���·���
	$("#stageDesc"+means).text("");
	
}

// songjia update for hlj
//ר��
function showSpeFunDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/specialDispather.jsp?meansId="+means, "ר��Ԥ�����Ϣ", "700","300");
}

//����ר��
function showAssiSpeFun(){
	openDivWin("<%=request.getContextPath()%>/npage/se112/assispeDispather.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "����ר��Ԥ�����Ϣ", "700","300");
}
//ϵͳ��ֵ
function toSysPay(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/systemPayDispather.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "ϵͳ��ֵ", "700","380");
}
//���п����ڸ���
function chooPayType(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/payTypeDispather.jsp?meansId="+means, "���п����ڸ���", "700","300");
}
//������ʽ
function chooOrderType(){ 
	var H10=meansFalg.charAt(9);
	var H11=meansFalg.charAt(10); 
    openDivWin("<%=request.getContextPath()%>/npage/se112/orderTypeDispather.jsp?meansId="+means+"&H10="+H10+"&H11="+H11, "������ʽ", "700","300");
}
//�ϰ�����ȯ
function chooCardType(){ 
    openDivWin("<%=request.getContextPath()%>/npage/se112/cardTypeDispather.jsp?meansId="+means+"&imeiCode="+imeiCode+"&svcNum=<%=svcNum%>","�����ն˶һ���", "700","300");
}
//ģ��ѡ��
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
    openDivWin("<%=request.getContextPath()%>/npage/se112/templetDispather.jsp?meansId="+means+"&actId=<%=actId%>&orderId="+orderId+"&brandId=<%=brandId%>&id_no=<%=id_no%>&svcNum=<%=svcNum%>&mode_code=<%=mode_code%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&act_type=<%=act_type%>&selectMeansId=<%=selectMeansId%>&resourceMoney="+resourceMoney, "ģ��ҵ��", "700","300");
}

//�ն�
function chooResDetails(){
	
	/*����140С�࣬���жϱ���ѡ��H54ģ��Ԫ�غ󣬲���ѡ���ն�*/
	if("<%=act_type%>"=="140"||"<%=act_type%>"=="141"){
		if(!chooseH54){
			showDialog("140��141С���Ӫ�������ѡ��ģ��Ԫ�أ���ѡ���ն�!",0);
			return false;
		}
	}
	var H56 = meansFalg.charAt(55);
	if(H56 == '1' && !isH56Selected){
		showDialog("��������[ʹ�úͰ�����ȯ]Ԫ�أ���ѡ��[�ն�]Ԫ��!",0);
		return false;
	}
	
	chooseRes = false;
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/clientDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>&act_type=<%=act_type%>&resFeeTemp="+resFeeTemp+"&scoreFeeTemp="+scoreFeeTemp, "�ն���Ϣ", "700","300");
}
//���ӿ�
function chooseCards(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/cardsDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>", "�мۿ�", "700","300");
}
//��������
function chooH14Score(){
	/*
		��ȡ�ֽ�Ԫ�أ�������������������ֵ���ϸҳ���� 
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
		alert("��ȷ���ۼ����ֶһ�����������ȷ����");
		var reg=/^([1-9]\d*)$/;
		var inputNum = $("#H13Num" + means).val();
		var scoreValue =$("#subScores"+means).val();
		if(inputNum==null||inputNum==""){
			showDialog("������ۼ����ֶһ�����!",0);
			return false;
		}
		if(!reg.test(inputNum)){
			showDialog("�ۼ����ֶһ����������ʽ��������������!",0);
			return false;
		}
		subScore = scoreValue*inputNum;
	}
	var H09=meansFalg.charAt(8); 
	var resourcefee =""; 
	if(H09=='1'){
		resourcefee = meansSelectedJson.find("H09.RESOURCE_FEE").value();
		var scoreTypeTemp = meansSelectedJson.find("H14.IS_SCORE").value();//���ֵ�������
		//alert("scoreTypeTemp="+scoreTypeTemp);
 		if(!chooseRes && scoreTypeTemp=="1"){//����ǻ��ֵ����������Ҫ��ѡ���նˣ��ٽ��л��ֵ������� 
			showDialog("����ѡ���ն�Ԫ�أ���ʹ�û��ֵ���!",0);
			return false;
		} 
	}
    //xin isRealName�����Ƿ�ʵ����
	openDivWin("<%=request.getContextPath()%>/npage/se112/chooReScoreDispather.jsp?meansId="+means+"&vCurPoint=<%=vCurPoint%>&brandId=<%=brandId%>&gScore=<%=gScore%>&isRealName=<%=Sname_Status%>&subScore="+subScore+"&cashInfo="+cashInfo+"&resourcefee="+resourcefee, "��������", "700","300");
}
//���ۼ����ֵ�������Ϊ��
function subScoreDisable(){
	$("#H13Num" + means).attr("disabled","true");
}
//����������ѡ����Ϊ��
function subH14ScoreDisable(){
	$("#chooH14ScoreBtn" + means).attr("disabled","true");
}
//��sp ѡ��ť��Ϊ��
function subH12SPDisable(){
	$("#chooseSPDet" + means).attr("disabled","true");
}
//����ȫ���ն�imei
var imeiCode = "";
function putImeiCode(imeicode){
	imeiCode = imeicode;
}
//����Ʒ
function sysShowGife(){
	var H08=meansFalg.charAt(7);
	openDivWin("<%=request.getContextPath()%>/npage/se112/sysShowGifefoud.jsp?meansId="+means+"&H08="+H08, "����Ʒ", "700","300");
}
//�ۼ�����
function showScoreDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreDispather.jsp?meansId="+means, "������Ϣ", "700","300");
}
//���ʷ�ѡ��
function chooFeeDetails(){
	var inputNum = $("#priFee" + means).val();
	var netFlag = document.getElementById("global_netFlag").value;
	var H15 = meansFalg.charAt(14);
	if(H15 == '1' && !isH15Selected){
		showDialog("��������[��Ա��Ϣ]����ѡ��[���ʷ�]!",0);
		return false;
	}
	if(inputNum ==""){
		showDialog("��ѡ��һ�����ʷ��ٵ��ѡ��ť!!",0);
		return false;
	}
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/feeDispather.jsp?meansId="+means+"&orderId="+orderId+"&startTime="+H11_effDateStr+"&H15="+H15+"&netFlag="+netFlag+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>&act_type=<%=act_type%>", "�ʷ���Ϣ", "1000","500");
}

//��Լ�ʷ�ѡ��
function chooAgreeFee(){
	var orderId = document.getElementById("login_accept").value;
	var contracttime  = document.getElementById("global_contracttime").value;
	var validmode= meansSelectedJson.find("VALID_MODE").value();//��Ч��ʶ����Լ���ޣ�
    openDivWin("<%=request.getContextPath()%>/npage/se112/agreeFeeDispather.jsp?meansId="+means+"&orderId="+orderId+"&validmode="+validmode+"&contracttime="+contracttime+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>&act_type=<%=act_type%>&selectvalidMode=<%=selectvalidMode%>", "��Լ�ʷ���Ϣ", "700","300");
}

//�Ͱ�����ȯ���
function chooseH42(){
	var scornMoney= meansSelectedJson.find("H42.DEDUCT_MONEY").value();
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreMoneyInfo.jsp?meansId="+means+"&scornMoney="+scornMoney+"&svcNum=<%=svcNum%>", "�Ͱ�����ȯ", "700","200");
}
//ʹ�úͰ�����ȯ
var isH56Selected = false;
function chooseH56(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/scoreMoneyInfoNew.jsp?meansId="+means+"&svcNum=<%=svcNum%>", "�Ͱ�����ȯ(��)", "700","200");
}

//ѡ���Ծɻ���
function chooOrderTypeH50(){
	var orderType = $("#orderType" + means).val();
	if(orderType=="0"){
		showDialog("'�Ƿ��Ծɻ���'��ѡ�� '��' �ٵ��ѡ��ť!!",0);
		return false;
	}
	var pay_moneycould = document.getElementById("pay_moneycould").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooOldResDispather.jsp?meansId="+means+"&pay_moneycould="+pay_moneycould+"&svcNum=<%=svcNum%>&act_type=<%=act_type%>", "�Ծɻ�����Ϣ", "700","300");
}
//��ͥ�ʷ�ѡ��
function choofamilyPay(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/feeDispather.jsp?meansId="+means+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>", "�ʷ���Ϣ", "700","300");
}
//SPҵ��
function chooSPDetails(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/spDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>&innetMons=<%=innetMons%>&actType=<%=act_type%>", "SPҵ����Ϣ", "1000","300");
}
//�ֻ�ƾ֤
function chooseCredence(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/phoneCredenceDispather.jsp?meansId="+means, "�ֻ�ƾ֤ҵ����Ϣ", "700","300");
}
//ȫ��ר��
function showAllSpeFunDetails(){
    openDivWin("<%=request.getContextPath()%>/npage/se112/specialAllDispather.jsp?meansId="+means, "ȫ��ר��Ԥ�����Ϣ", "700","300");
}
//ȫ�����ʷ�
function chooseAllFee(){
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/chooseAllFee.jsp?meansId="+means+"&orderId="+orderId+"&brandId=<%=brandId%>&mode_code=<%=mode_code%>&id_no=<%=id_no%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&svcNum=<%=svcNum%>", "ȫ�����ʷ�", "700","300");
}

//�ذ󸽼��ʷ�
function showfeeBindingFun(){
	 openDivWin("<%=request.getContextPath()%>/npage/se112/bindingfeeDispather.jsp?meansId="+means, "�ذ󸽼��ʷ�", "700","300");
}

//��Ա����
var newNetCode = "<%=netCode%>";
var RETURN_CODE = "";
var RETURN_MSG = "";
function memberInfo(){
	//add date:20150730,У�������16 19����������spҵ���������ѡ��sp
	var H12=meansFalg.charAt(11);
	if(H12=='1' && ("<%=act_type%>"=="16" || "<%=act_type%>" == "19")){
		if(!sp_Check){
			showDialog("����ѡ��SPҵ���ٽ��г�Ա����!",0);
		 	return false;
		}
	}
	var spNetFlag = document.getElementById("global_spNetFlag").value;
	if(spNetFlag=="Y" && ("<%=act_type%>"=="16" || "<%=act_type%>" == "19")){
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/marketLimit.jsp","���Ժ�...");
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
		openDivWin("<%=request.getContextPath()%>/npage/se112/toMemberInfo.jsp?meansId="+means+"&orderId="+orderId+"&netCode="+newNetCode+"&actType=<%=act_type%>&svcNum=<%=svcNum%>", "��Ա����", "1000","700");

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
	openDivWin("<%=request.getContextPath()%>/npage/se112/toMemberInfo.jsp?meansId="+means+"&orderId="+orderId+"&netCode="+newNetCode+"&actType=<%=act_type%>&svcNum=<%=svcNum%>", "��Ա����", "1000","700");
} 


function getMemberInfo(){
	var myPacket = null;
	myPacket = new AJAXPacket("getNetCode.jsp","���Ժ�...");
	myPacket.data.add("custOrderId","<%=custOrderId%>");
	core.ajax.sendPacket(myPacket,doMemberInfo);
	myPacket = null;
}

function doMemberInfo(packet){
	RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	newNetCode = packet.data.findValueByName("netCode");
}


//�������� add by zhouwy date:20140711
function chooCustDetails(){
	chooseCust = false;
	var orderId = document.getElementById("login_accept").value;
    openDivWin("<%=request.getContextPath()%>/npage/se112/custInfoDispather.jsp?meansId="+means+"&orderId="+orderId+"&svcNum=<%=svcNum%>", "����������Ϣ", "700","300");
}

//submit�ύ��������--hlj�޸ı�
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
	var H35=meansFalg.charAt(34);//ȫ�����ʷ�
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
	    showDialog("4��1����3�ս��л���ϵͳ�������ڴ˼䲻��ʹ�û��֣��������ͻ���ʹ�û��ְ����4��4�պ��ٽ��а���",0);
		return false;
	}
	if(H01=='1'){
		addCashPay();	       //�ֽ�
	
	}
	if(H02=='1'){
		assispCash();          //ר��Ԥ���
	}
	//����Э������ act_type=15
	//���Ϊfalse��û��ƴFBר�����ҪbuildH02Ex()ƴ��
	if((!buildH02Flag) && ("<%=act_type%>"=="15" || "<%=act_type%>"=="77" || "<%=act_type%>"=="25")){
		buildH02Ex();
	}
	if(H03=='1'){
		if(!payType_Check){
			showDialog("��ѡ�񸱿�ר��!",0);
		 	return false;
		}
		assispecialData();
	}
	if(H04=='1'){
	  if(!sysPay_Check){
			showDialog("��ѡ��ϵͳ��ֵ!",0);
		 	return false;
	  }
	}
	if(H05=='1'){
	  if(!agreeMent_Check){
			showDialog("��ѡ���Լ�ʷ�!",0);
		 	return false;
	  }
	}
	if(H06=='1'){
	   if(!specialfund_Check){
			showDialog("��ѡ�����з��ڸ���!",0);
		 	return false;
		}
	}
	if(H07=='1'){
	   if(!orderGift_Check){
			showDialog("��ѡ�����Ʒ!",0);
		 	return false;
		}
		//salesPromotionGift();	//����Ʒ
	}
	if(H08=='1'){
		phoneCredence();    
	}
	if(H09=='1'){
		if(!terminal_Check){
			showDialog("��ѡ���ն�!",0);
		 	return false;
		}
	}
	if(H10=='1'){
		if(!mainTraffic_Check){
			showDialog("��ѡ�����ʷ�!",0);
		 	return false;
		}
	}
	if(H11=='1'){
		//additionTraffic();		//�����ʷ�
		if(!H11_choose){showDialog("��ѡ�񸽼��ʷ�",1);return -1;}
	}
	if(H42=='1'){
		if(!H42_choose){showDialog("��ѡ���ֶһ�����Ϣ",1);return -1;}
	}
	if(H56=='1'){
		if(!isH56Selected){showDialog("��ѡʹ�úͰ�����ȯ",1);return -1;}
	}
	if(H12=='1'){		//SPҵ��
		if(!sp_Check){
			showDialog("��ѡ��SPҵ��!",0);
		 	return false;
		}
		addSpSystemPayData();		
	}
	if(H13=='1'){
		var reg=/^([1-9]\d*)$/;
		var inputNum = $("#H13Num" + means).val();
		if(inputNum==null||inputNum==""){
			showDialog("������ۼ����ֶһ�����!",0);
			return false;
		}
		if(!reg.test(inputNum)){
			showDialog("�ۼ����ֶһ����������ʽ��������������!",0);
			return false;
		}
		if(!AbatementIntegral("<%=vCurPoint%>",inputNum))//�ۼ�����
		{
			showDialog("��ǰ���ֲ���!",0);
		 	return false;
		}
		//xin
		if("��ʵ��"=="<%=Sname_Status%>"){ 
			//System.out.println(Sname_Status+"============Sname_Status");
			showDialog("���ѽ���ʵ���ǼǺ󷽿ɽ��л��ֶһ�����!",0);
			return false;
		}
	}
	if(H14=='1'){
		if(!counteractIntegral_Check){
			showDialog("��ѡ���������!",0);
		 	return false;
		}
	}
	if(H15=='1'){
		if(!isH15Selected){
			showDialog("�����ó�Ա��Ϣ!",0);
		 	return false;
		}
	}
	if(H20=='1'){
		addBroadDiscountPay();
	}
	if(H21=='1'){
		var printType = meansSelectedJson.find("H21.NVOICE_PRINT_TYPE").value();
		if("1"==meansFalg.charAt(8)){
			nvoicePrintType(printType);	//��Ʊ��ӡ����
		}else{
			nvoicePrintType("0");
		}
	}else{
		nvoicePrintType("0");
	}
	if(H23=='1'){
		sddConsiderations();	//ע������
	}
	if(H24=='1'){
		addNotfunc();			//��ע
	} else{
		addNotfuncs();
	}
	if(H27=='1'){
		addMessagefunc();			//���Ͷ���
	} else{
		addMessagefuncs();
	}
	if(H28=='1'){
		addBillDiscount();	//�˵��Ż�
	}
	if(H33=='1'){
		if(!orderType_Check){
			showDialog("��ѡ�񶩹���ʽ!",0);
		 	return false;
		}
	}else{
		addOrderTypeData("0");
	}
	if(H34=='1'){
		assispAllCash();          //ȫ��ר��Ԥ���
	}
	//ȫ�����ʷ�
	if(H35=='1'){
		if(!mainAllTraffic_Check){
			showDialog("��ѡ�������ײ�!",0);
		 	return false;
		}
	} 
	if(H36 == "1"){
		if(!H36_choose){showDialog("��ѡ�������ײ�",1);return -1;}
	}
	if(H37 == "1"){
		if(!H37_choose){showDialog("��ѡ��Wlan",1);return -1;}
	}
	if(H38 == "1"){
		if(!H38_choose){showDialog("��ѡ������ҵ��",1);return -1;}
	}
	if(H39 == "1"){
		if(!H39_choose){showDialog("��ѡ���ն�",1);return -1;}
	} 
	if(H35=="1"){
		if(checkGroup()<0 ){
			return;
		}
	}
	if(H41=='1'){
		addBindingTraffic();		//�ذ󸽼��ʷ�
	}
	if(H43=='1'){
		buildH43XML();
	}
	if(H44=='1'){
		if($.trim($("#pay_moneycould").val()) != $.trim($("#H44value"+means).text())){
			showDialog("ʵ��Ԥ������Լ��Ԥ�����ȣ�����������!",1);
			return;			
		}
	}
	if(H22=='1'){
		if(!chooseCust){
			showDialog("��ѡ����������!",0);
		 	return false;
		}
	}
	if(H48=='1'){
		if(!card_Checkfuca){
			showDialog("��ѡ���мۿ�!",0);
		 	return false;
		}
	}
	if(H49=='1'){
		//xin
		if("��ʵ��"=="<%=Sname_Status%>"){ 
			//System.out.println(Sname_Status+"============Sname_Status");
			showDialog("��ʵ���ƿͻ��������ܻ��֣�����ǰ���й��ƶ�Ӫҵ������ʵ���Ǽ�!",0);
			return false;
		}
		addScore();	       //���ͻ���
	}
	
	if(H50=='1'){
		var orderType = $("#orderType" + means).val();
		if(!chooseOldRes && orderType=="1"){
			showDialog("��ѡ����ӡ��Ծɻ��¡����ͻ��߽����Ƿ��Ծɻ��¡���Ϊ����!",0);
		 	return false;
		}
	}
	if(H52=='1'){
		if(!chooseCardCode){
			showDialog("��ѡ����Ӷһ���!",0);
		 	return false;
		}
	}
	if(H54=='1'){
	  if(!templet_Check){
			showDialog("��ѡ��ģ����Ϣ!",0);
		 	return false;
	  }
	}
	if(H55=='1'){
		addDeposit();//Ѻ��
	
	}
	if(H53=='1'){
		addEleGift();//����ħ�ٺ�
	}

	if("<%=act_type%>"=="140" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "149"|| "<%=act_type%>" == "71"|| "<%=act_type%>" == "157"){
		if((H42=='1' && H05=='1')||(H54=='1' && H09=='1')||(H42=='1' && H09=='1')){
			if(parseFloat(deductmoney)>=parseFloat(resourcecostprices)){
				showDialog("�ֿ۵Ļ��ֵ���ȯ�����ڵ�����ѡ���͵��ն˲ɹ��ۣ���ѡ��͵�λ�ײͻ���ٺ�Լ�ڡ�",0);
				return false;
			}
		}
	}
	
	var pay_moneycould=document.getElementById("pay_moneycould").value;
 	if(pay_moneycould==null||pay_moneycould==""||pay_moneycould=="null"){
		showDialog("ϵͳӦ�����Ϊ�գ�������ѡ��û������ѡ������⽫���!",0);
	 	return false;
	}
	busi_infoFcon(pay_moneycould);//Ӧ���ɵ�Ǯ��
	var pay_note=document.getElementById("pay_note").value;//���ӱ�ע
	note_infoFcon(pay_note);//��ע��Ϣ
	if("<%=printAccept %>"=="N/A" || "<%=printAccept %>"=="n/a" || "<%=printAccept %>"=="" 
		|| "<%=printAccept %>"=="NULL" ||"<%=printAccept %>"=="null"){
		showDialog("ϵͳ������ˮ�������,�����½���ҳ�����!",0);
	 	return false;
	}
	//Ԥ�ύ����
	preSubmitForm();
}
//Ԥ�ύ����
function preSubmitForm(){
	$("#btnSave").attr("disabled","disabled");
	var saleorderStrs=saleOrder.toJson();
	var myPacket = null;
	myPacket = new AJAXPacket("preMessageOprateOder.jsp","���Ժ�...");
	myPacket.data.add("saleOrder",saleorderStrs);
	core.ajax.sendPacket(myPacket,preDoSubmit);
	myPacket = null;
}

var XML_STR = "";//���ö�������Ϊȫ�ֱ���
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
		showDialog('ȷ��Ҫ�ύ��Ϣ��?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
	}else{
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
 				showDialog('ȷ�ϵ��������',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
		}
		if(ret=="continueSub"){
	 			showDialog('ȷ��Ҫ�ύ��Ϣ��?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
		}
  	}else{
     showDialog('��ȷ��Ҫ�ύ��Ϣ��?',3,'retT=submitForm();retF=cancelAction();closeFunc=closeForm()');
  	}
	}
}

//�ύ����

function submitForm(){
	var myPacket = null;
	var score_type = meansSelectedJson.find("H14.IS_SCORE").value();//���ֵ�������
	var score_value = document.getElementById("global_scoreValue").value;
	var score_money = document.getElementById("global_scoreMoney").value;
	var net_code = document.getElementById("global_netCode_temp").value;
	var net_sm_code = document.getElementById("global_netSmCode").value;
	var net_flag = document.getElementById("global_netFlag").value;
	myPacket = new AJAXPacket("messageOprateOder.jsp","���Ժ�...");
	myPacket.data.add("XML_STR",XML_STR);
	
	myPacket.data.add("busiId","<%=printAccept %>");
	myPacket.data.add("chnType","<%=chanType%>");
	myPacket.data.add("opCode","g794");
	myPacket.data.add("loginNo","<%=login_no%>");
	myPacket.data.add("loginPwd","<%=password%>");
	myPacket.data.add("netCode",net_code);//�������
	myPacket.data.add("userPwd","");//�û����루����)
	myPacket.data.add("phoneChgNo","<%=svcNum%>");//�ֿۻ��ֵ��ֻ�����
	myPacket.data.add("scoreType",score_type);//�ֿ�����
	myPacket.data.add("scoreValue",score_value);//�ֿۻ���ֵ
	myPacket.data.add("scoreMoney",score_money);//�ֿ�Ǯ��
	myPacket.data.add("netSmCode",net_sm_code);//���Ʒ��
	myPacket.data.add("netFlag",net_flag);//�����ʶ
	
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
		alert("���ʷ�: <%=mode_name%>  ���Ϊ :"+priFee);
	}
	showDialog('�����ɹ�!',3,'retT=goNextActiond();retF=goNextActiond();closeFunc=goNextActiond()');
}


function goNextActiond(){
	 goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
}

function payType_Checkfuc(){
	payType_Check=true;	//����ר��         
}
function specialfund_Checkfuc(){ 
	specialfund_Check=true;	//�ɷѷ�ʽ     
}
function valuableCard_Checkfuc(){       
	valuableCard_Check=true;	//�мۿ�       
}    
function terminal_Checkfuc(){   
	terminal_Check=true;		//�ն�  
}
function oldRes_Checkfuc(){   
	chooseOldRes=true;		//�Ծɻ���
}
function agreeMent_Checkfuc(){   
	agreeMent_Check=true;		//�ʷ��ն˷��� 
}
function templet_Checkfuc(){   
	templet_Check=true;		//ģ��Ԫ�� 
	chooseH54=true;
}
function sp_Checkfuc(){   
	sp_Check=true;		//spҵ��
}
function mainTraffic_Checkfuc(){            
	mainTraffic_Check=true;	//���ʷ�   
}
function counteractIntegral_Checkfuc(){      
	counteractIntegral_Check=true;    //��������    
}
function viceSysPay_Checkfuc(){      
	sysPay_Check=true;    //ϵͳ��ֵ    
}
function memNumber_Checkfuc(){
	memNumber_Check=true;	//��Ա����         
}
function orderType_Checkfuc(){ 
	orderType_Check=true;	//������ʽ     
}
function mainAllTraffic_Checkfuc(){            
	mainAllTraffic_Check=true;	//ȫ�����ʷ�   
}
var netCodePrintStr = "";
function NET_CODE_FUC(desc){ 
	netCodePrintStr = desc;
	Net_code_Check=true;		//���
}
function card_Checkfuc(){
	card_Checkfuca = true;
}
function h22CustInfo_Checkfuc(){      
	chooseCust=true;//�������� 
}
function cardCode_Checkfuc(){   
	chooseCardCode=true;		//���Ӷһ���
}
function H56_Checkfuc(){   
	isH56Selected=true;		//ʹ�úͰ�����ȯ
}

//�ύǰ��ȡ������
function cancelAction(){
	if(resourceNo != "-1"){
		getAjaxCheckSellEndsetNo(resourceNo);
		releasCardResource();
	}
	window.location.reload(true);
}

function closeForm(){
	try{
		parent.insertCar('<%=contactId%>');//����Ϊ�Ӵ�ID
		parent.removeTab("<%=opCode%>");
	}catch(e){
		//window.close();
	}	
}

function reSubmitAct(){
	isClose = false;//�������رմ����¼�
		 if(checksubmit(frm1147)){
			showDialog('�Ƿ�ȷ���ύ?',3,'retT=submit();retF=cancelAction();closeFunc=closeForm()');
		}
}
//--songjia add for hlj 20100309
//����Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
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
	//ȡ�����ˮ
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
  var str = s.replace(/#/g, "��");
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
	 //�ͻ���Ϣ
	 var cust_info="";
   //����
	 var opr_info="";
	 //��ע
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 //�������ַ���
	 var retInfo = "";
		var meansNamerets=meansNameret();
		cust_info+="�ֻ����룺   "+document.all.user_phone_no.innerText+"|";
		cust_info+="�ͻ�������   "+document.all.user_cust_name.innerText;
		opr_info+="�û�Ʒ�ƣ�"+document.all.user_sm_name.innerText+"          ҵ�����ͣ�"+meansNamerets+"|";
		opr_info+="ҵ����ˮ��"+document.getElementById("login_accept").value+"|";
		//means 
		//�ֽ�
		var cashPay = $("#cashPay"+means).text();
		if(cashPay != ""){
			opr_info+="�ֽ�"+cashPay+"|";
		}
		//ר��Ԥ���
		var specialFunds = $("#specialFunds"+means).text();
		if(specialFunds != ""&&specialFunds!="null"){
			if("<%=act_type%>"=="70"){
				var values = "";
				var strs = specialFunds.split("��");
				for(var k=0; k<strs.length; k++) {
					if(strs[k].indexOf("��������") < 0) {
						values += strs[k] + "��";
					}
				}
				opr_info+="ר��Ԥ��"+values.substring(0, (values.length - 1))+"|";
				//alert(values.substring(0, (values.length - 1)));
			}else{
				opr_info+="ר��Ԥ��"+specialFunds+"|";
		    }
    }

		//����ר��
		var showAssiSpe = $("#showAssiSpe"+means).text();
		if(showAssiSpe != ""&&showAssiSpe!="null"){
			opr_info+="����ר�"+showAssiSpe+"|";
		}
		//ϵͳ��ֵ
		var isAward = document.getElementById("isAward").value;
//		alert(isAward);
		if(isAward != ""){
		 	var isAwards = isAward.split("#");
		    var systemPay = $("#systemPay"+means).text();
		    if(systemPay != ""&&systemPay!="null"){
		   		 opr_info+="ϵͳ��ֵ:"+systemPay+"|";
		    }
		    for(var i =0;i<isAwards.length;i++){
			     if(isAwards[i] == "Y"){
					if(systemPay != "" && systemPay!="null"){
						opr_info+="ϵͳ��ֵ"+(i+1)+": ���û����н�|";
					}
			     }
			}
		}
		
		var H07=meansFalg.charAt(6); 
		if(H07=='1'){
			var awardRate = $("#H07AwardRate"+means).val();
			if(awardRate != ""&&awardRate!="null"){
				opr_info+="��Ʒ���ƣ�"+awardRate+"|";
			}
			if(giftAward == "N"){
				opr_info+="���û�δ�н�|";
			}
		}
		
		//�мۿ�
		var cardType = $("#cardType"+means).text();
		if(cardType != ""&&cardType!="null"){
			opr_info+="�мۿ���"+cardType+"|";
		}
		//�ն�
		var resourceDetails = $("#resourceDetails"+means).text();
		if(resourceDetails != ""&&resourceDetails!="null"){
			var imei_code = saleOrder.find("REQUEST_INFO.MEANS.MEAN.H09.IMEI_CODE").value(); 
			opr_info+="�նˣ�"+resourceDetails+"|";
			opr_info+="�ն�IMEI��"+imei_code+"|";
		}
		//���ʷ�feeDetails
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
		
		//�����ʷ�showAssifee
		var showAssifee = document.getElementById("global_AssiFeeDesc").value;
		//alert("showAssifee = "+showAssifee);
		//var showAssifee = $("#showAssifee"+means).text();
		if(showAssifee != ""&&showAssifee!="null"){
			
			if(showAssifee.length>500 && showAssifee.length<1000){
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500)+"|";
				}else{
					opr_info+="�����ʷѣ�"+showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500)+"|";
				}
				
			}else if(showAssifee.length>1000 && showAssifee.length<1500){
				
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000)+"|";
				}else{
					opr_info+="�����ʷѣ�"+showAssifee.substr(0,500)+"|";
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
					opr_info+="�����ʷѣ�"+showAssifee.substr(0,500)+"|";
					opr_info+=showAssifee.substr(500,1000)+"|";
					opr_info+=showAssifee.substr(1000,1500)+"|";
					opr_info+=showAssifee.substr(1500)+"|";
				}
			}else{
				if("<%=act_type%>"=="71"){
					opr_info+=showAssifee+"|";
				}else{
					opr_info+="�����ʷѣ�"+showAssifee+"|";
				}
			}
			
			<%-- if("<%=act_type%>"=="71"){
				opr_info+=showAssifee+"|";
			}else{
				opr_info+="�����ʷѣ�"+showAssifee+"|";
			} --%>
		}
		
		var assiFeeNote = document.getElementById("global_AssiFeeNote").value;
		//alert("assiFeeNote="+assiFeeNote);
		if(assiFeeNote != ""&& assiFeeNote!="null"){
			opr_info+=assiFeeNote+"|";
		}
		
		//SPҵ��SPDetails
		var SPDetails = $("#SPDetails"+means).text();
		if(SPDetails != ""&&SPDetails!="null"){
			opr_info+="SPҵ��"+SPDetails+"|";
		}
		//�ۼ�����subScore
		var subScores = $("#subScores"+means).text();
		if(subScores != ""){
			opr_info+="�ۼ����֣�"+subScores+"|";
		}
		//��������b14Score	
		var h14Score = $("#H14Score"+means).text();
		if(h14Score != ""&&h14Score!="null"){
			opr_info+="�������֣�"+h14Score+"|";
		}
		//���ͻ���H49Score	
		var H49Score = $("#H49Score"+means).text();
		if(H49Score != ""&&H49Score!="null"){
			opr_info+=H49Score+"|";
		}
		//���ͻ���h42Show	
		var h42Show = $("#H42_show"+means).text();
		if(h42Show != ""&&h42Show!="null"){
			opr_info+=h42Show+"|";
		}
		//���п����ڸ���	
		var payTypeInfo = $("#payTypeInfo"+means).text();
		if(payTypeInfo != ""&&payTypeInfo!="null"){
			opr_info+="���п����ڸ��"+payTypeInfo+"|";
		}
		var orderType =  saleOrder.find("REQUEST_INFO.MEANS.MEAN.H33.ORDER_TYPE_VALUE").value();
		if("û��ѡ�񵽽ڵ㣬�޷���ֵ" != orderType){
		   if(orderType == "1"){
		   	 opr_info+="�������ͣ�ԤԼ����|";
		   }
		}
		//��Աר����ӿ��Ӫ������
		if(printStrH32 != ""){
			opr_info += "��Աר�"+printStrH32+"|";
		}
		//����˺�(���Ӫ����)
		if(netCodePrintStr != ""){
			opr_info += netCodePrintStr+"|"; 
		}
		//��Լ�ʷѷ���
		
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
		
		//ģ������
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
				opr_info+="ע�����"+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500)+"|";
			}else if(attention.length>1000 && attention.length<1500){
				opr_info+="ע�����"+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500,1000)+"|";
				opr_info+=attention.substr(1000)+"|";
			}else if(attention.length>1500 && attention.length<2000){
				opr_info+="ע�����"+attention.substr(0,500)+"|";
				opr_info+=attention.substr(500,1000)+"|";
				opr_info+=attention.substr(1000,1500)+"|";
				opr_info+=attention.substr(1500)+"|";
			}else{
				opr_info+="ע�����"+attention+"|";
			}
			//opr_info+="ע�����"+attention+"|";
		}	
		var gudingz = "����";
		if(gudingz != ""&&gudingz!="null"){
			opr_info+="������"+gudingz+"|";
		}
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


function closeForm1(){
	window.location.reload(true);
}
//-----------------------------------------B32 ��Աר��-----------------------------------------
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
			document.getElementById("showAllFee" + means).innerHTML = "��ǰ���ʷѣ�<%=mode_code%>_<%=mode_name%>";
			$("#allPriFee"+means).attr("disabled","disabled");
			$("#showAllFeeButton"+means).attr("disabled","disabled");
			mainAllTraffic_Check=true;
		}else{
			obj.value="H35.SHOW.TRUE";
			showDialog("��ǰ���ʷѲ����ʷ����ñ��У���Ҫ������ʷ�!",1);
		}
	}else{
		document.getElementById("showAllFee" + means).innerHTML="";
		$("#allPriFee"+means).removeAttr("disabled");
		$("#showAllFeeButton"+means).removeAttr("disabled");
		mainAllTraffic_Check=false;
	}
		resetCosts(means);
}
function submit_disabled(){//�мۿ����ӻ�ѡ��ť����
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
    //4��1�յ�4��4�� 7�� �����ܰ���
	if((myDate >= $startDate) && (myDate <= $endDate)){
	   return false;
	 }
	return true;
}

</script>
