package com.sitech.acctmgr.atom.domains.volume;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

@SuppressWarnings("serial")
public class VolumeBookInOutDetail implements Serializable {
	@JSONField(name = "RESOURCE_BALANCE_ID")
	@ParamDesc(path = "RESOURCE_BALANCE_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "账本标识", memo = "")
	private String balanceId;

	@JSONField(name = "PRODUCT_ID")
	@ParamDesc(path = "PRODUCT_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "产品代码", memo = "黑龙江新增标识")
	private String productId;

	@JSONField(name = "TRADE_SESSION")
	@ParamDesc(path = "TRADE_SESSION", cons = ConsType.CT001, type = "string", len = "40", desc = "交易流水", memo = "")
	private String tradeSession;

	@JSONField(name = "RESOURCE_ACCT_TYPE")
	@ParamDesc(path = "RESOURCE_ACCT_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "账户类型", memo = "")
	private String acctType;

	@JSONField(name = "RESOURCE_VALUE")
	@ParamDesc(path = "RESOURCE_VALUE", cons = ConsType.CT001, type = "string", len = "18", desc = "资源剩余量", memo = "")
	private String value;

	@JSONField(name = "OPER_TYPE")
	@ParamDesc(path = "OPER_TYPE", cons = ConsType.CT001, type = "string", len = "2", desc = "操作类型", memo = "")
	private String operType;

	@JSONField(name = "CHANGE_REASON")
	@ParamDesc(path = "CHANGE_REASON", cons = ConsType.CT001, desc = "变动原因", len = "2", memo = "")
	private String changeReason;

	@JSONField(name = "OPER_CHANNEL")
	@ParamDesc(path = "OPER_CHANNEL", cons = ConsType.CT001, desc = "渠道类型", len = "5", memo = "")
	private String operChannel;

	@JSONField(name = "OPER_ID")
	@ParamDesc(path = "OPER_ID", cons = ConsType.CT001, desc = "操作员工号", len = "18", memo = "")
	private String operId;

	@JSONField(name = "OPER_DATE")
	@ParamDesc(path = "OPER_DATE", cons = ConsType.CT001, desc = "收支日期", len = "14", memo = "")
	private String operDate;

	@JSONField(name = "NOTES")
	@ParamDesc(path = "NOTES", cons = ConsType.CT001, desc = "备注", len = "50", memo = "")
	private String notes;

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

	public String getTradeSession() {
		return tradeSession;
	}

	public void setTradeSession(String tradeSession) {
		this.tradeSession = tradeSession;
	}

	public String getAcctType() {
		return acctType;
	}

	public void setAcctType(String acctType) {
		this.acctType = acctType;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	public String getChangeReason() {
		return changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
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

	public String getOperDate() {
		return operDate;
	}

	public void setOperDate(String operDate) {
		this.operDate = operDate;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@Override
	public String toString() {
		return "VolumeBookInOutDetail{" +
				"balanceId='" + balanceId + '\'' +
				", tradeSession='" + tradeSession + '\'' +
				", acctType='" + acctType + '\'' +
				", value='" + value + '\'' +
				", operType='" + operType + '\'' +
				", changeReason='" + changeReason + '\'' +
				", operChannel='" + operChannel + '\'' +
				", operId='" + operId + '\'' +
				", operDate='" + operDate + '\'' +
				", notes='" + notes + '\'' +
				'}';
	}
}
