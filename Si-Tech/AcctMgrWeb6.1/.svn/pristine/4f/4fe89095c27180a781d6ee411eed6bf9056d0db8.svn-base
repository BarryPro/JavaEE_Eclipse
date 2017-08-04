package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class DisFlagEntity {
	
    @JSONField(name = "YEAR_MONTH")
    @ParamDesc(path = "YEAR_MONTH", cons = ConsType.CT001, len = "6", type = "string", desc = "年月", memo = "")
    private String yearMonth;
    @JSONField(name = "FLAG")
    @ParamDesc(path = "FLAG", cons = ConsType.CT001, len = "1", type = "string", desc = "拆包标志", memo = "1: 拆包；0：不拆包")
    private String flag;
	/**
	 * @return the yearMonth
	 */
	public String getYearMonth() {
		return yearMonth;
	}
	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
}
