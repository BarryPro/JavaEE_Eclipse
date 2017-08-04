package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;

public class AgentOprEntity {
	
	 /**
     */
	@JSONField(name="TRANS_SN")
    private Long transSn;
	
    /**
     */
	@JSONField(name="PHONE_NO")
    private String phoneNo;
	
    /**
     */
	@JSONField(name="TRANS_FEE")
    private Long transFee;
	
    /**
     */
	@JSONField(name="OP_TIME")
    private String opTime;
	
    /**
     */
	@JSONField(name="STATUS")
    private String status;

	/**
	 * @return the transSn
	 */
	public Long getTransSn() {
		return transSn;
	}

	/**
	 * @param transSn the transSn to set
	 */
	public void setTransSn(Long transSn) {
		this.transSn = transSn;
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
	 * @return the transFee
	 */
	public Long getTransFee() {
		return transFee;
	}

	/**
	 * @param transFee the transFee to set
	 */
	public void setTransFee(Long transFee) {
		this.transFee = transFee;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}
