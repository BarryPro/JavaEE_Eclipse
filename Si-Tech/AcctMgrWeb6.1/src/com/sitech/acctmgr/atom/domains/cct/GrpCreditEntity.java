package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

public class GrpCreditEntity {

	 /**
     */
	@JSONField(name = "UNIT_ID")
    private Long unitId;
	
	 /**
     */
	@JSONField(name = "CREDIT_CODE")
    private String creditCode;
	
	 /**
     */
	@JSONField(name = "CREDIT_VALUE")
    private String creditValue;
	
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
	@JSONField(name = "AUTO_FLAG")
    private String autoFlag;
	
	 /**
     */
	@JSONField(name = "OP_CODE")
    private String opCode;
	
	
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
	@JSONField(name = "SYS_YM")
    private String sysYm;

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


	/**
	 * @return the creditCode
	 */
	public String getCreditCode() {
		return creditCode;
	}


	/**
	 * @param creditCode the creditCode to set
	 */
	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}


	/**
	 * @return the creditValue
	 */
	public String getCreditValue() {
		return creditValue;
	}


	/**
	 * @param creditValue the creditValue to set
	 */
	public void setCreditValue(String creditValue) {
		this.creditValue = creditValue;
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
	 * @return the autoFlag
	 */
	public String getAutoFlag() {
		return autoFlag;
	}


	/**
	 * @param autoFlag the autoFlag to set
	 */
	public void setAutoFlag(String autoFlag) {
		this.autoFlag = autoFlag;
	}


	/**
	 * @return the opCode
	 */
	public String getOpCode() {
		return opCode;
	}


	/**
	 * @param opCode the opCode to set
	 */
	public void setOpCode(String opCode) {
		this.opCode = opCode;
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
	 * @return the sysYm
	 */
	public String getSysYm() {
		return sysYm;
	}


	/**
	 * @param sysYm the sysYm to set
	 */
	public void setSysYm(String sysYm) {
		this.sysYm = sysYm;
	}


	
}
