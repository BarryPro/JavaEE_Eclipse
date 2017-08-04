package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class RemindEntity {

	@JSONField(name = "RULE_ID")
	@ParamDesc(path = "RULE_ID", cons = ConsType.CT001, type = "string", len = "18", desc = "订购业务代码", memo = "无")
	protected String ruleId;

	@JSONField(name = "RULE_NOTE")
	@ParamDesc(path = "RULE_NOTE", cons = ConsType.CT001, type = "string", len = "18", desc = "订购业务名称", memo = "无")
	protected String ruleNote;

	@JSONField(name = "FLAG")
	@ParamDesc(path = "FLAG", cons = ConsType.CT001, type = "string", len = "18", desc = "开通状态", memo = "无")
	protected String flag;

	public String getRuleId() {
		return ruleId;
	}

	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	public String getRuleNote() {
		return ruleNote;
	}

	public void setRuleNote(String ruleNote) {
		this.ruleNote = ruleNote;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}
