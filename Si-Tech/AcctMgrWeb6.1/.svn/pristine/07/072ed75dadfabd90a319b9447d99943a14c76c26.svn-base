package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:  已返费实体类 </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class BatchPayEntity implements Serializable {
	
	@JSONField(name="PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="20",desc="账本类型",memo="略")
	private String payType = "";
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="已经返费预存",memo="略")
	private long payFee = 0;
	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="20",desc="账本类型名称",memo="略")
	private String payTypeName = "";
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="30",desc="开始时间",memo="略")
	private String beginTime = "";
	@JSONField(name="END_TIME")
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="30",desc="结束时间",memo="略")
	private String endTime = "";
	@JSONField(name="OP_TIME")
	@ParamDesc(path="OP_TIME",cons=ConsType.CT001,type="String",len="30",desc="返费时间",memo="略")
	private String opTime = "";
	@JSONField(name="PAY_ATTR")
	@ParamDesc(path="PAY_ATTR",cons=ConsType.CT001,type="String",len="20",desc="类型标识",memo="略")
	private String payAttr = "";
	@JSONField(name="FEE_TYPE")
	@ParamDesc(path="FEE_TYPE",cons=ConsType.CT001,type="String",len="2",desc="账本种类",memo="0:普通预存, 1:赠费预存")
	private String feeType = "";
	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}
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
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}
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
	 * @return the payTypeName
	 */
	public String getPayTypeName() {
		return payTypeName;
	}
	/**
	 * @param payTypeName the payTypeName to set
	 */
	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
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
	/**
	 * @return the payAttr
	 */
	public String getPayAttr() {
		return payAttr;
	}
	/**
	 * @param payAttr the payAttr to set
	 */
	public void setPayAttr(String payAttr) {
		this.payAttr = payAttr;
	}
	/**
	 * @return the feeType
	 */
	public String getFeeType() {
		return feeType;
	}
	/**
	 * @param feeType the feeType to set
	 */
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}
	
	
}
