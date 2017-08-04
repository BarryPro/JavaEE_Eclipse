package com.sitech.acctmgr.atom.domains.record;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class UserChgRecdEntity {
	
	@JSONField(name = "RUN_CODE")
	@ParamDesc(path="RUN_CODE",cons=ConsType.CT001,type="String",len="100",desc="运行状态",memo="略")
    private String runCode;
	
	@JSONField(name = "OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="14",desc="查询时间",memo="略")
    private String opTime;

	/**
	 * @return the runCode
	 */
	public String getRunCode() {
		return runCode;
	}

	/**
	 * @param runCode the runCode to set
	 */
	public void setRunCode(String runCode) {
		this.runCode = runCode;
	}

	/**
	 * @return the opTime
	 */
	public String getOpTime() {
		return opTime;
	}

	/**
	 * @param opTime the opTime to set
	 */
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
}
