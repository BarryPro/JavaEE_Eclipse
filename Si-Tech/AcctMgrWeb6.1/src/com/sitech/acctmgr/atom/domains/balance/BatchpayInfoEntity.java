package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class BatchpayInfoEntity {
	
	 /**
     */
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="10",desc="缴费金额",memo="单位：分")
    private long payFee;
	
	 /**
     */
	@JSONField(name="PAY_NAME")
	@ParamDesc(path="PAY_NAME",cons=ConsType.CT001,type="String",len="100",desc="支付方式名称",memo="")
    private String payName;
	
	 /**
     */
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="14",desc="返费时间",memo="")
    private String beginTime;
	
	 /**
     */
	@JSONField(name="END_TIME")
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="14",desc="结束时间",memo="")
    private String endTime;
	
	 /**
     */
	@JSONField(name="FUNCTION_NAME")
	@ParamDesc(path="FUNCTION_NAME",cons=ConsType.CT001,type="String",len="100",desc="操作模块名称",memo="")
    private String funcName;

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
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
	 * @return the funcName
	 */
	public String getFuncName() {
		return funcName;
	}

	/**
	 * @param funcName the funcName to set
	 */
	public void setFuncName(String funcName) {
		this.funcName = funcName;
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

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
