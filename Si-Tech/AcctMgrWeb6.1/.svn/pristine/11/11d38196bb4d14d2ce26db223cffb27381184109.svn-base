package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class TaxInvoiceFeeEntity {
	
	@JSONField(name = "PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.QUES, type = "long", len = "3", desc = "打印流水", memo = "略")
	private long printSn;
	
	@JSONField(name = "PRINT_ARRAY")
	@ParamDesc(path = "PRINT_ARRAY", cons = ConsType.QUES, type = "int", len = "3", desc = "print_array", memo = "略")
	private int printArray;

	@JSONField(name = "GOODS_NAME")
	@ParamDesc(path = "GOODS_NAME", cons = ConsType.QUES, type = "string", len = "3", desc = "商品名称", memo = "略")
	private String goodsName;
	
	@JSONField(name = "GOODS_NUM")
	@ParamDesc(path = "GOODS_NUM", cons = ConsType.QUES, type = "string", len = "3", desc = "商品数量", memo = "略")
	private String goodsNum;

	@JSONField(name = "GOODS_PRICE")
	@ParamDesc(path = "GOODS_PRICE", cons = ConsType.QUES, type = "string", len = "3", desc = "商品价格", memo = "略")
	private String goodsPrice;

	@JSONField(name = "INVOICE_FEE")
	@ParamDesc(path = "INVOICE_FEE", cons = ConsType.QUES, type = "string", len = "3", desc = "不含税金额", memo = "略")
	private String invoiceFee;

	@JSONField(name = "TAX_RATE")
	@ParamDesc(path = "TAX_RATE", cons = ConsType.QUES, type = "string", len = "3", desc = "税率", memo = "略")
	private String taxRate;

	@JSONField(name = "TAX_FEE")
	@ParamDesc(path = "TAX_FEE", cons = ConsType.QUES, type = "string", len = "3", desc = "税费", memo = "略")
	private String taxFee;

	@JSONField(name = "REQUEST_SN")
	@ParamDesc(path = "REQUEST_SN", cons = ConsType.QUES, type = "string", len = "3", desc = "请求流水，主要给电子发票使用，由于CRM的print_sn 是一个没法区分，所以加请求流水", memo = "略")
	private String requestSn;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "3", desc = "账户号码", memo = "主要给print_info表中使用的字段")
	private long contractNo;

	@JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.QUES, type = "int", len = "3", desc = "账期", memo = "主要给print_info表中使用的字段")
	private int billCycle;

	@JSONField(name = "WRITE_FEE")
	@ParamDesc(path = "WRITE_FEE", cons = ConsType.QUES, type = "long", len = "3", desc = "冲销金额", memo = "主要给print_info表中使用的字段")
	private long writeFee;

	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path = "PAY_TYPE", cons = ConsType.QUES, type = "string", len = "3", desc = "冲销账本类型", memo = "合并是使用的标志")
	private String payType;

	@JSONField(name = "MAIN_CONTRACT_NO")
	@ParamDesc(path = "MAIN_CONTRACT_NO", cons = ConsType.QUES, type = "string", len = "3", desc = "主账户账号", memo = "主要给print_info表中使用的字段")
	private long mainContractNo;

	@JSONField(name = "BALANCE_ID")
	@ParamDesc(path = "BALANCE_ID", cons = ConsType.QUES, type = "string", len = "3", desc = "冲销账本的ID", memo = "该字段用于集团统付和话费红包更新冲销表时用")
	private long balanceId;

	@JSONField(name = "FEE_ACCEPT")
	@ParamDesc(path = "FEE_ACCEPT", cons = ConsType.QUES, type = "string", len = "3", desc = "订单行编号", memo = "营销购机打印发票时使用")
	private String feeAccept;

	@JSONField(name = "FEE_TYPE")
	@ParamDesc(path = "FEE_TYPE", cons = ConsType.QUES, type = "string", len = "3", desc = "费用类型", memo = "营销购机打印发票时使用")
	private String feeType;

	@JSONField(name = "FEE_CODE")
	@ParamDesc(path = "FEE_CODE", cons = ConsType.QUES, type = "string", len = "3", desc = "费用类型", memo = "营销购机打印发票时使用")
	private String feeCode;

	@JSONField(name = "FEE_CODE_SEQ")
	@ParamDesc(path = "FEE_CODE_SEQ", cons = ConsType.QUES, type = "string", len = "3", desc = "费用序号", memo = "营销购机打印发票时使用")
	private String feeCodeSeq;

	@JSONField(name = "ORDER_ID")
	@ParamDesc(path = "ORDER_ID", cons = ConsType.QUES, type = "string", len = "3", desc = "冲销账本的ID", memo = "营销购机打印发票时使用")
	private String orderId;

	@JSONField(name = "GOODS_UNIT")
	@ParamDesc(path = "GOODS_UNIT", cons = ConsType.QUES, type = "string", len = "3", desc = "单位", memo = "营销购机打印发票时使用")
	private String goodsUnit;

	@JSONField(name = "GGXH")
	@ParamDesc(path = "GGXH", cons = ConsType.QUES, type = "string", len = "3", desc = "型号", memo = "营销购机打印发票时使用")
	private String ggxh;


	public String getGoodsUnit() {
		return goodsUnit;
	}

	public void setGoodsUnit(String goodsUnit) {
		this.goodsUnit = goodsUnit;
	}

	public String getGgxh() {
		return ggxh;
	}

	public void setGgxh(String ggxh) {
		this.ggxh = ggxh;
	}

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

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getRequestSn() {
		return requestSn;
	}

	public void setRequestSn(String requestSn) {
		this.requestSn = requestSn;
	}

	public long getBalanceId() {
		return balanceId;
	}

	public void setBalanceId(long balanceId) {
		this.balanceId = balanceId;
	}

	public long getMainContractNo() {
		return mainContractNo;
	}

	public void setMainContractNo(long mainContractNo) {
		this.mainContractNo = mainContractNo;
	}

	public long getPrintSn() {
		return printSn;
	}

	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}

	public int getPrintArray() {
		return printArray;
	}

	public void setPrintArray(int printArray) {
		this.printArray = printArray;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}

	public String getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public String getInvoiceFee() {
		return invoiceFee;
	}

	public void setInvoiceFee(String invoiceFee) {
		this.invoiceFee = invoiceFee;
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

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public long getWriteFee() {
		return writeFee;
	}

	public void setWriteFee(long writeFee) {
		this.writeFee = writeFee;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	@Override
	public String toString() {
		return "TaxInvoiceFeeEntity [printSn=" + printSn + ", printArray=" + printArray + ", goodsName=" + goodsName + ", goodsNum=" + goodsNum
				+ ", goodsPrice=" + goodsPrice + ", invoiceFee=" + invoiceFee + ", taxRate=" + taxRate + ", taxFee=" + taxFee + ", requestSn="
				+ requestSn + ", contractNo=" + contractNo + ", billCycle=" + billCycle + ", writeFee=" + writeFee + ", payType=" + payType
				+ ", mainContractNo=" + mainContractNo + ", balanceId=" + balanceId + ", feeAccept=" + feeAccept + ", feeType=" + feeType
				+ ", feeCode=" + feeCode + ", feeCodeSeq=" + feeCodeSeq + ", orderId=" + orderId + "]";
	}

}
