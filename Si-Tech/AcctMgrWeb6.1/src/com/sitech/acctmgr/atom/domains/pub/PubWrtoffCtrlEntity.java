package com.sitech.acctmgr.atom.domains.pub;

import com.alibaba.fastjson.annotation.JSONField;

public class PubWrtoffCtrlEntity {

	/**
     */
	@JSONField(name = "WRTOFF_FLAG")
    private String wrtoffFlag;

	@JSONField(name = "WRTOFF_MONTH")
    private Integer wrtoffMonth;

	/**
	 * @return the wrtoffFlag
	 */
	public String getWrtoffFlag() {
		return wrtoffFlag;
	}

	/**
	 * @param wrtoffFlag the wrtoffFlag to set
	 */
	public void setWrtoffFlag(String wrtoffFlag) {
		this.wrtoffFlag = wrtoffFlag;
	}

	/**
	 * @return the wrtoffMonth
	 */
	public Integer getWrtoffMonth() {
		return wrtoffMonth;
	}

	/**
	 * @param wrtoffMonth the wrtoffMonth to set
	 */
	public void setWrtoffMonth(Integer wrtoffMonth) {
		this.wrtoffMonth = wrtoffMonth;
	}

}
