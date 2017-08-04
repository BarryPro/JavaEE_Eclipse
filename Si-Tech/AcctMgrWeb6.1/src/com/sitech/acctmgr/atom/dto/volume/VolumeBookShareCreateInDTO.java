package com.sitech.acctmgr.atom.dto.volume;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookShareCreateInDTO extends CommonInDTO {
	//消息头部分
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
	
	//消息体部分
	@ParamDesc(path = "BUSI_INFO.SHARE_ID", cons = ConsType.CT001, desc = "群ID", len = "18", memo = "不可空")
	private String shareId;
	
	@ParamDesc(path = "BUSI_INFO.LIMIT_TYPE", cons = ConsType.CT001, desc = "资源使用限定类型", len = "1", memo = "默认0")
	private String limitType;
	
	@ParamDesc(path = "BUSI_INFO.LIMIT_VALUE", cons = ConsType.CT001, desc = "资源使用限定值", len = "18", memo = "默认0")
	private String limitValue;
	
	@ParamDesc(path = "BUSI_INFO.LIMIT_CYCLE", cons = ConsType.CT001, desc = "资源使用限定周期", len = "5", memo = "默认N，主要总额限定时使用")
	private String limitCycle;
	
	@ParamDesc(path = "BUSI_INFO.EFF_DATE", cons = ConsType.CT001, desc = "生效时间", len = "15", memo = "可空")
	private String effDate;
	
	@ParamDesc(path = "BUSI_INFO.EXP_DATE", cons = ConsType.CT001, desc = "失效时间", len = "15", memo = "可空  不能超过原有账本失效时间")
	private String expDate;

	@Override
	public void decode(MBean arg0) {
		//请求头
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
		
		//请求体
		setShareId(arg0.getStr(getPathByProperName("shareId")));
		setLimitType(arg0.getStr(getPathByProperName("limitType")));
		setLimitValue(arg0.getStr(getPathByProperName("limitValue")));
		setLimitCycle(arg0.getStr(getPathByProperName("limitCycle")));
		setEffDate(arg0.getStr(getPathByProperName("effDate")));
		setExpDate(arg0.getStr(getPathByProperName("expDate")));
		
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

	public String getShareId() {
		return shareId;
	}

	public void setShareId(String shareId) {
		this.shareId = shareId;
	}

	public String getLimitType() {
		return limitType;
	}

	public void setLimitType(String limitType) {
		this.limitType = limitType;
	}

	public String getLimitCycle() {
		return limitCycle;
	}

	public void setLimitCycle(String limitCycle) {
		this.limitCycle = limitCycle;
	}

	public String getLimitValue() {
		return limitValue;
	}

	public void setLimitValue(String limitValue) {
		this.limitValue = limitValue;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	
	
}
