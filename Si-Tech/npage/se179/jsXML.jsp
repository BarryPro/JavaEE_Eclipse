<%
	//ȫ�ֱ�����ȫ�ֲ������js����
 %>
<script type="text/javascript">
var cancelInfo = instanceTemplate["CANCELINFO"]();
var root = instanceTemplate["ROOT"]();
//���������һ��contains���������ж��������Ƿ����ĳһԪ��
Array.prototype.contains = function(ele){
	var length = this.length;
	for(var i=0; i<length; i++){
		if(this[i]==ele){
			return true;
		}
	}
	return false;
}

function setData(addFeeCodeTemp,addFeeNameTemp,note,pay_moneyBig,pay_moneycould,allPaysBig,allPaysTemp,allPayTypesTemp,allPayNamesTemp,allPayMoneysTemp,allPayRtnTypesTemp,
		allPayRtnClassesTemp,allPayFactorTensTemp,allPayFactorElevensTemp,resFee,giftFee,scoreFee,resFeeChange,giftFeeChange,addFeeEffDateTemp,
		addFeeExpDateTemp,instIdTemp,iPhoneNoStr,iPhoneTypeNoStr,allFactorTwelve,resType,giftType,allFactorNineteensTemp,
		sysPayTypeNameTemp,sysPayTypeTemp,sysPayMoneysTemp,sysRtnTypeTemp,sysRtnClassTemp,sysFactorTenTemp,sysFactorElevenTemp,sysFactorFourteenTemp,
		sysFactorFifteenTemp,sysFactorsixteenTemp,sysFactorNineteenTemp,sysFactorTwentysixTemp,spCodeTemp,busiCodeTemp,startDateTemp,endDateTemp,boxIdTemp,choosType){
	//MSG_TYPE ���ĸ�ֵ-----------------------------------------
	cancelInfo.find("MSG_TYPE.BATCH_TYPE").set("1");
	cancelInfo.find("MSG_TYPE.TEMPLATE_ID").set("1");
	cancelInfo.find("MSG_TYPE.AUTO_CONFIRM").set("N");
	//OPR_INFO ���ĸ�ֵ-----------------------------------------
	cancelInfo.find("REQUEST_INFO.OPR_INFO.LOGINACCEPT").set("<%=printAccept%>");//��ˮ������Դ�ӿ�ȡ
	cancelInfo.find("REQUEST_INFO.OPR_INFO.OLD_LOGINACCEPT").set("<%=old_loginaccept%>");//ԭ������ˮ
	cancelInfo.find("REQUEST_INFO.OPR_INFO.CUSTORDERID").set("<%=custOrderId%>");//�ͻ�������crm������
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ORDERARRAYID").set("<%=orderArrayId%>");//�������crm������
	cancelInfo.find("REQUEST_INFO.OPR_INFO.REGION_ID").set("<%=reginCode%>");//���б���
	cancelInfo.find("REQUEST_INFO.OPR_INFO.CHANNEL_TYPE").set("0");//�������룿����
	cancelInfo.find("REQUEST_INFO.OPR_INFO.LOGIN_NO").set("<%=loginNo%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.LOGIN_PWD").set("<%=password%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.IP_ADDRESS").set("<%=ip_address%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.GROUP_ID").set("<%=groupId%>");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.CONTACT_ID").set("");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.OP_CODE").set("<%=opCode%>");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.OP_NOTICE").set("");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.SYS_NOTE").set("<%=sysNote%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.BRAND_ID").set("<%=brand_id_main%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.CUST_ID").set("<%=cust_id_main%>");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ID_NO").set("<%=id_no_main%>");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.SERVICE_NO").set("<%=servBusiId%>");//��ҵ���ṩ
	cancelInfo.find("REQUEST_INFO.OPR_INFO.SERVICE_NO").set("<%=phoneNo%>");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.CONTRACT_NO").set("");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.IMPOWER_LOGIN").set("");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.MASTER_SERV_ID").set("");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ACTION_TYPE").set("<%=actClass%>");//�����
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ACTION_ID").set("<%=actionId%>");//�ID
	cancelInfo.find("REQUEST_INFO.OPR_INFO.MEANS_ID").set("<%=meansId%>");//Ӫ����ʽID
	cancelInfo.find("REQUEST_INFO.OPR_INFO.OP_TIME").set("<%=oper_time%>");//����ʱ��
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.BUY_ICCID").set("BUY_ICCIDqqq");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.BUY_NAME").set("�û�ʲô����");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.PRODPRC_NAME").set("��������!!!");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.NOTE").set(note);
	
	//PRINT_INFO ���ĸ�ֵ-----------------------------------------
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.ACTION_NAME").set("<%=actName%>");//ҵ������
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.CUST_NAME").set("<%=cust_name_main%>");//�ͻ�����
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PHONE_NO").set("<%=phoneNo%>");//�ֻ�����
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PRINT_FLAG").set("<%=print_flag%>");//��ӡ��ʶ��0�ϴ�1�ִ�
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_MONEYBIG").set(pay_moneyBig);//��ӡ��ʶΪ0ʱ�Ǻϼƽ�(��д)��Ϊ1ʱ�ǹ�����
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_MONEYSMALL").set(pay_moneycould);//��ӡ��ʶΪ0ʱ��(Сд)��Ϊ1ʱ�ǣ�
	if("<%=print_flag%>"=="1"&&"<%=opCode%>"=="g796"){
		cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_SPECIALBIG").set(allPaysBig);//��ӡ��ʶΪ1ʱ��Ч��ר��(��д)
		cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_SPECIALSMALL").set(allPaysTemp);//��ӡ��ʶΪ1ʱ��Ч����(Сд)
	}
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.RESOURCEBRAND").set("<%=resourceBrand%>");//�ն�Ʒ��
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.RESOURCE_MODEL").set("<%=resourceModel%>");//�ն��ͺ�
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.IMEI_CODE").set("<%=resourceImeiCode%>");//IMEI
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.LOGIN_NAME").set("<%=loginNo%>");//��Ʊ��


	//�ʷ���䣺���ʷѡ������ʷ�-------------begin----------------
	//���ʷ���Ϣ
	var idNoArr = "<%=idNoTemp%>".split("#");
	var custIdArr = "<%=custIdTemp%>".split("#");
	var brandIdArr = "<%=brandIdTemp%>".split("#");
	var groupIdArr = "<%=groupIdTemp%>".split("#");
	var phoneNoArr = "<%=phoneNoTemp%>".split("#");
	var phoneTypeTemp = "<%=phoneTypeTemp%>".split("#");
	var priFeeCodeArr = "<%=priFeeCodeTemp%>".split("#");
	var priFeeNameArr = "<%=priFeeNameTemp%>".split("#");
	var priFeeValidArr = "<%=priFeeValidTemp%>".split("#");
	var distriFeeCodeArr = "<%=distriFeeCodeTemp%>".split("#");
	var distriFeeNameArr = "<%=distriFeeNameTemp%>".split("#");
	var CProdInstIdArr = "<%=CProdInstIdTemp%>".split("#");
	var nextOfferInstIdArr = "<%=nextOfferInstIdTemp%>".split("#");
	var CurMOfferEffTimeArr = "<%=CurMOfferEffTimeTemp%>".split("#");
	var CurMOfferExpTimeArr = "<%=CurMOfferExpTimeTemp%>".split("#");
	var NextMOfferIdArr = "<%=NextMOfferIdTemp%>".split("#");
	var NextMOfferNameArr = "<%=NextMOfferNameTemp%>".split("#");
	var NextMOfferEffTimeArr = "<%=NextMOfferEffTimeTemp%>".split("#");
	var NextMOfferExpTimeArr = "<%=NextMOfferExpTimeTemp%>".split("#");
	var priFeeOperateTypeArr = "<%=priFeeOperateTypeTemp%>".split("#");//���ʷѲ�����ʽ
	var nextFeeOperateTypeArr = "<%=nextFeeOperateTypeTemp%>".split("#");//��һ�����ʷѲ�����ʽ
	//�����ʷ���Ϣ
	var addFeeCodeArr = addFeeCodeTemp.split("#");
	var addFeeNameArr = addFeeNameTemp.split("#");
	var addFeeEffDateArr = addFeeEffDateTemp.split("#");
	var addFeeExpDateArr = addFeeExpDateTemp.split("#");
	var instIdArr =  instIdTemp.split("#");
	var addFeePhoneNoArr = "<%=phoneNoStrTemp%>".split("#");
	var addFeePhoneTypeArr = "<%=phoneNoStrType %>".split("#");
	var addFeeIdNoArr = "<%=addFeeIdNoStrTemp %>".split("#");
	var addFeeCustIdArr = "<%=addFeeCustIdStrTemp %>".split("#");
	var addFeeBrandIdArr = "<%=addFeeBrandIdStrTemp %>".split("#");
	//ȡ���ʷ������в��ظ��ĺ���,���ݺ���ȡ����Ӧ�����µ����ʷѡ������ʷ���Ϣ
	var phone = new Array();
	var idNo = new Array();
	var custId = new Array();
	var brandId = new Array();
	var phoneType = new Array();
	//���ʷѺ���
	if("<%=phoneNoTemp%>"!="null"&&"<%=phoneNoTemp%>"!=""){
		for(var i=0;i<phoneNoArr.length-1;i++){
			if(!phone.contains(phoneNoArr[i])){
				phone.push(phoneNoArr[i]);
				idNo.push(idNoArr[i]);
				custId.push(custIdArr[i]);
				brandId.push(brandIdArr[i]);
				phoneType.push(phoneTypeTemp[i]);
			}
		}
	}
	//�����ʷѺ���
	if("<%=phoneNoStrTemp %>"!="null"&&"<%=phoneNoStrTemp %>"!=""){
		for(var i=0;i<addFeePhoneNoArr.length-1;i++){
			if(!phone.contains(addFeePhoneNoArr[i])){
				phone.push(addFeePhoneNoArr[i]);
				idNo.push(addFeeIdNoArr[i]);
				custId.push(addFeeCustIdArr[i]);
				brandId.push(addFeeBrandIdArr[i]);
				phoneType.push(addFeePhoneTypeArr[i]);
			}
		}
	}
	//�ʷѱ������
	for(var i=0;i<phone.length;i++){
		/*������Ϣ���*/
		var prodbusi_info = instanceTemplate["PRODPRC_BUSIINFO"]();
		prodbusi_info.find("BUSIINFO_SEQ").set("1");
		prodbusi_info.find("SERVICE_OFFER_ID").set(phoneType[i]=="B"?"40042":"<%=prodServBusiId%>");
		prodbusi_info.find("DOMAIN_TYPE").set("P");
		prodbusi_info.find("PHONE_NO").set(phone[i]);
		prodbusi_info.find("ID_NO").set(idNo[i]);
		prodbusi_info.find("CUST_ID").set(custId[i]);
		prodbusi_info.find("BRAND_ID").set(brandId[i]);
		prodbusi_info.find("GROUP_ID").set("<%=groupId%>");
		//���ʷ����
		for(var j=0;j<phoneNoArr.length-1;j++){
			if(phoneNoArr[j]==phone[i]){
				var phoneNo = phoneNoArr[j];
				var priFeeCode = priFeeCodeArr[j];
				var priFeeName = priFeeNameArr[j];
				var priFeeValid = priFeeValidArr[j];
				var distriFeeCode = distriFeeCodeArr[j];
				var distriFeeName = distriFeeNameArr[j];
				var CProdInstId = CProdInstIdArr[j];
				var CurMOfferEffTime = CurMOfferEffTimeArr[j];
				var CurMOfferExpTime = CurMOfferExpTimeArr[j];
				var NextMOfferId = NextMOfferIdArr[j];
				var nextOfferInstId = nextOfferInstIdArr[j];
				var NextMOfferName = NextMOfferNameArr[j];
				var NextMOfferEffTime = NextMOfferEffTimeArr[j];
				var NextMOfferExpTime = NextMOfferExpTimeArr[j];
				var priFeeOperateType = priFeeOperateTypeArr[j];
				var netFeeOperateType = nextFeeOperateTypeArr[j];
				
				//���ʷѱ���------------------------------------------------
				if(priFeeCode != "null" && priFeeCode != ""){
					var Spe_info=instanceTemplate["PRODPRC_INFO"]();
					Spe_info.find("OPERATE_TYPE").set(priFeeOperateType);//1������2�޸ģ�3�˶�
					Spe_info.find("DISCOUNTPLANINSTID").set(CProdInstId);//�ʷ�ʵ����ʶ��Ĭ��0
					Spe_info.find("ORDER").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
					Spe_info.find("CUSTAGREEMENTID").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
					Spe_info.find("STATUS").set("X");//�ʷ�״̬��������A���˶�X
					Spe_info.find("PEI_FEE_CODE").set(priFeeCode);//�ʷѴ���
					Spe_info.find("PEI_FEE_NAME").set(priFeeName);//�ʷ�����
					Spe_info.find("PRI_FEE_VALID").set(priFeeValid);//�ʷ���Ч��ʶ��0������Ч��2һ��ԤԼ
					Spe_info.find("DISTRI_FEE_NAME").set(distriFeeName);//С���ʷ�����
					Spe_info.find("DISTRI_FEE_CODE").set(distriFeeCode);//С���ʷѴ���
					Spe_info.find("EFF_DATE").set(CurMOfferEffTime);//��Чʱ��
					Spe_info.find("EXP_DATE").set(CurMOfferExpTime);//ʧЧʱ��
					Spe_info.find("PARENTINSTID").set("0");//��ʵ����ʶ��Ĭ��
					Spe_info.find("CURLEVEL").set("0");//Ĭ��ֵ0
					Spe_info.find("DEVELOP_NO").set("<%=loginNo%>");//��չ����
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(Spe_info);
				}
				//���ʷ��µĿ�ѡ�ʷѱ���------------------------------------------------
				var extFeeTable = $("#table_feeExt_"+phoneNo+" :checkbox");
				
				for(var k=0; k<extFeeTable.length; k++){
					var kxInfo=instanceTemplate["PRODPRC_INFO"]();
					var feeExtDatas = $(extFeeTable[k]).val();
					var feeExtData = feeExtDatas.split("#");
					var oldStatus = feeExtData[4];
					var newStatus = ""; 
					var operateType = "";
					if(!($(extFeeTable[k]).attr("checked"))&& oldStatus =="A"){
						newStatus = "X";
						operateType = "3";
						feeExtData[6] = CurMOfferExpTime;
					}else if ($(extFeeTable[k]).attr("checked")&& oldStatus =="X"){
						newStatus = "A";
						operateType = "1";
					}else{
						newStatus=oldStatus;
					}
					//���ԭ״̬Ϊ���� ��old = A ȡ��֮����Ҫ��A ��������¾�״̬����˵������״̬�ޱ仯
					if(newStatus == oldStatus){
						continue;
					}
					if("<%=validType%>" == "1"){
						operateType = "2";
					}
					kxInfo.find("OPERATE_TYPE").set(operateType);
					kxInfo.find("DISCOUNTPLANINSTID").set(feeExtData[0]);
					kxInfo.find("ORDER").set("0");
					kxInfo.find("CUSTAGREEMENTID").set("0");
					kxInfo.find("STATUS").set(newStatus);
					kxInfo.find("PEI_FEE_CODE").set(feeExtData[1]);
					kxInfo.find("PEI_FEE_NAME").set(feeExtData[2]);
					kxInfo.find("PRI_FEE_VALID").set(feeExtData[3]);
					//var xqInfo =  $("#R13_"+feeExtData[1]).val();
					var xqInfo = document.getElementById("R13_"+feeExtData[1]).value;
					//alert("xqInfo="+xqInfo+"; feeExtData[1]="+feeExtData[1]);
					var temp = $("#R13_"+feeExtData[1]);
					if(xqInfo!=null && xqInfo!="" && xqInfo!="N/A"){
						var infoArr = xqInfo.split("~");
						kxInfo.find("DISTRI_FEE_NAME").set(infoArr[1]);//С���ʷ�����
						kxInfo.find("DISTRI_FEE_CODE").set(infoArr[0]);//С���ʷѴ���
					}
					
					kxInfo.find("KX_HABITUS_BUNCH").set(oldStatus);
					kxInfo.find("EFF_DATE").set(feeExtData[5]);
					kxInfo.find("EXP_DATE").set(feeExtData[6]);
					kxInfo.find("PARENTINSTID").set("0");
					kxInfo.find("CURLEVEL").set("0");
					kxInfo.find("DEVELOP_NO").set("<%=loginNo%>");
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(kxInfo);
				}
				//�¶������ʷѱ���------------------------------------------------
				if(NextMOfferId != "" && NextMOfferId != null){
					var newFee_info=instanceTemplate["PRODPRC_INFO"]();
					newFee_info.find("OPERATE_TYPE").set(netFeeOperateType);//1������2�޸ģ�3�˶�
					newFee_info.find("DISCOUNTPLANINSTID").set(nextOfferInstId);//�ʷ�ʵ����ʶ��Ĭ��0
					newFee_info.find("ORDER").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
					newFee_info.find("CUSTAGREEMENTID").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
					newFee_info.find("STATUS").set("A");//�ʷ�״̬��������A���˶�X
					newFee_info.find("PEI_FEE_CODE").set(NextMOfferId);//�ʷѴ���
					newFee_info.find("PEI_FEE_NAME").set(NextMOfferName);//�ʷ�����
					newFee_info.find("PRI_FEE_VALID").set("0");//�ʷ���Ч��ʶ��0������Ч��2һ��ԤԼ
					newFee_info.find("EFF_DATE").set(NextMOfferEffTime);//��Чʱ��
					newFee_info.find("EXP_DATE").set(NextMOfferExpTime);//ʧЧʱ��
					newFee_info.find("PARENTINSTID").set("0");//��ʵ����ʶ��Ĭ��
					newFee_info.find("CURLEVEL").set("0"); //Ĭ��ֵ0
					newFee_info.find("DEVELOP_NO").set("<%=loginNo%>");//��չ����
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(newFee_info);
				}
			}
		}
		
		//�����ʷ����
		for(var k=0;k<addFeePhoneNoArr.length-1;k++){
			if(addFeePhoneNoArr[k]==phone[i]){
				var addFeeCode = addFeeCodeArr[k];
				var addFeeName = addFeeNameArr[k];
				var addFeeEffDate = addFeeEffDateArr[k];
				var addFeeExpDate = addFeeExpDateArr[k];
				var instId = instIdArr[k];
				if("nan" == instId){
					continue;
				}
				var addFeePhoneNo = addFeePhoneNoArr[k];
				//�����ʷѱ���-------------------------------------------------
				var addFee_info=instanceTemplate["PRODPRC_INFO"]();
				addFee_info.find("OPERATE_TYPE").set("3");//1������2�޸ģ�3�˶�
				addFee_info.find("DISCOUNTPLANINSTID").set(instId);//�ʷ�ʵ����ʶ��Ĭ��0
				addFee_info.find("ORDER").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
				addFee_info.find("CUSTAGREEMENTID").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
				addFee_info.find("STATUS").set("X");//�ʷ�״̬��������A���˶�X
				addFee_info.find("PEI_FEE_CODE").set(addFeeCode);//�ʷѴ���
				addFee_info.find("PEI_FEE_NAME").set(addFeeName);//�ʷ�����
				addFee_info.find("PRI_FEE_VALID").set("0");//�ʷ���Ч��ʶ��0������Ч��2һ��ԤԼ
				addFee_info.find("EFF_DATE").set(addFeeEffDate);//��Чʱ��
				if("<%=validType%>" == "1"){
					addFee_info.find("EXP_DATE").set("<%=addfee_endtime%>");//ʧЧʱ�����Ϊ��ǰʱ�� quyl����
				}else{
					addFee_info.find("EXP_DATE").set(addFeeExpDate);//ʧЧʱ��
				}
				addFee_info.find("PARENTINSTID").set("0");//��ʵ����ʶ��Ĭ��
				addFee_info.find("CURLEVEL").set("0");//Ĭ��ֵ0
				addFee_info.find("DEVELOP_NO").set("<%=loginNo%>");//��չ����
				prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(addFee_info);
			}
		}

		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(prodbusi_info);
	}
	//�ʷ���䣺���ʷѡ������ʷ�-------------end----------------
	
	
	//����ʷ����
	if("<%=feeFlag%>"=="1"){
		var netbusi_info = instanceTemplate["PRODPRC_BUSIINFO"]();
		netbusi_info.find("BUSIINFO_SEQ").set("1");
		netbusi_info.find("SERVICE_OFFER_ID").set("40042");//����ʷ�Ĭ�ϴ�40042
		netbusi_info.find("DOMAIN_TYPE").set("P");
		netbusi_info.find("PHONE_NO").set("<%=netPhoneNo%>");
		netbusi_info.find("ID_NO").set("<%=netIdNo%>");
		netbusi_info.find("CUST_ID").set("<%=netCustId%>");
		netbusi_info.find("BRAND_ID").set("<%=netBrandId%>");
		netbusi_info.find("GROUP_ID").set("<%=netGroupId%>");
		
		//������ʷѱ���------------------------------------------------
		if("<%=netFeeCode%>" != ""){
			var net_info=instanceTemplate["PRODPRC_INFO"]();
			net_info.find("OPERATE_TYPE").set("3");//1������2�޸ģ�3�˶�
			net_info.find("DISCOUNTPLANINSTID").set("<%=netInstId%>");//�ʷ�ʵ����ʶ��Ĭ��0
			net_info.find("ORDER").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
			net_info.find("CUSTAGREEMENTID").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
			net_info.find("STATUS").set("X");//�ʷ�״̬��������A���˶�X
			net_info.find("PEI_FEE_CODE").set("<%=netFeeCode%>");//�ʷѴ���
			net_info.find("PEI_FEE_NAME").set("<%=netFeeName%>");//�ʷ�����
			net_info.find("EFF_DATE").set("<%=netEffTime%>");//��Чʱ��
			net_info.find("EXP_DATE").set("<%=netExpTime%>");//ʧЧʱ��
			net_info.find("PARENTINSTID").set("0");//��ʵ����ʶ��Ĭ��
			net_info.find("CURLEVEL").set("0");//Ĭ��ֵ0
			net_info.find("DEVELOP_NO").set("<%=loginNo%>");//��չ����
			netbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(net_info);
		}
		
		//�¶���������ʷѱ���------------------------------------------------
		if("<%=netNextFee%>" != ""){
			var newNet_info=instanceTemplate["PRODPRC_INFO"]();
			newNet_info.find("OPERATE_TYPE").set("1");//1������2�޸ģ�3�˶�
			newNet_info.find("DISCOUNTPLANINSTID").set("0");//�ʷ�ʵ����ʶ��Ĭ��0
			newNet_info.find("ORDER").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
			newNet_info.find("CUSTAGREEMENTID").set("0");//Ĭ�Ͻڵ㣬Ĭ��ֵ0
			newNet_info.find("STATUS").set("A");//�ʷ�״̬��������A���˶�X
			newNet_info.find("PEI_FEE_CODE").set("<%=netNextFee%>");//�ʷѴ���
			newNet_info.find("PEI_FEE_NAME").set("<%=netNextFeeName%>");//�ʷ�����
			newNet_info.find("PRI_FEE_VALID").set("0");//�ʷ���Ч��ʶ��0������Ч��2һ��ԤԼ
			newNet_info.find("EFF_DATE").set("<%=netNextEffTime%>");//��Чʱ��
			newNet_info.find("EXP_DATE").set("<%=netNextExpTime%>");//ʧЧʱ��
			newNet_info.find("PARENTINSTID").set("0");//��ʵ����ʶ��Ĭ��
			newNet_info.find("CURLEVEL").set("0"); //Ĭ��ֵ0
			newNet_info.find("DEVELOP_NO").set("<%=loginNo%>");//��չ����
			netbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(newNet_info);
		}
		
		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(netbusi_info);
	}

	//PRODPRC_BUSIINFO �������-end-----------------------------------------

	//�ʷ�BUSIINFO���-begin----------------------------------------------
	var feebusi_info=instanceTemplate["FEE_BUSIINFO"]();
	feebusi_info.find("BUSIINFO_SEQ").set("1");
	feebusi_info.find("SERVICE_OFFER_ID").set("<%=feeServBusiId%>");
	feebusi_info.find("DOMAIN_TYPE").set("F");
	feebusi_info.find("PHONE_NO").set("<%=phoneNo%>");
	feebusi_info.find("ID_NO").set("<%=id_no_main%>");
	feebusi_info.find("CUST_ID").set("<%=cust_id_main%>");
	feebusi_info.find("BRAND_ID").set("<%=brand_id_main%>");
	feebusi_info.find("GROUP_ID").set("<%=group_id_main%>");

	//�ֽ���---------------------------------------------------
	var cash_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
	if("<%=showCash%>" == "T"){
		cash_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		cash_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		cash_info.find("FEE_TYPE").set("0");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		cash_info.find("FEE_CODE").set("0");//������pay_type
		cash_info.find("FACTOR_TEN").set("<%=cashFactorTen%>");//0���ҳ� ��1����Ա��2������ ���˶�����0
		cash_info.find("FACTOR_ELEVEN").set("<%=cashFactorEleven%>");//�ҳ��ͳ�Ա�Լ���������
		cash_info.find("FACTOR_EIGHTEEN").set("<%=cashName%>");//ר������
		cash_info.find("FACTOR_NINETEEN").set("<%=cashFactorNineteen%>");//����Ҫƴ��
		cash_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(cash_info);
	}

	//ר���---------------------------------------------------
	if("<%=showPayType%>" == "T"){
		var payTypeArr = allPayTypesTemp.split("#");
		var payNameArr = allPayNamesTemp.split("#");
		var payMoneyArr = allPayMoneysTemp.split("#");
		var payRtnTypeArr = allPayRtnTypesTemp.split("#");
		var payRtnClassArr = allPayRtnClassesTemp.split("#");
		var payFactorTenArr = allPayFactorTensTemp.split("#");
		var payFactorEleArr = allPayFactorElevensTemp.split("#");
		var payFactorTwelveArr = allFactorTwelve.split("#");
		var payFactorNineteenArr = allFactorNineteensTemp.split("#");
		for(var i=0;i<payTypeArr.length-1;i++){
			var payType = payTypeArr[i];
			var payName = payNameArr[i];
			var payMoney = payMoneyArr[i];
			var payRtnType = payRtnTypeArr[i];
			var payRtnClass = payRtnClassArr[i];
			var payFactorTen = payFactorTenArr[i];
			var payFactorEle = payFactorEleArr[i];
			var payType_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
			payType_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
			payType_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
			payType_info.find("FEE_TYPE").set("1");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
			payType_info.find("FEE_CODE").set(payType);//������pay_type
			payType_info.find("FACTOR_THREE").set(payMoney);//������payMoney
			payType_info.find("FACTOR_SEVEN").set(payRtnType);//0���Ԥ�棻1������Ԥ��
			if(payRtnType=="1"){
				payType_info.find("FACTOR_EIGHT").set(payRtnClass);//������ʽΪ����Ԥ��ʱ�� 1�����·����ۼƣ�2�������3�����·����ۼƼӲ����4�����·��ز��ۼ�
			}
			payType_info.find("FACTOR_TEN").set(payFactorTen);//�ҳ��ͳ�Ա�Լ�������ʶ,0���ҳ� ��1����Ա��2������ ���˶�����0
			if(payFactorTen == "2"){
				payType_info.find("FACTOR_TWELVE").set("1");//������1 
			}else{
				payType_info.find("FACTOR_TWELVE").set(payFactorTwelveArr[i]);
			}
			payType_info.find("FACTOR_ELEVEN").set(payFactorEle);//�ҳ��ͳ�Ա�Լ���������
			payType_info.find("FACTOR_EIGHTEEN").set(payName);//ר������
			payType_info.find("FACTOR_NINETEEN").set(payFactorNineteenArr[i]);//�Ƿ�ԤԼ����
			payType_info.find("FACTOR_TWENTY").set("<%=netFlag %>");//�����ʶ
			if("<%=opCode%>" == "g798"){
				if("<%=selectType%>" == "3"){
					payType_info.find("FACTOR_TWENTYFIVE").set("3");//�ն��˻���ʶ
				}else{
					payType_info.find("FACTOR_TWENTYFIVE").set("2");//�ն��˻���ʶ
				}
			}
			payType_info.find("FACTOR_TWENTYFSIX").set("<%=cancelType%>");//ȡ�����ͱ�ʶ 3-����ȡ��
			feebusi_info.find("ORDER_LINE_FEELIST").addNode(payType_info);
		}
		
		//��Ϊ��Ա���������ڲ�����ר��ĳ�ԱҲҪ��䱨�ġ�
		//lowCon_type,�Ƿ�Ϊ��Ա������0 ��Ա�ϼƵ��� 1�ҳ�����
		var  lowContType = "<%=lowCon_type%>"; 
		if(lowContType == "0"){
			var cPhone = sysFactorElevenTemp.split("#");//���г�ֵ����
			var cPhoneType = sysFactorTenTemp.split("#");//���г�ֵ�����ֻ�����
			var zPhone = phone;//�����ʷѺ���
			var zPhoneType = phoneType;//�ʷѺ�������
			for(var i=0; i<cPhone.length-1; i++){
				if(!zPhone.contains(cPhone[i])){
					zPhone.push(cPhone[i]);
					zPhoneType.push(cPhoneType[i]);
				}
			}
			//���û��ר��ĳ�Ա
			for(var i=0;i<zPhone.length;i++){
				if((!payFactorEleArr.contains(zPhone[i]))&&zPhoneType[i]!="0"){
					var payType_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
					payType_info.find("RECEIVE_FEE_TYPE").set("");//0���գ�1��
					payType_info.find("RECEIVE_ACC_TYPE").set("");//0��������1������
					payType_info.find("FEE_TYPE").set("");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
					payType_info.find("FEE_CODE").set("");//������pay_type
					payType_info.find("FACTOR_SEVEN").set("");//0���Ԥ�棻1������Ԥ��
					payType_info.find("FACTOR_EIGHT").set("");//������ʽΪ����Ԥ��ʱ�� 1�����·����ۼƣ�2�������3�����·����ۼƼӲ����4�����·��ز��ۼ�
					payType_info.find("FACTOR_TEN").set("1");//�ҳ��ͳ�Ա�Լ�������ʶ,0���ҳ� ��1����Ա��2������ ���˶�����0
					payType_info.find("FACTOR_TWELVE").set("");//������1 
					payType_info.find("FACTOR_ELEVEN").set(zPhone[i]);//�ҳ��ͳ�Ա�Լ���������
					payType_info.find("FACTOR_EIGHTEEN").set("");//ר������
					payType_info.find("FACTOR_NINETEEN").set("");//�Ƿ�ԤԼ����
					payType_info.find("FACTOR_TWENTY").set("");//�����ʶ
					feebusi_info.find("ORDER_LINE_FEELIST").addNode(payType_info);
				}
			}
		}
	}

	//ϵͳ��ֵ����---------------------------------------------------
	if("<%=showSysPayType%>" == "T"){
		var sysPayTypeNameArr = sysPayTypeNameTemp.split("#");
		var sysPayTypeArr = sysPayTypeTemp.split("#");
		var sysPayMoneysArr = sysPayMoneysTemp.split("#");
		var sysRtnTypeArr = sysRtnTypeTemp.split("#");
		var sysRtnClassArr = sysRtnClassTemp.split("#");
		var sysFactorTenArr = sysFactorTenTemp.split("#");
		var sysFactorElevenArr = sysFactorElevenTemp.split("#");
		var sysFactorFourteenArr = sysFactorFourteenTemp.split("#");
		var sysFactorFifteenArr = sysFactorFifteenTemp.split("#");
		var sysFactorsixteenArr = sysFactorsixteenTemp.split("#");
		var sysFactorNineteenArr = sysFactorNineteenTemp.split("#");
		var sysFactorTwentysixArr = sysFactorTwentysixTemp.split("#");
		for(var i=0;i<sysPayTypeArr.length-1;i++){
			var sysPayTypeName = sysPayTypeNameArr[i];
			var sysPayType = sysPayTypeArr[i];
			var sysPayMoneys = sysPayMoneysArr[i];
			var sysRtnType = sysRtnTypeArr[i];
			var sysRtnClass = sysRtnClassArr[i];
			var sysFactorTen = sysFactorTenArr[i];
			var sysFactorEleven = sysFactorElevenArr[i];
			var sysFactorFourteen = sysFactorFourteenArr[i];
			var sysFactorFifteen = sysFactorFifteenArr[i];
			var sysFactorsixteen = sysFactorsixteenArr[i];
			var sysFactorNineteen = sysFactorNineteenArr[i];
			var sysFactorTwentysix = sysFactorTwentysixArr[i];
			var sys_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
			sys_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
			sys_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
			sys_info.find("FEE_TYPE").set("2");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
			sys_info.find("FEE_CODE").set(sysPayType);//������pay_type
			sys_info.find("FACTOR_THREE").set(sysPayMoneys);//������payMoney
			sys_info.find("FACTOR_SEVEN").set(sysRtnType);//0���Ԥ�棻1������Ԥ��
			if(sysRtnType == "1"){
				sys_info.find("FACTOR_EIGHT").set(sysRtnClass);//������ʽΪ����Ԥ��ʱ��,1�����·����ۼƣ�2�������3�����·����ۼƼӲ����4�����·��ز��ۼ�
			}
			sys_info.find("FACTOR_TEN").set(sysFactorTen);//0���ҳ� ��1����Ա��2���������˶�����0
			sys_info.find("FACTOR_ELEVEN").set(sysFactorEleven);//�ҳ��ͳ�Ա�Լ�������ʶ
			sys_info.find("FACTOR_FOURTEEN").set(sysFactorFourteen);//ϵͳ��ֵ�Ƿ��н�
			sys_info.find("FACTOR_FIFTEEN").set(sysFactorFifteen);//0��������1��������2�������͸���
			sys_info.find("FACTOR_SIXTEEN").set(sysFactorsixteen);//ϵͳ��ֵ��������
			sys_info.find("FACTOR_EIGHTEEN").set(sysPayTypeName);//ר������
			sys_info.find("FACTOR_NINETEEN").set(sysFactorNineteen);//�Ƿ�ԤԼ����
			sys_info.find("FACTOR_TWENTY").set("<%=netFlag %>");//�����ʶ
			sys_info.find("FACTOR_TWENTYFSIX").set(sysFactorTwentysix);//SP��ҵ���ʶ
			if("<%=opCode%>" == "g798"){
				if("<%=selectType%>" == "3"){
					sys_info.find("FACTOR_TWENTYFIVE").set("3");//�ն��˻���ʶ
				}else{
					sys_info.find("FACTOR_TWENTYFIVE").set("2");//�ն��˻���ʶ
				}
			}
			feebusi_info.find("ORDER_LINE_FEELIST").addNode(sys_info);
		}	
	}
	
	//�˵��Żݱ���---------------------------------------------------
	if("<%=showBillDiscount%>" == "T"){
		var bill_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		bill_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		bill_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		bill_info.find("FEE_TYPE").set("3");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		bill_info.find("FACTOR_TEN").set("<%=billFactorTen%>");//0���ҳ� ��1����Ա��2���������˶�����0
		bill_info.find("FACTOR_ELEVEN").set("<%=billFactorEleven%>");//�ҳ��ͳ�Ա�Լ�������ʶ
		bill_info.find("FACTOR_NINETEEN").set("<%=billFactorNineteen%>");//�Ƿ�ԤԼ����
		bill_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(bill_info);
	}
	
	//�������ѱ���---------------------------------------------------
	if("<%=showUnConsumer%>" == "T" ){
		var consume_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		consume_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		consume_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		consume_info.find("FEE_TYPE").set("5");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		consume_info.find("FACTOR_TEN").set("<%=unConFactorTen%>");//0���ҳ� ��1����Ա��2���������˶�����0
		consume_info.find("FACTOR_ELEVEN").set("<%=unConFactorEleven%>");//�ҳ��ͳ�Ա�Լ�������ʶ
		consume_info.find("FACTOR_NINETEEN").set("<%=unConFactorNineteen%>");//�Ƿ�ԤԼ����
		consume_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(consume_info);
	}

	if("<%=opCode%>"=="g796"){
		//���������---------------------------------------------------
		var resource_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		resource_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		resource_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		resource_info.find("FEE_TYPE").set("6");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		//resource_info.find("FACTOR_TEN").set("");//0���ҳ� ��1����Ա��2���������˶�����0
		resource_info.find("FACTOR_THREE").set(resFee);
		resource_info.find("FACTOR_TEN").set("0");
		resource_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//��������
		resource_info.find("FACTOR_SEVENTEEN").set(resType);//���ֻ�������
		resource_info.find("FACTOR_EIGHTEEN").set("���ֻ���");//���ֻ���
		resource_info.find("FACTOR_NINETEEN").set("");//�Ƿ�ԤԼ����
		resource_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		resource_info.find("SHOULD_PAY").set(resFeeChange);//ʵ��
		resource_info.find("BUSI_SHOULD").set(resFeeChange);//Ӧ��
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(resource_info);
	
		//������Ʒ���---------------------------------------------------
		var gift_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		gift_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		gift_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		gift_info.find("FEE_TYPE").set("7");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		gift_info.find("FACTOR_THREE").set(giftFee);
		gift_info.find("FACTOR_TEN").set("0");
		gift_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//��������
		gift_info.find("FACTOR_SEVENTEEN").set(giftType);//������Ʒ������
		gift_info.find("FACTOR_EIGHTEEN").set("������Ʒ��");//������Ʒ��
		gift_info.find("FACTOR_NINETEEN").set("");//�Ƿ�ԤԼ����
		gift_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		gift_info.find("SHOULD_PAY").set(giftFeeChange);//ʵ��
		gift_info.find("BUSI_SHOULD").set(giftFeeChange);//Ӧ�� 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(gift_info);
		//�����ֿ��---------------------------------------------------
		var score_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		score_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		score_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		score_info.find("FEE_TYPE").set("12");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		score_info.find("FACTOR_THREE").set(scoreFee);
		score_info.find("FACTOR_TEN").set("0");
		score_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//��������
		score_info.find("FACTOR_SEVENTEEN").set("");
		score_info.find("FACTOR_EIGHTEEN").set("�����ֿ�");//������Ʒ��
		score_info.find("FACTOR_NINETEEN").set("");//�Ƿ�ԤԼ����
		score_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		score_info.find("SHOULD_PAY").set(scoreFeeChange);//ʵ��
		score_info.find("BUSI_SHOULD").set(scoreFeeChange);//Ӧ�� 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(score_info);
	}else if("<%=opCode%>"=="g798" && choosType =="0"){
		//������Ʒ���---------------------------------------------------
		var gift_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		gift_info.find("RECEIVE_FEE_TYPE").set("0");//0���գ�1��
		gift_info.find("RECEIVE_ACC_TYPE").set("1");//0��������1������
		gift_info.find("FEE_TYPE").set("7");//0Ϊ�ֽ�1Ϊר�2ϵͳ��ֵ��3�����Żݣ�4���ֵֿۣ�5�������ѣ������󣩣�6������
		gift_info.find("FACTOR_THREE").set(giftFee);
		gift_info.find("FACTOR_TEN").set("0");
		gift_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//��������
		gift_info.find("FACTOR_SEVENTEEN").set(giftType);//������Ʒ������
		gift_info.find("FACTOR_EIGHTEEN").set("������Ʒ��");//������Ʒ��
		gift_info.find("FACTOR_NINETEEN").set("");//�Ƿ�ԤԼ����
		gift_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		gift_info.find("SHOULD_PAY").set(giftFeeChange);//ʵ��
		gift_info.find("BUSI_SHOULD").set(giftFeeChange);//Ӧ�� 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(gift_info);
	}
	if("<%=showResource%>" == "T" && "<%=opCode%>"=="g798" ){
		feebusi_info.find("MARKET_PRICE").set("<%=marketPrice%>");
		feebusi_info.find("TAX_PERCENT").set("<%=taxPercent%>");
		feebusi_info.find("TAX_FEE").set("<%=taxFee%>");
	}
	cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(feebusi_info);
	//�ʷ�BUSIINFO���-end ---------------------------------------------
	
	//�ն�BUSIINFO���-begin----------------------------------------
	
	if("<%=showResource%>" == "T" && "<%=opCode%>"=="g798" ){
		var res_busiinfo=instanceTemplate["RES_BUSIINFO"]();
		res_busiinfo.find("BUSIINFO_SEQ").set("1");
		res_busiinfo.find("SERVICE_OFFER_ID").set("<%=resServBusiId%>");
		res_busiinfo.find("DOMAIN_TYPE").set("Z");
		res_busiinfo.find("PHONE_NO").set("<%=phoneNo%>");
		res_busiinfo.find("ID_NO").set("<%=id_no_main%>");
		res_busiinfo.find("CUST_ID").set("<%=cust_id_main%>");
		res_busiinfo.find("BRAND_ID").set("<%=brand_id_main%>");
		res_busiinfo.find("GROUP_ID").set("<%=group_id_main%>");
		var res_info = instanceTemplate["RES_INFO"]();
		res_info.find("SALE_NOTE").set("Ӫ���");
		res_info.find("RES_COST_FEE").set("<%=resCostPrice%>");
		res_info.find("RES_SALE_FEE").set("<%=resourceFee%>");
		res_info.find("RES_REAL_FEE").set("<%=resRealFee%>");
		res_info.find("RESOURCE_BRAND").set("<%=resourceBrand%>");
		res_info.find("RESOURCE_MODEL").set("<%=resourceModel%>");
		res_info.find("RESOURCE_RES_CODE").set("<%=resourceResCode%>");
		res_info.find("RESOURCE_BRAND_CODE").set("<%=resourceBrandCode%>");
		res_info.find("IMEI_CODE").set("<%=resourceImeiCode%>");
		res_info.find("DELIVERY_TIME").set("<%=deliveryTime%>");
		res_info.find("QUALITY_LIMIT").set("<%=qualityLimit%>");
		res_info.find("RESOURCE_UNDEADLINE").set("<%=resUndeadLine%>");
		res_info.find("RESOURCE_PERCENT").set("<%=resPercent%>");
		res_info.find("RESOURCE_MONTH_PAY").set("<%=resMonthPay%>");
		res_info.find("SALE_CODE").set("40");
		res_info.find("RES_BUSI_TYPE").set("21");
		res_busiinfo.find("BUSI_MODEL.RES_INFO_LIST").addNode(res_info);
		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(res_busiinfo);
	}
	//�ն�BUSIINFO���-end----------------------------------------
	
	//����BUSIINFO���-begin--------------------------------------
	if("<%=showScore%>" == "T" && "<%=opCode%>"=="g798"){
		var score_busiinfo=instanceTemplate["SCORE_BUSIINFO"]();
		score_busiinfo.find("BUSIINFO_SEQ").set("1");
		score_busiinfo.find("SERVICE_OFFER_ID").set("<%=scoreServBusiId%>");
		score_busiinfo.find("DOMAIN_TYPE").set("S");
		score_busiinfo.find("PHONE_NO").set("<%=phoneNo%>");
		score_busiinfo.find("ID_NO").set("<%=id_no_main%>");
		score_busiinfo.find("CUST_ID").set("<%=cust_id_main%>");
		score_busiinfo.find("BRAND_ID").set("<%=brand_id_main%>");
		score_busiinfo.find("GROUP_ID").set("<%=group_id_main%>");
		var deduction_integral_busi_info = instanceTemplate["DEDUCTION_INTEGRAL_BUSI_INFO"]();
		deduction_integral_busi_info.find("SCORE_TYPE").set("3");//�˻���
		deduction_integral_busi_info.find("SCORE_VALUE").set("<%=scoreValue%>");
		deduction_integral_busi_info.find("RES_NUM").set("");
		deduction_integral_busi_info.find("CON_MONEY").set("");
		deduction_integral_busi_info.find("FACTOR_ONE").set("");
		deduction_integral_busi_info.find("FACTOR_TWO").set("");
		deduction_integral_busi_info.find("FACTOR_THREE").set("");
		deduction_integral_busi_info.find("FACTOR_FOUR").set("");
		deduction_integral_busi_info.find("FACTOR_FIVE").set("");
		score_busiinfo.find("BUSI_MODEL.DEDUCTION_INTEGRAL_BUSI_LIST").addNode(deduction_integral_busi_info);
		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(score_busiinfo);		
	}else if("<%=showNetScore%>" == "T" && "<%=opCode%>"=="g796"){
		var score_busiinfo=instanceTemplate["SCORE_BUSIINFO"]();
		score_busiinfo.find("BUSIINFO_SEQ").set("1");
		score_busiinfo.find("SERVICE_OFFER_ID").set("<%=scoreServBusiId%>");
		score_busiinfo.find("DOMAIN_TYPE").set("S");
		score_busiinfo.find("PHONE_NO").set("<%=phoneNo%>");
		score_busiinfo.find("ID_NO").set("<%=id_no_main%>");
		score_busiinfo.find("CUST_ID").set("<%=cust_id_main%>");
		score_busiinfo.find("BRAND_ID").set("<%=brand_id_main%>");
		score_busiinfo.find("GROUP_ID").set("<%=group_id_main%>");
		var deduction_integral_busi_info = instanceTemplate["DEDUCTION_INTEGRAL_BUSI_INFO"]();
		deduction_integral_busi_info.find("SCORE_TYPE").set("1");//�˻���
		deduction_integral_busi_info.find("SCORE_VALUE").set("<%=netScore%>");
		deduction_integral_busi_info.find("RES_NUM").set("");
		deduction_integral_busi_info.find("CON_MONEY").set("");
		deduction_integral_busi_info.find("FACTOR_ONE").set("3");
		deduction_integral_busi_info.find("FACTOR_TWO").set("");
		deduction_integral_busi_info.find("FACTOR_THREE").set("");
		deduction_integral_busi_info.find("FACTOR_FOUR").set("");
		deduction_integral_busi_info.find("FACTOR_FIVE").set("");
		score_busiinfo.find("BUSI_MODEL.DEDUCTION_INTEGRAL_BUSI_LIST").addNode(deduction_integral_busi_info);
		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(score_busiinfo);	
	}
	//����BUSIINFO���-end----------------------------------------
	
	//���ڸ���BUSIINFO���-begin----------------------------------------
	 var databusi_info=instanceTemplate["DATA_LIST_BUSIINFO"]();
	databusi_info.find("BUSIINFO_SEQ").set("1");
	databusi_info.find("SERVICE_OFFER_ID").set("<%=commServBusiId%>");
	databusi_info.find("DOMAIN_TYPE").set("FQ");
	databusi_info.find("PHONE_NO").set("<%=phoneNo%>");
	databusi_info.find("ID_NO").set("<%=id_no_main%>");
	databusi_info.find("CUST_ID").set("<%=cust_id_main%>");
	databusi_info.find("BRAND_ID").set("<%=brand_id_main%>");
	databusi_info.find("GROUP_ID").set("<%=group_id_main%>");
	var data_info = instanceTemplate["DATA_LIST_INFO"]();
	if( "<%=showGift%>" == "T"){
		data_info.find("CHK_LENGTH").set("<%=chkLength%>");
	}
	if("<%=showResource%>" == "T" && "<%=resMonthPay%>"!="0" && ("<%=actClass%>" == "15" || "<%=actClass%>"=="77" || "<%=actClass%>"=="78" || "<%=actClass%>"=="25")){
		data_info.find("RESOURCE_MONTH_PAY").set("<%=resMonthPay%>");
		data_info.find("RESOURCE_UNDEADLINE").set("<%=resUndeadLine%>");
	}
	
	if("<%=showGIFT%>" == "T" && "<%=opCode%>"=="g798" ){
		data_info.find("GIFT_CODE").set("<%=GIFT_CODE%>");
		data_info.find("SCORE_VALUE").set("<%=SCORE_VALUE%>");
		data_info.find("PLANT_FLAG").set("<%=PLANT_FLAG%>");
	}
	
	databusi_info.find("BUSI_MODEL").addNode(data_info);
	//ȫ��һ�廯SP
	if("<%=gSpStr%>" != ""){
		var gSpStrArr = "<%=gSpStr%>".split(",");
		for(var i=0; i<gSpStrArr.length-1; i++){
			gSpStr = gSpStrArr[i];
			if(gSpStr.indexOf("#06#") < 0){
				continue;
			}
			gSpStr = gSpStr.replace("#06#", "#07#");
			var gspInfo = instanceTemplate["GSP_INFO"]();
			gspInfo.find("GSP_STR").set(gSpStr);
			databusi_info.addNode(gspInfo);
		}
	}
	cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(databusi_info);
	
	//SP ҵ�� BUSIINFO���-begin----------------------------------------
	 var dataBusiInfo=instanceTemplate["DATA_LIST_BUSIINFO"]();
	 dataBusiInfo.find("BUSIINFO_SEQ").set("1");
	 dataBusiInfo.find("SERVICE_OFFER_ID").set("<%=spServBusiId%>");
	 dataBusiInfo.find("DOMAIN_TYPE").set("SP");
	 dataBusiInfo.find("PHONE_NO").set("<%=phoneNo%>");
	 dataBusiInfo.find("ID_NO").set("<%=id_no_main%>");
	 dataBusiInfo.find("CUST_ID").set("<%=cust_id_main%>");
	 dataBusiInfo.find("BRAND_ID").set("<%=brand_id_main%>");
	 dataBusiInfo.find("GROUP_ID").set("<%=group_id_main%>");
	//var dataInfo = instanceTemplate["DATA_LIST_INFO"]();
	//dataBusiInfo.find("BUSI_MODEL").addNode(dataInfo);
	//SPҵ��
	if("<%=showSP%>" == "T"){
		var spCodeArr = spCodeTemp.split("#");
		var busiCodeArr = busiCodeTemp.split("#");
		var startDateArr = startDateTemp.split("#");
		var endDateArr = endDateTemp.split("#");
		var boxIdArr = boxIdTemp.split("#");
		
		for(var i=0;i<spCodeArr.length-1;i++){
			var spCode = spCodeArr[i];
			var busiCode = busiCodeArr[i];
			var startDate = startDateArr[i];
			var endDate = endDateArr[i];
			var boxId = boxIdArr[i];
		
			var SPInfo = instanceTemplate["SP_INFO"]();
			SPInfo.find("SP_CODE").set(spCode);
			SPInfo.find("BUSI_CODE").set(busiCode);
			SPInfo.find("START_DATE").set(startDate);
			SPInfo.find("END_DATE").set(endDate);
			SPInfo.find("BOX_ID").set(boxId);
			dataBusiInfo.find("BUSI_MODEL").addNode(SPInfo);
		}
	}
	cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(dataBusiInfo);
	//SP ҵ��BUSIINFO���-end=====================================================
	
	var cancelInfoStrs=cancelInfo.toJson();
	return cancelInfoStrs;
}
</script>