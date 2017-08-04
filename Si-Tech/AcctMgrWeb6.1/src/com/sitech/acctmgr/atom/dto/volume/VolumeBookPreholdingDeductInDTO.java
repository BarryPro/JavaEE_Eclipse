package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookPreholdingDeductInDTO extends CommonInDTO {
	@ParamDesc(path = "BUSI_INFO.SERVICE_MSG_TYPE", cons = ConsType.CT001, desc = "业务操作类型", len = "2", memo = "消息类型。具体值参见消息类型定义表。01充入")
	private String serviceMsgType;
	@ParamDesc(path = "BUSI_INFO.CHANGE_REASON", cons = ConsType.CT001, desc = "变动原因", len = "2", memo = "消息类型。具体值参见消息类型定义表。后台程序不做判断,仅用于查询；01 充值 04 转售 07 兑换 08 交易 09 红包")
	private String changeReason;
	@ParamDesc(path = "BUSI_INFO.TRADE_SEQ", cons = ConsType.CT001, desc = "交易流水", len = "40", memo = "流水id")
	private String reqSeq;
	@ParamDesc(path = "BUSI_INFO.MSISDN", cons = ConsType.CT001, desc = "用户号码", len = "15", memo = "")
	private String msisdn;
	@ParamDesc(path = "BUSI_INFO.USER_ID", cons = ConsType.CT001, desc = "用户标识", len = "18", memo = "")
	private String userId;
	@ParamDesc(path = "BUSI_INFO.REGION_ID", cons = ConsType.CT001, desc = "地市编码", len = "2", memo = "可填写默认值“00” 安徽移动填值，如滁州地市填写为22 ")
	private String regionId = "00";
	@ParamDesc(path = "BUSI_INFO.PART_ID", cons = ConsType.CT001, desc = "分区编码", len = "2", memo = "可填写默认值“00”")
	private String partId = "00";
	@ParamDesc(path = "BUSI_INFO.OPER_SOURCE", cons = ConsType.CT001, desc = "来源区分：商户类型 ", len = "5", memo = "")
	private String operSource;
	@ParamDesc(path = "BUSI_INFO.OPER_CHANNEL", cons = ConsType.CT001, desc = "来源区分：渠道类型 ", len = "5", memo = "")
	private String operChannel;
	@ParamDesc(path = "BUSI_INFO.OPER_ID", cons = ConsType.CT001, desc = "来源区分：营业员编号", len = "18", memo = "")
	private String operId;

	@ParamDesc(path = "BUSI_INFO.RESERVE_SESSION", cons = ConsType.CT001, type = "string", len = "40", desc = "预占流水", memo = "")
	private String reserveSession;
	@ParamDesc(path = "BUSI_INFO.CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "预占扣减流量额度", memo = "单位：KB")
	private String chargeValue;
	@ParamDesc(path = "BUSI_INFO.CHARGE_FLAG", cons = ConsType.CT001, type = "string", len = "1", desc = "扣减后冲入标识", memo = "非空，0表示只预占扣减，1表示扣减后冲入。")
	private String chargeFlag;
	@ParamDesc(path = "BUSI_INFO.CHARGE_MSISDN", cons = ConsType.CT001, type = "string", len = "15", desc = "冲入用户号码", memo = "可空")
	private String chargeMsisdn;
	@ParamDesc(path = "BUSI_INFO.CHARGE_USERID", cons = ConsType.CT001, type = "string", len = "18", desc = "冲入用户标识", memo = "可空")
	private String chargeUserId;
	@ParamDesc(path = "BUSI_INFO.PRODUCT_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "产品id", memo = "可空，充值流量账本对应的产品")
	private String productId;
	@ParamDesc(path = "BUSI_INFO.GROUP_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "集团id", memo = "可空，充值流量账本对应的集团id")
	private String groupId1;

	@Override
	public void decode(MBean arg0) {
		/*请求头信息*/
		setServiceMsgType(arg0.getStr(getPathByProperName("serviceMsgType")));
		setChangeReason(arg0.getStr(getPathByProperName("changeReason")));
		setReqSeq(arg0.getStr(getPathByProperName("reqSeq")));
		setMsisdn(arg0.getStr(getPathByProperName("msisdn")));
		setUserId(arg0.getStr(getPathByProperName("userId")));
		setRegionId(arg0.getStr(getPathByProperName("regionId")));
		setPartId(arg0.getStr(getPathByProperName("partId")));
		setOperSource(arg0.getStr(getPathByProperName("operSource")));
		setOperChannel(arg0.getStr(getPathByProperName("operChannel")));
		setOperId(arg0.getStr(getPathByProperName("operId")));

		setReserveSession(arg0.getStr(getPathByProperName("reserveSession")));
		setChargeValue(arg0.getStr(getPathByProperName("chargeValue")));
		setChargeFlag(arg0.getStr(getPathByProperName("chargeFlag")));
		setChargeMsisdn(arg0.getStr(getPathByProperName("chargeMsisdn")));
		setChargeUserId(arg0.getStr(getPathByProperName("chargeUserId")));
		setProductId(arg0.getStr(getPathByProperName("productId")));
		setGroupId1(arg0.getStr(getPathByProperName("groupId1")));
	}

	public String getServiceMsgType() {
		return serviceMsgType;
	}

	public void setServiceMsgType(String serviceMsgType) {
		this.serviceMsgType = serviceMsgType;
	}

	public String getChangeReason() {
		return changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	public String getReqSeq() {
		return reqSeq;
	}

	public void setReqSeq(String reqSeq) {
		this.reqSeq = reqSeq;
	}

	public String getMsisdn() {
		return msisdn;
	}

	public void setMsisdn(String msisdn) {
		this.msisdn = msisdn;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getPartId() {
		return partId;
	}

	public void setPartId(String partId) {
		this.partId = partId;
	}

	public String getOperSource() {
		return operSource;
	}

	public void setOperSource(String operSource) {
		this.operSource = operSource;
	}

	public String getOperChannel() {
		return operChannel;
	}

	public void setOperChannel(String operChannel) {
		this.operChannel = operChannel;
	}

	public String getOperId() {
		return operId;
	}

	public void setOperId(String operId) {
		this.operId = operId;
	}

	public String getReserveSession() {
		return reserveSession;
	}

	public void setReserveSession(String reserveSession) {
		this.reserveSession = reserveSession;
	}

	public String getChargeValue() {
		return chargeValue;
	}

	public void setChargeValue(String chargeValue) {
		this.chargeValue = chargeValue;
	}

	public String getChargeFlag() {
		return chargeFlag;
	}

	public void setChargeFlag(String chargeFlag) {
		this.chargeFlag = chargeFlag;
	}

	public String getChargeMsisdn() {
		return chargeMsisdn;
	}

	public void setChargeMsisdn(String chargeMsisdn) {
		this.chargeMsisdn = chargeMsisdn;
	}

	public String getChargeUserId() {
		return chargeUserId;
	}

	public void setChargeUserId(String chargeUserId) {
		this.chargeUserId = chargeUserId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getGroupId1() {
		return groupId1;
	}

	public void setGroupId1(String groupId1) {
		this.groupId1 = groupId1;
	}

}
