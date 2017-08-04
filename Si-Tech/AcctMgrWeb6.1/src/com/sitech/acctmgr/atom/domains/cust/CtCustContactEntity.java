package com.sitech.acctmgr.atom.domains.cust;

import com.alibaba.fastjson.annotation.JSONField;

public class CtCustContactEntity {
	
	@JSONField(name = "CUST_ID")
	private Long custId;
	
	@JSONField(name = "CONTACT_ID")
	private Long contactId;
	
	@JSONField(name = "ID_TYPE")
	private String idType;
	
	@JSONField(name = "ID_ICCID")
	private String idIccid;
	
	@JSONField(name = "CONTACT_ORDER")
	private Long contactOrder;
	
	@JSONField(name = "CONTACT_TYPE")
	private String contactType;
	
	@JSONField(name = "CONTACT_NAME")
	private String contactName;
	
	@JSONField(name = "CONTACT_PHONE")
	private String contactPhone;

	@JSONField(name = "ADDRESS_ID")
	private Long addressId;
	
	@JSONField(name = "CONTACT_ADDRESS")
	private String contactAddress;
	
	@JSONField(name = "CONTACT_POST")
	private String contactPost;
	
	@JSONField(name = "CONTACT_EMAIL")
	private String contactEmail;
	
	/**
	 * @return the custId
	 */
	public Long getCustId() {
		return custId;
	}

	/**
	 * @param custId the custId to set
	 */
	public void setCustId(Long custId) {
		this.custId = custId;
	}

	/**
	 * @return the contactId
	 */
	public Long getContactId() {
		return contactId;
	}

	/**
	 * @param contactId the contactId to set
	 */
	public void setContactId(Long contactId) {
		this.contactId = contactId;
	}

	/**
	 * @return the idType
	 */
	public String getIdType() {
		return idType;
	}

	/**
	 * @param idType the idType to set
	 */
	public void setIdType(String idType) {
		this.idType = idType;
	}

	/**
	 * @return the idIccid
	 */
	public String getIdIccid() {
		return idIccid;
	}

	/**
	 * @param idIccid the idIccid to set
	 */
	public void setIdIccid(String idIccid) {
		this.idIccid = idIccid;
	}

	/**
	 * @return the contactOrder
	 */
	public Long getContactOrder() {
		return contactOrder;
	}

	/**
	 * @param contactOrder the contactOrder to set
	 */
	public void setContactOrder(Long contactOrder) {
		this.contactOrder = contactOrder;
	}

	/**
	 * @return the contactType
	 */
	public String getContactType() {
		return contactType;
	}

	/**
	 * @param contactType the contactType to set
	 */
	public void setContactType(String contactType) {
		this.contactType = contactType;
	}

	/**
	 * @return the contactName
	 */
	public String getContactName() {
		return contactName;
	}

	/**
	 * @param contactName the contactName to set
	 */
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	/**
	 * @return the addressId
	 */
	public Long getAddressId() {
		return addressId;
	}

	/**
	 * @param addressId the addressId to set
	 */
	public void setAddressId(Long addressId) {
		this.addressId = addressId;
	}

	/**
	 * @return the contactAddress
	 */
	public String getContactAddress() {
		return contactAddress;
	}

	/**
	 * @param contactAddress the contactAddress to set
	 */
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	/**
	 * @return the contactPost
	 */
	public String getContactPost() {
		return contactPost;
	}

	/**
	 * @param contactPost the contactPost to set
	 */
	public void setContactPost(String contactPost) {
		this.contactPost = contactPost;
	}
	
	/**
	 * @return the contactPhone
	 */
	public String getContactPhone() {
		return contactPhone;
	}

	/**
	 * @param contactPhone the contactPhone to set
	 */
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * @return the contactEmail
	 */
	public String getContactEmail() {
		return contactEmail;
	}

	/**
	 * @param contactEmail the contactEmail to set
	 */
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CtCustContactEntity [custId=" + custId + ", contactId="
				+ contactId + ", idType=" + idType + ", idIccid=" + idIccid
				+ ", contactOrder=" + contactOrder + ", contactType="
				+ contactType + ", contactName=" + contactName
				+ ", contactPhone=" + contactPhone + ", addressId=" + addressId
				+ ", contactAddress=" + contactAddress + ", contactPost="
				+ contactPost + ", contactEmail=" + contactEmail + "]";
	}
	
}
