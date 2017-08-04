package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8229CheckQueryOutDTO extends CommonOutDTO{


	/**
	 * 
	 */
	private static final long serialVersionUID = 3872501236762563113L;
	
	@JSONField(name="CHECK_MONEY")
	@ParamDesc(path="CHECK_MONEY",cons=ConsType.CT001,type="String",len="14",desc="支票金额",memo="略")
	private String checkMoney;
	
	@JSONField(name="BANK_COUNT")
	@ParamDesc(path="BANK_COUNT",cons=ConsType.CT001,type="String",len="30",desc="银行帐号",memo="略")
	private String bankCount;
	
	@JSONField(name="OWNER_UNIT")
	@ParamDesc(path="OWNER_UNIT",cons=ConsType.CT001,type="String",len="60",desc="银行户名",memo="略")
	private String ownerUnit;
	
	@JSONField(name="OWNER_NAME")
	@ParamDesc(path="OWNER_NAME",cons=ConsType.CT001,type="String",len="20",desc="用户名称",memo="略")
	private String ownerName;
	
	@JSONField(name="CONTACT_PERSON")
	@ParamDesc(path="CONTACT_PERSON",cons=ConsType.CT001,type="String",len="20",desc="联系电话",memo="略")
	private String contactPerson;
	
	@JSONField(name="OWNER_ID")
	@ParamDesc(path="OWNER_ID",cons=ConsType.CT001,type="String",len="18",desc="身份证号",memo="略")
	private String ownerId;
	
	@Override
    public MBean encode() {
        MBean result = new MBean();
        result.setBody(getPathByProperName("checkMoney"), checkMoney);
        result.setBody(getPathByProperName("bankCount"), bankCount);
        result.setBody(getPathByProperName("ownerUnit"), ownerUnit);
        result.setBody(getPathByProperName("ownerName"), ownerName);
        result.setBody(getPathByProperName("contactPerson"), contactPerson);
        result.setBody(getPathByProperName("ownerId"), ownerId);
        return result;
    }

	/**
	 * @return the checkMoney
	 */
	public String getCheckMoney() {
		return checkMoney;
	}

	/**
	 * @return the bankCount
	 */
	public String getBankCount() {
		return bankCount;
	}

	/**
	 * @return the ownerUnit
	 */
	public String getOwnerUnit() {
		return ownerUnit;
	}

	/**
	 * @return the ownerName
	 */
	public String getOwnerName() {
		return ownerName;
	}

	/**
	 * @return the contactPerson
	 */
	public String getContactPerson() {
		return contactPerson;
	}

	/**
	 * @return the ownerId
	 */
	public String getOwnerId() {
		return ownerId;
	}

	/**
	 * @param checkMoney the checkMoney to set
	 */
	public void setCheckMoney(String checkMoney) {
		this.checkMoney = checkMoney;
	}

	/**
	 * @param bankCount the bankCount to set
	 */
	public void setBankCount(String bankCount) {
		this.bankCount = bankCount;
	}

	/**
	 * @param ownerUnit the ownerUnit to set
	 */
	public void setOwnerUnit(String ownerUnit) {
		this.ownerUnit = ownerUnit;
	}

	/**
	 * @param ownerName the ownerName to set
	 */
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	/**
	 * @param contactPerson the contactPerson to set
	 */
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	/**
	 * @param ownerId the ownerId to set
	 */
	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}


}
