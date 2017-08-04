package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 转账查询出参实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class TransOutEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7778547738667723221L;
	

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
				
	@JSONField(name="CUST_NAME")
	@ParamDesc(path="CUST_NAME",cons=ConsType.QUES,type="String",len="64",desc="客户名称",memo="略")
	private String custName;
	
	@JSONField(name="TRANS_FEE")
	@ParamDesc(path="TRANS_FEE",cons=ConsType.QUES,type="long",len="20",desc="可转金额",memo="略")
	private long transFee;
	
	@JSONField(name="REMAIN_FEE")
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.QUES,type="long",len="20",desc="余额",memo="略")
	private long remainFee;
	
	@JSONField(name="OPEN_TIME")
	@ParamDesc(path="OPEN_TIME",cons=ConsType.QUES,type="String",len="14",desc="开户时间",memo="略")
	private String openTime;
	
	@JSONField(name="EXPIRE_TIME")
	@ParamDesc(path="EXPIRE_TIME",cons=ConsType.QUES,type="String",len="14",desc="销户时间",memo="略")
	private String expireTime;
	
	private String accountType ;
	
	private String contractattType ;
	
	private String brandId;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TransOutEntity [phoneNo=" + phoneNo + ", custName="
				+ custName + ", transFee=" + transFee
				+ ", remainFee=" + remainFee
				+ ", openTime=" + openTime + ", expireTime=" + expireTime
				+ "]";
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
	 * @return the transFee
	 */
	public long getTransFee() {
		return transFee;
	}

	/**
	 * @param transFee the transFee to set
	 */
	public void setTransFee(long transFee) {
		this.transFee = transFee;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the openTime
	 */
	public String getOpenTime() {
		return openTime;
	}

	/**
	 * @param openTime the openTime to set
	 */
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	/**
	 * @return the expireTime
	 */
	public String getExpireTime() {
		return expireTime;
	}

	/**
	 * @param expireTime the expireTime to set
	 */
	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	/**
	 * @return the accountType
	 */
	public String getAccountType() {
		return accountType;
	}

	/**
	 * @param accountType the accountType to set
	 */
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	/**
	 * @return the contractattType
	 */
	public String getContractattType() {
		return contractattType;
	}

	/**
	 * @param contractattType the contractattType to set
	 */
	public void setContractattType(String contractattType) {
		this.contractattType = contractattType;
	}

	/**
	 * @return the brandId
	 */
	public String getBrandId() {
		return brandId;
	}

	/**
	 * @param brandId the brandId to set
	 */
	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}
}
