package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;

public class DetailEnterEntity {

    /**
     *  ID_NO
     */
	@JSONField(name="ID_NO")
    private Long idNo;

    /**
     *  PHONE_NO
     */
	@JSONField(name="PHONE_NO")
    private String phoneNo;

    /**
     *  LOGIN_NO
     */
	@JSONField(name="LOGIN_NO")
    private String loginNo;

    /**
     *  START_DATE
     */
	@JSONField(name="START_DATE")
    private String startDate;

    /**
     *  END_DATE
     */
	@JSONField(name="END_DATE")
    private String endDate;

    /**
     *  QUERY_TYPE
     */
	@JSONField(name="QUERY_TYPE")
    private String queryType;

    /**
     *  ENTER_TIME
     */
	@JSONField(name="ENTER_TIME")
    private String enterTime;

    /**
     *  VALID_FLAG
     */
	@JSONField(name="VALID_FLAG")
    private String validFlag;

    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getPhoneNo(){
    	return this.phoneNo;
    }
 
    public void setPhoneNo(String phoneNo){
      this.phoneNo=phoneNo;
    }
 
    public String getLoginNo(){
    	return this.loginNo;
    }
 
    public void setLoginNo(String loginNo){
      this.loginNo=loginNo;
    }

 
    public String getQueryType(){
    	return this.queryType;
    }
 
    public void setQueryType(String queryType){
      this.queryType=queryType;
    }
 
    public String getValidFlag(){
    	return this.validFlag;
    }
 
    public void setValidFlag(String validFlag){
      this.validFlag=validFlag;
    }

	/**
	 * @return the enterTime
	 */
	public String getEnterTime() {
		return enterTime;
	}

	/**
	 * @param enterTime the enterTime to set
	 */
	public void setEnterTime(String enterTime) {
		this.enterTime = enterTime;
	}

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
