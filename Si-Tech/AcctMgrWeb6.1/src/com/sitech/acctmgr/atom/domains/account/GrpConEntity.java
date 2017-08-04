package com.sitech.acctmgr.atom.domains.account;

import com.alibaba.fastjson.annotation.JSONField;

public class GrpConEntity {
	
    /**
     */
	@JSONField(name = "UNIT_ID")
    private long unitId;
	
    /**
     */
	@JSONField(name = "CUST_ID")
    private long custId;
	
    /**
     */
	@JSONField(name = "UNIT_NAME")
    private String unitName;
	
    /**
     */
	@JSONField(name = "CUST_LEVEL")
    private String custLevel;
	
    /**
     */
	@JSONField(name = "STAFF_LOGIN_NAME")
    private String staffLoginName;
	
    /**
     */
	@JSONField(name = "STAFF_LOGIN")
    private String staffLogin;
	
    /**
     */
	@JSONField(name = "PRODUCT_NAME")
    private String productName;

	/**
	 * @return the unitId
	 */
	public long getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	/**
	 * @return the custId
	 */
	public long getCustId() {
		return custId;
	}

	/**
	 * @param custId the custId to set
	 */
	public void setCustId(long custId) {
		this.custId = custId;
	}

	/**
	 * @return the unitName
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * @param unitName the unitName to set
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * @return the staffLoginName
	 */
	public String getStaffLoginName() {
		return staffLoginName;
	}

	/**
	 * @param staffLoginName the staffLoginName to set
	 */
	public void setStaffLoginName(String staffLoginName) {
		this.staffLoginName = staffLoginName;
	}

	/**
	 * @return the staffLogin
	 */
	public String getStaffLogin() {
		return staffLogin;
	}

	/**
	 * @param staffLogin the staffLogin to set
	 */
	public void setStaffLogin(String staffLogin) {
		this.staffLogin = staffLogin;
	}

	/**
	 * @return the productName
	 */
	public String getProductName() {
		return productName;
	}

	/**
	 * @param productName the productName to set
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}

	/**
	 * @return the custLevel
	 */
	public String getCustLevel() {
		return custLevel;
	}

	/**
	 * @param custLevel the custLevel to set
	 */
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
}
