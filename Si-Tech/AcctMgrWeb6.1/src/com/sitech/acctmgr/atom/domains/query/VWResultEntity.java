package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class VWResultEntity {
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="电话号码",memo="略")
	private String phoneNo = "";
	@JSONField(name="CUST_NAME")
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="100",desc="客户名称",memo="略")
	private String custName = "";
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo = 0;
	@JSONField(name="SPECIAL_TYPE")
	@ParamDesc(path="SPECIAL_TYPE",cons=ConsType.CT001,type="String",len="30",desc="是否专款",memo="略")
	private String specailType = "";
	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="100",desc="预存款名称",memo="略")
	private String payTypeName = "";
	@JSONField(name="ACCT_ITEM_CODE")
	@ParamDesc(path="ACCT_ITEM_CODE",cons=ConsType.CT001,type="String",len="10",desc="账目项",memo="略")
	private String acctItemCode = "";
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="20",desc="应收费用",memo="单位：分")
	private long shouldPay = 0;
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="20",desc="优惠费用",memo="单位：分")
	private long favourFee = 0;
	@JSONField(name="WRTOFF_FEE")
	@ParamDesc(path="WRTOFF_FEE",cons=ConsType.CT001,type="long",len="20",desc="当月划拨",memo="单位：分")
	private long wrtoffFee = 0;
	@JSONField(name="BALANCE_FEE")
	@ParamDesc(path="BALANCE_FEE",cons=ConsType.CT001,type="long",len="20",desc="当前可用余额",memo="单位：分")
	private long balanceFee = 0;
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费余额",memo="单位：分")
	private long oweFee = 0;
	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}
	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}
	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}
	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}
	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}
	/**
	 * @return the specailType
	 */
	public String getSpecailType() {
		return specailType;
	}
	/**
	 * @param specailType the specailType to set
	 */
	public void setSpecailType(String specailType) {
		this.specailType = specailType;
	}
	/**
	 * @return the payTypeName
	 */
	public String getPayTypeName() {
		return payTypeName;
	}
	/**
	 * @param payTypeName the payTypeName to set
	 */
	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}
	/**
	 * @return the acctItemCode
	 */
	public String getAcctItemCode() {
		return acctItemCode;
	}
	/**
	 * @param acctItemCode the acctItemCode to set
	 */
	public void setAcctItemCode(String acctItemCode) {
		this.acctItemCode = acctItemCode;
	}
	/**
	 * @return the shouldPay
	 */
	public long getShouldPay() {
		return shouldPay;
	}
	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}
	/**
	 * @return the favourFee
	 */
	public long getFavourFee() {
		return favourFee;
	}
	/**
	 * @param favourFee the favourFee to set
	 */
	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}
	/**
	 * @return the wrtoffFee
	 */
	public long getWrtoffFee() {
		return wrtoffFee;
	}
	/**
	 * @param wrtoffFee the wrtoffFee to set
	 */
	public void setWrtoffFee(long wrtoffFee) {
		this.wrtoffFee = wrtoffFee;
	}
	/**
	 * @return the balanceFee
	 */
	public long getBalanceFee() {
		return balanceFee;
	}
	/**
	 * @param balanceFee the balanceFee to set
	 */
	public void setBalanceFee(long balanceFee) {
		this.balanceFee = balanceFee;
	}
	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}
	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}
	
	
}
