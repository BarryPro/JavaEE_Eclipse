package com.sitech.acctmgr.atom.domains.cust;

import com.alibaba.fastjson.annotation.JSONField;

public class PersonalCustEntity {
    /**
     */
	@JSONField(name = "CUST_ID")
    private Long custId;

    /**
     */
	@JSONField(name = "SEX_CODE")
    private String sexCode;
    
    /**
     */
	@JSONField(name = "PROFESSION_ID")
    private String professionId;

    /**
     */
	@JSONField(name = "WORK_CODE")
    private String workCode;

    /**
     */
	@JSONField(name = "CUST_LOVE")
    private String custLove;

    /**
     */
	@JSONField(name = "CUST_HABIT")
    private String custHabit;

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
	 * @return the workCode
	 */
	public String getWorkCode() {
		return workCode;
	}

	/**
	 * @param workCode the workCode to set
	 */
	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}

	/**
	 * @return the custLove
	 */
	public String getCustLove() {
		return custLove;
	}

	/**
	 * @param custLove the custLove to set
	 */
	public void setCustLove(String custLove) {
		this.custLove = custLove;
	}

	/**
	 * @return the custHabit
	 */
	public String getCustHabit() {
		return custHabit;
	}

	/**
	 * @param custHabit the custHabit to set
	 */
	public void setCustHabit(String custHabit) {
		this.custHabit = custHabit;
	}

	/**
	 * @return the sexCode
	 */
	public String getSexCode() {
		return sexCode;
	}

	/**
	 * @param sexCode the sexCode to set
	 */
	public void setSexCode(String sexCode) {
		this.sexCode = sexCode;
	}

	/**
	 * @return the professionId
	 */
	public String getProfessionId() {
		return professionId;
	}

	/**
	 * @param professionId the professionId to set
	 */
	public void setProfessionId(String professionId) {
		this.professionId = professionId;
	}


}
