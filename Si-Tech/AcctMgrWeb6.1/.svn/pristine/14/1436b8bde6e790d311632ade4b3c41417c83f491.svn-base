package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title: 转账费用展示列表  </p>
 * <p>Description: 转账查询服务页面展示列表  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class TransFeeEntity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6626077976894711687L;
	
	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="64",desc="账本名称",memo="略")
	private String payTypeName;
	
	@JSONField(name="PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本",memo="略")
	private String payType;
	
	@JSONField(name="CUR_BALANCE")
	@ParamDesc(path="CUR_BALANCE",cons=ConsType.CT001,type="long",len="14",desc="账本预存",memo="略")
	private long curBalance;
			
	@JSONField(name="PAY_ATTR")
	@ParamDesc(path="PAY_ATTR",cons=ConsType.CT001,type="String",len="10",desc="账本属性",memo="略")
	private String payAttr;
	
	@JSONField(name="PRIORITY")
	@ParamDesc(path="PRIORITY",cons=ConsType.CT001,type="String",len="3",desc="优先级",memo="略")
	private String priority;
	
	@JSONField(name="TRANS_FLAG")
	@ParamDesc(path="TRANS_FLAG",cons=ConsType.QUES,type="String",len="3",desc="转账标志",memo="可转不可转标志")
	private String transFlag;
	
	@JSONField(name="BACK_FLAG")
	@ParamDesc(path="BACK_FLAG",cons=ConsType.QUES,type="String",len="3",desc="退费标志",memo="可退不可退标志")
	private String backFlag;
	

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "TransFeeList [payTypeName=" + payTypeName + ", payType="
				+ payType + ", curBalance=" + curBalance
				+ ", payAttr=" + payAttr
				+ ", priority=" + priority
				+ ", transFlag=" + transFlag
				+ ", backFlag=" + backFlag+ "]";
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
	 * @return the curBalance
	 */
	public long getCurBalance() {
		return curBalance;
	}




	/**
	 * @param curBalance the curBalance to set
	 */
	public void setCurBalance(long curBalance) {
		this.curBalance = curBalance;
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
	 * @return the priority
	 */
	public String getPriority() {
		return priority;
	}




	/**
	 * @param priority the priority to set
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}




	/**
	 * @return the transFlag
	 */
	public String getTransFlag() {
		return transFlag;
	}




	/**
	 * @param transFlag the transFlag to set
	 */
	public void setTransFlag(String transFlag) {
		this.transFlag = transFlag;
	}




	/**
	 * @return the backFlag
	 */
	public String getBackFlag() {
		return backFlag;
	}




	/**
	 * @param backFlag the backFlag to set
	 */
	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}
}
