<%
	//全局变量和全局操作相关js函数
 %>
<script type="text/javascript">
var cancelInfo = instanceTemplate["CANCELINFO"]();
var root = instanceTemplate["ROOT"]();
//定义数组的一个contains方法用于判断数组中是否包含某一元素
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
	//MSG_TYPE 报文赋值-----------------------------------------
	cancelInfo.find("MSG_TYPE.BATCH_TYPE").set("1");
	cancelInfo.find("MSG_TYPE.TEMPLATE_ID").set("1");
	cancelInfo.find("MSG_TYPE.AUTO_CONFIRM").set("N");
	//OPR_INFO 报文赋值-----------------------------------------
	cancelInfo.find("REQUEST_INFO.OPR_INFO.LOGINACCEPT").set("<%=printAccept%>");//流水，从资源接口取
	cancelInfo.find("REQUEST_INFO.OPR_INFO.OLD_LOGINACCEPT").set("<%=old_loginaccept%>");//原销售流水
	cancelInfo.find("REQUEST_INFO.OPR_INFO.CUSTORDERID").set("<%=custOrderId%>");//客户订单，crm传来的
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ORDERARRAYID").set("<%=orderArrayId%>");//订单子项，crm传来的
	cancelInfo.find("REQUEST_INFO.OPR_INFO.REGION_ID").set("<%=reginCode%>");//地市编码
	cancelInfo.find("REQUEST_INFO.OPR_INFO.CHANNEL_TYPE").set("0");//渠道编码？？？
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
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.SERVICE_NO").set("<%=servBusiId%>");//行业部提供
	cancelInfo.find("REQUEST_INFO.OPR_INFO.SERVICE_NO").set("<%=phoneNo%>");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.CONTRACT_NO").set("");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.IMPOWER_LOGIN").set("");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.MASTER_SERV_ID").set("");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ACTION_TYPE").set("<%=actClass%>");//活动类型
	cancelInfo.find("REQUEST_INFO.OPR_INFO.ACTION_ID").set("<%=actionId%>");//活动ID
	cancelInfo.find("REQUEST_INFO.OPR_INFO.MEANS_ID").set("<%=meansId%>");//营销方式ID
	cancelInfo.find("REQUEST_INFO.OPR_INFO.OP_TIME").set("<%=oper_time%>");//操作时间
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.BUY_ICCID").set("BUY_ICCIDqqq");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.BUY_NAME").set("用户什么名称");
	//cancelInfo.find("REQUEST_INFO.OPR_INFO.PRODPRC_NAME").set("又是神马!!!");
	cancelInfo.find("REQUEST_INFO.OPR_INFO.NOTE").set(note);
	
	//PRINT_INFO 报文赋值-----------------------------------------
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.ACTION_NAME").set("<%=actName%>");//业务名称
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.CUST_NAME").set("<%=cust_name_main%>");//客户名称
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PHONE_NO").set("<%=phoneNo%>");//手机号码
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PRINT_FLAG").set("<%=print_flag%>");//打印标识：0合打，1分打
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_MONEYBIG").set(pay_moneyBig);//打印标识为0时是合计金额：(大写)，为1时是购机款
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_MONEYSMALL").set(pay_moneycould);//打印标识为0时是(小写)，为1时是￥
	if("<%=print_flag%>"=="1"&&"<%=opCode%>"=="g796"){
		cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_SPECIALBIG").set(allPaysBig);//打印标识为1时有效：专款(大写)
		cancelInfo.find("REQUEST_INFO.PRINT_INFO.PAY_SPECIALSMALL").set(allPaysTemp);//打印标识为1时有效：￥(小写)
	}
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.RESOURCEBRAND").set("<%=resourceBrand%>");//终端品牌
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.RESOURCE_MODEL").set("<%=resourceModel%>");//终端型号
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.IMEI_CODE").set("<%=resourceImeiCode%>");//IMEI
	cancelInfo.find("REQUEST_INFO.PRINT_INFO.LOGIN_NAME").set("<%=loginNo%>");//开票人


	//资费填充：主资费、附加资费-------------begin----------------
	//主资费信息
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
	var priFeeOperateTypeArr = "<%=priFeeOperateTypeTemp%>".split("#");//主资费操作方式
	var nextFeeOperateTypeArr = "<%=nextFeeOperateTypeTemp%>".split("#");//下一档主资费操作方式
	//附加资费信息
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
	//取出资费中所有不重复的号码,根据号码取出相应号码下的主资费、附加资费信息
	var phone = new Array();
	var idNo = new Array();
	var custId = new Array();
	var brandId = new Array();
	var phoneType = new Array();
	//主资费号码
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
	//附加资费号码
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
	//资费报文填充
	for(var i=0;i<phone.length;i++){
		/*公共信息填充*/
		var prodbusi_info = instanceTemplate["PRODPRC_BUSIINFO"]();
		prodbusi_info.find("BUSIINFO_SEQ").set("1");
		prodbusi_info.find("SERVICE_OFFER_ID").set(phoneType[i]=="B"?"40042":"<%=prodServBusiId%>");
		prodbusi_info.find("DOMAIN_TYPE").set("P");
		prodbusi_info.find("PHONE_NO").set(phone[i]);
		prodbusi_info.find("ID_NO").set(idNo[i]);
		prodbusi_info.find("CUST_ID").set(custId[i]);
		prodbusi_info.find("BRAND_ID").set(brandId[i]);
		prodbusi_info.find("GROUP_ID").set("<%=groupId%>");
		//主资费填充
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
				
				//主资费报文------------------------------------------------
				if(priFeeCode != "null" && priFeeCode != ""){
					var Spe_info=instanceTemplate["PRODPRC_INFO"]();
					Spe_info.find("OPERATE_TYPE").set(priFeeOperateType);//1订购，2修改，3退订
					Spe_info.find("DISCOUNTPLANINSTID").set(CProdInstId);//资费实例标识：默认0
					Spe_info.find("ORDER").set("0");//默认节点，默认值0
					Spe_info.find("CUSTAGREEMENTID").set("0");//默认节点，默认值0
					Spe_info.find("STATUS").set("X");//资费状态：订购传A，退订X
					Spe_info.find("PEI_FEE_CODE").set(priFeeCode);//资费代码
					Spe_info.find("PEI_FEE_NAME").set(priFeeName);//资费名称
					Spe_info.find("PRI_FEE_VALID").set(priFeeValid);//资费生效标识：0立即生效，2一般预约
					Spe_info.find("DISTRI_FEE_NAME").set(distriFeeName);//小区资费名称
					Spe_info.find("DISTRI_FEE_CODE").set(distriFeeCode);//小区资费代码
					Spe_info.find("EFF_DATE").set(CurMOfferEffTime);//生效时间
					Spe_info.find("EXP_DATE").set(CurMOfferExpTime);//失效时间
					Spe_info.find("PARENTINSTID").set("0");//父实例标识：默认
					Spe_info.find("CURLEVEL").set("0");//默认值0
					Spe_info.find("DEVELOP_NO").set("<%=loginNo%>");//发展工号
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(Spe_info);
				}
				//主资费下的可选资费报文------------------------------------------------
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
					//如果原状态为订购 则old = A 取消之后需要传A 所以如果新旧状态不等说明订购状态无变化
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
						kxInfo.find("DISTRI_FEE_NAME").set(infoArr[1]);//小区资费名称
						kxInfo.find("DISTRI_FEE_CODE").set(infoArr[0]);//小区资费代码
					}
					
					kxInfo.find("KX_HABITUS_BUNCH").set(oldStatus);
					kxInfo.find("EFF_DATE").set(feeExtData[5]);
					kxInfo.find("EXP_DATE").set(feeExtData[6]);
					kxInfo.find("PARENTINSTID").set("0");
					kxInfo.find("CURLEVEL").set("0");
					kxInfo.find("DEVELOP_NO").set("<%=loginNo%>");
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(kxInfo);
				}
				//新订购主资费报文------------------------------------------------
				if(NextMOfferId != "" && NextMOfferId != null){
					var newFee_info=instanceTemplate["PRODPRC_INFO"]();
					newFee_info.find("OPERATE_TYPE").set(netFeeOperateType);//1订购，2修改，3退订
					newFee_info.find("DISCOUNTPLANINSTID").set(nextOfferInstId);//资费实例标识：默认0
					newFee_info.find("ORDER").set("0");//默认节点，默认值0
					newFee_info.find("CUSTAGREEMENTID").set("0");//默认节点，默认值0
					newFee_info.find("STATUS").set("A");//资费状态：订购传A，退订X
					newFee_info.find("PEI_FEE_CODE").set(NextMOfferId);//资费代码
					newFee_info.find("PEI_FEE_NAME").set(NextMOfferName);//资费名称
					newFee_info.find("PRI_FEE_VALID").set("0");//资费生效标识：0立即生效，2一般预约
					newFee_info.find("EFF_DATE").set(NextMOfferEffTime);//生效时间
					newFee_info.find("EXP_DATE").set(NextMOfferExpTime);//失效时间
					newFee_info.find("PARENTINSTID").set("0");//父实例标识：默认
					newFee_info.find("CURLEVEL").set("0"); //默认值0
					newFee_info.find("DEVELOP_NO").set("<%=loginNo%>");//发展工号
					prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(newFee_info);
				}
			}
		}
		
		//附加资费填充
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
				//附加资费报文-------------------------------------------------
				var addFee_info=instanceTemplate["PRODPRC_INFO"]();
				addFee_info.find("OPERATE_TYPE").set("3");//1订购，2修改，3退订
				addFee_info.find("DISCOUNTPLANINSTID").set(instId);//资费实例标识：默认0
				addFee_info.find("ORDER").set("0");//默认节点，默认值0
				addFee_info.find("CUSTAGREEMENTID").set("0");//默认节点，默认值0
				addFee_info.find("STATUS").set("X");//资费状态：订购传A，退订X
				addFee_info.find("PEI_FEE_CODE").set(addFeeCode);//资费代码
				addFee_info.find("PEI_FEE_NAME").set(addFeeName);//资费名称
				addFee_info.find("PRI_FEE_VALID").set("0");//资费生效标识：0立即生效，2一般预约
				addFee_info.find("EFF_DATE").set(addFeeEffDate);//生效时间
				if("<%=validType%>" == "1"){
					addFee_info.find("EXP_DATE").set("<%=addfee_endtime%>");//失效时间更改为当前时间 quyl更改
				}else{
					addFee_info.find("EXP_DATE").set(addFeeExpDate);//失效时间
				}
				addFee_info.find("PARENTINSTID").set("0");//父实例标识：默认
				addFee_info.find("CURLEVEL").set("0");//默认值0
				addFee_info.find("DEVELOP_NO").set("<%=loginNo%>");//发展工号
				prodbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(addFee_info);
			}
		}

		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(prodbusi_info);
	}
	//资费填充：主资费、附加资费-------------end----------------
	
	
	//宽带资费填充
	if("<%=feeFlag%>"=="1"){
		var netbusi_info = instanceTemplate["PRODPRC_BUSIINFO"]();
		netbusi_info.find("BUSIINFO_SEQ").set("1");
		netbusi_info.find("SERVICE_OFFER_ID").set("40042");//宽带资费默认传40042
		netbusi_info.find("DOMAIN_TYPE").set("P");
		netbusi_info.find("PHONE_NO").set("<%=netPhoneNo%>");
		netbusi_info.find("ID_NO").set("<%=netIdNo%>");
		netbusi_info.find("CUST_ID").set("<%=netCustId%>");
		netbusi_info.find("BRAND_ID").set("<%=netBrandId%>");
		netbusi_info.find("GROUP_ID").set("<%=netGroupId%>");
		
		//宽带主资费报文------------------------------------------------
		if("<%=netFeeCode%>" != ""){
			var net_info=instanceTemplate["PRODPRC_INFO"]();
			net_info.find("OPERATE_TYPE").set("3");//1订购，2修改，3退订
			net_info.find("DISCOUNTPLANINSTID").set("<%=netInstId%>");//资费实例标识：默认0
			net_info.find("ORDER").set("0");//默认节点，默认值0
			net_info.find("CUSTAGREEMENTID").set("0");//默认节点，默认值0
			net_info.find("STATUS").set("X");//资费状态：订购传A，退订X
			net_info.find("PEI_FEE_CODE").set("<%=netFeeCode%>");//资费代码
			net_info.find("PEI_FEE_NAME").set("<%=netFeeName%>");//资费名称
			net_info.find("EFF_DATE").set("<%=netEffTime%>");//生效时间
			net_info.find("EXP_DATE").set("<%=netExpTime%>");//失效时间
			net_info.find("PARENTINSTID").set("0");//父实例标识：默认
			net_info.find("CURLEVEL").set("0");//默认值0
			net_info.find("DEVELOP_NO").set("<%=loginNo%>");//发展工号
			netbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(net_info);
		}
		
		//新订购宽带主资费报文------------------------------------------------
		if("<%=netNextFee%>" != ""){
			var newNet_info=instanceTemplate["PRODPRC_INFO"]();
			newNet_info.find("OPERATE_TYPE").set("1");//1订购，2修改，3退订
			newNet_info.find("DISCOUNTPLANINSTID").set("0");//资费实例标识：默认0
			newNet_info.find("ORDER").set("0");//默认节点，默认值0
			newNet_info.find("CUSTAGREEMENTID").set("0");//默认节点，默认值0
			newNet_info.find("STATUS").set("A");//资费状态：订购传A，退订X
			newNet_info.find("PEI_FEE_CODE").set("<%=netNextFee%>");//资费代码
			newNet_info.find("PEI_FEE_NAME").set("<%=netNextFeeName%>");//资费名称
			newNet_info.find("PRI_FEE_VALID").set("0");//资费生效标识：0立即生效，2一般预约
			newNet_info.find("EFF_DATE").set("<%=netNextEffTime%>");//生效时间
			newNet_info.find("EXP_DATE").set("<%=netNextExpTime%>");//失效时间
			newNet_info.find("PARENTINSTID").set("0");//父实例标识：默认
			newNet_info.find("CURLEVEL").set("0"); //默认值0
			newNet_info.find("DEVELOP_NO").set("<%=loginNo%>");//发展工号
			netbusi_info.find("BUSI_MODEL.PRODPRC_LIST").addNode(newNet_info);
		}
		
		cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(netbusi_info);
	}

	//PRODPRC_BUSIINFO 报文填充-end-----------------------------------------

	//资费BUSIINFO填充-begin----------------------------------------------
	var feebusi_info=instanceTemplate["FEE_BUSIINFO"]();
	feebusi_info.find("BUSIINFO_SEQ").set("1");
	feebusi_info.find("SERVICE_OFFER_ID").set("<%=feeServBusiId%>");
	feebusi_info.find("DOMAIN_TYPE").set("F");
	feebusi_info.find("PHONE_NO").set("<%=phoneNo%>");
	feebusi_info.find("ID_NO").set("<%=id_no_main%>");
	feebusi_info.find("CUST_ID").set("<%=cust_id_main%>");
	feebusi_info.find("BRAND_ID").set("<%=brand_id_main%>");
	feebusi_info.find("GROUP_ID").set("<%=group_id_main%>");

	//现金报文---------------------------------------------------
	var cash_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
	if("<%=showCash%>" == "T"){
		cash_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		cash_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		cash_info.find("FEE_TYPE").set("0");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		cash_info.find("FEE_CODE").set("0");//传费用pay_type
		cash_info.find("FACTOR_TEN").set("<%=cashFactorTen%>");//0：家长 ；1：成员；2：副卡 个人订购传0
		cash_info.find("FACTOR_ELEVEN").set("<%=cashFactorEleven%>");//家长和成员以及副卡号码
		cash_info.find("FACTOR_EIGHTEEN").set("<%=cashName%>");//专款名称
		cash_info.find("FACTOR_NINETEEN").set("<%=cashFactorNineteen%>");//不需要拼串
		cash_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(cash_info);
	}

	//专款报文---------------------------------------------------
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
			payType_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
			payType_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
			payType_info.find("FEE_TYPE").set("1");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
			payType_info.find("FEE_CODE").set(payType);//传费用pay_type
			payType_info.find("FACTOR_THREE").set(payMoney);//传费用payMoney
			payType_info.find("FACTOR_SEVEN").set(payRtnType);//0：活动预存；1：底线预存
			if(payRtnType=="1"){
				payType_info.find("FACTOR_EIGHT").set(payRtnClass);//返还方式为底线预存时传 1：按月返回累计；2：拆包；3：按月返回累计加拆包；4：按月返回不累计
			}
			payType_info.find("FACTOR_TEN").set(payFactorTen);//家长和成员以及副卡标识,0：家长 ；1：成员；2：副卡 个人订购传0
			if(payFactorTen == "2"){
				payType_info.find("FACTOR_TWELVE").set("1");//副卡传1 
			}else{
				payType_info.find("FACTOR_TWELVE").set(payFactorTwelveArr[i]);
			}
			payType_info.find("FACTOR_ELEVEN").set(payFactorEle);//家长和成员以及副卡号码
			payType_info.find("FACTOR_EIGHTEEN").set(payName);//专款名称
			payType_info.find("FACTOR_NINETEEN").set(payFactorNineteenArr[i]);//是否预约办理
			payType_info.find("FACTOR_TWENTY").set("<%=netFlag %>");//宽带标识
			if("<%=opCode%>" == "g798"){
				if("<%=selectType%>" == "3"){
					payType_info.find("FACTOR_TWENTYFIVE").set("3");//终端退机标识
				}else{
					payType_info.find("FACTOR_TWENTYFIVE").set("2");//终端退机标识
				}
			}
			payType_info.find("FACTOR_TWENTYFSIX").set("<%=cancelType%>");//取消类型标识 3-换挡取消
			feebusi_info.find("ORDER_LINE_FEELIST").addNode(payType_info);
		}
		
		//若为成员低消，对于不存在专款的成员也要填充报文。
		//lowCon_type,是否为成员低消，0 成员合计低消 1家长低消
		var  lowContType = "<%=lowCon_type%>"; 
		if(lowContType == "0"){
			var cPhone = sysFactorElevenTemp.split("#");//所有充值号码
			var cPhoneType = sysFactorTenTemp.split("#");//所有充值号码手机类型
			var zPhone = phone;//所有资费号码
			var zPhoneType = phoneType;//资费号码类型
			for(var i=0; i<cPhone.length-1; i++){
				if(!zPhone.contains(cPhone[i])){
					zPhone.push(cPhone[i]);
					zPhoneType.push(cPhoneType[i]);
				}
			}
			//填充没有专款的成员
			for(var i=0;i<zPhone.length;i++){
				if((!payFactorEleArr.contains(zPhone[i]))&&zPhoneType[i]!="0"){
					var payType_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
					payType_info.find("RECEIVE_FEE_TYPE").set("");//0不收，1收
					payType_info.find("RECEIVE_ACC_TYPE").set("");//0不传账务，1传账务
					payType_info.find("FEE_TYPE").set("");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
					payType_info.find("FEE_CODE").set("");//传费用pay_type
					payType_info.find("FACTOR_SEVEN").set("");//0：活动预存；1：底线预存
					payType_info.find("FACTOR_EIGHT").set("");//返还方式为底线预存时传 1：按月返回累计；2：拆包；3：按月返回累计加拆包；4：按月返回不累计
					payType_info.find("FACTOR_TEN").set("1");//家长和成员以及副卡标识,0：家长 ；1：成员；2：副卡 个人订购传0
					payType_info.find("FACTOR_TWELVE").set("");//副卡传1 
					payType_info.find("FACTOR_ELEVEN").set(zPhone[i]);//家长和成员以及副卡号码
					payType_info.find("FACTOR_EIGHTEEN").set("");//专款名称
					payType_info.find("FACTOR_NINETEEN").set("");//是否预约办理
					payType_info.find("FACTOR_TWENTY").set("");//宽带标识
					feebusi_info.find("ORDER_LINE_FEELIST").addNode(payType_info);
				}
			}
		}
	}

	//系统充值报文---------------------------------------------------
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
			sys_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
			sys_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
			sys_info.find("FEE_TYPE").set("2");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
			sys_info.find("FEE_CODE").set(sysPayType);//传费用pay_type
			sys_info.find("FACTOR_THREE").set(sysPayMoneys);//传费用payMoney
			sys_info.find("FACTOR_SEVEN").set(sysRtnType);//0：活动预存；1：底线预存
			if(sysRtnType == "1"){
				sys_info.find("FACTOR_EIGHT").set(sysRtnClass);//返还方式为底线预存时传,1：按月返回累计；2：拆包；3：按月返回累计加拆包；4：按月返回不累计
			}
			sys_info.find("FACTOR_TEN").set(sysFactorTen);//0：家长 ；1：成员；2：副卡个人订购传0
			sys_info.find("FACTOR_ELEVEN").set(sysFactorEleven);//家长和成员以及副卡标识
			sys_info.find("FACTOR_FOURTEEN").set(sysFactorFourteen);//系统充值是否中奖
			sys_info.find("FACTOR_FIFTEEN").set(sysFactorFifteen);//0：主卡；1：副卡；2：主卡和副卡
			sys_info.find("FACTOR_SIXTEEN").set(sysFactorsixteen);//系统充值副卡号码
			sys_info.find("FACTOR_EIGHTEEN").set(sysPayTypeName);//专款名称
			sys_info.find("FACTOR_NINETEEN").set(sysFactorNineteen);//是否预约办理
			sys_info.find("FACTOR_TWENTY").set("<%=netFlag %>");//宽带标识
			sys_info.find("FACTOR_TWENTYFSIX").set(sysFactorTwentysix);//SP新业务标识
			if("<%=opCode%>" == "g798"){
				if("<%=selectType%>" == "3"){
					sys_info.find("FACTOR_TWENTYFIVE").set("3");//终端退机标识
				}else{
					sys_info.find("FACTOR_TWENTYFIVE").set("2");//终端退机标识
				}
			}
			feebusi_info.find("ORDER_LINE_FEELIST").addNode(sys_info);
		}	
	}
	
	//账单优惠报文---------------------------------------------------
	if("<%=showBillDiscount%>" == "T"){
		var bill_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		bill_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		bill_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		bill_info.find("FEE_TYPE").set("3");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		bill_info.find("FACTOR_TEN").set("<%=billFactorTen%>");//0：家长 ；1：成员；2：副卡个人订购传0
		bill_info.find("FACTOR_ELEVEN").set("<%=billFactorEleven%>");//家长和成员以及副卡标识
		bill_info.find("FACTOR_NINETEEN").set("<%=billFactorNineteen%>");//是否预约办理
		bill_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(bill_info);
	}
	
	//底线消费报文---------------------------------------------------
	if("<%=showUnConsumer%>" == "T" ){
		var consume_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		consume_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		consume_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		consume_info.find("FEE_TYPE").set("5");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		consume_info.find("FACTOR_TEN").set("<%=unConFactorTen%>");//0：家长 ；1：成员；2：副卡个人订购传0
		consume_info.find("FACTOR_ELEVEN").set("<%=unConFactorEleven%>");//家长和成员以及副卡标识
		consume_info.find("FACTOR_NINETEEN").set("<%=unConFactorNineteen%>");//是否预约办理
		consume_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(consume_info);
	}

	if("<%=opCode%>"=="g796"){
		//补购机款报文---------------------------------------------------
		var resource_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		resource_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		resource_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		resource_info.find("FEE_TYPE").set("6");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		//resource_info.find("FACTOR_TEN").set("");//0：家长 ；1：成员；2：副卡个人订购传0
		resource_info.find("FACTOR_THREE").set(resFee);
		resource_info.find("FACTOR_TEN").set("0");
		resource_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//主卡号码
		resource_info.find("FACTOR_SEVENTEEN").set(resType);//补手机款类型
		resource_info.find("FACTOR_EIGHTEEN").set("补手机款");//补手机款
		resource_info.find("FACTOR_NINETEEN").set("");//是否预约办理
		resource_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		resource_info.find("SHOULD_PAY").set(resFeeChange);//实收
		resource_info.find("BUSI_SHOULD").set(resFeeChange);//应收
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(resource_info);
	
		//补促销品款报文---------------------------------------------------
		var gift_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		gift_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		gift_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		gift_info.find("FEE_TYPE").set("7");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		gift_info.find("FACTOR_THREE").set(giftFee);
		gift_info.find("FACTOR_TEN").set("0");
		gift_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//主卡号码
		gift_info.find("FACTOR_SEVENTEEN").set(giftType);//补促销品款类型
		gift_info.find("FACTOR_EIGHTEEN").set("补促销品款");//补促销品款
		gift_info.find("FACTOR_NINETEEN").set("");//是否预约办理
		gift_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		gift_info.find("SHOULD_PAY").set(giftFeeChange);//实收
		gift_info.find("BUSI_SHOULD").set(giftFeeChange);//应收 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(gift_info);
		//补积分款报文---------------------------------------------------
		var score_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		score_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		score_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		score_info.find("FEE_TYPE").set("12");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		score_info.find("FACTOR_THREE").set(scoreFee);
		score_info.find("FACTOR_TEN").set("0");
		score_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//主卡号码
		score_info.find("FACTOR_SEVENTEEN").set("");
		score_info.find("FACTOR_EIGHTEEN").set("补积分款");//补促销品款
		score_info.find("FACTOR_NINETEEN").set("");//是否预约办理
		score_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		score_info.find("SHOULD_PAY").set(scoreFeeChange);//实收
		score_info.find("BUSI_SHOULD").set(scoreFeeChange);//应收 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(score_info);
	}else if("<%=opCode%>"=="g798" && choosType =="0"){
		//补促销品款报文---------------------------------------------------
		var gift_info=instanceTemplate["ORDER_LINE_FEE_INFO"]();
		gift_info.find("RECEIVE_FEE_TYPE").set("0");//0不收，1收
		gift_info.find("RECEIVE_ACC_TYPE").set("1");//0不传账务，1传账务
		gift_info.find("FEE_TYPE").set("7");//0为现金，1为专款，2系统充值，3帐务优惠，4积分抵扣，5底限消费（新需求），6购机款
		gift_info.find("FACTOR_THREE").set(giftFee);
		gift_info.find("FACTOR_TEN").set("0");
		gift_info.find("FACTOR_ELEVEN").set("<%=phoneNo%>");//主卡号码
		gift_info.find("FACTOR_SEVENTEEN").set(giftType);//补促销品款类型
		gift_info.find("FACTOR_EIGHTEEN").set("补促销品款");//补促销品款
		gift_info.find("FACTOR_NINETEEN").set("");//是否预约办理
		gift_info.find("FACTOR_TWENTY").set("<%=netFlag %>");
		gift_info.find("SHOULD_PAY").set(giftFeeChange);//实收
		gift_info.find("BUSI_SHOULD").set(giftFeeChange);//应收 
		feebusi_info.find("ORDER_LINE_FEELIST").addNode(gift_info);
	}
	if("<%=showResource%>" == "T" && "<%=opCode%>"=="g798" ){
		feebusi_info.find("MARKET_PRICE").set("<%=marketPrice%>");
		feebusi_info.find("TAX_PERCENT").set("<%=taxPercent%>");
		feebusi_info.find("TAX_FEE").set("<%=taxFee%>");
	}
	cancelInfo.find("REQUEST_INFO.BUSIINFO_LIST").addNode(feebusi_info);
	//资费BUSIINFO填充-end ---------------------------------------------
	
	//终端BUSIINFO填充-begin----------------------------------------
	
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
		res_info.find("SALE_NOTE").set("营销活动");
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
	//终端BUSIINFO填充-end----------------------------------------
	
	//积分BUSIINFO填充-begin--------------------------------------
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
		deduction_integral_busi_info.find("SCORE_TYPE").set("3");//退积分
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
		deduction_integral_busi_info.find("SCORE_TYPE").set("1");//退积分
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
	//积分BUSIINFO填充-end----------------------------------------
	
	//分期付款BUSIINFO填充-begin----------------------------------------
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
	//全网一体化SP
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
	
	//SP 业务 BUSIINFO填充-begin----------------------------------------
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
	//SP业务
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
	//SP 业务BUSIINFO填充-end=====================================================
	
	var cancelInfoStrs=cancelInfo.toJson();
	return cancelInfoStrs;
}
</script>