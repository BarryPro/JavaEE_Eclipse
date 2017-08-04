package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class GroupchgInfoEntity {

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
	@JSONField(name = "AREA_CODE")
    private String areaCode;

    /**
     */
	@JSONField(name = "EFF_DATE")
    private String effDate;

    /**
     */
	@JSONField(name = "EXP_DATE")
    private String expDate;

    /**
     */
	@JSONField(name = "IN_GROUP")
    private String inGroup;

    /**
     */
	@JSONField(name = "OUT_GROUP")
    private String outGroup;

    /**
     */
	@JSONField(name = "BACK_FLAG")
    private String backFlag;

    /**
     */
	@JSONField(name = "PHONE_NO")
    private String phoneNo;

    /**
     */
	@JSONField(name = "GROUP_ID")
    private String groupId;
	
    /**
     */
	@JSONField(name = "GROUP_ID_PHONE")
    private String groupIdPhone;
	
    /**
     */
	@JSONField(name = "GROUP_ID_PAY")
    private String groupIdPay;

    public Long getContractNo(){
    	return this.contractNo;
    }
 
    public void setContractNo(Long contractNo){
      this.contractNo=contractNo;
    }
 
    public Long getIdNo(){
    	return this.idNo;
    }
 
    public void setIdNo(Long idNo){
      this.idNo=idNo;
    }
 
    public String getAreaCode(){
    	return this.areaCode;
    }
 
    public void setAreaCode(String areaCode){
      this.areaCode=areaCode;
    }
 
 
    public String getInGroup(){
    	return this.inGroup;
    }
 
    public void setInGroup(String inGroup){
      this.inGroup=inGroup;
    }
 
    public String getOutGroup(){
    	return this.outGroup;
    }
 
    public void setOutGroup(String outGroup){
      this.outGroup=outGroup;
    }
 
    public String getBackFlag(){
    	return this.backFlag;
    }
 
    public void setBackFlag(String backFlag){
      this.backFlag=backFlag;
    }
 
    public String getPhoneNo(){
    	return this.phoneNo;
    }
 
    public void setPhoneNo(String phoneNo){
      this.phoneNo=phoneNo;
    }
 
    public String getGroupId(){
    	return this.groupId;
    }
 
    public void setGroupId(String groupId){
      this.groupId=groupId;
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

	/**
	 * @return the groupIdPhone
	 */
	public String getGroupIdPhone() {
		return groupIdPhone;
	}

	/**
	 * @param groupIdPhone the groupIdPhone to set
	 */
	public void setGroupIdPhone(String groupIdPhone) {
		this.groupIdPhone = groupIdPhone;
	}

	/**
	 * @return the groupIdPay
	 */
	public String getGroupIdPay() {
		return groupIdPay;
	}

	/**
	 * @param groupIdPay the groupIdPay to set
	 */
	public void setGroupIdPay(String groupIdPay) {
		this.groupIdPay = groupIdPay;
	}
 

}
