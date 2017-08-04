package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class RemindOpenEntity {

	@JSONField(name = "RULE_ID")
	@ParamDesc(path = "RULE_ID", cons = ConsType.CT001, type = "String", len = "15", desc = "订购业务代码", memo = "无")
	protected String ruleId;

	@JSONField(name = "RULE_NOTE")
	@ParamDesc(path = "RULE_NOTE", cons = ConsType.CT001, type = "String", len = "100", desc = "订购业务名称", memo = "无")
	protected String ruleNote;

	@JSONField(name = "FLAG")
	@ParamDesc(path = "FLAG", cons = ConsType.CT001, type = "String", len = "1", desc = "开通状态", memo = "1：已关闭，0：已开通无")
	protected String flag;

	protected String isRemind;

	/**
	 * @return the ruleId
	 */
	public String getRuleId() {
		return ruleId;
	}

	/**
	 * @param ruleId
	 *            the ruleId to set
	 */
	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	/**
	 * @return the ruleNote
	 */
	public String getRuleNote() {
		return ruleNote;
	}

	/**
	 * @param ruleNote
	 *            the ruleNote to set
	 */
	public void setRuleNote(String ruleNote) {
		this.ruleNote = ruleNote;
	}

	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag
	 *            the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getIsRemind() {
		return isRemind;
	}

	public void setIsRemind(String isRemind) {
		this.isRemind = isRemind;
	}

}
