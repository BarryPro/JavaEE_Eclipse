package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @Title:   总对总缴费落地入参dto[]
 * @Description: 
 * @Date : 2015年2月28日下午2:45:25
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期 ：20150715  修改人： LIJXD  修改目的 ：单行本-V1.3.7集团需求 
 *  	增加 CardNo/CardType/CardBusiProp/CardProvince/CallingIDValue/BatchNo/IsGive/PayOrganID/CorrelationID 记录到表里 <p> 	
 */
public class SGrpUnifyPayCfmInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7149042809868798741L;

	//非空
	@ParamDesc(path="BUSI_INFO.ID_TYPE",cons=ConsType.CT001,type="String",len="2",desc="用户标识",memo="01：手机号码和05：物联网号码类型")
	private String 	idType;
	@ParamDesc(path="BUSI_INFO.ID_VALUE",cons=ConsType.CT001,type="String",len="40",desc="入账号码"	,memo="01：手机号码和05：物联网号码")
	private String 	idValue; //号码
	@ParamDesc(path="BUSI_INFO.TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="操作流水号"	,memo="统一支付流水号")
	private String transactionId; 
	@ParamDesc(path="BUSI_INFO.ACTION_DATE",cons=ConsType.CT001,type="String",len="8",desc="操作请求日期",memo="YYYYMMDD")
	private String actionDate ;
	@ParamDesc(path="BUSI_INFO.ACTION_TIME",cons=ConsType.CT001,type="String",len="20",desc="交易时间",memo="YYYYMMDDHH24MISS")
	private String actionTime ;
	
	@ParamDesc(path="BUSI_INFO.ORGAN_ID",cons=ConsType.CT001,type="String",len="4",desc="机构编码"
			,memo="指结算机构。银行充值填写银行机构编码；"
					+ "天猫方案中机构码填写：0051,浙江电商运营中心移动商城填写：0055,"
					+ "移动商城编码,目前用于移动商城通过手机支付、积分支付、混合支付进行扣款的方式对于移动商城跳转到统一支付系统，"
					+ "然后跳转到建行或者银联的方式，机构编码填写建行0004或者银联0057。"
					+ "有价卡电子化系统填写0060")
	private String	organId;
	@ParamDesc(path="BUSI_INFO.CNL_TYP",cons=ConsType.CT001,type="String",len="2",desc="渠道标识"
			,memo="移动网厅：02 ； 天猫店充值：81；建行、浦发侧充值缴费：50~55")
	private String cnlTyp ;
	
	@ParamDesc(path="BUSI_INFO.PAYED_TYPE",cons=ConsType.CT001,type="String",len="2",desc="付费类型"
			,memo="01：缴预存；02缴话费，默认为缴预存；银行方案根据具体情况填写；天猫、移动商城方案中固定")
	private String 	payedType;
	@ParamDesc(path="BUSI_INFO.SETTLE_DATE",cons=ConsType.CT001,type="String",len="8",desc="交易账期"
			,memo="格式YYYYMMDD；交易帐期；银行接口方案指银行的账期；天猫接口方案指浙江运营中心的账期；移动商城方案指移动商城的账期")
	private String 	settleDate;
	@ParamDesc(path="BUSI_INFO.ACTIVITY_CODE",cons=ConsType.CT001,type="String",len="8",desc="",memo="对账字段")
	private String 	activityCode;
	@ParamDesc(path="BUSI_INFO.SESSION_ID",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String 	sessionID;
	@ParamDesc(path="BUSI_INFO.TRANS_IDO",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String 	transIDO;
	@ParamDesc(path="BUSI_INFO.TRANS_IDO_TIME",cons=ConsType.CT001,type="String",len="14",desc="",memo="对账字段")
	private String 	transIDOTime;
	@ParamDesc(path="BUSI_INFO.TRANS_IDH",cons=ConsType.CT001,type="String",len="32",desc="",memo="对账字段")
	private String  transIDH;
	@ParamDesc(path="BUSI_INFO.TRANS_IDH_TIME",cons=ConsType.CT001,type="String",len="14",desc="",memo="对账字段")
	private String 	transIDHTime;
	@ParamDesc(path="BUSI_INFO.MSG_SENDER",cons=ConsType.CT001,type="String",len="4",desc="",memo="对账字段")
	private String 	msgSender;
	@ParamDesc(path="BUSI_INFO.MSG_RECEIVER",cons=ConsType.CT001,type="String",len="4",desc="",memo="对账字段")
	private String 	msgReceiver;
	
	@ParamDesc(path="BUSI_INFO.CHARGE_MONEY",cons=ConsType.CT001,type="long",len="14",desc="充值金额"
			,memo="（要求此金额必须为非负整数，单位：分）对于总对总银行缴费，对应于签约缴费接口的ChargeMoney。")
	private long  chargeMoney;
	@ParamDesc(path="BUSI_INFO.PAY_MENT",cons=ConsType.CT001,type="long",len="14",desc="订单总金额"
			,memo="订单的总金额，即客户付款金额。"
					+ "对于总对总银行缴费，对应签约缴费接口的payed字段；"
					+ "灵犀业务，订单总金额=用户支付金额 + 红包赠送金额；"
					+ "其他业务 订单总金额=用户支付金额；对于无折扣的情况，该字段取值等于充值金额。")
	private long payment ;
	
	@ParamDesc(path="BUSI_INFO.BIP_CODE",cons=ConsType.CT001,type="String",len="32",desc="扣费金额"
			,memo="网站签约缴费：BIP1A160；短信签约缴费：BIP1A161；电话签约缴费：BIP1A162；预付费自动缴费：BIP1A163")
	private String bipCode ;
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.CT001,type="String",len="256",desc="备注",memo="略")
	private String payNote ;
	
	//可空
	@ParamDesc(path="BUSI_INFO.BUSITRANS_ID",cons=ConsType.QUES,type="String",len="32",desc="业务流水号"
			,memo="银行方案填写银行的流水号；如果是移动商城，则填移动商城的报文头中的发起方交易流水号；如果是天猫商城，填浙江运营中心的报文头中的发起方交易流水号；如果是有价卡充值业务，填写有价卡系统生成的TransactionID（供省公司记录并在后续充值稽核文件中填写）;")
	private String 	busiTransID;
	@ParamDesc(path="BUSI_INFO.PAYTRANS_ID",cons=ConsType.QUES,type="String",len="32",desc="支付流水号"
			,memo="银行方案不需要填写；天猫方案填写支付宝流水号；移动商城(未接入银行)填写银行扣款流水号 ；移动商城-积分支付填写积分系统的支付流水")
	private String 	payTransID;
	@ParamDesc(path="BUSI_INFO.ORDER_NO",cons=ConsType.QUES,type="String",len="32",desc="订单号",memo="订单号")
	private String 	orderNo;
	@ParamDesc(path="BUSI_INFO.PRODUCT_NO",cons=ConsType.QUES,type="String",len="32",desc="产品编号",memo="产品编号")
	private String 	productNo;
	@ParamDesc(path="BUSI_INFO.ACTIVITY_NO",cons=ConsType.QUES,type="String",len="32",desc="营销活动号"
			,memo="如果涉及到营销活动，需要填营销活动号")
	private String activityNo;
	@ParamDesc(path="BUSI_INFO.PRODUCTSHELF_NO",cons=ConsType.QUES,type="String",len="32",desc="商品上架编码"
			,memo="银行方案不需要填写；天猫、移动商城方案如果有，则需要填写；移动商城方案：移动商城的商品上架编码， 用于移动商城标识充值商品（优惠/活动），要求省份能够落地保存 ，省份可使用该字段对在对账、结算、运营分析中对不同的充值商品（优惠/活动）进行有效区分，包含集团统一和省份个性化活动，移动商城对每个活动约定的唯一编码。")
	private String productShelfNo;
	@ParamDesc(path="BUSI_INFO.ORDER_CNT",cons=ConsType.QUES,type="String",len="14",desc="订单数量",memo="用户购买的产品数量")
	private long orderCnt;
	
	@ParamDesc(path="BUSI_INFO.COMMISION",cons=ConsType.QUES,type="long",len="14",desc="佣金"
			,memo="佣金费用，单位分：银行方案不需要填写；天猫方案如果有，填写天猫佣金；移动商城不需要填写")
	private long commision;
	@ParamDesc(path="BUSI_INFO.REBATE_FEE",cons=ConsType.QUES,type="long",len="14",desc="积分返点费用"
			,memo="积分返点费用，单位分：银行方案不需要填写；天猫方案如果有，填写积分返点费；移动商城不需要填写")
	private long rebateFee;
	@ParamDesc(path="BUSI_INFO.CREDITCARD_FEE",cons=ConsType.QUES,type="long",len="14",desc="信用卡费用"
			,memo="信用卡费用，单位分（留待扩展，默认为空）")
	private long creditCardFee;
	@ParamDesc(path="BUSI_INFO.SERVICE_FEE",cons=ConsType.QUES,type="long",len="14",desc="电商服务费"
			,memo="运营服务费，单位分：银行方案不需要填写；天猫方案如果有，填写浙江运营费用")
	private long serviceFee;
	@ParamDesc(path="BUSI_INFO.PROD_DISCOUNT",cons=ConsType.QUES,type="long",len="14",desc="产品扣减金额"
			,memo="产品折减金额，单位为“分”（备用字段）")
	private long prodDiscount;
	
	@ParamDesc(path="BUSI_INFO.RESERVE1",cons=ConsType.QUES,type="String",len="128",desc="折扣率"
			,memo="示例如下：1表示无折扣；0.99表示99折；0.995表示99.5折；0.9855表示98.55折。"
					+ "对于总对总银行缴费，对应于签约缴费接口的Discount字段，统一支付取省公司该上发字段，然后透传给省公司，供省公司参考。统一支付不校验该折扣率是否符合充值金额、订单金额的比例关系。"
					+ "省公司不允许给异省副号发起折扣缴费。如果没有此字段，则不做校验。")
	private String reserve1; 
	@ParamDesc(path="BUSI_INFO.RESERVE2",cons=ConsType.QUES,type="String",len="128",desc="预留字段",memo="天猫聚划算等营销（天猫专用）活动")
	private String reserve2;
	@ParamDesc(path="BUSI_INFO.RESERVE3",cons=ConsType.QUES,type="String",len="128",desc="预留字段"
			,memo="红包金额，单位“分”（灵犀语音助手业务使用，费用由灵犀支付，省公司落地保存该字段）")
	private String reserve3;
	@ParamDesc(path="BUSI_INFO.RESERVE4",cons=ConsType.QUES,type="String",len="128",desc="预留字段",memo="略")
	private String reserve4;

	//有价卡增加入参
	@ParamDesc(path="BUSI_INFO.CARDNO",cons=ConsType.QUES,type="String",len="20",desc="卡号"
			,memo="电子卡卡号：如果机构编码OrganID等于有价卡系统0060，则此字段必填")
	private String cardNo;
	@ParamDesc(path="BUSI_INFO.CARDTYPE",cons=ConsType.QUES,type="String",len="1",desc="卡业务类型"
			,memo="0：话费充值卡；1：流量充值卡 。如果机构编码OrganID等于有价卡系统0060，则此字段必填")
	private String cardType;
	@ParamDesc(path="BUSI_INFO.CARDBUSIPROP",cons=ConsType.QUES,type="String",len="64",desc="卡业务属性"
			,memo="如xxM流量 当卡业务类型选择流量充值卡时根据具体值返回。如果机构编码OrganID等于有价卡系统0060，则此字段必填")
	private String cardBusiProp;
	@ParamDesc(path="BUSI_INFO.CARDPROVINC",cons=ConsType.QUES,type="String",len="3",desc="卡归属省"
			,memo="参加附录6.4 省编码，如果机构编码OrganID等于有价卡系统0060，则此字段必填。")
	private String cardProvinc;
	@ParamDesc(path="BUSI_INFO.CALLINGIDVALUE",cons=ConsType.QUES,type="String",len="32",desc="主叫号码",memo="冲值接入手机号，非必填写。")
	private String callingIDValue;
	@ParamDesc(path="BUSI_INFO.BATCHNO",cons=ConsType.QUES,type="String",len="2",desc="对账批次"
			,memo="从01开始到12，一天12场批次，每2小时一次。如果机构编码OrganID等于有价卡系统0060，则此字段必填。")
	private String batchNo;
	@ParamDesc(path="BUSI_INFO.ISGIVE",cons=ConsType.QUES,type="String",len="128",desc="是否赠送"
			,memo="0:非赠送；1: 赠送 。如果机构编码OrganID等于有价卡系统0060，则此字段必填")
	private String isGive;
	
	//移动商城增加入参
	@ParamDesc(path="BUSI_INFO.PAYORGANID",cons=ConsType.QUES,type="String",len="4",desc="支付机构编码"
			,memo="见附录6.2系统机构编码 ：目前由移动商城根据业务需求填写。对于积分支付，填写为“0063 积分商城”；对于现金支付，填写“手机支付”、“支付宝”或者其他支付机构的编码。")
	private String payOrganID;
	@ParamDesc(path="BUSI_INFO.CORRELATIONID",cons=ConsType.QUES,type="String",len="32",desc="关联号"
			,memo="移动商城“混合支付业务”填写（由移动商城填写混合支付订单的父订单关联号，移动商城带给统一支付、统一支付再带给省。可用于客户投诉时，对混合支付的两笔交易进行关联，要求省份保存该字段）；")
	private String correlationID;
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		//非空
		setIdType(arg0.getStr(getPathByProperName("idType")));
		setIdValue(arg0.getStr(getPathByProperName("idValue")));
		setTransactionId(arg0.getStr(getPathByProperName("transactionId")));
		setActionDate(arg0.getStr(getPathByProperName("actionDate")));
		setActionTime(arg0.getStr(getPathByProperName("actionTime")));
		setOrganId(arg0.getStr(getPathByProperName("organId")));
		setCnlTyp(arg0.getStr(getPathByProperName("cnlTyp")));
		setPayedType(arg0.getStr(getPathByProperName("payedType")));
		setSettleDate(arg0.getStr(getPathByProperName("settleDate")));
		setActivityCode(arg0.getStr(getPathByProperName("activityCode")));
		setSessionID(arg0.getStr(getPathByProperName("sessionID")));
		setTransIDO(arg0.getStr(getPathByProperName("transIDO")));
		setTransIDOTime(arg0.getStr(getPathByProperName("transIDOTime")));
		setTransIDH(arg0.getStr(getPathByProperName("transIDH")));
		setTransIDHTime(arg0.getStr(getPathByProperName("transIDHTime")));
		setMsgSender(arg0.getStr(getPathByProperName("msgSender")));
		setMsgReceiver(arg0.getStr(getPathByProperName("msgReceiver")));
		setBipCode(arg0.getStr(getPathByProperName("bipCode")));
		setChargeMoney(Long.parseLong(arg0.getObject(getPathByProperName("chargeMoney")).toString()));
		setPayment(Long.parseLong(arg0.getObject(getPathByProperName("payment")).toString()));
		//可能为空
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("activityNo")))){
			setActivityNo(arg0.getStr(getPathByProperName("activityNo")).trim());
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payNote")))){
			setPayNote(arg0.getStr(getPathByProperName("payNote")).trim());
		}else {
			String sPayMoney = String.format("%.2f", (double)chargeMoney/100);
			payNote = "集团总对总统一支付号码"+idValue+"交费"+sPayMoney+"元";
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("busiTransID")))){
			setBusiTransID(arg0.getStr(getPathByProperName("busiTransID")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payTransID")))){
			setPayTransID(arg0.getStr(getPathByProperName("payTransID")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("orderNo")))){
			setOrderNo(arg0.getStr(getPathByProperName("orderNo")));
		}	
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("productNo")))){
			setProductNo(arg0.getStr(getPathByProperName("productNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("productShelfNo")))){
			setProductShelfNo(arg0.getStr(getPathByProperName("productShelfNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("orderCnt")))){
			setOrderCnt(Long.parseLong(arg0.getObject(getPathByProperName("orderCnt")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("commision")))){
			setCommision(Long.parseLong(arg0.getObject(getPathByProperName("commision")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("rebateFee")))){
			setRebateFee(Long.parseLong(arg0.getObject(getPathByProperName("rebateFee")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("prodDiscount")))){
			setProdDiscount(Long.parseLong(arg0.getObject(getPathByProperName("prodDiscount")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("creditCardFee")))){
			setCreditCardFee(Long.parseLong(arg0.getObject(getPathByProperName("creditCardFee")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("serviceFee")))){
			setServiceFee(Long.parseLong(arg0.getObject(getPathByProperName("serviceFee")).toString()));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reserve1")))){
			setReserve1(arg0.getStr(getPathByProperName("reserve1")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reserve2")))){
			setReserve2(arg0.getStr(getPathByProperName("reserve2")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reserve3")))){
			setReserve3(arg0.getStr(getPathByProperName("reserve3")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("reserve4")))){
			setReserve4(arg0.getStr(getPathByProperName("reserve4")));
		}
	
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			setOpCode(arg0.getStr(getPathByProperName("opCode")).trim());
		}else {
			 opCode="8000";
		}
		
		//新增需求
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("cardNo")))){
			setCardNo(arg0.getStr(getPathByProperName("cardNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("cardType")))){
			setCardType(arg0.getStr(getPathByProperName("cardType")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("cardBusiProp")))){
			setCardBusiProp(arg0.getStr(getPathByProperName("cardBusiProp")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("cardProvinc")))){
			setCardProvinc(arg0.getStr(getPathByProperName("cardProvinc")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("callingIDValue")))){
			setCallingIDValue(arg0.getStr(getPathByProperName("callingIDValue")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("batchNo")))){
			setBatchNo(arg0.getStr(getPathByProperName("batchNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("isGive")))){
			setIsGive(arg0.getStr(getPathByProperName("isGive")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payOrganID")))){
			setPayOrganID(arg0.getStr(getPathByProperName("payOrganID")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("correlationID")))){
			setCorrelationID(arg0.getStr(getPathByProperName("correlationID")));
		}
	 
		
	}


	/**
	 * @return the idType
	 */
	public String getIdType() {
		return idType;
	}


	/**
	 * @param idType the idType to set
	 */
	public void setIdType(String idType) {
		this.idType = idType;
	}


	/**
	 * @return the idValue
	 */
	public String getIdValue() {
		return idValue;
	}


	/**
	 * @param idValue the idValue to set
	 */
	public void setIdValue(String idValue) {
		this.idValue = idValue;
	}


	/**
	 * @return the transactionId
	 */
	public String getTransactionId() {
		return transactionId;
	}


	/**
	 * @param transactionId the transactionId to set
	 */
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}


	/**
	 * @return the actionDate
	 */
	public String getActionDate() {
		return actionDate;
	}


	/**
	 * @param actionDate the actionDate to set
	 */
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}


	/**
	 * @return the actionTime
	 */
	public String getActionTime() {
		return actionTime;
	}


	/**
	 * @param actionTime the actionTime to set
	 */
	public void setActionTime(String actionTime) {
		this.actionTime = actionTime;
	}


	/**
	 * @return the organId
	 */
	public String getOrganId() {
		return organId;
	}


	/**
	 * @param organId the organId to set
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}


	/**
	 * @return the cnlTyp
	 */
	public String getCnlTyp() {
		return cnlTyp;
	}


	/**
	 * @param cnlTyp the cnlTyp to set
	 */
	public void setCnlTyp(String cnlTyp) {
		this.cnlTyp = cnlTyp;
	}


	/**
	 * @return the payedType
	 */
	public String getPayedType() {
		return payedType;
	}


	/**
	 * @param payedType the payedType to set
	 */
	public void setPayedType(String payedType) {
		this.payedType = payedType;
	}


	/**
	 * @return the settleDate
	 */
	public String getSettleDate() {
		return settleDate;
	}


	/**
	 * @param settleDate the settleDate to set
	 */
	public void setSettleDate(String settleDate) {
		this.settleDate = settleDate;
	}


	/**
	 * @return the activityCode
	 */
	public String getActivityCode() {
		return activityCode;
	}


	/**
	 * @param activityCode the activityCode to set
	 */
	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}


	/**
	 * @return the sessionID
	 */
	public String getSessionID() {
		return sessionID;
	}


	/**
	 * @param sessionID the sessionID to set
	 */
	public void setSessionID(String sessionID) {
		this.sessionID = sessionID;
	}


	/**
	 * @return the transIDO
	 */
	public String getTransIDO() {
		return transIDO;
	}


	/**
	 * @param transIDO the transIDO to set
	 */
	public void setTransIDO(String transIDO) {
		this.transIDO = transIDO;
	}


	/**
	 * @return the transIDOTime
	 */
	public String getTransIDOTime() {
		return transIDOTime;
	}


	/**
	 * @param transIDOTime the transIDOTime to set
	 */
	public void setTransIDOTime(String transIDOTime) {
		this.transIDOTime = transIDOTime;
	}


	/**
	 * @return the transIDH
	 */
	public String getTransIDH() {
		return transIDH;
	}


	/**
	 * @param transIDH the transIDH to set
	 */
	public void setTransIDH(String transIDH) {
		this.transIDH = transIDH;
	}


	/**
	 * @return the transIDHTime
	 */
	public String getTransIDHTime() {
		return transIDHTime;
	}


	/**
	 * @param transIDHTime the transIDHTime to set
	 */
	public void setTransIDHTime(String transIDHTime) {
		this.transIDHTime = transIDHTime;
	}


	/**
	 * @return the msgSender
	 */
	public String getMsgSender() {
		return msgSender;
	}


	/**
	 * @param msgSender the msgSender to set
	 */
	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}


	/**
	 * @return the msgReceiver
	 */
	public String getMsgReceiver() {
		return msgReceiver;
	}


	/**
	 * @param msgReceiver the msgReceiver to set
	 */
	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}


	/**
	 * @return the chargeMoney
	 */
	public long getChargeMoney() {
		return chargeMoney;
	}


	/**
	 * @param chargeMoney the chargeMoney to set
	 */
	public void setChargeMoney(long chargeMoney) {
		this.chargeMoney = chargeMoney;
	}


	/**
	 * @return the payment
	 */
	public long getPayment() {
		return payment;
	}


	/**
	 * @param payment the payment to set
	 */
	public void setPayment(long payment) {
		this.payment = payment;
	}


	/**
	 * @return the bipCode
	 */
	public String getBipCode() {
		return bipCode;
	}


	/**
	 * @param bipCode the bipCode to set
	 */
	public void setBipCode(String bipCode) {
		this.bipCode = bipCode;
	}


	/**
	 * @return the payNote
	 */
	public String getPayNote() {
		return payNote;
	}


	/**
	 * @param payNote the payNote to set
	 */
	public void setPayNote(String payNote) {
		this.payNote = payNote;
	}


	/**
	 * @return the busiTransID
	 */
	public String getBusiTransID() {
		return busiTransID;
	}


	/**
	 * @param busiTransID the busiTransID to set
	 */
	public void setBusiTransID(String busiTransID) {
		this.busiTransID = busiTransID;
	}


	/**
	 * @return the payTransID
	 */
	public String getPayTransID() {
		return payTransID;
	}


	/**
	 * @param payTransID the payTransID to set
	 */
	public void setPayTransID(String payTransID) {
		this.payTransID = payTransID;
	}


	/**
	 * @return the orderNo
	 */
	public String getOrderNo() {
		return orderNo;
	}


	/**
	 * @param orderNo the orderNo to set
	 */
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}


	/**
	 * @return the productNo
	 */
	public String getProductNo() {
		return productNo;
	}


	/**
	 * @param productNo the productNo to set
	 */
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}


	/**
	 * @return the activityNo
	 */
	public String getActivityNo() {
		return activityNo;
	}


	/**
	 * @param activityNo the activityNo to set
	 */
	public void setActivityNo(String activityNo) {
		this.activityNo = activityNo;
	}


	/**
	 * @return the productShelfNo
	 */
	public String getProductShelfNo() {
		return productShelfNo;
	}


	/**
	 * @param productShelfNo the productShelfNo to set
	 */
	public void setProductShelfNo(String productShelfNo) {
		this.productShelfNo = productShelfNo;
	}


	/**
	 * @return the orderCnt
	 */
	public long getOrderCnt() {
		return orderCnt;
	}


	/**
	 * @param orderCnt the orderCnt to set
	 */
	public void setOrderCnt(long orderCnt) {
		this.orderCnt = orderCnt;
	}


	/**
	 * @return the commision
	 */
	public long getCommision() {
		return commision;
	}


	/**
	 * @param commision the commision to set
	 */
	public void setCommision(long commision) {
		this.commision = commision;
	}


	/**
	 * @return the rebateFee
	 */
	public long getRebateFee() {
		return rebateFee;
	}


	/**
	 * @param rebateFee the rebateFee to set
	 */
	public void setRebateFee(long rebateFee) {
		this.rebateFee = rebateFee;
	}


	/**
	 * @return the creditCardFee
	 */
	public long getCreditCardFee() {
		return creditCardFee;
	}


	/**
	 * @param creditCardFee the creditCardFee to set
	 */
	public void setCreditCardFee(long creditCardFee) {
		this.creditCardFee = creditCardFee;
	}


	/**
	 * @return the serviceFee
	 */
	public long getServiceFee() {
		return serviceFee;
	}


	/**
	 * @param serviceFee the serviceFee to set
	 */
	public void setServiceFee(long serviceFee) {
		this.serviceFee = serviceFee;
	}


	/**
	 * @return the prodDiscount
	 */
	public long getProdDiscount() {
		return prodDiscount;
	}


	/**
	 * @param prodDiscount the prodDiscount to set
	 */
	public void setProdDiscount(long prodDiscount) {
		this.prodDiscount = prodDiscount;
	}


	/**
	 * @return the reserve1
	 */
	public String getReserve1() {
		return reserve1;
	}


	/**
	 * @param reserve1 the reserve1 to set
	 */
	public void setReserve1(String reserve1) {
		this.reserve1 = reserve1;
	}


	/**
	 * @return the reserve2
	 */
	public String getReserve2() {
		return reserve2;
	}


	/**
	 * @param reserve2 the reserve2 to set
	 */
	public void setReserve2(String reserve2) {
		this.reserve2 = reserve2;
	}


	/**
	 * @return the reserve3
	 */
	public String getReserve3() {
		return reserve3;
	}


	/**
	 * @param reserve3 the reserve3 to set
	 */
	public void setReserve3(String reserve3) {
		this.reserve3 = reserve3;
	}


	/**
	 * @return the reserve4
	 */
	public String getReserve4() {
		return reserve4;
	}


	/**
	 * @param reserve4 the reserve4 to set
	 */
	public void setReserve4(String reserve4) {
		this.reserve4 = reserve4;
	}


	/**
	 * @return the cardNo
	 */
	public String getCardNo() {
		return cardNo;
	}


	/**
	 * @param cardNo the cardNo to set
	 */
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}


	/**
	 * @return the cardType
	 */
	public String getCardType() {
		return cardType;
	}


	/**
	 * @param cardType the cardType to set
	 */
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}


	/**
	 * @return the cardBusiProp
	 */
	public String getCardBusiProp() {
		return cardBusiProp;
	}


	/**
	 * @param cardBusiProp the cardBusiProp to set
	 */
	public void setCardBusiProp(String cardBusiProp) {
		this.cardBusiProp = cardBusiProp;
	}


	/**
	 * @return the cardProvinc
	 */
	public String getCardProvinc() {
		return cardProvinc;
	}


	/**
	 * @param cardProvinc the cardProvinc to set
	 */
	public void setCardProvinc(String cardProvinc) {
		this.cardProvinc = cardProvinc;
	}


	/**
	 * @return the callingIDValue
	 */
	public String getCallingIDValue() {
		return callingIDValue;
	}


	/**
	 * @param callingIDValue the callingIDValue to set
	 */
	public void setCallingIDValue(String callingIDValue) {
		this.callingIDValue = callingIDValue;
	}


	/**
	 * @return the batchNo
	 */
	public String getBatchNo() {
		return batchNo;
	}


	/**
	 * @param batchNo the batchNo to set
	 */
	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}


	/**
	 * @return the isGive
	 */
	public String getIsGive() {
		return isGive;
	}


	/**
	 * @param isGive the isGive to set
	 */
	public void setIsGive(String isGive) {
		this.isGive = isGive;
	}


	/**
	 * @return the payOrganID
	 */
	public String getPayOrganID() {
		return payOrganID;
	}


	/**
	 * @param payOrganID the payOrganID to set
	 */
	public void setPayOrganID(String payOrganID) {
		this.payOrganID = payOrganID;
	}


	/**
	 * @return the correlationID
	 */
	public String getCorrelationID() {
		return correlationID;
	}


	/**
	 * @param correlationID the correlationID to set
	 */
	public void setCorrelationID(String correlationID) {
		this.correlationID = correlationID;
	}


	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	 
	
}
