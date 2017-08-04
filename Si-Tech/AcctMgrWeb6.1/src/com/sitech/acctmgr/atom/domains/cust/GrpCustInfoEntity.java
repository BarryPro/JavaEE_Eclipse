package com.sitech.acctmgr.atom.domains.cust;

import com.alibaba.fastjson.annotation.JSONField;

public class GrpCustInfoEntity {

	  /**
     */
	@JSONField(name = "CUST_ID")
    private Long custId;

    /**
     */
	@JSONField(name = "AREA_TYPE")
    private Integer areaType;

    /**
     */
	@JSONField(name = "BANK_ACCOUNT_NO")
    private String bankAccountNo;

    /**
     */
	@JSONField(name = "BANK_NAME")
    private String bankName;

    /**
     */
	@JSONField(name = "CREDIT_GRADE")
    private String creditGrade;

    /**
     */
	@JSONField(name = "GROUP_TYPE")
    private Integer groupType;


    /**
     */
	@JSONField(name = "PRODUCT_TYPE")
    private String productType;


    /**
     */
	@JSONField(name = "VALID_FLAG")
    private String validFlag;
    
    /**
     */
	@JSONField(name = "UNIT_ID")
    private Long unitId;

	/**
	 * @return the custId
	 */
	public Long getCustId() {
		return custId;
	}

	/**
	 * @param custId the custId to set
	 */
	public void setCustId(Long custId) {
		this.custId = custId;
	}

	/**
	 * @return the areaType
	 */
	public Integer getAreaType() {
		return areaType;
	}

	/**
	 * @param areaType the areaType to set
	 */
	public void setAreaType(Integer areaType) {
		this.areaType = areaType;
	}

	/**
	 * @return the bankAccountNo
	 */
	public String getBankAccountNo() {
		return bankAccountNo;
	}

	/**
	 * @param bankAccountNo the bankAccountNo to set
	 */
	public void setBankAccountNo(String bankAccountNo) {
		this.bankAccountNo = bankAccountNo;
	}

	/**
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**
	 * @return the creditGrade
	 */
	public String getCreditGrade() {
		return creditGrade;
	}

	/**
	 * @param creditGrade the creditGrade to set
	 */
	public void setCreditGrade(String creditGrade) {
		this.creditGrade = creditGrade;
	}

	/**
	 * @return the groupType
	 */
	public Integer getGroupType() {
		return groupType;
	}

	/**
	 * @param groupType the groupType to set
	 */
	public void setGroupType(Integer groupType) {
		this.groupType = groupType;
	}

	/**
	 * @return the productType
	 */
	public String getProductType() {
		return productType;
	}

	/**
	 * @param productType the productType to set
	 */
	public void setProductType(String productType) {
		this.productType = productType;
	}

	/**
	 * @return the validFlag
	 */
	public String getValidFlag() {
		return validFlag;
	}

	/**
	 * @param validFlag the validFlag to set
	 */
	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

	/**
	 * @return the unitId
	 */
	public Long getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}


}
