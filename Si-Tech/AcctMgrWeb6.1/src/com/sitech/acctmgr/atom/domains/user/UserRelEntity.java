package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class UserRelEntity {
	@JSONField(name = "MASTER_ID")
    private long masterId;
	
	@JSONField(name = "SLAVE_ID")
    private long slaveId;

	@JSONField(name = "EFF_DATE")
	private String effDate;

	@JSONField(name = "EXP_DATE")
	private String expDate;

	/**
	 * @return the masterId
	 */
	public long getMasterId() {
		return masterId;
	}

	/**
	 * @param masterId the masterId to set
	 */
	public void setMasterId(long masterId) {
		this.masterId = masterId;
	}

	/**
	 * @return the slaveId
	 */
	public long getSlaveId() {
		return slaveId;
	}

	/**
	 * @param slaveId the slaveId to set
	 */
	public void setSlaveId(long slaveId) {
		this.slaveId = slaveId;
	}

	/**
	 * @return the effDate
	 */
	public String getEffDate() {
		return effDate;
	}

	/**
	 * @param effDate the effDate to set
	 */
	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	/**
	 * @return the expDate
	 */
	public String getExpDate() {
		return expDate;
	}

	/**
	 * @param expDate the expDate to set
	 */
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
}
