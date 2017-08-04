package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;

public class PayMentEntity {

	private static final long serialVersionUID = 1L;

	/**
     */
	@JSONField(name = "PAY_SN")
	private Long paySn;

	/**
     */
	@JSONField(name = "CONTRACT_NO")
	private Long contractNo;

	/**
     */
	@JSONField(name = "ID_NO")
	private Long idNo;

	/**
     */
	@JSONField(name = "USER_GROUP_ID")
	private String userGroupId;

	/**
     */
	@JSONField(name = "PHONE_NO")
	private String phoneNo;

	/**
     */
	@JSONField(name = "BRAND_ID")
	private String brandId;

	/**
     */
	@JSONField(name = "TOTAL_DATE")
	private Integer totalDate;

	/**
     */
	@JSONField(name = "PAY_PATH")
	private String payPath;

	/**
     */
	@JSONField(name = "PAY_METHOD")
	private String payMethod;

	/**
     */
	@JSONField(name = "PAY_TYPE")
	private String payType;

	/**
     */
	@JSONField(name = "PAY_FEE")
	private Long payFee;

	/**
     */
	@JSONField(name = "CURRENT_PREPAY")
	private Long currentPrepay;

	/**
     */
	@JSONField(name = "PAY_TIME")
	private String payTime;

	/**
     */
	@JSONField(name = "STATUS")
	private String status;

	/**
     */
	@JSONField(name = "BANK_CODE")
	private String bankCode;

	/**
     */
	@JSONField(name = "ORIGINAL_SN")
	private Long originalSn;

	/**
     */
	@JSONField(name = "FOREIGN_SN")
	private String foreignSn;

	/**
     */
	@JSONField(name = "FOREIGN_TIME")
	private String foreignTime;

	/**
     */
	@JSONField(name = "GROUP_ID")
	private String groupId;

	/**
     */
	@JSONField(name = "LOGIN_NO")
	private String loginNo;

	/**
     */
	@JSONField(name = "OP_CODE")
	private String opCode;

	/**
     */
	@JSONField(name = "OP_TIME")
	private String opTime;

	/**
     */
	@JSONField(name = "YEAR_MONTH")
	private Integer yearMonth;

	/**
     */
	@JSONField(name = "REMARK")
	private String remark;

	@JSONField(name = "SUFFIX")
	private Integer suffix;

	@JSONField(name = "FUNCTION_NAME")
	private String functionName;

	@JSONField(name = "PAY_TYPE_NAME")
	private String payTypeName;

	public Long getPaySn() {
		return this.paySn;
	}

	public void setPaySn(Long paySn) {
		this.paySn = paySn;
	}

	public Long getContractNo() {
		return this.contractNo;
	}

	public void setContractNo(Long contractNo) {
		this.contractNo = contractNo;
	}

	public Long getIdNo() {
		return this.idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public String getUserGroupId() {
		return this.userGroupId;
	}

	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}

	public String getPhoneNo() {
		return this.phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBrandId() {
		return this.brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public Integer getTotalDate() {
		return this.totalDate;
	}

	public void setTotalDate(Integer totalDate) {
		this.totalDate = totalDate;
	}

	public String getPayPath() {
		return this.payPath;
	}

	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}

	public String getPayMethod() {
		return this.payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getPayType() {
		return this.payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public Long getPayFee() {
		return this.payFee;
	}

	public void setPayFee(Long payFee) {
		this.payFee = payFee;
	}

	public Long getCurrentPrepay() {
		return this.currentPrepay;
	}

	public void setCurrentPrepay(Long currentPrepay) {
		this.currentPrepay = currentPrepay;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBankCode() {
		return this.bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public Long getOriginalSn() {
		return this.originalSn;
	}

	public void setOriginalSn(Long originalSn) {
		this.originalSn = originalSn;
	}

	public String getForeignSn() {
		return this.foreignSn;
	}

	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

	public String getGroupId() {
		return this.groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getLoginNo() {
		return this.loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getOpCode() {
		return this.opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public Integer getYearMonth() {
		return this.yearMonth;
	}

	public void setYearMonth(Integer yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the suffix
	 */
	public Integer getSuffix() {
		return suffix;
	}

	/**
	 * @param suffix
	 *            the suffix to set
	 */
	public void setSuffix(Integer suffix) {
		this.suffix = suffix;
	}

	/**
	 * @return the payTime
	 */
	public String getPayTime() {
		return payTime;
	}

	/**
	 * @param payTime
	 *            the payTime to set
	 */
	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	/**
	 * @return the foreignTime
	 */
	public String getForeignTime() {
		return foreignTime;
	}

	/**
	 * @param foreignTime
	 *            the foreignTime to set
	 */
	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime
	 *            the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	/**
	 * @return the functionName
	 */
	public String getFunctionName() {
		return functionName;
	}

	/**
	 * @param functionName
	 *            the functionName to set
	 */
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	/**
	 * @return the payTypeName
	 */
	public String getPayTypeName() {
		return payTypeName;
	}

	/**
	 * @param payTypeName
	 *            the payTypeName to set
	 */
	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	@Override
	public String toString() {
		return "PayMentEntity [paySn=" + paySn + ", contractNo=" + contractNo + ", idNo=" + idNo + ", userGroupId=" + userGroupId + ", phoneNo="
				+ phoneNo + ", brandId=" + brandId + ", totalDate=" + totalDate + ", payPath=" + payPath + ", payMethod=" + payMethod + ", payType="
				+ payType + ", payFee=" + payFee + ", currentPrepay=" + currentPrepay + ", payTime=" + payTime + ", status=" + status + ", bankCode="
				+ bankCode + ", originalSn=" + originalSn + ", foreignSn=" + foreignSn + ", foreignTime=" + foreignTime + ", groupId=" + groupId
				+ ", loginNo=" + loginNo + ", opCode=" + opCode + ", opTime=" + opTime + ", yearMonth=" + yearMonth + ", remark=" + remark
				+ ", suffix=" + suffix + ", functionName=" + functionName + ", payTypeName=" + payTypeName + "]";
	}

}
