package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class SmsBackPayEntity {
    @JSONField(name = "OP_TIME")
    @ParamDesc(path = "OP_TIME", cons = ConsType.CT001, len = "14", type = "string", desc = "返费时间", memo = "")
    private String opTime;   
    @JSONField(name = "PAY_MONEY")
    @ParamDesc(path = "PAY_MONEY", cons = ConsType.CT001, len = "15", type = "long", desc = "返费金额", memo = "单位：分")
    private long payMoney;
    @JSONField(name = "PAY_TYPE")
    @ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, len = "14", type = "string", desc = "账本类型", memo = "")
    private String payType;
    
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
	 * @return the payMoney
	 */
	public long getPayMoney() {
		return payMoney;
	}
	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}
	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}
	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	} 
}
