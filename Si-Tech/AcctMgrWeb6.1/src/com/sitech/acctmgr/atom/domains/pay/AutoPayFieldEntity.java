package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title: 签约关系属性实体  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class AutoPayFieldEntity {
	
	@JSONField(name="PAY_MONEY")
	long payMoney;
	
	@JSONField(name="BALANCE_LIMIT")
	long balanceLimit;
	
	@JSONField(name="AUTO_FLAG")
	String autoFlag;
	
	@JSONField(name="PAY_DAY")
	String payDay;
	

	@Override
	public String toString() {
		return "AutoPayFieldEntity [payMoney=" + payMoney + ", balanceLimit=" + balanceLimit + ", autoFlag=" + autoFlag + ", payDay="
				+ payDay + "]";
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public long getBalanceLimit() {
		return balanceLimit;
	}

	public void setBalanceLimit(long balanceLimit) {
		this.balanceLimit = balanceLimit;
	}

	public String getAutoFlag() {
		return autoFlag;
	}

	public void setAutoFlag(String autoFlag) {
		this.autoFlag = autoFlag;
	}

	public String getPayDay() {
		return payDay;
	}

	public void setPayDay(String payDay) {
		this.payDay = payDay;
	}
	


}
