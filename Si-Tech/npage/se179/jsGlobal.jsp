<%
	//ȫ�ֱ�����ȫ�ֲ������js����
 %>
<script type="text/javascript">
/*
 * У����û�ȡ������Ϣ�����Ƿ�ִ�гɹ�
 */
function checkServiceRtn(){
	if("<%=actInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("����������Ϣ��ȡʧ��:<%=actInfoRtnMsg%>!",0);
		return false;
	}else if("<%=feeInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("������Ϣ��ȡʧ��:<%=feeInfoRtnMsg%>!",0);
		return false;
	}else if("<%=resInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("��Դ��Ϣ��ȡʧ��:<%=resInfoRtnMsg%>!",0);
		return false;
	}else if("<%=prodInfoRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("�ʷ���Ϣ��ȡʧ��:<%=prodInfoRtnMsg%>!",0);
		return false;
	}else if("<%=cancelRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("���ʷѻ�ȡʧ��:<%=cancelRtnMsg%>!",0);
		return false;
	}else if("<%=netRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("�����ʶ��ȡʧ��:<%=netRtnMsg%>!",0);
		return false;
	}else if("<%=netScoreRtnCode%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("���ֵ�������������Ϣ��ȡʧ��:<%=netScoreRtnMsg%>!",0);
		return false;
	}else if("<%=codeTemp%>"!="000000"){
		$("#qry").attr("disabled","disabled");
		showDialog("��ѯ���ʷѿ�ѡ�ʷ�ʧ��:<%=msgTemp%>!",0);
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
			showDialog("����д��ע!",0);
		 	return false;
	}
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  	if(typeof(ret)!="undefined"){
	  if((ret=="confirm")){
	  			$("#qry").attr("disabled","disabled");
 				showDialog('ȷ�ϵ��������',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
		}
		if(ret=="continueSub"){
				$("#qry").attr("disabled","disabled");
	 			showDialog('ȷ��Ҫ�ύ��Ϣ��?',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
		}
  	}else{
	 	 $("#qry").attr("disabled","disabled");
	     showDialog('��ȷ��Ҫ�ύ��Ϣ��?',3,'retT=doSubmit();retF=cancelAction();closeFunc=closeForm()');
  	}
}


var tempnm="";				   		//��ʱ��������
var resFee = "";              		//��������
var giftFee = "";  					//������Ʒ��
var scoreFee = "";            		//�����ֿ�
var resFeeChange = 0;         		//�������� ���,��λ��
var giftFeeChange = 0;        		//������Ʒ��,���,��λ��
var scoreFeeChange = 0;  			//�����ֿ�,���,��λ��
var resType = "";             		//������������
var giftType = "";           		//������Ʒ������
var note = "";					 	//��ע
var addFeeCodeTemp = "";			//�����ʷѴ��봮,��#�ָ�
var addFeeNameTemp = "";			//�����ʷ����ƴ�,��#�ָ�
var allPaysTemp = "";				//ר���ܽ�Сд
var allPayTypesTemp = "";			//ר��������ʹ�����#�ָ�
var allPayNamesTemp = "";			//ר�����ƴ�����#�ָ�
var allPayMoneysTemp = "";			//ר����ô�����#�ָ�
var allPayRtnTypesTemp = "";		//ר�����ʽ������#�ָ�
var allPayRtnClassesTemp = "";		//ר������ʹ���û�е���~ռλ
var allPayFactorTensTemp = "";		//ר��ҳ���ʶ����#�ָ�
var allPayFactorElevensTemp = "";	//�ҳ��ͳ�Ա�Լ���������,��#�ָ�
var allFactorTwelve = "";			//ר�ʽ������#�ָ�
var allFactorNineteensTemp = "";	//ר�����ʽ������#�ָ�

var sysPayTypeNameTemp = "";		//ϵͳ��ֵ���ƴ�,��#�ָ�
var sysPayTypeTemp = "";			//ϵͳ��ֵ���ʹ�,��#�ָ�
var sysPayMoneysTemp = "";			//ϵͳ��ֵ���ô�,��#�ָ�
var sysRtnTypeTemp = "";			//ϵͳ��ֵ������ʽ��,��#�ָ�
var sysRtnClassTemp = "";			//ϵͳ��ֵ�������ʹ�,��#�ָ�,û�е���~ռλ
var sysFactorTenTemp = "";			//0���ҳ� ��1����Ա��2���������˶�����0,��#�ָ�
var sysFactorElevenTemp = "";		//�ҳ��ͳ�Ա�Լ��������봮,��#�ָ�
var sysFactorFourteenTemp = "";		//ϵͳ��ֵ�Ƿ��н���,��#�ָ�
var sysFactorFifteenTemp = "";		//0��������1��������2�������͸���,��#�ָ�
var sysFactorsixteenTemp = "";		//ϵͳ��ֵ�������봮,��#�ָ�
var sysFactorNineteenTemp = "";		//��Ч��ʽ��,��#�ָ�
var sysFactorTwentysixTemp = "";    //��ʶ��SP��Ȩ��ҵ������ͨϵͳ��ֵ��1-��Ȩ�棬��������ϵͳ��ֵ

var spCodeTemp = "";
var busiCodeTemp = "";
var startDateTemp = "";
var endDateTemp = "";
var boxIdTemp = "";

var pay_moneycould = 0;
var pay_moneyBig="";
var allPaysBig = "";

var addFeeEffDate = "";//�����ʷѿ�ʼʱ�䴮,��#�ָ�
var addFeeExpDate = "";//�����ʷѽ���ʱ�䴮,��#�ָ�
var instIdTemp = "";//�����ʷ��ʷ�ʵ����,��#�ָ�
var iPhoneNoStr = "";//�����ʷѳ�Ա�ֻ����봮,��#�ָ�
var iPhoneTypeNoStr = $("#phoneNoStrType").val();;//�����ʷ��ֻ�����,��#�ָ�
var cancel_rtn = true;
var cancel_rtn2 = true;
var cancel_rtn3 = true;

var vFlag = "";//2��Ʒδ������
var choosType = "";//1�˻�����Ʒ0���˻�����Ʒ


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
	 
	 //****ר����Ϣbegin *******//
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
	//****ר����Ϣ end *******//
	
	//****ϵͳ��ֵ��Ϣ begin *******//
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
	//****ϵͳ��ֵ��Ϣ end *******//
	
	//****SP��Ϣ begin *******//
	spCodeTemp = $("#spCodeTemp").val();
	busiCodeTemp = $("#busiCodeTemp").val();
	startDateTemp = $("#startDateTemp").val();
	endDateTemp = $("#endDateTemp").val();
	boxIdTemp = $("#boxIdTemp").val();
	//****SP��Ϣ end *******//
		
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
	
	//������ڸ����ʷѣ���ȡ��ʧЧʱ��
	if("<%=showAddFee%>" == "T"){
		callAddFeeFun();
	}
	if(!cancel_rtn2){
		showDialog("��ȡ�����ʷ���ʧЧʱ��ʧ�ܣ�",0);
		return;
	}

	if(choosType == "1" && "<%=opCode%>"=="g798"){
		callGiftFun();
	}
	if(!cancel_rtn3){
		showDialog("��ȡ����Ʒ״̬ʧ�ܣ�",0);
		return;
	}
	if(vFlag == "2"){
		showDialog("����Ʒδ�������������˻���",0);
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
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/getEffectTime.jsp","���Ժ�......");
	sPacket.data.add("iChnSource","0");
	sPacket.data.add("opCode","<%=opCode%>");
	sPacket.data.add("iLoginNo","<%=loginNo%>");
	sPacket.data.add("iLoginPWD","<%=password%>");
	sPacket.data.add("iPhoneNo","<%=phoneNo%>");
	sPacket.data.add("iOprAccept","<%=printAccept%>");
	sPacket.data.add("BUSI_ID","<%=busiId%>");  //����ˮ ����ʱ��ˮ
	sPacket.data.add("iPhoneNoStr",phoneNoStrTemp);
	sPacket.data.add("iOfferIdStr",addFeeCodeTemp);
	sPacket.data.add("iOprTypeStr",oprTypeStrTemp);//������ʶ(1������3�˶�)	 ��		"#"�ָ�
	sPacket.data.add("iDateTypeStr",dateTypeTemp);
	sPacket.data.add("iOfferTypeStr",offerTypeStrTemp);//�ʷ�����(0�����ʷ� 1�������ʷ�) ��,"#"�ָ�
	sPacket.data.add("iUnitStr",unitStrTemp);//ʧЧʱ��ƫ�Ƶ�λ	"#"�ָ�,��ѡ�ʷѶ���ʱ��Ҫ���������ʱ��"x"ռλ 0���£�1���죻2���ꣻ6����Ȼ�£�
	sPacket.data.add("iOffsetStr",unitStrTemp);//����,ʧЧʱ��ƫ����	"#"�ָ�,��ѡ�ʷѶ���ʱ��Ҫ���������ʱ��"x"ռλ
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
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/getGiftStatus.jsp","���Ժ�......");
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
	var sPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/messageOprateCancel.jsp","���Ժ�......");
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
		alert("��ǰ���ʷ�: <%=mode_name_main%> ���Ϊ��<%=newPriFeeName%>");
	<%}%>
	var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
	var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
	if(trim(RETURN_CODE) == "000000" || trim(RETURN_CODE) == "0"){
		showDialog('�����ɹ�',3,'retT=goNextActiond();retF=cancelActions();closeFunc=closeForm1()');
	}else{
		showDialog("����ʧ��:"+RETURN_MSG,0);
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




function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի���
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
 * ��Ҫ��ӡ�������Ϣ��ȡ��ʱ���ش�ӡ����ʱ����Ϣ��ֻ����ʾ�û��Ļ�����Ϣ�Լ��������������Ʒ���ע����
 */
function printInfo(printType){
     var cust_info = ""; 	//�ͻ���Ϣ
	 var opr_info = "";  	//����
	 var note_info1 = "";	//��ע
	 var note_info2 = "";	//��ע
	 var note_info3 = "";	//��ע
	 var note_info4 = "";	//��ע
	 var retInfo = "";  	//�������ַ���
		
	cust_info+="�ֻ����룺   "+"<%=phoneNo%>"+"|";
	cust_info+="�ͻ�������   "+"<%=cust_name_main%>"+"|";
	cust_info+="�ͻ���ַ��   "+"<%=cust_address_main%>"+"|";
	cust_info+="֤�����룺   "+"<%=id_name_main%>"+"|";
	opr_info+="ҵ�����ͣ�<%=actName%> ȡ��"+"|";
	
	opr_info+="ҵ����ˮ��"+"<%=busiId%>" + "|";
	opr_info+="����ʱ�䣺"+"<%=cancel_time%>" + "|";
	
	if("<%=opCode%>" == "g796"){
		var resFee=$("#resFee").val();
		opr_info+="�������"+resFee+"Ԫ|";
		var giftFee=$("#giftFee").val();
		opr_info+="������Ʒ�"+giftFee+"Ԫ|";
		var scoreFee=$("#scoreFee").val();
		opr_info+="�����ֿ"+scoreFee+"Ԫ|";
	}else if("<%=opCode%>" == "g798"){
		opr_info+="�˻��ͻ��ֽ�"+"<%=repayResourceFees%>" + "|";
		opr_info+="�ͻ������ѵ�ר�"+"<%=TotConsumMoneys%>" + "|";
	}

	var note = $("#note").val();
	//i101�͹�������(����)�������ӡ��ע
	if(("<%=actClass%>"!="72") || ("<%=actClass%>"!="73")){
		opr_info+="��ע��"+note+"|";
	}

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	//alert("�����ӡ��Ϣ retInfo="+retInfo);
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
  var str = s.replace(/#/g, "��");
  return str;
}


function openwindow(theNo,p,q){
	//���崰�ڲ���
    var h=600;
    var w=720;
    var t=screen.availHeight-h-20;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
    var belong_code ="<%=belong_code_main%>";
    var maincash_no = "<%=mode_code_main %>";//���ʷѴ�����
    var ip = "<%=newPriFeeCode%>"; //���ʷѴ��� ��
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
		if(a1=="Y")a1Tmp="�ѿ�ͨ";
		if(a1=="N")a1Tmp="δ��ͨ";
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
	$("#R12"+dynTbIndex).val(a12);   //Ϊ�˽������������Ϣ�еĻس����������ʾ��ȫ
	dynTbIndex++;
}


function tohidden(s){//s ��ʾ �ײ����ͣ���openwindow ����
	var tmpTr = "";
	for(var a = document.all('tr').rows.length-2 ;a>0; a--){//ɾ����tr1��ʼ��Ϊ������
        if(document.all.R8[a].value==s && document.all.R1[a].value=="N"){   			
        	if(document.all.R11[a].value.trim()=="0"||document.all.R11[a].value.trim()=="c"){//choice_flag0��cɾ��
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
		return "��";
	}else{
	   if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n)){
	        return "���ݷǷ�";
	   }
	   var unit = "ǧ��ʰ��ǧ��ʰ��ǧ��ʰԪ�Ƿ�", str = "";
	    n += "00";
	   var p = n.indexOf('.');
	   if (p >= 0)
	        n = n.substring(0, p) + n.substr(p+1, 2);
	        unit = unit.substr(unit.length - n.length);
	   for (var i=0; i < n.length; i++)
	        str += '��Ҽ��������½��ƾ�'.charAt(n.charAt(i)) + unit.charAt(i);
	   return str.replace(/��(ǧ|��|ʰ|��)/g, "��").replace(/(��)+/g, "��").replace(/��(��|��|Ԫ)/g, "$1").replace(/(��)��|Ҽ(ʰ)/g, "$1$2").replace(/^Ԫ��?|���/g, "").replace(/Ԫ$/g, "Ԫ��");
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