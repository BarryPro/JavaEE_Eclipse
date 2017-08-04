package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class NotBackBalanceEntity {

	@JSONField(name = "PAY_TYPE")
	@ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, type = "String", len = "30", desc = "账本类型", memo = "略")
	private String payType;

	@JSONField(name = "PAY_TYPE_NAME")
	@ParamDesc(path = "PAY_TYPE_NAME", cons = ConsType.CT001, type = "String", len = "50", desc = "账本类型名称", memo = "略")
	private String payTypeName;

	@JSONField(name = "BALANCE")
	@ParamDesc(path = "BALANCE", cons = ConsType.CT001, type = "long", len = "20", desc = "金额", memo = "略")
	private long balance;

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayTypeName() {
		return payTypeName;
	}

	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	public long getBalance() {
		return balance;
	}

	public void setBalance(long balance) {
		this.balance = balance;
	}

}
