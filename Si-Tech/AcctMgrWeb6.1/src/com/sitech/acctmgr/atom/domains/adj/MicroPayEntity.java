package com.sitech.acctmgr.atom.domains.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class MicroPayEntity {

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="电话号码",memo="略")
	protected String phoneNo;
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="String",len="20",desc="ID号",memo="略")
	protected String idNo;
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="String",len="20",desc="账号",memo="略")
	protected String contractNo;
	@JSONField(name="BUSI_CODE")
	@ParamDesc(path="BUSI_CODE",cons=ConsType.CT001,type="String",len="20",desc="商品代码",memo="略")
	protected String busiCode;
	@JSONField(name="UNIT_CODE")
	@ParamDesc(path="UNIT_CODE",cons=ConsType.CT001,type="String",len="20",desc="商家单位代码",memo="略")
	protected String unitCode;
	@JSONField(name="OP_TYPE")
	@ParamDesc(path="OP_TYPE",cons=ConsType.CT001,type="String",len="20",desc="电话号码",memo="略")
	protected String opType;
	@JSONField(name="UNIT_PRICE")
	@ParamDesc(path="UNIT_PRICE",cons=ConsType.CT001,type="String",len="20",desc="单价",memo="略")
	protected String unitPrice;
	@JSONField(name="PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="20",desc="缴费账本",memo="略")
	protected String payType;
	@JSONField(name="AMOUNT")
	@ParamDesc(path="AMOUNT",cons=ConsType.CT001,type="String",len="40",desc="数量",memo="略")
	protected String amount;
	@JSONField(name="ORI_PAY_SN")
	@ParamDesc(path="ORI_PAY_SN",cons=ConsType.CT001,type="String",len="40",desc="原始支付流水",memo="略")
	protected String oriPaySn;
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="支付金额",memo="略")
	protected long payFee;
	@JSONField(name="ORI_FOREIGN_SN")
	@ParamDesc(path="ORI_FOREIGN_SN",cons=ConsType.CT001,type="String",len="40",desc="原始商家扣费流水",memo="略")
	protected String oriForeignSn;
	@JSONField(name="FOREIGN_TIME")
	@ParamDesc(path="FOREIGN_TIME",cons=ConsType.CT001,type="String",len="40",desc="外部交易时间",memo="略")
	protected String foreignTime;
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.CT001,type="String",len="40",desc="支付流水",memo="略")
	protected String paySn;
	@JSONField(name="INNET_CODE")
	@ParamDesc(path="INNET_CODE",cons=ConsType.CT001,type="String",len="40",desc="交易代码",memo="略")
	protected String innetCode;
	@JSONField(name="FACTOR_FOUR")
	@ParamDesc(path="FACTOR_FOUR",cons=ConsType.CT001,type="String",len="40",desc="商家名称",memo="略")
	protected String factorFour;
	@JSONField(name="FACTOR_FIVE")
	@ParamDesc(path="FACTOR_FIVE",cons=ConsType.CT001,type="String",len="40",desc="商品名称",memo="略")
	protected String factorFive;
	@JSONField(name="USE_FLAG")
	@ParamDesc(path="USE_FLAG",cons=ConsType.CT001,type="String",len="2",desc="使用标志",memo="0：已支，1：冲正")
	protected String useFlag;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	
	@Override
	public String toString() {
		return "MicroPayEntity [phoneNo=" + phoneNo +"]"
				+"[idNo=" + idNo +"]"+"[contractNo=" + contractNo +"]"+"[busiCode=" + busiCode +"]"
				+"[unitCode=" + unitCode +"]"+"[opType=" + opType +"]"+"[unitPrice=" + unitPrice +"]"
				+"[payType=" + payType +"]"+"[amount=" + amount +"]"+"[oriPaySn=" + oriPaySn +"]"
				+"[payFee=" + payFee +"]"+"[paySn=" + paySn +"]"+"[foreignTime=" + foreignTime +"]";
	}

	public String getIdNo() {
		return idNo;
	}
	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}
	public String getContractNo() {
		return contractNo;
	}
	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}
	public String getBusiCode() {
		return busiCode;
	}
	public void setBusiCode(String busiCode) {
		this.busiCode = busiCode;
	}
	public String getUnitCode() {
		return unitCode;
	}
	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}
	public String getOpType() {
		return opType;
	}
	public void setOpType(String opType) {
		this.opType = opType;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getOriPaySn() {
		return oriPaySn;
	}
	public void setOriPaySn(String oriPaySn) {
		this.oriPaySn = oriPaySn;
	}
	public String getOriForeignSn() {
		return oriForeignSn;
	}
	public void setOriForeignSn(String oriForeignSn) {
		this.oriForeignSn = oriForeignSn;
	}
	public String getInnetCode() {
		return innetCode;
	}
	public void setInnetCode(String innetCode) {
		this.innetCode = innetCode;
	}
	public String getFactorFour() {
		return factorFour;
	}
	public void setFactorFour(String factorFour) {
		this.factorFour = factorFour;
	}
	public String getFactorFive() {
		return factorFive;
	}
	public void setFactorFive(String factorFive) {
		this.factorFive = factorFive;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getPayFee() {
		return payFee;
	}

	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}

	public String getPaySn() {
		return paySn;
	}

	public void setPaySn(String paySn) {
		this.paySn = paySn;
	}

	public String getUseFlag() {
		return useFlag;
	}

	public void setUserFlag(String userFlag) {
		this.useFlag = userFlag;
	}
	public String getForeignTime() {
		return foreignTime;
	}

	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
	}


}
