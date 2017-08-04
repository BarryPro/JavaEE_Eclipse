package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class PayTypeEntity {
	
    @JSONField(name = "PAY_TYPE")
    @ParamDesc(path = "PAY_TYPE", cons = ConsType.CT001, len = "8", type = "string", desc = "支付类型", memo = "")
    private String payType;
    @JSONField(name = "PAY_NAME")
    @ParamDesc(path = "PAY_NAME", cons = ConsType.CT001, len = "128", type = "string", desc = "支付类型名称", memo = "")
    private String payName;
    
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
	/**
	 * @return the payName
	 */
	public String getPayName() {
		return payName;
	}
	/**
	 * @param payName the payName to set
	 */
	public void setPayName(String payName) {
		this.payName = payName;
	}
    
    
}
