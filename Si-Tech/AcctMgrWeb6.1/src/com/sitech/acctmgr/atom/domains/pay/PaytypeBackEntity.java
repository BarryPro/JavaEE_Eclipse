package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

 /**
  * 
 * @Title:   []
 * @Description: 转账查询：可转账本列表
 * @Date : 2015年3月13日下午3:09:50
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p>
  */
public class PaytypeBackEntity implements Serializable {

	public PaytypeBackEntity() {
	}

	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="String",len="64",desc="账本类型",memo="略")
	private String payTypeName;
	@JSONField(name="BACK_FLAG")
	@ParamDesc(path="BACK_FLAG",cons=ConsType.CT001,type="String",len="10",desc="可退标志",memo="略")
	private String backFlag;
	@JSONField(name="CHANGE_FLAG")
	@ParamDesc(path="CHANGE_FLAG",cons=ConsType.CT001,type="String",len="10",desc="可转标志",memo="略")
	private String changeFlag;
	@JSONField(name="PRIORITY")
	@ParamDesc(path="PRIORITY",cons=ConsType.CT001,type="String",len="3",desc="优先级",memo="略")
	private String priority;
	@JSONField(name="CON_BALANCE")
	@ParamDesc(path="CON_BALANCE",cons=ConsType.CT001,type="string",len="14",desc="账本可退金额",memo="略")
	private long conBalance;
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
	 * @return the conBalance
	 */
	public long getConBalance() {
		return conBalance;
	}
	/**
	 * @param conBalance the conBalance to set
	 */
	public void setConBalance(long conBalance) {
		this.conBalance = conBalance;
	}
	/**
	 * @return the changeFlag
	 */
	public String getChangeFlag() {
		return changeFlag;
	}
	/**
	 * @param changeFlag the changeFlag to set
	 */
	public void setChangeFlag(String changeFlag) {
		this.changeFlag = changeFlag;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PaytypeBackEntity [payTypeName=" + payTypeName + ", backFlag="
				+ backFlag + ", changeFlag=" + changeFlag + ", priority="
				+ priority + ", conBalance=" + conBalance + "]";
	}
	 
	 
 
	
}
