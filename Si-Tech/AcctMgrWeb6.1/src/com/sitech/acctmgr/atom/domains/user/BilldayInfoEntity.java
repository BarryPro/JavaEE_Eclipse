package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;

public class BilldayInfoEntity {

    /**
     */
	@JSONField(name = "BEGIN_DATE")
    private Integer beginDate;

    /**
     */
	@JSONField(name = "END_DATE")
    private Integer endDate;

    /**
     */
	@JSONField(name = "DUR_FLAG")
    private String durFlag;

	/**
	 * @return the beginDate
	 */
	public Integer getBeginDate() {
		return beginDate;
	}

	/**
	 * @param beginDate the beginDate to set
	 */
	public void setBeginDate(Integer beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * @return the endDate
	 */
	public Integer getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(Integer endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the durFlag
	 */
	public String getDurFlag() {
		return durFlag;
	}

	/**
	 * @param durFlag the durFlag to set
	 */
	public void setDurFlag(String durFlag) {
		this.durFlag = durFlag;
	}

    
}
