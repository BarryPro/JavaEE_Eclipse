package com.sitech.acctmgr.atom.domains.account;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>
 * Title: 展示账户列表实体
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
public class AccountListEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8276125212039500352L;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "账户号码", memo = "略")
	private long contractNo;

	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "账户名称", memo = "略")
	private String contractName;

	@JSONField(name = "UNCODE_NAME")
	@ParamDesc(path = "UNCODE_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "账户名称", memo = "略")
	private String unCodeName;

	@JSONField(name = "PAY_NAME")
	@ParamDesc(path = "PAY_NAME", cons = ConsType.QUES, type = "String", len = "30", desc = "账户支付类型名称", memo = "略")
	private String payName;
	
	@JSONField(name = "CONTRACTATT_TYPE")
	@ParamDesc(path = "CONTRACTATT_TYPE", cons = ConsType.QUES, type = "String", len = "30", desc = "账户属性", memo = "略")
	private String contracttType;

	@JSONField(name = "CONTRACTATT_NAME")
	@ParamDesc(path = "CONTRACTATT_NAME", cons = ConsType.QUES, type = "String", len = "30", desc = "账户属性类型", memo = "略")
	private String contracttName;

	@JSONField(name = "ORDER_NAME")
	@ParamDesc(path = "ORDER_NAME", cons = ConsType.QUES, type = "String", len = "20", desc = "代付名称", memo = "默认账户或代付账户")
	private String orderName;

	@JSONField(name = "STATUS_NAME")
	@ParamDesc(path = "STATUS_NAME", cons = ConsType.QUES, type = "String", len = "30", desc = "状态名称", memo = "略")
	private String statusName;

	@JSONField(name = "EFF_DATE")
	@ParamDesc(path = "EFF_DATE", cons = ConsType.QUES, type = "String", len = "8", desc = "生效日期", memo = "YYYYMMDD")
	private String effDate;

	@JSONField(name = "EXP_DATE")
	@ParamDesc(path = "EXP_DATE", cons = ConsType.QUES, type = "String", len = "8", desc = "失效日期", memo = "YYYYMMDD")
	private String expDate;

	@JSONField(name = "REMAIN_FEE")
	@ParamDesc(path = "REMAIN_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "余额", memo = "略")
	private long remainFee = 0;

	@JSONField(name = "PREPAY_FEE")
	@ParamDesc(path = "PREPAY_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "预存金额", memo = "略")
	private long prepayFee = 0;

	@JSONField(name = "OWE_FEE")
	@ParamDesc(path = "OWE_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "欠费", memo = "略")
	private long oweFee = 0;

	@JSONField(name = "UNBILL_FEE")
	@ParamDesc(path = "UNBILL_FEE", cons = ConsType.QUES, type = "long", len = "20", desc = "内存欠费", memo = "略")
	private long unBillFee = 0;

	// 下面为离网用户新增内容
	@JSONField(name = "ID_NO")
	@ParamDesc(path = "ID_NO", cons = ConsType.QUES, type = "long", len = "20", desc = "用户号码", memo = "略")
	private long idNo;
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.QUES, type = "String", len = "20", desc = "手机号码", memo = "略")
	private String phoneNo;

	@JSONField(name = "CUST_ID")
	@ParamDesc(path = "CUST_ID", cons = ConsType.QUES, type = "long", len = "20", desc = "客户ID", memo = "略")
	private long custId;

	@JSONField(name = "CUST_NAME")
	@ParamDesc(path = "CUST_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "客户名称", memo = "略")
	private String custName;

	@JSONField(name = "BLUR_CUST_NAME")
	@ParamDesc(path = "BLUR_CUST_NAME", cons = ConsType.QUES, type = "String", len = "100", desc = "模糊化客户名称", memo = "略")
	private String blurCustName;

	@JSONField(name = "OPEN_TIME")
	@ParamDesc(path = "OPEN_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "入网时间", memo = "略")
	private String openTime;

	@JSONField(name = "RUN_TIME")
	@ParamDesc(path = "RUN_TIME", cons = ConsType.QUES, type = "String", len = "20", desc = "离网时间", memo = "略")
	private String runTime;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AccountListEntity [contractNo=" + contractNo + ", contractName=" + contractName + ", unCodeName=" + unCodeName
				+ ", payName=" + payName + ", contracttType=" + contracttType + ", contracttName=" + contracttName + ", orderName="
				+ orderName + ", statusName=" + statusName + ", effDate=" + effDate + ", expDate=" + expDate + ", remainFee=" + remainFee
				+ ", prepayFee=" + prepayFee + ", oweFee=" + oweFee + ", unBillFee=" + unBillFee + ", idNo=" + idNo + ", custId=" + custId
				+ ", custName=" + custName + ", blurCustName=" + blurCustName + ", openTime=" + openTime + ", runTime=" + runTime
				+ ", getContracttType()=" + getContracttType() + ", getContractNo()=" + getContractNo() + ", getContractName()="
				+ getContractName() + ", getPayName()=" + getPayName() + ", getUnCodeName()=" + getUnCodeName() + ", getContracttName()="
				+ getContracttName() + ", getOrderName()=" + getOrderName() + ", getStatusName()=" + getStatusName() + ", getEffDate()="
				+ getEffDate() + ", getExpDate()=" + getExpDate() + ", getRemainFee()=" + getRemainFee() + ", getPrepayFee()="
				+ getPrepayFee() + ", getOweFee()=" + getOweFee() + ", getUnBillFee()=" + getUnBillFee() + ", getIdNo()=" + getIdNo()
				+ ", getCustName()=" + getCustName() + ", getBlurCustName()=" + getBlurCustName() + ", getCustId()=" + getCustId()
				+ ", getRunTime()=" + getRunTime() + ", getOpenTime()=" + getOpenTime() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}

	public String getContracttType() {
		return contracttType;
	}

	public void setContracttType(String contracttType) {
		this.contracttType = contracttType;
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

	public String getPayName() {
		return payName;
	}

	public void setPayName(String payName) {
		this.payName = payName;
	}

	public String getUnCodeName() {
		return unCodeName;
	}

	public void setUnCodeName(String unCodeName) {
		this.unCodeName = unCodeName;
	}

	public String getContracttName() {
		return contracttName;
	}

	public void setContracttName(String contracttName) {
		this.contracttName = contracttName;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
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

	public long getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	public long getPrepayFee() {
		return prepayFee;
	}

	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	public long getUnBillFee() {
		return unBillFee;
	}

	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo
	 *            the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName
	 *            the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}

	/**
	 * @return the blurCustName
	 */
	public String getBlurCustName() {
		return blurCustName;
	}

	/**
	 * @param blurCustName
	 *            the blurCustName to set
	 */
	public void setBlurCustName(String blurCustName) {
		this.blurCustName = blurCustName;
	}

	/**
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}

	/**
	 * @param custId
	 *            the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}

	/**
	 * @return the runTime
	 */
	public String getRunTime() {
		return runTime;
	}

	/**
	 * @param runTime
	 *            the runTime to set
	 */
	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}

	/**
	 * @return the openTime
	 */
	public String getOpenTime() {
		return openTime;
	}

	/**
	 * @param openTime
	 *            the openTime to set
	 */
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

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
}
