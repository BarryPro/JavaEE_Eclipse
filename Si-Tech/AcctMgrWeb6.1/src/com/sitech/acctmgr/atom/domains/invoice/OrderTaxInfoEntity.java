package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class OrderTaxInfoEntity {

	@JSONField(name = "FEE_CODE")
	@ParamDesc(path = "FEE_CODE", cons = ConsType.CT001, type = "String", len = "100", desc = "费用代码", memo = "略")
	private String feeCode;
	@JSONField(name = "MADE_PRICE")
	@ParamDesc(path = "MADE_PRICE", cons = ConsType.CT001, type = "String", len = "100", desc = "成本价", memo = "略")
	private long madePrice;
	@JSONField(name = "RESOURCE_UNIT")
	@ParamDesc(path = "RESOURCE_UNIT", cons = ConsType.CT001, type = "String", len = "100", desc = "单位", memo = "略")
	private String resourceUnit;
	@JSONField(name = "FEE_CODE_SEQ")
	@ParamDesc(path = "FEE_CODE_SEQ", cons = ConsType.CT001, type = "String", len = "100", desc = "费用序号", memo = "略")
	private long feeCodeSeq;

	@JSONField(name = "RESOURCE_NUM")
	@ParamDesc(path = "RESOURCE_NUM", cons = ConsType.CT001, type = "String", len = "100", desc = "数量", memo = "略")
	private String resourceNum;

	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.CT001, type = "String", len = "100", desc = "税额", memo = "略")
	private long taxFee;

	@JSONField(name = "RESOURCE_NAME")
	@ParamDesc(path = "RESOURCE_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "货品名称", memo = "略")
	private String resourceName;

	@JSONField(name = "SHOULD_PAY")
	@ParamDesc(path = "SHOULD_PAY", cons = ConsType.CT001, type = "String", len = "100", desc = "实收金额", memo = "略")
	private long shouldPay;

	@JSONField(name = "RESOURCE_MODEL")
	@ParamDesc(path = "RESOURCE_MODEL", cons = ConsType.CT001, type = "String", len = "100", desc = "货品型号", memo = "略")
	private String resourceModel;

	@JSONField(name = "TAX_SHOULD")
	@ParamDesc(path = "TAX_SHOULD", cons = ConsType.CT001, type = "String", len = "100", desc = "计价金额", memo = "略")
	private long taxShould;

	@JSONField(name = "FEE_TYPE")
	@ParamDesc(path = "FEE_TYPE", cons = ConsType.CT001, type = "String", len = "100", desc = "费用类型", memo = "略")
	private String feeType;

	@JSONField(name = "BUY_PRICE")
	@ParamDesc(path = "BUY_PRICE", cons = ConsType.CT001, type = "String", len = "100", desc = "购机款", memo = "略")
	private long buyPrice;

	@JSONField(name = "MORE_FEE")
	@ParamDesc(path = "MORE_FEE", cons = ConsType.CT001, type = "String", len = "100", desc = "终端补贴增值税", memo = "略")
	private long moreFee;
	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.CT001, type = "String", len = "100", desc = "税率", memo = "略")
	private double taxRate;

	@JSONField(name = "FEE_ACCEPT")
	@ParamDesc(path = "FEE_ACCEPT", cons = ConsType.CT001, type = "String", len = "100", desc = "订单行编号", memo = "略")
	private String feeAccept;

	public String getFeeCode() {
		return feeCode;
	}

	public void setFeeCode(String feeCode) {
		this.feeCode = feeCode;
	}

	public String getResourceUnit() {
		return resourceUnit;
	}

	public void setResourceUnit(String resourceUnit) {
		this.resourceUnit = resourceUnit;
	}

	public String getResourceNum() {
		return resourceNum;
	}

	public void setResourceNum(String resourceNum) {
		this.resourceNum = resourceNum;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	public String getResourceModel() {
		return resourceModel;
	}

	public void setResourceModel(String resourceModel) {
		this.resourceModel = resourceModel;
	}

	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	public double getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(int taxRate) {
		if (taxRate != 0)
			this.taxRate = taxRate / 100.00;
	}

	public String getFeeAccept() {
		return feeAccept;
	}

	public void setFeeAccept(String feeAccept) {
		this.feeAccept = feeAccept;
	}

	public long getMadePrice() {
		return madePrice;
	}

	public void setMadePrice(long madePrice) {
		this.madePrice = madePrice;
	}

	public long getFeeCodeSeq() {
		return feeCodeSeq;
	}

	public void setFeeCodeSeq(long feeCodeSeq) {
		this.feeCodeSeq = feeCodeSeq;
	}

	public long getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(long taxFee) {
		this.taxFee = taxFee;
	}

	public long getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	public long getTaxShould() {
		return taxShould;
	}

	public void setTaxShould(long taxShould) {
		this.taxShould = taxShould;
	}

	public long getBuyPrice() {
		return buyPrice;
	}

	public void setBuyPrice(long buyPrice) {
		this.buyPrice = buyPrice;
	}

	public long getMoreFee() {
		return moreFee;
	}

	public void setMoreFee(long moreFee) {
		this.moreFee = moreFee;
	}

}
