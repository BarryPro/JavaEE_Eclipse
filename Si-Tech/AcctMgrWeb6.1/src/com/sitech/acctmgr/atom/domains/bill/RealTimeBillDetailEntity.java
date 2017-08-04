package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class RealTimeBillDetailEntity {
	
	@JSONField(name = "ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="20",desc="手机号码",memo="略")
	private long idNo;
	
	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String phoneNo;
	
	@JSONField(name = "MIN_YM")
	@ParamDesc(path="MIN_YM",cons=ConsType.CT001,type="String",len="6",desc="欠费年月",memo="略")
	private String minYm;
	
	@JSONField(name = "OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="20",desc="欠费",memo="略")
	private long oweFee;
	
	@JSONField(name = "RECEIVED_FEE")
	@ParamDesc(path="RECEIVED_FEE",cons=ConsType.CT001,type="long",len="20",desc="已收款",memo="略")
	private long receivedFee;
	
	@JSONField(name = "SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="20",desc="合计应收",memo="略")
	private long shouldPay;
	
	@JSONField(name = "FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="20",desc="优惠费用",memo="略")
	private long favourFee;
	
	@JSONField(name = "MONTHLY_RENT")
	@ParamDesc(path="MONTHLY_RENT",cons=ConsType.CT001,type="long",len="20",desc="月租费用",memo="略")
	private long monthlyRent;
	
	@JSONField(name = "THE_INTERNET_FEE")
	@ParamDesc(path="THE_INTERNET_FEE",cons=ConsType.CT001,type="long",len="20",desc="本网费",memo="略")
	private long theInernetFee;
	
	@JSONField(name = "ROAMING_FEE")
	@ParamDesc(path="ROAMING_FEE",cons=ConsType.CT001,type="long",len="20",desc="漫游费用",memo="略")
	private long roamingFee;
	
	@JSONField(name = "LONG_PHONE_FEE")
	@ParamDesc(path="LONG_PHONE_FEE",cons=ConsType.CT001,type="long",len="20",desc="长话费",memo="略")
	private long longPhoneFee;
	
	@JSONField(name = "INCREMENT_FEE")
	@ParamDesc(path="INCREMENT_FEE",cons=ConsType.CT001,type="long",len="20",desc="增值业务",memo="略")
	private long incrementFee;
	
	@JSONField(name = "COLLECTION_FEE")
	@ParamDesc(path="COLLECTION_FEE",cons=ConsType.CT001,type="long",len="20",desc="代收费",memo="略")
	private long collectionFee;
	
	@JSONField(name = "SUBSEQUENT_COLLECTION_FEE")
	@ParamDesc(path="SUBSEQUENT_COLLECTION_FEE",cons=ConsType.CT001,type="long",len="20",desc="补收费用",memo="略")
	private long subsequentCollectionFee;
	
	@JSONField(name = "CUST_NAME")
	@ParamDesc(path="CUST_NAME",cons=ConsType.CT001,type="String",len="20",desc="客户名称",memo="略")
	private String custName;
	
	@JSONField(name = "CONTACT_NAME")
	@ParamDesc(path="CONTACT_NAME",cons=ConsType.CT001,type="String",len="20",desc="联系人名",memo="略")
	private String contactName;
	
	@JSONField(name = "CONTACT_PHONE")
	@ParamDesc(path="CONTACT_PHONE",cons=ConsType.CT001,type="String",len="20",desc="联系电话",memo="略")
	private String contactPhone;

	@JSONField(name = "QUERY_SN")
	@ParamDesc(path = "QUERY_SN", cons = ConsType.CT001, type = "Long", len = "14", desc = "查詢流水", memo = "")
	private String querySn;
	
	
	/**
	 * @return the querySn
	 */
	public String getQuerySn() {
		return querySn;
	}

	/**
	 * @param querySn the querySn to set
	 */
	public void setQuerySn(String querySn) {
		this.querySn = querySn;
	}

	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
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
	 * @return the minYm
	 */
	public String getMinYm() {
		return minYm;
	}

	/**
	 * @param minYm the minYm to set
	 */
	public void setMinYm(String minYm) {
		this.minYm = minYm;
	}

	/**
	 * @return the oweFee
	 */
	public long getOweFee() {
		return oweFee;
	}

	/**
	 * @param oweFee the oweFee to set
	 */
	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the receivedFee
	 */
	public long getReceivedFee() {
		return receivedFee;
	}

	/**
	 * @param receivedFee the receivedFee to set
	 */
	public void setReceivedFee(long receivedFee) {
		this.receivedFee = receivedFee;
	}

	/**
	 * @return the shouldPay
	 */
	public long getShouldPay() {
		return shouldPay;
	}

	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	/**
	 * @return the favourFee
	 */
	public long getFavourFee() {
		return favourFee;
	}

	/**
	 * @param favourFee the favourFee to set
	 */
	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}

	/**
	 * @return the monthlyRent
	 */
	public long getMonthlyRent() {
		return monthlyRent;
	}

	/**
	 * @param monthlyRent the monthlyRent to set
	 */
	public void setMonthlyRent(long monthlyRent) {
		this.monthlyRent = monthlyRent;
	}

	/**
	 * @return the theInernetFee
	 */
	public long getTheInernetFee() {
		return theInernetFee;
	}

	/**
	 * @param theInernetFee the theInernetFee to set
	 */
	public void setTheInernetFee(long theInernetFee) {
		this.theInernetFee = theInernetFee;
	}

	/**
	 * @return the roamingFee
	 */
	public long getRoamingFee() {
		return roamingFee;
	}

	/**
	 * @param roamingFee the roamingFee to set
	 */
	public void setRoamingFee(long roamingFee) {
		this.roamingFee = roamingFee;
	}

	/**
	 * @return the longPhoneFee
	 */
	public long getLongPhoneFee() {
		return longPhoneFee;
	}

	/**
	 * @param longPhoneFee the longPhoneFee to set
	 */
	public void setLongPhoneFee(long longPhoneFee) {
		this.longPhoneFee = longPhoneFee;
	}

	/**
	 * @return the incrementFee
	 */
	public long getIncrementFee() {
		return incrementFee;
	}

	/**
	 * @param incrementFee the incrementFee to set
	 */
	public void setIncrementFee(long incrementFee) {
		this.incrementFee = incrementFee;
	}

	/**
	 * @return the collectionFee
	 */
	public long getCollectionFee() {
		return collectionFee;
	}

	/**
	 * @param collectionFee the collectionFee to set
	 */
	public void setCollectionFee(long collectionFee) {
		this.collectionFee = collectionFee;
	}

	/**
	 * @return the subsequentCollectionFee
	 */
	public long getSubsequentCollectionFee() {
		return subsequentCollectionFee;
	}

	/**
	 * @param subsequentCollectionFee the subsequentCollectionFee to set
	 */
	public void setSubsequentCollectionFee(long subsequentCollectionFee) {
		this.subsequentCollectionFee = subsequentCollectionFee;
	}

	/**
	 * @return the custName
	 */
	public String getCustName() {
		return custName;
	}

	/**
	 * @param custName the custName to set
	 */
	public void setCustName(String custName) {
		this.custName = custName;
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

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RealTimeBillDetailEntity [idNo=" + idNo + ", phoneNo="
				+ phoneNo + ", minYm=" + minYm + ", oweFee=" + oweFee
				+ ", receivedFee=" + receivedFee + ", shouldPay=" + shouldPay
				+ ", favourFee=" + favourFee + ", monthlyRent=" + monthlyRent
				+ ", theInernetFee=" + theInernetFee + ", roamingFee="
				+ roamingFee + ", longPhoneFee=" + longPhoneFee
				+ ", incrementFee=" + incrementFee + ", collectionFee="
				+ collectionFee + ", subsequentCollectionFee="
				+ subsequentCollectionFee + ", custName=" + custName
				+ ", contactName=" + contactName + ", contactPhone="
				+ contactPhone + "]";
	}

	
}
