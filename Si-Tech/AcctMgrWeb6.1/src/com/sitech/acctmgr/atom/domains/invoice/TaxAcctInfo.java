package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@SuppressWarnings("serial")
public class TaxAcctInfo implements Serializable {

	// 银行名称
	@JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "银行名称", memo = "略")
	private String bankName;

	@JSONField(name = "ADDRESS")
	@ParamDesc(path = "ADDRESS", cons = ConsType.QUES, type = "String", len = "100", desc = "公司地址", memo = "略")
	private String address;

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "公司电话", memo = "略")
	private String phoneNo;

	@JSONField(name = "CON_PHONE_NO")
	@ParamDesc(path = "CON_PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "账户对应的服务号码", memo = "略")
	private String conPhoneNo;

	@JSONField(name = "BANK_ACCOUNT")
	@ParamDesc(path = "BANK_ACCOUNT", cons = ConsType.QUES, type = "String", len = "50", desc = "银行账户", memo = "略")
	private String bankAccount;

	// 账户属性类型
	@JSONField(name = "CONTRACTATT_TYPE")
	@ParamDesc(path = "CONTRACTATT_TYPE", cons = ConsType.CT001, type = "String", len = "5", desc = "账户属性类型", memo = "略")
	private String acctType;

	// 账户号
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账户号", memo = "略")
	private long contractNo;

	// 账户名称
	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "账户名称", memo = "略")
	private String contractName;

	// 集团客户ID
	@JSONField(name = "CUST_ID")
	@ParamDesc(path = "CUST_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "集团客户ID", memo = "略")
	private long custId;

	// 开始时间
	@JSONField(name = "EFF_DATE")
	@ParamDesc(path = "EFF_DATE", cons = ConsType.QUES, type = "String", len = "20", desc = "开始时间", memo = "略")
	private String effDate;

	// 结束时间
	@JSONField(name = "EXP_DATE")
	@ParamDesc(path = "EXP_DATE", cons = ConsType.QUES, type = "String", len = "20", desc = "结束时间", memo = "略")
	private String expDate;

	// 资质税号
	@JSONField(name = "TAXPAYER_ID")
	@ParamDesc(path = "TAXPAYER_ID", cons = ConsType.CT001, type = "string", len = "30", desc = "资质税号", memo = "略")
	private String taxPayerId;

	// 集团编码
	@JSONField(name = "UNIT_ID")
	@ParamDesc(path = "UNIT_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "集团编码", memo = "略")
	private long unitId;

	// 集团名称
	@JSONField(name = "UNIT_NAME")
	@ParamDesc(path = "UNIT_NAME", cons = ConsType.CT001, type = "String", len = "100", desc = "集团名称", memo = "略")
	private String unitName;

	@JSONField(name = "REGION_CODE")
	@ParamDesc(path = "REGION_CODE", cons = ConsType.QUES, type = "String", len = "20", desc = "地市代码", memo = "略")
	private String regionCode;

	@JSONField(name = "REGION_NAME")
	@ParamDesc(path = "REGION_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "地市名称", memo = "略")
	private String regionName;

	@JSONField(name = "TAXID_INDEX")
	@ParamDesc(path = "TAXID_INDEX", cons = ConsType.QUES, type = "int", len = "3", desc = "同一账户的税务资质号序号", memo = "略")
	private int taxIdIndex;

	public String getConPhoneNo() {
		return conPhoneNo;
	}

	public void setConPhoneNo(String conPhoneNo) {
		this.conPhoneNo = conPhoneNo;
	}

	/**
	 * @return the taxIdIndex
	 */
	public int getTaxIdIndex() {
		return taxIdIndex;
	}

	/**
	 * @param taxIdIndex
	 *            the taxIdIndex to set
	 */
	public void setTaxIdIndex(int taxIdIndex) {
		this.taxIdIndex = taxIdIndex;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the bankAccount
	 */
	public String getBankAccount() {
		return bankAccount;
	}

	/**
	 * @param bankAccount
	 *            the bankAccount to set
	 */
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode
	 *            the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName
	 *            the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * 
	 */
	public TaxAcctInfo() {
		// TODO Auto-generated constructor stub
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAcctType() {
		return acctType;
	}

	public void setAcctType(String acctType) {
		this.acctType = acctType;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public long getCustId() {
		return custId;
	}

	public void setCustId(long custId) {
		this.custId = custId;
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

	public String getTaxPayerId() {
		return taxPayerId;
	}

	public void setTaxPayerId(String taxPayerId) {
		this.taxPayerId = taxPayerId;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/* (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString() */
	@Override
	public String toString() {
		return "TaxAcctInfo [bankName=" + bankName + ", acctType=" + acctType + ", contractNo=" + contractNo + ", contractName=" + contractName
				+ ", custId=" + custId + ", effDate=" + effDate + ", expDate=" + expDate + ", taxPayerId=" + taxPayerId + ", unitId=" + unitId
				+ ", unitName=" + unitName + ", regionCode=" + regionCode + ", regionName=" + regionName + "]";
	}

}
