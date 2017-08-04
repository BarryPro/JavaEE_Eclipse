package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

public class UnStopHolidayEntity {

	private static final long serialVersionUID = 1L;

    /**
     */
	@JSONField(name = "REGION_CODE")
    private String regionCode;

    /**
     */
    @JSONField(name = "CREDIT_CLASS")
    private String creditClass;

    /**
     */
    @JSONField(name = "HOLIDAY_NAME")
    private String holidayName;
    
    /**
     */
    @JSONField(name = "BEGIN_TIME")
    private String beginTime;
    
    /**
     */
    @JSONField(name = "END_TIME")
    private String endTime;
    
    /**
     */
    @JSONField(name = "LOGIN_NO")
    private String loginNo;
    
    /**
     */
    @JSONField(name = "OP_TIME")
    private String opTime;
    
    /**
     */
    @JSONField(name = "OP_NOTE")
    private String opNote;

	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the creditClass
	 */
	public String getCreditClass() {
		return creditClass;
	}

	/**
	 * @param creditClass the creditClass to set
	 */
	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}

	/**
	 * @return the holidayName
	 */
	public String getHolidayName() {
		return holidayName;
	}

	/**
	 * @param holidayName the holidayName to set
	 */
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}

	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}

	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}



}
