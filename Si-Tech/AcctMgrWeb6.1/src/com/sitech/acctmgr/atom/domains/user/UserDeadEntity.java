package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class UserDeadEntity {

	/**
     */
	@JSONField(name = "ID_NO")
	private Long idNo;

	/**
     */
	@JSONField(name = "CONTRACT_NO")
	private Long contractNo;

	/**
     */
	@JSONField(name = "CUST_ID")
	private Long custId;

	/**
     */
	@JSONField(name = "CUST_NAME")
	private String custName;

	/**
     */
	@JSONField(name = "PHONE_NO")
	private String phoneNo;

	/**
     */
	@JSONField(name = "MASTER_SERV_ID")
	private String masterServId;

	/**
     */
	@JSONField(name = "OPEN_TIME")
	private String openTime;

	/**
     */
	@JSONField(name = "GROUP_ID")
	private String groupId;

	/**
     */
	@JSONField(name = "OWNER_TYPE")
	private Integer ownerType;

	/**
     */
	@JSONField(name = "BILL_START_TIME")
	private String billStartTime;

	@JSONField(name = "PROD_NAME")
	private String prodName;

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	/**
	 * @return the idNo
	 */
	public Long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo
	 *            the idNo to set
	 */
	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	/**
	 * @return the contractNo
	 */
	public Long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo
	 *            the contractNo to set
	 */
	public void setContractNo(Long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the custId
	 */
	public Long getCustId() {
		return custId;
	}

	/**
	 * @param custId
	 *            the custId to set
	 */
	public void setCustId(Long custId) {
		this.custId = custId;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo
	 *            the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the masterServId
	 */
	public String getMasterServId() {
		return masterServId;
	}

	/**
	 * @param masterServId
	 *            the masterServId to set
	 */
	public void setMasterServId(String masterServId) {
		this.masterServId = masterServId;
	}

	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId
	 *            the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the ownerType
	 */
	public Integer getOwnerType() {
		return ownerType;
	}

	/**
	 * @param ownerType
	 *            the ownerType to set
	 */
	public void setOwnerType(Integer ownerType) {
		this.ownerType = ownerType;
	}

	/**
	 * @return the openTime
	 */
	public String getOpenTime() {
		return openTime;
	}

	/**
	 * @param openTime
	 *            the openTime to set
	 */
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	/**
	 * @return the billStartTime
	 */
	public String getBillStartTime() {
		return billStartTime;
	}

	/**
	 * @param billStartTime
	 *            the billStartTime to set
	 */
	public void setBillStartTime(String billStartTime) {
		this.billStartTime = billStartTime;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName
	 *            the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
	}

}
