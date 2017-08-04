package com.sitech.acctmgr.atom.domains.cct;

import com.alibaba.fastjson.annotation.JSONField;

public class CreditAdjEntity {

	/**
     */
	@JSONField(name = "ID_NO")
	private Long idNo;

	@JSONField(name = "LIMIT_OWE")
	private long limitOwe;

	@JSONField(name = "LOGIN_ACCEPT")
	private long loginAccept;

	@JSONField(name = "EXPIRE_TIME")
	private String expireTime;

	@JSONField(name = "STATUS")
	private String status;

	@JSONField(name = "OLD_LIMIT_OWE")
	private long oldLimitOwe;

	@JSONField(name = "NEW_LIMIT_OWE")
	private long newLimitOwe;

	@JSONField(name = "LOGIN_NO")
	private String loginNo;

	@JSONField(name = "REGION_ID")
	private String regionId;

	@JSONField(name = "PHONE_NO")
	private String phoneNo;

	@JSONField(name = "OLD_OP_TIME")
	private String oldOpTime;

	@JSONField(name = "OP_CODE")
	private String opCode;

	@JSONField(name = "OP_NOTE")
	private String opNote;

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getOldOpTime() {
		return oldOpTime;
	}

	public void setOldOpTime(String oldOpTime) {
		this.oldOpTime = oldOpTime;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public Long getIdNo() {
		return idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public long getLimitOwe() {
		return limitOwe;
	}

	public void setLimitOwe(long limitOwe) {
		this.limitOwe = limitOwe;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(String expireTime) {
		this.expireTime = expireTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getOldLimitOwe() {
		return oldLimitOwe;
	}

	public void setOldLimitOwe(long oldLimitOwe) {
		this.oldLimitOwe = oldLimitOwe;
	}

	public long getNewLimitOwe() {
		return newLimitOwe;
	}

	public void setNewLimitOwe(long newLimitOwe) {
		this.newLimitOwe = newLimitOwe;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	@Override
	public String toString() {
		return "CreditAdjEntity [idNo=" + idNo + ", limitOwe=" + limitOwe + ", loginAccept=" + loginAccept + ", expireTime=" + expireTime
				+ ", status=" + status + ", oldLimitOwe=" + oldLimitOwe + ", newLimitOwe=" + newLimitOwe + ", loginNo=" + loginNo + ", regionId="
				+ regionId + ", phoneNo=" + phoneNo + ", oldOpTime=" + oldOpTime + ", opCode=" + opCode + ", opNote=" + opNote + "]";
	}

}
