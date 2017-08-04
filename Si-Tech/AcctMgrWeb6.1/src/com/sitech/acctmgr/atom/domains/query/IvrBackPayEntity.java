package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class IvrBackPayEntity {
	
    @JSONField(name = "OP_TIME")
    @ParamDesc(path = "OP_TIME", cons = ConsType.CT001, len = "14", type = "string", desc = "返费时间", memo = "")
    private String opTime;   
    @JSONField(name = "PAY_MONEY")
    @ParamDesc(path = "PAY_MONEY", cons = ConsType.CT001, len = "15", type = "long", desc = "返费金额", memo = "")
    private long payMoney;
    @JSONField(name = "FUNCTION_NAME")
    @ParamDesc(path = "FUNCTION_NAME", cons = ConsType.CT001, len = "100", type = "string", desc = "操作代码名称", memo = "")
    private String functionName;
    @JSONField(name = "BEGIN_TIME")
    @ParamDesc(path = "BEGIN_TIME", cons = ConsType.CT001, len = "14", type = "string", desc = "开始返费时间", memo = "")
    private String beginTime;
    @JSONField(name = "RETURN_NUM")
    @ParamDesc(path = "RETURN_NUM", cons = ConsType.CT001, len = "8", type = "string", desc = "返费次数", memo = "")
    private String returnNum;
    
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
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}
	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	/**
	 * @return the returnNum
	 */
	public String getReturnNum() {
		return returnNum;
	}
	/**
	 * @param returnNum the returnNum to set
	 */
	public void setReturnNum(String returnNum) {
		this.returnNum = returnNum;
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
}
