package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 功能：sp业务计费类型数据实体
 */
public class SPBillAcctRuleEntity {
	
	@JSONField(name = "ACCT_RULE")
	@ParamDesc(path = "ACCT_RULE", cons = ConsType.CT001, type = "int", len = "6", desc = "计费规则", memo = "5：立即计费；7：免三天")
	private int acctRule;
	
	@JSONField(name = "SP_CODE")
	@ParamDesc(path = "SP_CODE", cons = ConsType.CT001, type = "String", len = "1000", desc = "企业代码列表", memo = "略")
    private String spCode;
	
	@JSONField(name = "OPER_CODE")
	@ParamDesc(path = "OPER_CODE", cons = ConsType.CT001, type = "String", len = "1000", desc = "业务代码列表", memo = "略")
    private String operCode;

    public int getAcctRule() {
		return acctRule;
	}

	public void setAcctRule(int acctRule) {
		this.acctRule = acctRule;
	}

	public String getSpCode() {
		return spCode;
	}

	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

	public String getOperCode() {
		return operCode;
	}

	public void setOperCode(String operCode) {
		this.operCode = operCode;
	}

	@Override
    public String toString() {
        return "SPBillAcctRuleEntity{" +
                "acctRule=" + acctRule +
                ", spCode='" + spCode + '\'' +
                ", operCode=" + operCode +
                '}';
    }
}
