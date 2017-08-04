package com.sitech.acctmgr.atom.domains.base;

import com.alibaba.fastjson.annotation.JSONField;

public class GroupEntity {

	 /**
	    */
	@JSONField(name = "LOGIN_REGION")
	private String loginRegion;
	
	 /**
	    */
	@JSONField(name = "LOGIN_REGION_NAME")
	private String loginRegionName;
	
	 /**
	    */
	@JSONField(name = "USER_REGION")
	private String userRegion;
	
	 /**
	    */
	@JSONField(name = "USER_REGION_NAME")
	private String userRegionName;
	
	 /**
	    */
	@JSONField(name = "REGION_FLAG")
	private String regionFlag;

	/**
	 * @return the loginRegion
	 */
	public String getLoginRegion() {
		return loginRegion;
	}

	/**
	 * @param loginRegion the loginRegion to set
	 */
	public void setLoginRegion(String loginRegion) {
		this.loginRegion = loginRegion;
	}

	/**
	 * @return the loginRegionName
	 */
	public String getLoginRegionName() {
		return loginRegionName;
	}

	/**
	 * @param loginRegionName the loginRegionName to set
	 */
	public void setLoginRegionName(String loginRegionName) {
		this.loginRegionName = loginRegionName;
	}

	/**
	 * @return the userRegion
	 */
	public String getUserRegion() {
		return userRegion;
	}

	/**
	 * @param userRegion the userRegion to set
	 */
	public void setUserRegion(String userRegion) {
		this.userRegion = userRegion;
	}

	/**
	 * @return the userRegionName
	 */
	public String getUserRegionName() {
		return userRegionName;
	}

	/**
	 * @param userRegionName the userRegionName to set
	 */
	public void setUserRegionName(String userRegionName) {
		this.userRegionName = userRegionName;
	}

	/**
	 * @return the regionFlag
	 */
	public String getRegionFlag() {
		return regionFlag;
	}

	/**
	 * @param regionFlag the regionFlag to set
	 */
	public void setRegionFlag(String regionFlag) {
		this.regionFlag = regionFlag;
	}
}
