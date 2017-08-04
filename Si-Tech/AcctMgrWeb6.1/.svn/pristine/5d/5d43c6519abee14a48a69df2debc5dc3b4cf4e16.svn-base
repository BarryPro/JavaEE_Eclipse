package com.sitech.acctmgr.atom.dto.volume;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.volume.TransferOtherEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

@SuppressWarnings("serial")
public class VolumeBookTransferInDTO extends CommonInDTO {
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

	@ParamDesc(path = "BUSI_INFO.ACCT_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "流量帐户", memo = "Acct_id与acct_type不能同时为空")
	private String acctId;
	@ParamDesc(path = "BUSI_INFO.ACCT_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "账户类型", memo = "Acct_id与acct_type不能同时为空")
	private String acctType;
	@ParamDesc(path = "BUSI_INFO.BALANCE_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "流量帐本", memo = "可为空 如果不为空，则不判断Acct_id、Acct_type、BalanceType、ADD_ATTR_CODE，直接扣减balance_id对应的账本；")
	private String balanceId;
	@ParamDesc(path = "BUSI_INFO.BALANCE_TYPE", cons = ConsType.CT001, type = "string", len = "10", desc = "账本类型", memo = "可为空")
	private String balanceType;
	@ParamDesc(path = "BUSI_INFO.ADD_ATTR_CODE", cons = ConsType.CT001, type = "string", len = "150", desc = "流量帐本附加属性", memo = "可空，参看账本附加属性表。编码各省自己定义")
	private String addAttrCode;
	@ParamDesc(path = "BUSI_INFO.CHARGE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "转移流量总额度", memo = "不为空 单位：KB")
	private String chargeValue;
	@ParamDesc(path = "BUSI_INFO.COUNT", cons = ConsType.CT001, type = "string", len = "4", desc = "转出对象个数", memo = "转出对象个数，建议单笔操作转移对象不要太多，建议在10以内。多用户采用多笔操作进行。")
	private String count;
	@ParamDesc(path = "BUSI_INFO.OTHERS", cons = ConsType.PLUS, type = "compx", len = "", desc = "转移对象列表", memo = "")
	private List<TransferOtherEntity> others;
	@ParamDesc(path = "BUSI_INFO.EFF_DATE", cons = ConsType.CT001, type = "string", len = "14", desc = "转入用户流量账本生效时间", memo = "可空 格式：YYYYMMDDHH24MISS如果为空，则取转出账本的生失效时间")
	private String effDate;
	@ParamDesc(path = "BUSI_INFO.EXP_DATE", cons = ConsType.CT001, type = "string", len = "14", desc = "转入用户流量账本失效时间", memo = "可空。格式：YYYYMMDDHH24MISS 如果为空，则取转出账本的生失效时间")
	private String expDate;
	@ParamDesc(path = "BUSI_INFO.QUERY_FLAG", cons = ConsType.CT001, type = "string", len = "1", desc = "返回用户总流量表示", memo = "不可空,0表示不返回,1表示返回")
	private String queryFlag;
	@ParamDesc(path = "BUSI_INFO.PRODUCT_ID", cons = ConsType.QUES, type = "string", len = "18", desc = "产品代码", memo = "黑龙江新增标识")
	private String productId;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
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

		/*请求业务信息*/
		setAcctId(arg0.getStr(getPathByProperName("acctId")));
		setAcctType(arg0.getStr(getPathByProperName("acctType")));
		setBalanceId(arg0.getStr(getPathByProperName("balanceId")));
		setBalanceType(arg0.getStr(getPathByProperName("balanceType")));
		setAddAttrCode(arg0.getStr(getPathByProperName("addAttrCode")));
		setChargeValue(arg0.getStr(getPathByProperName("chargeValue")));
		setCount(arg0.getStr(getPathByProperName("count")));
		setOthers(arg0.getList(getPathByProperName("others"), TransferOtherEntity.class));
		setEffDate(arg0.getStr(getPathByProperName("effDate")));
		setExpDate(arg0.getStr(getPathByProperName("expDate")));
		setQueryFlag(arg0.getStr(getPathByProperName("queryFlag")));
		setProductId(arg0.getStr(getPathByProperName("productId")));

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

	public String getAcctId() {
		return acctId;
	}

	public void setAcctId(String acctId) {
		this.acctId = acctId;
	}

	public String getAcctType() {
		return acctType;
	}

	public void setAcctType(String acctType) {
		this.acctType = acctType;
	}

	public String getBalanceType() {
		return balanceType;
	}

	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}

	public String getAddAttrCode() {
		return addAttrCode;
	}

	public void setAddAttrCode(String addAttrCode) {
		this.addAttrCode = addAttrCode;
	}

	public String getChargeValue() {
		return chargeValue;
	}

	public void setChargeValue(String chargeValue) {
		this.chargeValue = chargeValue;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public List<TransferOtherEntity> getOthers() {
		return others;
	}

	public void setOthers(List<TransferOtherEntity> others) {
		this.others = others;
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

	public String getQueryFlag() {
		return queryFlag;
	}

	public void setQueryFlag(String queryFlag) {
		this.queryFlag = queryFlag;
	}

	public String getBalanceId() {
		return balanceId;
	}

	public void setBalanceId(String balanceId) {
		this.balanceId = balanceId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
}




