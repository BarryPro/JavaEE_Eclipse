package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSPBillAcctRuleOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "ACCT_RULE", desc = "计费规则", cons = ConsType.CT001, type = "int", len = "6", memo = "5：立即计费；7：免三天")
	private int acctRule;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("acctRule"), acctRule);
		return result;
	}

	public int getAcctRule() {
		return acctRule;
	}

	public void setAcctRule(int acctRule) {
		this.acctRule = acctRule;
	}
}
