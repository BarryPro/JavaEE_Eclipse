package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Query8128Entity implements Serializable {
	
	@JSONField(name="DAYS")
	@ParamDesc(path="DAYS",cons=ConsType.CT001,type="int",len="20",desc="延长时间",memo="略")
	private int days = 0;
	@JSONField(name="FUNCTION_NAME")
	@ParamDesc(path="FUNCTION_NAME",cons=ConsType.CT001,type="String",len="50",desc="操作功能名称",memo="略")
	private String functionName = "";
	@JSONField(name="LOGIN_NO")
	@ParamDesc(path="LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="操作工号",memo="略")
	private String loginNo = "";
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="20",desc="操作时间",memo="略")
	private String opTime = "";
	@JSONField(name="REMARK")
	@ParamDesc(path="REMARK",cons=ConsType.CT001,type="String",len="100",desc="备注",memo="略")
	private String remark = "";
	
	
	/**
	 * @return the days
	 */
	public int getDays() {
		return days;
	}
	/**
	 * @param days the days to set
	 */
	public void setDays(int days) {
		this.days = days;
	}
	/**
	 * @return the functionName
	 */
	public String getFunctionName() {
		return functionName;
	}
	/**
	 * @param functionName the functionName to set
	 */
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	/**
	 * @return the loginNo
	 */
	public String getLoginNo() {
		return loginNo;
	}
	/**
	 * @param loginNo the loginNo to set
	 */
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
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
	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}	
	
}
