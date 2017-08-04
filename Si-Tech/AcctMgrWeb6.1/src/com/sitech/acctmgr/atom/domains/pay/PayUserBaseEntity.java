package com.sitech.acctmgr.atom.domains.pay;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PayUserBaseEntity {

	@JSONField(name="PHONE_NO")
	private String	phoneNo;
	
	@JSONField(name="CONTRACT_NO")
	private long	contractNo;
	
	@JSONField(name="ID_NO")
	private long	idNo;
	
	@JSONField(name="BRAND_ID")
	private String	brandId;
	
	@JSONField(name="USER_GROUP_ID")
	private	String	userGroupId;
	
	@JSONField(name="REGION_ID")
	private String	regionId;

	@JSONField(name="RUN_CODE")
	private String	runCode;

	@JSONField(name="CUST_ID")
	private long	custId;

	@JSONField(name="PROD_PRCID")
	private String prodPrcid;
	
	/***
	 * 号码缴费或者账户缴费标识  true 是号码缴费   flase 为账户缴费
	 */
	private boolean	phoneFlag;
	
	/***
	 * 用户在离网标识  true：在网  false：离网
	 */
	private boolean netFlag;
	
	@JSONField(name="BRAND_NAME")
	private String brandName;
	
	
	
	
	public Map<String, Object> toMap(){
		
		return JSON.parseObject(JSON.toJSONString(this), Map.class);
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return "PayUserBaseEntity [phoneNo=" + phoneNo + ", contractNo=" + contractNo + ", idNo=" + idNo + ", brandId="
				+ brandId + ", userGroupId=" + userGroupId + ", regionId=" + regionId + ", runCode=" + runCode
				+ ", custId=" + custId + ", prodPrcid=" + prodPrcid + ", phoneFlag=" + phoneFlag + ", netFlag="
				+ netFlag + ", brandName=" + brandName + "]";
	}

	/**
	 * @return the userGroupId
	 */
	public String getUserGroupId() {
		return userGroupId;
	}

	/**
	 * @param userGroupId the userGroupId to set
	 */
	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
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
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
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

	/**
	 * @return the regionId
	 */
	public String getRegionId() {
		return regionId;
	}

	/**
	 * @param regionId the regionId to set
	 */
	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	/**
	 * @return the phoneFlag号码缴费或者账户缴费标识  true 是号码缴费   flase 为账户缴费
	 */
	public boolean isPhoneFlag() {
		return phoneFlag;
	}

	/**
	 * @param phoneFlag the phoneFlag to set
	 */
	public void setPhoneFlag(boolean phoneFlag) {
		this.phoneFlag = phoneFlag;
	}

	/**
	 * @return the netFlag
	 */
	public boolean isNetFlag() {
		return netFlag;
	}

	/**
	 * @param netFlag the netFlag to set
	 */
	public void setNetFlag(boolean netFlag) {
		this.netFlag = netFlag;
	}


	public String getRunCode() {
		return runCode;
	}

	public void setRunCode(String runCode) {
		this.runCode = runCode;
	}

	public long getCustId() {
		return custId;
	}

	public void setCustId(long custId) {
		this.custId = custId;
	}

	public String getProdPrcid() {
		return prodPrcid;
	}

	public void setProdPrcid(String prodPrcid) {
		this.prodPrcid = prodPrcid;
	}

	/**
	 * @return the brandName
	 */
	public String getBrandName() {
		return brandName;
	}

	/**
	 * @param brandName the brandName to set
	 */
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	
}
