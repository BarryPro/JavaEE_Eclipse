package com.sitech.acctmgr.atom.domains.base;

import com.alibaba.fastjson.annotation.JSONField;

public class ChngroupRelEntity {

	private static final long serialVersionUID = 1L;

    /**
     */
	@JSONField(name = "GROUP_ID")
    private String groupId;

    /**
     */
	@JSONField(name = "PARENT_GROUP_ID")
    private String parentGroupId;

    /**
     */
	@JSONField(name = "REGION_CODE")
    private String regionCode;
	
    /**
     */
	@JSONField(name = "REGION_NAME")
    private String regionName;

    /**
     */
	@JSONField(name = "DENORM_LEVEL")
    private Integer denormLevel;

    /**
     */
	@JSONField(name = "PARENT_LEVEL")
    private Integer parentLevel;

    /**
     */
	@JSONField(name = "CURRENT_LEVEL")
    private Integer currentLevel;

    @JSONField(name = "PROVINCE_ID")
    private String provinceId;
	

    public String getGroupId(){
    	return this.groupId;
    }
 
    public void setGroupId(String groupId){
      this.groupId=groupId;
    }
 
    public String getParentGroupId(){
    	return this.parentGroupId;
    }
 
    public void setParentGroupId(String parentGroupId){
      this.parentGroupId=parentGroupId;
    }
 
    public Integer getDenormLevel(){
    	return this.denormLevel;
    }
 
    public void setDenormLevel(Integer denormLevel){
      this.denormLevel=denormLevel;
    }
 
    public Integer getParentLevel(){
    	return this.parentLevel;
    }
 
    public void setParentLevel(Integer parentLevel){
      this.parentLevel=parentLevel;
    }
 
    public Integer getCurrentLevel(){
    	return this.currentLevel;
    }
 
    public void setCurrentLevel(Integer currentLevel){
      this.currentLevel=currentLevel;
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

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId;
    }

    @Override
    public String toString() {
        return "ChngroupRelEntity{" +
                "groupId='" + groupId + '\'' +
                ", parentGroupId='" + parentGroupId + '\'' +
                ", regionCode='" + regionCode + '\'' +
                ", regionName='" + regionName + '\'' +
                ", denormLevel=" + denormLevel +
                ", parentLevel=" + parentLevel +
                ", currentLevel=" + currentLevel +
                ", provinceId='" + provinceId + '\'' +
                '}';
    }
}
