package com.sitech.acctmgr.atom.domains.base;

import com.alibaba.fastjson.annotation.JSONField;

public class ChngroupDictEntity {

    /**
     */
	@JSONField(name = "GROUP_ID")
    private String groupId;

    /**
     */
	@JSONField(name = "GROUP_NAME")
    private String groupName;
	
	@JSONField(name = "ID_NAME")
	private String plusNameId;

	/**
     */
	@JSONField(serialize = false)
    private Integer rootDistance;

    /**
     */
	@JSONField(serialize = false)
    private String provinceId;

    /**
     */
	@JSONField(serialize = false)
    private Integer regionId;

    /**
     */
	@JSONField(serialize = false)
    private String bossOrgCode;


    public String getGroupId(){
    	return this.groupId;
    }
 
    public void setGroupId(String groupId){
      this.groupId=groupId;
    }
 
    public String getGroupName(){
    	return this.groupName;
    }
 
    public void setGroupName(String groupName){
      this.groupName=groupName;
    }

	/**
	 * @return the rootDistance
	 */
	public Integer getRootDistance() {
		return rootDistance;
	}

	/**
	 * @param rootDistance the rootDistance to set
	 */
	public void setRootDistance(Integer rootDistance) {
		this.rootDistance = rootDistance;
	}

	/**
	 * @return the provinceId
	 */
	public String getProvinceId() {
		return provinceId;
	}

	/**
	 * @param provinceId the provinceId to set
	 */
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	/**
	 * @return the regionId
	 */
	public Integer getRegionId() {
		return regionId;
	}

	/**
	 * @param regionId the regionId to set
	 */
	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}

	/**
	 * @return the bossOrgCode
	 */
	public String getBossOrgCode() {
		return bossOrgCode;
	}

	/**
	 * @param bossOrgCode the bossOrgCode to set
	 */
	public void setBossOrgCode(String bossOrgCode) {
		this.bossOrgCode = bossOrgCode;
	}
	
    public String getPlusNameId() {
		return plusNameId;
	}

	public void setPlusNameId(String plusNameId) {
		this.plusNameId = plusNameId;
	}
}
