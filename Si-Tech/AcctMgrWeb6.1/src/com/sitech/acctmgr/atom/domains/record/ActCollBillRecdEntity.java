package com.sitech.acctmgr.atom.domains.record;

import com.alibaba.fastjson.annotation.JSONField;

public class ActCollBillRecdEntity {

	@JSONField(name = "CONTRACT_NO")
	private long	contractNo;
	
	@JSONField(name = "BILL_CYCLE")
	private int 	billCycle;
	
	@JSONField(name = "TOTAL_DATE")
	private int		totalDate;
	
	@JSONField(name = "LOGIN_ACCEPT")
	private long 	loginAccept;
	
	@JSONField(name = "GROUP_ID")
	private String 	groupId;
	
	@JSONField(name = "PAY_FEE")
	private long 	payFee;
	
	@JSONField(name = "FETCH_NO")
	private String 	fetchNo;
	
	@JSONField(name = "BACK_FLAG")
	private String 	backFlag;
	
	@JSONField(name = "RETURN_CODE")
	private String 	returnCode;
		
	@JSONField(name = "OP_CODE")
	private String 	opCode;
	
	@JSONField(name = "LOGIN_NO")
	private String 	loginNo;
	
	@JSONField(name = "ORG_ID")
	private String 	orgId;
	
	@JSONField(name = "OP_TIME")
	private String 	opTime;
	
	@JSONField(name = "REMARK")
	private String 	remark;

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the billCycle
	 */
	public int getBillCycle() {
		return billCycle;
	}

	/**
	 * @param billCycle the billCycle to set
	 */
	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	/**
	 * @return the totalDate
	 */
	public int getTotalDate() {
		return totalDate;
	}

	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	/**
	 * @return the loginAccept
	 */
	public long getLoginAccept() {
		return loginAccept;
	}

	/**
	 * @param loginAccept the loginAccept to set
	 */
	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}

	/**
	 * @return the fetchNo
	 */
	public String getFetchNo() {
		return fetchNo;
	}

	/**
	 * @param fetchNo the fetchNo to set
	 */
	public void setFetchNo(String fetchNo) {
		this.fetchNo = fetchNo;
	}

	/**
	 * @return the backFlag
	 */
	public String getBackFlag() {
		return backFlag;
	}

	/**
	 * @param backFlag the backFlag to set
	 */
	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	/**
	 * @return the returnCode
	 */
	public String getReturnCode() {
		return returnCode;
	}

	/**
	 * @param returnCode the returnCode to set
	 */
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
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
	 * @return the orgId
	 */
	public String getOrgId() {
		return orgId;
	}

	/**
	 * @param orgId the orgId to set
	 */
	public void setOrgId(String orgId) {
		this.orgId = orgId;
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
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
