package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class CRMTaxEntity {

	@JSONField(name = "FEE_ACCEPT")
	@ParamDesc(path = "FEE_ACCEPT", cons = ConsType.QUES, type = "String", len = "100", desc = "订单行编号", memo = "略")
	private String feeAccept;

	@JSONField(name = "FEE_TYPE")
	@ParamDesc(path = "FEE_TYPE", cons = ConsType.QUES, type = "String", len = "100", desc = "费用类型", memo = "略")
	private String feeType;

	@JSONField(name = "FEE_CODE")
	@ParamDesc(path = "FEE_CODE", cons = ConsType.QUES, type = "String", len = "100", desc = "费用类型", memo = "略")
	private String feeCode;

	@JSONField(name = "FEE_CODE_SEQ")
	@ParamDesc(path = "FEE_CODE_SEQ", cons = ConsType.QUES, type = "String", len = "100", desc = "费用序号", memo = "略")
	private String feeCodeSeq;

	@JSONField(name = "SHOULD_PAY")
	@ParamDesc(path = "SHOULD_PAY", cons = ConsType.QUES, type = "String", len = "100", desc = "实收金额", memo = "略")
	private String shouldPay;

	@JSONField(name = "TAX_SHOULD")
	@ParamDesc(path = "TAX_SHOULD", cons = ConsType.QUES, type = "String", len = "100", desc = "计税金额", memo = "略")
	private String taxShould;

	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.QUES, type = "String", len = "100", desc = "税率", memo = "略")
	private String taxRate;

	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.QUES, type = "String", len = "100", desc = "税额", memo = "略")
	private String taxFee;

	@JSONField(name = "RESOURCE_NAME")
	@ParamDesc(path = "RESOURCE_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "货品名称", memo = "略")
	private String resourceName;

	@JSONField(name = "RESOURCE_MODEL")
	@ParamDesc(path = "RESOURCE_MODEL", cons = ConsType.QUES, type = "String", len = "100", desc = "货品型号", memo = "略")
	private String resourceModel;

	@JSONField(name = "RESOURCE_UNIT")
	@ParamDesc(path = "RESOURCE_UNIT", cons = ConsType.QUES, type = "String", len = "100", desc = "单位", memo = "略")
	private String resourceUnit;

	@JSONField(name = "RESOURCE_NUM")
	@ParamDesc(path = "RESOURCE_NUM", cons = ConsType.QUES, type = "String", len = "100", desc = "数量", memo = "略")
	private String resourceNum;

	@JSONField(name = "BUY_PRICE")
	@ParamDesc(path = "BUY_PRICE", cons = ConsType.QUES, type = "String", len = "100", desc = "购机款", memo = "略")
	private String buyPrice;

	@JSONField(name = "MADE_PRICE")
	@ParamDesc(path = "MADE_PRICE", cons = ConsType.QUES, type = "String", len = "100", desc = "成本价", memo = "略")
	private String madePrice;

	@JSONField(name = "MORE_FEE")
	@ParamDesc(path = "MORE_FEE", cons = ConsType.QUES, type = "String", len = "100", desc = "移动业务收入-终端补贴增值税 XX金额", memo = "略")
	private String moreFee;

	public String getFeeAccept() {
		return feeAccept;
	}

	public void setFeeAccept(String feeAccept) {
		this.feeAccept = feeAccept;
	}

	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	public String getFeeCode() {
		return feeCode;
	}

	public void setFeeCode(String feeCode) {
		this.feeCode = feeCode;
	}

	public String getFeeCodeSeq() {
		return feeCodeSeq;
	}

	public void setFeeCodeSeq(String feeCodeSeq) {
		this.feeCodeSeq = feeCodeSeq;
	}

	public String getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(String shouldPay) {
		this.shouldPay = shouldPay;
	}

	public String getTaxShould() {
		return taxShould;
	}

	public void setTaxShould(String taxShould) {
		this.taxShould = taxShould;
	}

	public String getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(String taxRate) {
		this.taxRate = taxRate;
	}

	public String getTaxFee() {
		return taxFee;
	}

	public void setTaxFee(String taxFee) {
		this.taxFee = taxFee;
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

	public String getBuyPrice() {
		return buyPrice;
	}

	public void setBuyPrice(String buyPrice) {
		this.buyPrice = buyPrice;
	}

	public String getMadePrice() {
		return madePrice;
	}

	public void setMadePrice(String madePrice) {
		this.madePrice = madePrice;
	}

	public String getMoreFee() {
		return moreFee;
	}

	public void setMoreFee(String moreFee) {
		this.moreFee = moreFee;
	}

	@Override
	public String toString() {
		return "CRMTaxEntity [feeAccept=" + feeAccept + ", feeType=" + feeType + ", feeCode=" + feeCode + ", feeCodeSeq=" + feeCodeSeq
				+ ", shouldPay=" + shouldPay + ", taxShould=" + taxShould + ", taxRate=" + taxRate + ", taxFee=" + taxFee + ", resourceName="
				+ resourceName + ", resourceModel=" + resourceModel + ", resourceUnit=" + resourceUnit + ", resourceNum=" + resourceNum
				+ ", buyPrice=" + buyPrice + ", madePrice=" + madePrice + ", moreFee=" + moreFee + "]";
	}

}

