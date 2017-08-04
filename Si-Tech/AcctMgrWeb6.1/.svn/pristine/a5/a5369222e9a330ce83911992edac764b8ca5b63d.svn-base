package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

@SuppressWarnings("serial")

/**
 * 
* @Title:   []
* @Description: 退预存款：不可退预存列表实体类
* @Date : 2015年3月12日下午6:02:12
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class BalanceNBEntity implements Serializable {

	 
	public BalanceNBEntity() {
	}

	@JSONField(name="PREPAY_FEE")
	@ParamDesc(path="PREPAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="预存",memo="略")
	private long nobackPrepay;
	@JSONField(name="PAY_TYPE")
	@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="string",len="5",desc="账本类型",memo="略")
	private String payType;
	@JSONField(name="PAY_TYPE_NAME")
	@ParamDesc(path="PAY_TYPE_NAME",cons=ConsType.CT001,type="string",len="18",desc="账本名称",memo="略")
	private String payTypeName;
	/**
	 * @return the nobackPrepay
	 */
	public long getNobackPrepay() {
		return nobackPrepay;
	}
	/**
	 * @param nobackPrepay the nobackPrepay to set
	 */
	public void setNobackPrepay(long nobackPrepay) {
		this.nobackPrepay = nobackPrepay;
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
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BalanceNBEntity [nobackPrepay=" + nobackPrepay + ", payType="
				+ payType + ", payTypeName=" + payTypeName + "]";
	}
	
	 

	
}
