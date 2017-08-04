package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

public class CreditInfoEntity {

	/**
     */
	@JSONField(name = "ID_NO")
	private Long idNo;

	/**
     */
	@JSONField(name = "REGION_ID")
	private Integer regionId;

	/**
     */
	@JSONField(name = "CREDIT_CLASS")
	private String creditClass;

	@JSONField(name = "CREDIT_CODE")
	private String creditCode;

	/**
     */
	@JSONField(name = "CREDIT_GRADE_NAME")
	private String creditGradeName;

	/**
     */
	@JSONField(name = "CREDIT_FEE")
	private Long creditFee;

	/**
     */
	@JSONField(name = "STOP_FLAG")
	private String stopFlag;

	/**
     */
	@JSONField(name = "OWE_FLAG")
	private String oweFlag;

	/**
     */
	@JSONField(name = "VALID_FLAG")
	private String validFlag;

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
	@JSONField(name = "BEGIN_MONTH")
	private String beginMonth;

	/**
     */
	@JSONField(name = "END_MONTH")
	private String endMonth;

	/**
     */
	@JSONField(name = "BEGIN_YEAR")
	private String beginYear;

	/**
     */
	@JSONField(name = "END_YEAR")
	private String endYear;

	/**
     */
	@JSONField(name = "SEND_FLAG")
	private Integer sendFlag;

	/**
     */
	@JSONField(name = "PHONE_NO")
	private String phoneNo;

	@JSONField(name = "LIMIT_OWE")
	private long limitOwe;

	public Long getIdNo() {
		return idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public Integer getRegionId() {
		return regionId;
	}

	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}

	public String getCreditClass() {
		return creditClass;
	}

	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}

	public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}

	public String getCreditGradeName() {
		return creditGradeName;
	}

	public void setCreditGradeName(String creditGradeName) {
		this.creditGradeName = creditGradeName;
	}

	public Long getCreditFee() {
		return creditFee;
	}

	public void setCreditFee(Long creditFee) {
		this.creditFee = creditFee;
	}

	public String getStopFlag() {
		return stopFlag;
	}

	public void setStopFlag(String stopFlag) {
		this.stopFlag = stopFlag;
	}

	public String getOweFlag() {
		return oweFlag;
	}

	public void setOweFlag(String oweFlag) {
		this.oweFlag = oweFlag;
	}

	public String getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(String validFlag) {
		this.validFlag = validFlag;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getBeginMonth() {
		return beginMonth;
	}

	public void setBeginMonth(String beginMonth) {
		this.beginMonth = beginMonth;
	}

	public String getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(String endMonth) {
		this.endMonth = endMonth;
	}

	public String getBeginYear() {
		return beginYear;
	}

	public void setBeginYear(String beginYear) {
		this.beginYear = beginYear;
	}

	public String getEndYear() {
		return endYear;
	}

	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}

	public Integer getSendFlag() {
		return sendFlag;
	}

	public void setSendFlag(Integer sendFlag) {
		this.sendFlag = sendFlag;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getLimitOwe() {
		return limitOwe;
	}

	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}

	@Override
	public String toString() {
		return "CreditInfoEntity{" +
				"idNo=" + idNo +
				", regionId=" + regionId +
				", creditClass='" + creditClass + '\'' +
				", creditGradeName='" + creditGradeName + '\'' +
				", creditFee=" + creditFee +
				", stopFlag='" + stopFlag + '\'' +
				", oweFlag='" + oweFlag + '\'' +
				", validFlag='" + validFlag + '\'' +
				", beginTime='" + beginTime + '\'' +
				", endTime='" + endTime + '\'' +
				", beginMonth='" + beginMonth + '\'' +
				", endMonth='" + endMonth + '\'' +
				", beginYear='" + beginYear + '\'' +
				", endYear='" + endYear + '\'' +
				", sendFlag=" + sendFlag +
				", phoneNo='" + phoneNo + '\'' +
				", limitOwe=" + limitOwe +
				'}';
	}
}
