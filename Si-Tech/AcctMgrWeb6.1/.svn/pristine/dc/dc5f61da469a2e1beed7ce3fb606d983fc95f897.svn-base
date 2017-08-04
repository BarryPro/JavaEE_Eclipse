package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 
* @Title:   []
* @Description: 一点支付缴费：被支付账户对象列表
* @Date : 2015年3月12日下午6:01:25
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class AccountPayedEntity implements Serializable {

	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long 	contractNo;
	
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="string",len="128",desc="账户名称",memo="略")
	private String  contractName;
	
	@JSONField(name="PAY_NAME")
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="string",len="18",desc="账户支付方式",memo="略")
	private String 	payName;
	
	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="预存款",memo="略")
	private long 	prepayFee;
	
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.CT001,type="long",len="14",desc="欠费",memo="略")
	private long 	owe_fee;
	
	@JSONField(name="DELAY_FEE")
	@ParamDesc(path="DELAY_FEE",cons=ConsType.CT001,type="string",len="18",desc="滞纳金",memo="略")
	private long 	delayFee;
	
	@JSONField(name="FIX_FEE")
	@ParamDesc(path="FIX_FEE",cons=ConsType.CT001,type="string",len="18",desc="支付金额",memo="略")
	private long 	fixFee;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="14",desc="被支付用户号码",memo="")
	private String 	phoneNo;
	
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="string",len="18",desc="用户标识",memo="略")
	private long 	idNo;
	
	@JSONField(name="BRAND_ID")
	@ParamDesc(path="BRAND_ID",cons=ConsType.CT001,type="string",len="10",desc="品牌",memo="")
	private String 	brandId;

	@JSONField(name="GROUP_ID")
	@ParamDesc(path="GROUP_ID",cons=ConsType.CT001,type="string",len="10",desc="用户归属",memo="")
	private String 	groupId;
	
	@JSONField(name="REGION_CODE")
	@ParamDesc(path="REGION_CODE",cons=ConsType.CT001,type="string",len="10",desc="地市编码",memo="全省：2200")
	private String 	regionCode;

	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AccountPayedEntity [contractNo=" + contractNo
				+ ", contractName=" + contractName + ", payName=" + payName
				+ ", prepayFee=" + prepayFee + ", owe_fee=" + owe_fee
				+ ", delayFee=" + delayFee + ", fixFee=" + fixFee
				+ ", phoneNo=" + phoneNo + ", idNo=" + idNo + ", brandId="
				+ brandId + ", groupId=" + groupId + ", regionCode="
				+ regionCode + "]";
	}


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
	 * @return the contractName
	 */
	public String getContractName() {
		return contractName;
	}

	/**
	 * @param contractName the contractName to set
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}

	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}

	/**
	 * @return the prepayFee
	 */
	public long getPrepayFee() {
		return prepayFee;
	}

	/**
	 * @param prepayFee the prepayFee to set
	 */
	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	/**
	 * @return the owe_fee
	 */
	public long getOwe_fee() {
		return owe_fee;
	}

	/**
	 * @param owe_fee the owe_fee to set
	 */
	public void setOwe_fee(long owe_fee) {
		this.owe_fee = owe_fee;
	}

	/**
	 * @return the delayFee
	 */
	public long getDelayFee() {
		return delayFee;
	}

	/**
	 * @param delayFee the delayFee to set
	 */
	public void setDelayFee(long delayFee) {
		this.delayFee = delayFee;
	}

	/**
	 * @return the fixFee
	 */
	public long getFixFee() {
		return fixFee;
	}

	/**
	 * @param fixFee the fixFee to set
	 */
	public void setFixFee(long fixFee) {
		this.fixFee = fixFee;
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
	 * @return the brandId
	 */
	public String getBrandId() {
		return brandId;
	}

	/**
	 * @param brandId the brandId to set
	 */
	public void setBrandId(String brandId) {
		this.brandId = brandId;
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
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	
}
