<%
	//全局变量和全局操作相关js函数
 %>
<script type="text/javascript">
/*
 * 校验调用获取订购信息服务是否执行成功
 */
function checkServiceRtn(){
	if("<%=actInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("订购基本信息获取失败:<%=actInfoRtnMsg%>!",0);
		return false;
	}else if("<%=feeInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("费用信息获取失败:<%=feeInfoRtnMsg%>!",0);
		return false;
	}else if("<%=resInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("资源信息获取失败:<%=resInfoRtnMsg%>!",0);
		return false;
	}else if("<%=prodInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("资费信息获取失败:<%=prodInfoRtnMsg%>!",0);
		return false;
	}else if("<%=cancelRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("新资费获取失败:<%=cancelRtnMsg%>!",0);
		return false;
	}else if("<%=netRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("宽带标识获取失败:<%=netRtnMsg%>!",0);
		return false;
	}else if("<%=netScoreRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("积分抵消宽带包年款信息获取失败:<%=netScoreRtnMsg%>!",0);
		return false;
	}else if("<%=codeTemp%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("查询主资费可选资费失败:<%=msgTemp%>!",0);
		return false;
	}
}

function doSub(){
	checkServiceRtn();
	printDetail();
}

function printDetail(){
	var note = $("#note").val();
	if(note==null||note==""||note=="null"){
			showDialog("请填写备注!",0);
		 	return false;
	}
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  	if(typeof(ret)!="undefined"){
	  if((ret=="confirm")){
	  			$("#qry").attr("disabled","disabled");
 				showDialog('确认电子免填单吗？',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
		}
		if(ret=="continueSub"){
				$("#qry").attr("disabled","disabled");
	 			showDialog('确认要提交信息吗?',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
		}
  	}else{
	 	 $("#qry").attr("disabled","disabled");
	     showDialog('请确认要提交信息吗?',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
  	}
}


var tempnm="";				   		//临时操作变量
var resFee = "";              		//补购机款
var giftFee = "";  					//补促销品款
var scoreFee = "";            		//补积分款
var resFeeChange = 0;         		//补购机款 金额,单位分
var giftFeeChange = 0;        		//补促销品款,金额,单位分
var scoreFeeChange = 0;  			//补积分款,金额,单位分
var resType = "";             		//补购机款类型
var giftType = "";           		//补促销品款类型
var note = "";					 	//备注
var addFeeCodeTemp = "";			//附加资费代码串,用#分隔
var addFeeNameTemp = "";			//附加资费名称串,用#分隔
var allPaysTemp = "";				//专款总金额，小写
var allPayTypesTemp = "";			//专款费用类型串，用#分隔
var allPayNamesTemp = "";			//专款名称串，用#分隔
var allPayMoneysTemp = "";			//专款费用串，用#分隔
var allPayRtnTypesTemp = "";		//专款返还方式串，用#分隔
var allPayRtnClassesTemp = "";		//专款返还类型串，没有的用~占位
var allPayFactorTensTemp = "";		//专款家长标识，用#分隔
var allPayFactorElevensTemp = "";	//家长和成员以及副卡号码,用#分隔
var allFactorTwelve = "";			//专款方式串，用#分隔
var allFactorNineteensTemp = "";	//专款办理方式串，用#分隔

var sysPayTypeNameTemp = "";		//系统充值名称串,用#分隔
var sysPayTypeTemp = "";			//系统充值类型串,用#分隔
var sysPayMoneysTemp = "";			//系统充值费用串,用#分隔
var sysRtnTypeTemp = "";			//系统充值返还方式串,用#分隔
var sysRtnClassTemp = "";			//系统充值返还类型串,用#分隔,没有的用~占位
var sysFactorTenTemp = "";			//0：家长 ；1：成员；2：副卡个人订购传0,用#分隔
var sysFactorElevenTemp = "";		//家长和成员以及副卡号码串,用#分隔
var sysFactorFourteenTemp = "";		//系统充值是否中奖串,用#分隔
var sysFactorFifteenTemp = "";		//0：主卡；1：副卡；2：主卡和副卡,用#分隔
var sysFactorsixteenTemp = "";		//系统充值副卡号码串,用#分隔
var sysFactorNineteenTemp = "";		//生效方式串,用#分隔
var sysFactorTwentysixTemp = "";    //标识是SP新权益业务还是普通系统充值，1-新权益，其它正常系统充值

var spCodeTemp = "";
var busiCodeTemp = "";
var startDateTemp = "";
var endDateTemp = "";
var boxIdTemp = "";

var pay_moneycould = 0;
var pay_moneyBig="";
var allPaysBig = "";

var addFeeEffDate = "";//附加资费开始时间串,用#分隔
var addFeeExpDate = "";//附加资费结束时间串,用#分隔
var instIdTemp = "";//附加资费资费实例串,用#分隔
var iPhoneNoStr = "";//附加资费成员手机号码串,用#分隔
var iPhoneTypeNoStr = $("#phoneNoStrType").val();;//附加资费手机类型,用#分隔
var cancel_rtn = true;
var cancel_rtn2 = true;
var cancel_rtn3 = true;

var vFlag = "";//2奖品未冲正。
var choosType = "";//1退还促销品0不退还促销品


function doSubmit(){
	
	 if("<%=opCode%>"=="g798"){
		choosType = trim($("#choosType").val());
	 }
	 
	 if("<%=opCode%>"=="g796"){
		 resFee = trim($("#resFee").val());
		 giftFee = trim($("#giftFee").val());
		 scoreFee = trim($("#scoreFee").val());
		 resType = trim($("#resModel").val());
		 giftType = trim($("#gfitModel").val());
	 }else if ("<%=opCode%>"=="g798" && choosType == "1"){
	 	 giftFee = trim($("#giftFee").val());
	 	 giftType = trim($("#gfitModel").val());
	 }
	 note = $("#note").val();

	 addFeeCodeTemp = $("#addFeeCodeTemp").val();
	 addFeeNameTemp = $("#addFeeNameTemp").val();
	 
	 //****专款信息begin *******//
	 allPaysTemp = $("#allPaysTemp").val();
	 allPayTypesTemp = $("#allPayTypesTemp").val();
	 allPayNamesTemp = $("#allPayNamesTemp").val();
	 allPayMoneysTemp = $("#allPayMoneysTemp").val();
	 allPayRtnTypesTemp = $("#allPayRtnTypesTemp").val();
	 allPayRtnClassesTemp = $("#allPayRtnClassesTemp").val();
	 allPayFactorTensTemp = $("#allPayFactorTensTemp").val();
	 allPayFactorElevensTemp = $("#allPayFactorElevensTemp").val();
	 allFactorTwelve = $("#allFactorTwelveTemp").val();
	 allFactorNineteensTemp =  $("#allFactorNineteensTemp").val();
	//****专款信息 end *******//
	
	//****系统充值信息 begin *******//
	sysPayTypeNameTemp = $("#sysPayTypeNameTemp").val();
	sysPayTypeTemp = $("#sysPayTypeTemp").val();
	sysPayMoneysTemp = $("#sysPayMoneysTemp").val();
	sysRtnTypeTemp = $("#sysRtnTypeTemp").val();
    sysRtnClassTemp = $("#sysRtnClassTemp").val();
    sysFactorTenTemp = $("#sysFactorTenTemp").val();
	sysFactorElevenTemp = $("#sysFactorElevenTemp").val();
	sysFactorFourteenTemp = $("#sysFactorFourteenTemp").val();
	sysFactorFifteenTemp = $("#sysFactorFifteenTemp").val();
	sysFactorsixteenTemp = $("#sysFactorsixteenTemp").val();
	sysFactorNineteenTemp = $("#sysFactorNineteenTemp").val();
	sysFactorTwentysixTemp = $("#sysFactorTwentysixTemp").val();
	//****系统充值信息 end *******//
	
	//****SP信息 begin *******//
	spCodeTemp = $("#spCodeTemp").val();
	busiCodeTemp = $("#busiCodeTemp").val();
	startDateTemp = $("#startDateTemp").val();
	endDateTemp = $("#endDateTemp").val();
	boxIdTemp = $("#boxIdTemp").val();
	//****SP信息 end *******//
		
	if(resFee==null||resFee == ""){
		resFee="0";
	}
	if(giftFee==null||giftFee == ""){
		giftFee="0";
	}
	if(scoreFee==null||scoreFee == ""){
		scoreFee="0";
	}			
	resFeeChange = parseFloat(resFee) * 100;
	giftFeeChange = parseFloat(giftFee) * 100;
	scoreFeeChange = parseFloat(scoreFee) * 100;

	if(allPaysTemp!=""&&allPaysTemp!=null){
		allPaysBig = DX(parseFloat(allPaysTemp));
	}
	
	if("<%=opCode%>"=="g796"){
		if("<%=print_flag%>"=="0"){
			pay_moneycould=parseFloat(resFee)+parseFloat(giftFee)+parseFloat(scoreFee);
			pay_moneyBig=DX(pay_moneycould);
		}else if("<%=print_flag%>" =="1"){
			pay_moneycould=parseFloat(resFee);
			pay_moneyBig=DX(pay_moneycould);
		}
	}else if("<%=opCode%>"=="g798"){
		pay_moneycould=parseFloat("<%=resRealFee%>");
		pay_moneyBig=DX(pay_moneycould);
	}
	
	//如果存在附加资费，获取生失效时间
	if("<%=showAddFee%>" == "T"){
		callAddFeeFun();
	}
	if(!cancel_rtn2){
		showDialog("获取附加资费生失效时间失败！",0);
		return;
	}

	if(choosType == "1" && "<%=opCode%>"=="g798"){
		callGiftFun();
	}
	if(!cancel_rtn3){
		showDialog("获取促销品状态失败！",0);
		return;
	}
	if(vFlag == "2"){
		showDialog("促销品未冲正，不允许退机！",0);
		return;
	}
	callDoCancelFun();
}

function callAddFeeFun(){
	var phoneNoStrTemp = $("#phoneNoStrTemp").val();
	var oprTypeStrTemp = $("#oprTypeStrTemp").val();
	var dateTypeTemp = $("#dateTypeTemp").val();
	var offerTypeStrTemp = $("#offerTypeStrTemp").val();
	var unitStrTemp = $("#unitStrTemp").val();
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/getEffectTime.jsp","请稍候......");
	sPacket.data.add("iChnSource","0");
	sPacket.data.add("opCode","<%=opCode%>");
	sPacket.data.add("iLoginNo","<%=loginNo%>");
	sPacket.data.add("iLoginPWD","<%=password%>");
	sPacket.data.add("iPhoneNo","<%=phoneNo%>");
	sPacket.data.add("iOprAccept","<%=printAccept%>");
	sPacket.data.add("BUSI_ID","<%=busiId%>");  //旧流水 订购时流水
	sPacket.data.add("iPhoneNoStr",phoneNoStrTemp);
	sPacket.data.add("iOfferIdStr",addFeeCodeTemp);
	sPacket.data.add("iOprTypeStr",oprTypeStrTemp);//订购标识(1订购；3退订)	 串		"#"分隔
	sPacket.data.add("iDateTypeStr",dateTypeTemp);
	sPacket.data.add("iOfferTypeStr",offerTypeStrTemp);//资费类型(0：主资费 1：附加资费) 串,"#"分隔
	sPacket.data.add("iUnitStr",unitStrTemp);//失效时间偏移单位	"#"分隔,可选资费订购时需要，其他情况时以"x"占位 0：月；1：天；2：年；6：自然月；
	sPacket.data.add("iOffsetStr",unitStrTemp);//期限,失效时间偏移量	"#"分隔,可选资费订购时需要，其他情况时以"x"占位
	sPacket.data.add("meansId","<%=meansId%>");
	core.ajax.sendPacket(sPacket,getAddFeeDate);
	sPacket = null;
}


function getAddFeeDate(packet){
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(RETURN_CODE!="000000"){
		$("#qry").attr("disabled","disabled");
		cancel_rtn2 = false;
	}
	addFeeEffDate = packet.data.findValueByName("effDateTemp");
	addFeeExpDate = packet.data.findValueByName("expDateTemp");
	instIdTemp = packet.data.findValueByName("instIdTemp");
	iPhoneNoStr = packet.data.findValueByName("iPhoneNoStr");
}


function callGiftFun(){
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/getGiftStatus.jsp","请稍候......");
	sPacket.data.add("iChnSource","0");
	sPacket.data.add("opCode","g794");
	sPacket.data.add("iLoginNo","<%=loginNo%>");
	sPacket.data.add("iLoginPWD","<%=password%>");
	sPacket.data.add("iPhoneNo","<%=phoneNo%>");
	sPacket.data.add("iOprAccept","<%=printAccept%>");
	core.ajax.sendPacket(sPacket,getGiftStatus);
	sPacket = null;
}


function getGiftStatus(packet){
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(RETURN_CODE!="000000"){
		$("#qry").attr("disabled","disabled");
		cancel_rtn3 = false;
	}
	vFlag = trim(packet.data.findValueByName("vFlag"));
}

function callDoCancelFun(){
	var cancelInfoStrs = setData(addFeeCodeTemp,addFeeNameTemp,note,pay_moneyBig,pay_moneycould,allPaysBig,allPaysTemp,allPayTypesTemp,
			allPayNamesTemp,allPayMoneysTemp,allPayRtnTypesTemp,allPayRtnClassesTemp,allPayFactorTensTemp,allPayFactorElevensTemp,resFee,giftFee,scoreFee,
			resFeeChange,giftFeeChange,addFeeEffDate,addFeeExpDate,instIdTemp,iPhoneNoStr,iPhoneTypeNoStr,allFactorTwelve,resType,giftType,allFactorNineteensTemp,
			sysPayTypeNameTemp,sysPayTypeTemp,sysPayMoneysTemp,sysRtnTypeTemp,sysRtnClassTemp,sysFactorTenTemp,sysFactorElevenTemp,sysFactorFourteenTemp,
			sysFactorFifteenTemp,sysFactorsixteenTemp,sysFactorNineteenTemp,sysFactorTwentysixTemp,spCodeTemp,busiCodeTemp,startDateTemp,endDateTemp,boxIdTemp,choosType);
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/messageOprateCancel.jsp","请稍候......");
	sPacket.data.add("BUSI_ID","<%=busiId%>");
	sPacket.data.add("ID_NO","<%=id_no_main%>");
	sPacket.data.add("PHONE_NO","<%=phoneNo%>");
	sPacket.data.add("LOGIN_NO","<%=loginNo%>");
	sPacket.data.add("GROUP_ID","<%=groupId%>");
	sPacket.data.add("OP_CODE","<%=opCode%>");
	sPacket.data.add("CANCEL_TYPE","<%=cancelType%>");
	sPacket.data.add("cancelInfo",cancelInfoStrs);
	core.ajax.sendPacket(sPacket,doFunction);
	sPacket = null;
}


function doFunction(packet){
	<%if("T".equals(showPriFee)){ %>
		alert("当前主资费: <%=mode_name_main%> 变更为：<%=newPriFeeName%>");
	<%}%>
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(trim(RETURN_CODE) == "000000" || trim(RETURN_CODE) == "0"){
		showDialog('操作成功',3,'retT=goNextActiond();retF=cancelActions();closeFunc=closeForm1()');
	}else{
		showDialog("操作失败:"+RETURN_MSG,0);
		return;
	}
}
	


function cancelAction(){
	window.location.reload(true);
}
function cancelActions(){
	window.close();
}

function closeForm1(){
	window.location.reload(true);
}




function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框
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
	var sysAccept = "<%=printAccept%>";
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path +="&mode_code="+fav_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%="g796"%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" ;
	path += submitCfm+"&pType="+pType+"&billType="+billType;
	path +="&printInfo=" +trim(printStr);
	var ret=window.showModalDialog(path,obj,prop,'status:yes;help:yes;scroll:yes');
	return ret;
}

/*
 * 需要打印的免填单信息，取消时不必打印订购时的信息，只需显示用户的基本信息以及补购机款、补促销品款、备注即可
 */
function printInfo(printType){
     var cust_info = ""; 	//客户信息
	 var opr_info = "";  	//内容
	 var note_info1 = "";	//备注
	 var note_info2 = "";	//备注
	 var note_info3 = "";	//备注
	 var note_info4 = "";	//备注
	 var retInfo = "";  	//返回总字符串
		
	cust_info+="手机号码：   "+"<%=phoneNo%>"+"|";
	cust_info+="客户姓名：   "+"<%=cust_name_main%>"+"|";
	cust_info+="客户地址：   "+"<%=cust_address_main%>"+"|";
	cust_info+="证件号码：   "+"<%=id_name_main%>"+"|";
	opr_info+="业务类型：<%=actName%> 取消"+"|";
	
	opr_info+="业务流水："+"<%=busiId%>" + "|";
	opr_info+="办理时间："+"<%=cancel_time%>" + "|";
	
	if("<%=opCode%>" == "g796"){
		var resFee=$("#resFee").val();
		opr_info+="补购机款："+resFee+"元|";
		var giftFee=$("#giftFee").val();
		opr_info+="补促销品款："+giftFee+"元|";
		var scoreFee=$("#scoreFee").val();
		opr_info+="补积分款："+scoreFee+"元|";
	}else if("<%=opCode%>" == "g798"){
		opr_info+="退还客户现金："+"<%=repayResourceFees%>" + "|";
		opr_info+="客户已消费的专款："+"<%=TotConsumMoneys%>" + "|";
	}

	var note = $("#note").val();
	//i101和购机赠费(自有)免填单不打印备注
	if(("<%=actClass%>"!="72") || ("<%=actClass%>"!="73")){
		opr_info+="备注："+note+"|";
	}

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	//alert("免填单打印信息 retInfo="+retInfo);
    return retInfo;
}

function strcat(){
	var result = "";
	for(var i = 0; i< arguments.length; i++){
		result = result + replaceConnectChar(arguments[i]) + '#';
	}
	return result;
}

function replaceConnectChar(s){
  var str = s.replace(/#/g, "＃");
  return str;
}


function openwindow(theNo,p,q){
	//定义窗口参数
    var h=600;
    var w=720;
    var t=screen.availHeight-h-20;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
    var belong_code ="<%=belong_code_main%>";
    var maincash_no = "<%=mode_code_main %>";//主资费代码老
    var ip = "<%=newPriFeeCode%>"; //主资费代码 新
    var cust_id = "<%=id_no_main%>";
    var sendflag ="<%=tbselect%>".substring(0,1);
	//-----------------linxd--1---------------------------
	var minopen="";
	var maxopen="";
    minopen = oMinOpenObj[theNo].value;
	maxopen = oMaxOpenObj[theNo].value;

    var ret_code = window.showModalDialog("<%=request.getContextPath()%>/npage/se179/feeFuInfo.jsp?mode_type="+p+"&belong_code="+belong_code+"&maincash_no="+codeChg(maincash_no)+"&ip="+codeChg(ip)+"&cust_id="+cust_id+"&sendflag="+sendflag+"&mode_name="+q+"&minopen="+minopen+"&maxopen="+maxopen+"&login_no=<%=loginNo%>","",prop);
    var srcStr = ret_code;
    if(ret_code==null){
        return false;
    }

    if(typeof(srcStr)!="undefined"){
    	tohidden(p);
        getStr(srcStr,token);
    }
}


function getStr(srcStr,token){
	var field_num = 13;
	var i =0;
	var inString = srcStr;
	var retInfo="";
	var tmpPos=0;
    var chPos;
    var valueStr;
    var retValue="";

    var a0="";
    var a1="";
    var a2="";
    var a3="";
    var a4="";
	var a5="";
	var a6="";
	var a7="";
    var a8="";
	var a9="";
	var a10="";
	var a11="";
	var a12="";
	var a1Tmp="";
	retInfo = inString;
	chPos = retInfo.indexOf(token);
    while(chPos > -1)
    {
	  for( i=0; i<field_num; i++)
	  {
		valueStr = retInfo.substring(0,chPos);

		if(i == 0) a0 = valueStr;
		if(i == 1) a1 = valueStr;
		if(a1=="Y")a1Tmp="已开通";
		if(a1=="N")a1Tmp="未开通";
		if(i == 2) a2 = valueStr;
		if(i == 3) a3 = valueStr;
		if(i == 4) a4 = valueStr;
        if(i == 5) a5 = valueStr;
		if(i == 6) a6 = valueStr;
        if(i == 7) a7 = valueStr;
        if(i == 8) a8 = valueStr;
		if(i == 9) a9 = valueStr;
		if(i == 10) a10 = valueStr;
        if(i == 11) a11 = valueStr;
		if(i == 12) a12 = valueStr;
		//rdShowMessageDialog("a12="+a12);
		retInfo = retInfo.substring(chPos + 1);
		chPos = retInfo.indexOf(token);
        if( !(chPos > -1)) break;
       }
		  insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp);
    }
}

function insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp){
	var tr1=tr.insertRow();
	tr1.id="tr"+dynTbIndex;
	var divid = "div"+dynTbIndex;
	td1 = tr1.insertCell();
	td2 = tr1.insertCell();
	td3 = tr1.insertCell();
	td4 = tr1.insertCell();
	td5 = tr1.insertCell();
	td6 = tr1.insertCell();
	td7 = tr1.insertCell();
	td8 = tr1.insertCell();
	td2.id="div"+dynTbIndex;
	td1.innerHTML = '<div align="center"><input type="checkbox" name="checkId" checked></input></div>';
	td2.innerHTML = '<div align="center"><a Href="javascript:openhref('+"'"+a7+"'"+')">'+a0+'</a><input id=R0 type=hidden value='+a0+'  size=10 readonly></input></div>';
	td3.innerHTML = '<div align="center">'+a1Tmp+'<input id=R1 type=hidden value='+a1+'  size=10 readonly></input></div>';
	td4.innerHTML = '<div align="center">'+a2+'<input id=R2 type=hidden value='+a2+'  size=18 readonly></input></div>';
	td5.innerHTML = '<div align="center">'+a3+'<input id=R3 type=hidden value='+a3+'  size=10 readonly></input></div>';
	td6.innerHTML = '<div align="center">'+a4+'<input id=R4 type=hidden value='+a4+'  size=10 readonly></input></div>';
	td7.innerHTML = '<div align="center">'+a5+'<input id=R5 type=hidden value='+a5+'  size=10 readonly></input></div>';
	td8.innerHTML = '<div align="center">'+a6+'<input id=R6 type=hidden value='+a6+'  size=10 readonly><input id=R7 type=hidden value='+a7+'  size=10 readonly><input id=R8 type=hidden value='+a8+'  size=10 readonly><input id=R9 type=hidden value='+a9+'  size=10 readonly><input id=R10 type=hidden value='+a10+'  size=10 readonly><input id=R11 type=hidden value='+a11+'  size=10 readonly><input name="R12" id="R12'+dynTbIndex+'" type=hidden  size=10 readonly></input></div>';
	$("#R12"+dynTbIndex).val(a12);   //为了解决返回描述信息中的回车造成数据显示不全
	dynTbIndex++;
}


function tohidden(s){//s 表示 套餐类型，从openwindow 传入
	var tmpTr = "";
	for(var a = document.all('tr').rows.length-2 ;a>0; a--){//删除从tr1开始，为第三行
        if(document.all.R8[a].value==s && document.all.R1[a].value=="N"){   			
        	if(document.all.R11[a].value.trim()=="0"||document.all.R11[a].value.trim()=="c"){//choice_flag0或c删除
                document.all.tr.deleteRow(a+1);
			}
        }
	}
    return true;
}

function codeChg(s){
	var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
	str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
	str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
	str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
	str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
	return str;
}

function openhref(p,b){
	var h=300;
	var w=550;
	var t=screen.availHeight-h-20;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
	var region_code = b;
	var ret_code = window.showModalDialog("<%=request.getContextPath()%>/npage/se179/feeInfunds.jsp?mode_code="+p+"&region_code="+region_code+"&login_no=<%=loginNo%>","",prop);
}

function DX(n) {
	if(n=="" || n=="0"){
		return "零";
	}else{
	   if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n)){
	        return "数据非法";
	   }
	   var unit = "千百拾亿千百拾万千百拾元角分", str = "";
	    n += "00";
	   var p = n.indexOf('.');
	   if (p >= 0)
	        n = n.substring(0, p) + n.substr(p+1, 2);
	        unit = unit.substr(unit.length - n.length);
	   for (var i=0; i < n.length; i++)
	        str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
	   return str.replace(/零(千|百|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
	}
}

function goNextActiond(){
	 goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=print_flag%>");
}

function hidshowTR(){
	var choosType = document.getElementById("choosType").value;
	//alert("choosType:"+choosType);
	if(choosType == "0"){
		$("#tr_1").show();
	}else{
		$("#tr_1").hide();
	}
}

</script>