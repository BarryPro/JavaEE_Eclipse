package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class familyEntity {
    @JSONField(name = "SEC_PHONE")
    @ParamDesc(path = "SEC_PHONE", cons = ConsType.CT001, type = "string", len = "15", desc = "副卡号码", memo = "略")
    private String secPhone;
    @JSONField(name = "SEC_UNBILL")
    @ParamDesc(path = "SEC_UNBILL", cons = ConsType.CT001, type = "long", len = "15", desc = "副卡未出账话费", memo = "单位：分")
    private long secUnBill;
	/**
	 * @return the secPhone
	 */
	public String getSecPhone() {
		return secPhone;
	}
	/**
	 * @param secPhone the secPhone to set
	 */
	public void setSecPhone(String secPhone) {
		this.secPhone = secPhone;
	}
	/**
	 * @return the secUnBill
	 */
	public long getSecUnBill() {
		return secUnBill;
	}
	/**
	 * @param secUnBill the secUnBill to set
	 */
	public void setSecUnBill(long secUnBill) {
		this.secUnBill = secUnBill;
	}
}
